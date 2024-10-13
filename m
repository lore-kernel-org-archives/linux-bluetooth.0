Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2799A7711F
	for <linux-bluetooth@vger.kernel.org>; Sun, 13 Oct 2024 18:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728842884; cv=none; b=Gy6vzsbRypO5GQUR0tfp5/WFwS9nQbFp6rGUokzgjxgVcbsHorQ15ZW1GgSpdh3fVwnNj/SYwxam2egwhxlPUKZ7g/exeX2ZXEZHn34ME45jqTOG1xHoOuKrZlPacMwmqTagN3S2qGhX6VGHw7BZwhyPTXF+dDPSUP587eUw97Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728842884; c=relaxed/simple;
	bh=4VC6pq6yNc9nmilNCNkoH1Xl/z4BzV2VbHbRL+Mk2Uo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dheWdSxzqr4OloztMHX9pvLF54LrZDQ2DK9RgrSfGt8gu0E4U8QoZVcQ6noYZXKYXGD7nxB8jPkrFHDzm7gavpZZQPYFHgqFpYeCCd1mh3oz/lygTBJbedC796/op3RCsNSMeNKL+RQaq0mmCbH2gYE6ZCO2t8RnYaJRbsWBSXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O7F50OeE; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O7F50OeE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728842882; x=1760378882;
  h=date:from:to:cc:subject:message-id;
  bh=4VC6pq6yNc9nmilNCNkoH1Xl/z4BzV2VbHbRL+Mk2Uo=;
  b=O7F50OeE3/FCRSIeWkedfeyAnvt4fvQ/lZfeHOwoKPAOL4jX1IcQonzG
   bnuJAworj+vZqe6dLDKC06G2FgB4rPy2FZjrpC5j9gHkOyUG9QBkC74OD
   YCko7nph3NsJDypazGVFwty2OgoaIc7P/XeBvX2mJFo/aqHGP+2pSksxG
   ZUIF48WDK+PQCvyhCEAOVfruQ1nTc4NTHztaABG96fHFZM9aMY+thdGyo
   ozz7X/oAHFlxpb/jWB+3VsnVu7jPQrCxBncpAuFYb/bdol/pA72XbsUwj
   9sgTVUJKCFboyvSDA4QN9cKHlTLieF0E1kVaOrxEcNR5qCLk70MogA4KD
   w==;
X-CSE-ConnectionGUID: y4fpQIR9Q5iitXyonxDHhQ==
X-CSE-MsgGUID: LzAeGXPsQ7SZ+3fiSVKmyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="39575560"
X-IronPort-AV: E=Sophos;i="6.11,201,1725346800"; 
   d="scan'208";a="39575560"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 11:08:02 -0700
X-CSE-ConnectionGUID: ZdmIOWhRTBeOZLIuDU/+lQ==
X-CSE-MsgGUID: p6HihWvdQeKap2U+Q0l0pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,201,1725346800"; 
   d="scan'208";a="77700697"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 13 Oct 2024 11:08:00 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t030Y-000Eax-0m;
	Sun, 13 Oct 2024 18:07:58 +0000
Date: Mon, 14 Oct 2024 02:07:38 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 fdc32fdd5952c66731d285e9c6986bfeb0310d67
Message-ID: <202410140231.akcki5S1-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: fdc32fdd5952c66731d285e9c6986bfeb0310d67  Bluetooth: btintel_pcie: Add recovery mechanism

elapsed time: 2843m

