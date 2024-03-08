Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0BF2C68C
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Mar 2024 03:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709869837; cv=none; b=GcANMXunhFDmcEpXviAPlTzWc8f73DwmDo0Y8iPfDph8J2zbckxp1GuMv4YxtGuqUzoQRzrmZ6VwOZGtsi+6MKdBY7PYn6hhulD9SQFKMLLdqKnDGpr8m8PbHOK6DO5OkPyf8TzP1eeZ6MxH15A7cCSvs55A8ISVuGdMQoZy1sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709869837; c=relaxed/simple;
	bh=b4LiLqS4HGmtaM5qC/j4D+XcxhZ4jD01IxgQ1Vj28nk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=o86m5aY4oAMm3JuUDCxNfvgkttKZLyiQg9iLvmB5hjnlK9WVYBCnpN67DpL+O0GlD1lOYlMrtMXQCuXuUEiF8UoA1LiC0/3tKBqoCwCh6A6xbCzfazsqrbo05uYytRG/QhxccozqaWhActHKYbbeewXkAbQZqYhUOeJrLPFbNBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bca7m/CC; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bca7m/CC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709869834; x=1741405834;
  h=date:from:to:cc:subject:message-id;
  bh=b4LiLqS4HGmtaM5qC/j4D+XcxhZ4jD01IxgQ1Vj28nk=;
  b=Bca7m/CCWDWz48dRo5x6kelhO83qdLjpYgeO2I+EcsVccbFonrG/D5q4
   n+yVaohtzJiL5uv4mh2lth1zIH/K/Be+BeeLuJ8M4QPhCQNFu1Tr6NKe3
   ako4lKXG4VeaUtp1LBK4tHYHboIL6C8DjFrxx917CXpv4bLgLQA+WYPWm
   nfumWQaymXtlkO7Br2UIHp5bfsAlILfNRx98AlRwX3xes05T5zgpwiz2k
   nw7kXgPo20p3dvQK6VtRF1NT5m+3eIKIFbKhUTfic0GBTQiyfleXIX+fb
   fuAsBMS02Y7btIC3IfByDOKDujA5LONKyqt6vYbpMpf2aV9cmGCLPGNq7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4703184"
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="4703184"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 19:50:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="10751285"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 07 Mar 2024 19:50:34 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1riRFf-0005zt-0f;
	Fri, 08 Mar 2024 03:50:31 +0000
Date: Fri, 08 Mar 2024 11:50:11 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 48201a3b3f398be6a01f78a14b18bd5d31c47458
Message-ID: <202403081107.f08Asidt-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 48201a3b3f398be6a01f78a14b18bd5d31c47458  Bluetooth: Add new quirk for broken read key length on ATS2851

elapsed time: 1385m

