set -xe

unset JAVA_TOOL_OPTIONS

# To OpenJDK folder
root_dir=$(dirname "$0")/../../
cd $root_dir/repos/openjdk

# Choose build: use slowdebug for shorter build time (32m user time for release vs. 20m user time for slowdebug)
export DEBUG_LEVEL=fastdebug
echo $RUSTUP_TOOLCHAIN

# Build
sh configure --disable-warnings-as-errors --with-debug-level=$DEBUG_LEVEL
make CONF=linux-x86_64-normal-server-$DEBUG_LEVEL THIRD_PARTY_HEAP=$PWD/../../openjdk

# --- SemiSpace ---
export MMTK_PLAN=SemiSpace

# Test - the benchmarks that are commented out do not work yet
# Note: the command line options are necessary for now to ensure the benchmarks work. We may later change the options if we do not have these many constraints.
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar antlr
#build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar bloat - does not work for stock build
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar fop
#build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar jython - does not work for stock build
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar luindex
#build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar lusearch - validation failed
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar pmd
#build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar xalan - mmtk-core gets stuck in slowdebug build

# These benchmarks take 40s+ for slowdebug build, we may consider removing them from the CI
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar hsqldb
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar eclipse

# --- Immix ---
export MMTK_PLAN=Immix

# Test - the benchmarks that are commented out do not work yet
# Note: the command line options are necessary for now to ensure the benchmarks work. We may later change the options if we do not have these many constraints.
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar antlr
#build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar bloat - does not work for stock build
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar fop
#build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar jython - does not work for stock build
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar luindex
#build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar lusearch - validation failed
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar pmd
#build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar xalan - mmtk-core gets stuck in slowdebug build

# These benchmarks take 40s+ for slowdebug build, we may consider removing them from the CI
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar hsqldb
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar eclipse

# --- Immix ---
export MMTK_PLAN=GenImmix

# Test - the benchmarks that are commented out do not work yet
# Note: the command line options are necessary for now to ensure the benchmarks work. We may later change the options if we do not have these many constraints.
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar antlr
#build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar bloat - does not work for stock build
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar fop
#build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar jython - does not work for stock build
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar luindex
#build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar lusearch - validation failed
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar pmd
#build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar xalan - mmtk-core gets stuck in slowdebug build

# These benchmarks take 40s+ for slowdebug build, we may consider removing them from the CI
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar hsqldb
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar eclipse

# --- GenCopy ---
export MMTK_PLAN=GenCopy

build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar antlr
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar fop
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar luindex
# Fail non-deterministically
# build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar hsqldb

# Fail with OOM (code 137)
# build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar pmd

# This passes, but it takes horribly long time to run. We exclude it.
# build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar eclipse

# --- NoGC ---

# Build
export MMTK_PLAN=NoGC

# Test - the benchmarks that are commented out do not work yet
# Note: We could increase heap size when mmtk core can work for larger heap. We may get more benchmarks running.

build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms1G -Xmx1G -jar benchmarks/dacapo-2006-10-MR2.jar antlr
#build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms1G -Xmx1G -jar benchmarks/dacapo-2006-10-MR2.jar bloat - does not work for stock build
#build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms1G -Xmx1G -jar benchmarks/dacapo-2006-10-MR2.jar eclipes - OOM
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms1G -Xmx1G -jar benchmarks/dacapo-2006-10-MR2.jar fop
#build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms1G -Xmx1G -jar benchmarks/dacapo-2006-10-MR2.jar hsqldb - OOM
#build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms1G -Xmx1G -jar benchmarks/dacapo-2006-10-MR2.jar jython - does not work for stock build
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms1G -Xmx1G -jar benchmarks/dacapo-2006-10-MR2.jar luindex
#build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms1G -Xmx1G -jar benchmarks/dacapo-2006-10-MR2.jar lusearch - OOM
#build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms1G -Xmx1G -jar benchmarks/dacapo-2006-10-MR2.jar pmd - OOM
#build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms1G -Xmx1G -jar benchmarks/dacapo-2006-10-MR2.jar xalan - OOM

# --- MarkCompact ---
export MMTK_PLAN=MarkCompact
# Test - the benchmarks that are commented out do not work yet
# Note: the command line options are necessary for now to ensure the benchmarks work. We may later change the options if we do not have these many constraints.
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar antlr
#build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar bloat - does not work for stock build
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar fop
#build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar jython - does not work for stock build
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar luindex
#build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar lusearch - validation failed
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar pmd
#build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar xalan - mmtk-core gets stuck in slowdebug build

# These benchmarks take 40s+ for slowdebug build, we may consider removing them from the CI
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -XX:TieredStopAtLevel=1 -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar hsqldb
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -XX:TieredStopAtLevel=1 -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar eclipse

# --- MarkSweep ---
export MMTK_PLAN=MarkSweep

# Test - the benchmarks that are commented out do not work yet
# Note: the command line options are necessary for now to ensure the benchmarks work. We may later change the options if we do not have these many constraints.
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar antlr
#build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar bloat - does not work for stock build
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar fop
#build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar jython - does not work for stock build
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar luindex
# build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar lusearch
#- validation failed
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar pmd
#build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar xalan - mmtk-core gets stuck in slowdebug build

# These benchmarks take 40s+ for slowdebug build, we may consider removing them from the CI
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar hsqldb
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar eclipse

# Run benchmarks with the mark bit in the header now
unset MMTK_PLAN
MARK_IN_HEADER=1 make CONF=linux-x86_64-normal-server-$DEBUG_LEVEL THIRD_PARTY_HEAP=$PWD/../../openjdk

export MMTK_PLAN=MarkSweep

# Test - the benchmarks that are commented out do not work yet
# Note: the command line options are necessary for now to ensure the benchmarks work. We may later change the options if we do not have these many constraints.
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar antlr
#build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar bloat - does not work for stock build
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar fop
#build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar jython - does not work for stock build
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar luindex
# build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar lusearch
#- validation failed
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar pmd
#build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar xalan - mmtk-core gets stuck in slowdebug build

# These benchmarks take 40s+ for slowdebug build, we may consider removing them from the CI
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar hsqldb
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms500M -Xmx500M -jar benchmarks/dacapo-2006-10-MR2.jar eclipse

# --- PageProtect ---
# Make sure this runs last in our tests unless we want to set it back to the default limit.
sudo sysctl -w vm.max_map_count=655300

export MMTK_PLAN=PageProtect

build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms4G -Xmx4G -jar benchmarks/dacapo-2006-10-MR2.jar antlr
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms4G -Xmx4G -jar benchmarks/dacapo-2006-10-MR2.jar fop
build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms4G -Xmx4G -jar benchmarks/dacapo-2006-10-MR2.jar luindex
# build/linux-x86_64-normal-server-$DEBUG_LEVEL/jdk/bin/java -XX:+UseThirdPartyHeap -server -XX:MetaspaceSize=100M -Xms4G -Xmx4G -jar benchmarks/dacapo-2006-10-MR2.jar pmd
