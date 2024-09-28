Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1081319470
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Sep 2024 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727538383; cv=none; b=apZVDcWgRWWsRXdcwleKVvs2rLcZ/3HSQ94FkKfxnA0sE1IyccdRBJvZK873079PveYok92b1kilV6xqerXAiu22k1Qg7vih8S0jDpTS3rOLpho1DaB59uNvYgX/mnzTsNTMhfif8IpJsyFtjIwUV4oJXghacp1sd6dCiaRGRkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727538383; c=relaxed/simple;
	bh=2nQb0vtmEEqJehNzxgzYyZ1jCR+5W7VjkWs0L3l7OCk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pMdoP7lQqWogVzzz8mGrjTicHESDUDkmpYO7RPTuyr2/LUcD7O4eiTfJHD5Mx6HQ8ypLLM2oE06wtBXsAcgPIibtXlM1MvOGzrD5u0NAsojBV1BzG3CVatlqvEvZuUV5ckPEsuNmjF8SdQus4HBNQgvfUt/kdsuzUbAafaCrgx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U+YPxidS; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U+YPxidS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727538381; x=1759074381;
  h=date:from:to:cc:subject:message-id;
  bh=2nQb0vtmEEqJehNzxgzYyZ1jCR+5W7VjkWs0L3l7OCk=;
  b=U+YPxidShCoSP2K0I56hocDETeNLuf2+XRXt+hOq+ysgc+FZdL1dAaB3
   bbQj8l/zizM9KtXy4YIXihIRiXsFt1OMV1VWjyrybaL75FiMdcoJ5r9x9
   FGcchvX5lTbdndoe5OR1Wh9T/k2g5aMaMahLPPjd6tFOyrOs2OxqnuF6+
   j2wYA8GGK71chvWL4LbtrAJwIsOET7WBDl5SpVjAf5EqzuW9T+GEEdh7U
   GqZ81je4O+5+UCGIgzJkfeAXnnAfSZaEzIz/ae3sBeCIQ7mGPJMgwzVRh
   LRiT/K+fZMP/ZWnM3Kv3DN0Y/FfiMbX9AOYlMfqMSAiMzhpcl2WsBDyrR
   g==;
X-CSE-ConnectionGUID: dx59g4JuTBOVjY8qYFcUeQ==
X-CSE-MsgGUID: oRNu43PCSOmNc8RS37U+Ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="44135341"
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="44135341"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2024 08:46:20 -0700
X-CSE-ConnectionGUID: iZN8WMRiSV6+AY4zzlJJrQ==
X-CSE-MsgGUID: 9/nN2kmeQHiQeD/WZYElEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="77358849"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 28 Sep 2024 08:46:19 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1suZeD-000NO1-04;
	Sat, 28 Sep 2024 15:46:17 +0000
Date: Sat, 28 Sep 2024 23:46:12 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 cc34f7a69916dcddfb3b5e29fac263b85ec5faa9
Message-ID: <202409282306.SoKex5xW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: cc34f7a69916dcddfb3b5e29fac263b85ec5faa9  Bluetooth: btnxpuart: Rename IW615 to IW610

elapsed time: 1450m