configs tested: 247
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240307   gcc  
arc                   randconfig-001-20240308   gcc  
arc                   randconfig-002-20240307   gcc  
arc                   randconfig-002-20240308   gcc  
arm                              alldefconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   gcc  
arm                                 defconfig   clang
arm                        neponset_defconfig   gcc  
arm                           omap1_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20240308   gcc  
arm                   randconfig-002-20240307   gcc  
arm                   randconfig-003-20240307   gcc  
arm                        shmobile_defconfig   gcc  
arm                          sp7021_defconfig   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240307   gcc  
arm64                 randconfig-002-20240307   gcc  
arm64                 randconfig-003-20240307   gcc  
arm64                 randconfig-004-20240308   gcc  
csky                             alldefconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240307   gcc  
csky                  randconfig-001-20240308   gcc  
csky                  randconfig-002-20240307   gcc  
csky                  randconfig-002-20240308   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240307   clang
i386         buildonly-randconfig-001-20240308   clang
i386         buildonly-randconfig-002-20240307   gcc  
i386         buildonly-randconfig-002-20240308   clang
i386         buildonly-randconfig-003-20240307   clang
i386         buildonly-randconfig-003-20240308   gcc  
i386         buildonly-randconfig-004-20240307   gcc  
i386         buildonly-randconfig-004-20240308   gcc  
i386         buildonly-randconfig-005-20240307   gcc  
i386         buildonly-randconfig-005-20240308   gcc  
i386         buildonly-randconfig-006-20240307   clang
i386         buildonly-randconfig-006-20240308   clang
i386                                defconfig   clang
i386                  randconfig-001-20240307   gcc  
i386                  randconfig-001-20240308   clang
i386                  randconfig-002-20240307   gcc  
i386                  randconfig-002-20240308   clang
i386                  randconfig-003-20240307   clang
i386                  randconfig-003-20240308   clang
i386                  randconfig-004-20240307   gcc  
i386                  randconfig-004-20240308   gcc  
i386                  randconfig-005-20240307   gcc  
i386                  randconfig-005-20240308   clang
i386                  randconfig-006-20240307   clang
i386                  randconfig-006-20240308   clang
i386                  randconfig-011-20240307   clang
i386                  randconfig-011-20240308   gcc  
i386                  randconfig-012-20240307   gcc  
i386                  randconfig-012-20240308   clang
i386                  randconfig-013-20240307   clang
i386                  randconfig-013-20240308   clang
i386                  randconfig-014-20240307   clang
i386                  randconfig-014-20240308   clang
i386                  randconfig-015-20240307   clang
i386                  randconfig-015-20240308   gcc  
i386                  randconfig-016-20240307   clang
i386                  randconfig-016-20240308   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240307   gcc  
loongarch             randconfig-001-20240308   gcc  
loongarch             randconfig-002-20240307   gcc  
loongarch             randconfig-002-20240308   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1830-neo_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                           ip28_defconfig   gcc  
mips                     loongson1c_defconfig   gcc  
mips                          malta_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
mips                   sb1250_swarm_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240307   gcc  
nios2                 randconfig-001-20240308   gcc  
nios2                 randconfig-002-20240307   gcc  
nios2                 randconfig-002-20240308   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240307   gcc  
parisc                randconfig-001-20240308   gcc  
parisc                randconfig-002-20240307   gcc  
parisc                randconfig-002-20240308   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     powernv_defconfig   gcc  
powerpc                      ppc64e_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20240307   gcc  
powerpc               randconfig-001-20240308   gcc  
powerpc               randconfig-002-20240307   gcc  
powerpc               randconfig-003-20240307   gcc  
powerpc                  storcenter_defconfig   gcc  
powerpc                     tqm8540_defconfig   gcc  
powerpc                     tqm8560_defconfig   gcc  
powerpc64             randconfig-001-20240307   gcc  
powerpc64             randconfig-001-20240308   gcc  
powerpc64             randconfig-002-20240307   gcc  
powerpc64             randconfig-003-20240307   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240308   gcc  
s390                  randconfig-002-20240308   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                    randconfig-001-20240307   gcc  
sh                    randconfig-001-20240308   gcc  
sh                    randconfig-002-20240307   gcc  
sh                    randconfig-002-20240308   gcc  
sh                          rsk7201_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                            titan_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240307   gcc  
sparc64               randconfig-001-20240308   gcc  
sparc64               randconfig-002-20240307   gcc  
sparc64               randconfig-002-20240308   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240307   gcc  
um                    randconfig-002-20240308   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-002-20240308   gcc  
x86_64       buildonly-randconfig-003-20240308   gcc  
x86_64       buildonly-randconfig-004-20240307   clang
x86_64       buildonly-randconfig-005-20240308   gcc  
x86_64       buildonly-randconfig-006-20240307   clang
x86_64       buildonly-randconfig-006-20240308   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240308   gcc  
x86_64                randconfig-003-20240307   clang
x86_64                randconfig-005-20240308   gcc  
x86_64                randconfig-006-20240307   clang
x86_64                randconfig-006-20240308   gcc  
x86_64                randconfig-012-20240308   gcc  
x86_64                randconfig-014-20240307   clang
x86_64                randconfig-015-20240307   clang
x86_64                randconfig-015-20240308   gcc  
x86_64                randconfig-016-20240307   clang
x86_64                randconfig-016-20240308   gcc  
x86_64                randconfig-072-20240308   gcc  
x86_64                randconfig-073-20240307   clang
x86_64                randconfig-073-20240308   gcc  
x86_64                randconfig-074-20240308   gcc  
x86_64                randconfig-075-20240307   clang
x86_64                randconfig-075-20240308   gcc  
x86_64                randconfig-076-20240307   clang
x86_64                randconfig-076-20240308   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20240307   gcc  
xtensa                randconfig-001-20240308   gcc  
xtensa                randconfig-002-20240307   gcc  
xtensa                randconfig-002-20240308   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