configs tested: 207
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              alldefconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                        nsimosci_defconfig    clang-20
arc                   randconfig-001-20241013    gcc-14.1.0
arc                   randconfig-002-20241013    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                          ixp4xx_defconfig    clang-20
arm                          moxart_defconfig    gcc-14.1.0
arm                           omap1_defconfig    gcc-14.1.0
arm                          pxa168_defconfig    gcc-14.1.0
arm                          pxa3xx_defconfig    clang-20
arm                   randconfig-001-20241013    gcc-14.1.0
arm                   randconfig-002-20241013    gcc-14.1.0
arm                   randconfig-003-20241013    gcc-14.1.0
arm                   randconfig-004-20241013    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241013    gcc-14.1.0
arm64                 randconfig-002-20241013    gcc-14.1.0
arm64                 randconfig-003-20241013    gcc-14.1.0
arm64                 randconfig-004-20241013    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241013    gcc-14.1.0
csky                  randconfig-002-20241013    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241013    gcc-14.1.0
hexagon               randconfig-002-20241013    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241013    clang-18
i386        buildonly-randconfig-001-20241013    gcc-12
i386        buildonly-randconfig-002-20241013    gcc-12
i386        buildonly-randconfig-003-20241013    clang-18
i386        buildonly-randconfig-003-20241013    gcc-12
i386        buildonly-randconfig-004-20241013    gcc-12
i386        buildonly-randconfig-005-20241013    clang-18
i386        buildonly-randconfig-005-20241013    gcc-12
i386        buildonly-randconfig-006-20241013    clang-18
i386        buildonly-randconfig-006-20241013    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20241013    clang-18
i386                  randconfig-001-20241013    gcc-12
i386                  randconfig-002-20241013    gcc-12
i386                  randconfig-003-20241013    gcc-12
i386                  randconfig-004-20241013    gcc-11
i386                  randconfig-004-20241013    gcc-12
i386                  randconfig-005-20241013    clang-18
i386                  randconfig-005-20241013    gcc-12
i386                  randconfig-006-20241013    clang-18
i386                  randconfig-006-20241013    gcc-12
i386                  randconfig-011-20241013    clang-18
i386                  randconfig-011-20241013    gcc-12
i386                  randconfig-012-20241013    gcc-12
i386                  randconfig-013-20241013    clang-18
i386                  randconfig-013-20241013    gcc-12
i386                  randconfig-014-20241013    gcc-12
i386                  randconfig-015-20241013    clang-18
i386                  randconfig-015-20241013    gcc-12
i386                  randconfig-016-20241013    clang-18
i386                  randconfig-016-20241013    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241013    gcc-14.1.0
loongarch             randconfig-002-20241013    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                            q40_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          ath79_defconfig    clang-20
mips                           ip32_defconfig    clang-20
mips                     loongson1c_defconfig    gcc-14.1.0
mips                          rm200_defconfig    gcc-14.1.0
mips                         rt305x_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241013    gcc-14.1.0
nios2                 randconfig-002-20241013    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241013    gcc-14.1.0
parisc                randconfig-002-20241013    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                   currituck_defconfig    gcc-14.1.0
powerpc                       eiger_defconfig    clang-20
powerpc                     ep8248e_defconfig    gcc-14.1.0
powerpc                       holly_defconfig    clang-20
powerpc                     ksi8560_defconfig    gcc-14.1.0
powerpc                      mgcoge_defconfig    gcc-14.1.0
powerpc                      pasemi_defconfig    gcc-14.1.0
powerpc                     powernv_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241013    gcc-14.1.0
powerpc               randconfig-002-20241013    gcc-14.1.0
powerpc               randconfig-003-20241013    gcc-14.1.0
powerpc                     tqm8540_defconfig    gcc-14.1.0
powerpc                      tqm8xx_defconfig    clang-20
powerpc64             randconfig-001-20241013    gcc-14.1.0
powerpc64             randconfig-002-20241013    gcc-14.1.0
powerpc64             randconfig-003-20241013    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241013    gcc-14.1.0
riscv                 randconfig-002-20241013    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241013    gcc-14.1.0
s390                  randconfig-002-20241013    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                        dreamcast_defconfig    gcc-14.1.0
sh                ecovec24-romimage_defconfig    clang-20
sh                        edosk7760_defconfig    gcc-14.1.0
sh                          polaris_defconfig    clang-20
sh                    randconfig-001-20241013    gcc-14.1.0
sh                    randconfig-002-20241013    gcc-14.1.0
sh                           se7619_defconfig    clang-20
sh                   sh7724_generic_defconfig    clang-20
sh                        sh7763rdp_defconfig    gcc-14.1.0
sh                            titan_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241013    gcc-14.1.0
sparc64               randconfig-002-20241013    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241013    gcc-14.1.0
um                    randconfig-002-20241013    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241013    clang-18
x86_64      buildonly-randconfig-002-20241013    clang-18
x86_64      buildonly-randconfig-003-20241013    clang-18
x86_64      buildonly-randconfig-004-20241013    clang-18
x86_64      buildonly-randconfig-005-20241013    clang-18
x86_64      buildonly-randconfig-006-20241013    clang-18
x86_64                              defconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241013    clang-18
x86_64                randconfig-002-20241013    clang-18
x86_64                randconfig-003-20241013    clang-18
x86_64                randconfig-004-20241013    clang-18
x86_64                randconfig-005-20241013    clang-18
x86_64                randconfig-006-20241013    clang-18
x86_64                randconfig-011-20241013    clang-18
x86_64                randconfig-012-20241013    clang-18
x86_64                randconfig-013-20241013    clang-18
x86_64                randconfig-014-20241013    clang-18
x86_64                randconfig-015-20241013    clang-18
x86_64                randconfig-016-20241013    clang-18
x86_64                randconfig-071-20241013    clang-18
x86_64                randconfig-072-20241013    clang-18
x86_64                randconfig-073-20241013    clang-18
x86_64                randconfig-074-20241013    clang-18
x86_64                randconfig-075-20241013    clang-18
x86_64                randconfig-076-20241013    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-18
x86_64                         rhel-8.3-kunit    clang-18
x86_64                           rhel-8.3-ltp    clang-18
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                       common_defconfig    clang-20
xtensa                randconfig-001-20241013    gcc-14.1.0
xtensa                randconfig-002-20241013    gcc-14.1.0
xtensa                    smp_lx200_defconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