configs tested: 161
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                            allyesconfig    gcc-13.3.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                        nsim_700_defconfig    gcc-13.2.0
arc                   randconfig-001-20240928    gcc-13.2.0
arc                   randconfig-002-20240928    gcc-13.2.0
arm                               allnoconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                       aspeed_g4_defconfig    clang-20
arm                          collie_defconfig    gcc-14.1.0
arm                             pxa_defconfig    gcc-14.1.0
arm                   randconfig-001-20240928    gcc-14.1.0
arm                   randconfig-002-20240928    gcc-14.1.0
arm                   randconfig-003-20240928    clang-20
arm                   randconfig-004-20240928    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                 randconfig-001-20240928    gcc-14.1.0
arm64                 randconfig-002-20240928    gcc-14.1.0
arm64                 randconfig-003-20240928    clang-20
arm64                 randconfig-004-20240928    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20240928    gcc-14.1.0
csky                  randconfig-002-20240928    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20240928    clang-20
hexagon               randconfig-002-20240928    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240928    clang-18
i386        buildonly-randconfig-002-20240928    gcc-12
i386        buildonly-randconfig-003-20240928    clang-18
i386        buildonly-randconfig-004-20240928    gcc-12
i386        buildonly-randconfig-005-20240928    gcc-12
i386        buildonly-randconfig-006-20240928    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20240928    clang-18
i386                  randconfig-002-20240928    gcc-12
i386                  randconfig-003-20240928    clang-18
i386                  randconfig-004-20240928    clang-18
i386                  randconfig-005-20240928    clang-18
i386                  randconfig-006-20240928    gcc-12
i386                  randconfig-011-20240928    clang-18
i386                  randconfig-012-20240928    gcc-12
i386                  randconfig-013-20240928    clang-18
i386                  randconfig-014-20240928    clang-18
i386                  randconfig-015-20240928    clang-18
i386                  randconfig-016-20240928    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch             randconfig-001-20240928    gcc-14.1.0
loongarch             randconfig-002-20240928    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                          multi_defconfig    gcc-14.1.0
m68k                           sun3_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                     cu1000-neo_defconfig    gcc-13.2.0
mips                            gpr_defconfig    clang-20
mips                     loongson1c_defconfig    gcc-13.2.0
nios2                             allnoconfig    gcc-14.1.0
nios2                 randconfig-001-20240928    gcc-14.1.0
nios2                 randconfig-002-20240928    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-14.1.0
openrisc                 simple_smp_defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-14.1.0
parisc                randconfig-001-20240928    gcc-14.1.0
parisc                randconfig-002-20240928    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc                     mpc512x_defconfig    clang-20
powerpc               randconfig-001-20240928    gcc-14.1.0
powerpc               randconfig-002-20240928    gcc-14.1.0
powerpc               randconfig-003-20240928    clang-20
powerpc                     tqm5200_defconfig    gcc-14.1.0
powerpc64             randconfig-001-20240928    clang-20
powerpc64             randconfig-002-20240928    clang-20
powerpc64             randconfig-003-20240928    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-20
riscv                 randconfig-001-20240928    gcc-14.1.0
riscv                 randconfig-002-20240928    gcc-14.1.0
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    clang-20
s390                  randconfig-001-20240928    clang-15
s390                  randconfig-002-20240928    clang-20
s390                       zfcpdump_defconfig    clang-20
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-14.1.0
sh                    randconfig-001-20240928    gcc-14.1.0
sh                    randconfig-002-20240928    gcc-14.1.0
sh                          rsk7201_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-14.1.0
sparc64               randconfig-001-20240928    gcc-14.1.0
sparc64               randconfig-002-20240928    gcc-14.1.0
um                               alldefconfig    clang-20
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20240928    clang-16
um                    randconfig-002-20240928    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20240928    clang-18
x86_64      buildonly-randconfig-002-20240928    gcc-12
x86_64      buildonly-randconfig-003-20240928    gcc-12
x86_64      buildonly-randconfig-004-20240928    gcc-12
x86_64      buildonly-randconfig-005-20240928    clang-18
x86_64      buildonly-randconfig-006-20240928    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                randconfig-001-20240928    clang-18
x86_64                randconfig-002-20240928    gcc-12
x86_64                randconfig-003-20240928    clang-18
x86_64                randconfig-004-20240928    gcc-12
x86_64                randconfig-005-20240928    clang-18
x86_64                randconfig-006-20240928    gcc-11
x86_64                randconfig-011-20240928    gcc-12
x86_64                randconfig-012-20240928    gcc-12
x86_64                randconfig-013-20240928    gcc-12
x86_64                randconfig-014-20240928    clang-18
x86_64                randconfig-015-20240928    gcc-12
x86_64                randconfig-016-20240928    gcc-12
x86_64                randconfig-071-20240928    gcc-12
x86_64                randconfig-072-20240928    clang-18
x86_64                randconfig-073-20240928    gcc-11
x86_64                randconfig-074-20240928    clang-18
x86_64                randconfig-075-20240928    gcc-12
x86_64                randconfig-076-20240928    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-func    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20240928    gcc-14.1.0
xtensa                randconfig-002-20240928    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
