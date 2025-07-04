Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2F242A83
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Jul 2025 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751632985; cv=none; b=Dguzit36c//FJgHEnuzkVwj6dSsT/S+1lvI3ZCY63RY4Mb5bE6xFY4Mp2Rvs+1u5SCdU3dicDnOHIcNs1W6B0Lb9uPySKEUdtv5xP+eHIExGsTH5pDAzxZZSy7NvrBTcEux2TicZh931N/e+91bRA4Ni/0itR77qaCNcZee8sms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751632985; c=relaxed/simple;
	bh=MdYJ4b0mJpMIaops6wNh5XiBPBSrqAOcCkQoRyYEj8s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Y97mHKlp8MBNDPOZUyO9lmPHK0DHZAd95A3FVi3dbs+KyNQHmD97gMly8ExLo5JQuv2kwnFWfnZpnicnyAJiPtzgPginamYWVXygAlvbNPpRcft4OfWETCfjFtg+Hh3sqXSJtaCNr0npqOzDfB+dZS0kHgoEe/OJuLmu+r1clxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BogfSy+/; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BogfSy+/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751632983; x=1783168983;
  h=date:from:to:cc:subject:message-id;
  bh=MdYJ4b0mJpMIaops6wNh5XiBPBSrqAOcCkQoRyYEj8s=;
  b=BogfSy+/MsMwBcJxUGwAXJ4IMumV0Tc7jwz+YDlZi6dpyv2NqDd/EVWI
   gOeX+UnMPOvgJ/GayvHAcnC3cYVa7WBHNoMK/raiEq1Q1HYEQpCMgBevZ
   +n7XyxLwBDYO+hw/dVxBT3NOIKYj3Vt16JHwTXB2ysJgNUgkjJXuhuPW6
   r/ocobplfy47RTHVtm16TPk/sVJ36Q9fC37n7FKjm+8ME/QEed9zQFinJ
   4KydN3JntfdaJ/owV207StzDI7QguaaFogoIS6Ssoe9O4nt3ja7Q71V4a
   4lY6y3aELVWw/JiVd7YrALetgLZ3ebPwdNIZu+YD2U8VEanYzgUsDqNeC
   w==;
X-CSE-ConnectionGUID: U0y0JuUGSdyH+1d/9YVtCA==
X-CSE-MsgGUID: 7tJku0mdQOet2bsXcuI1hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="65023707"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="65023707"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 05:42:53 -0700
X-CSE-ConnectionGUID: P5yvCO+eQhuwKjhC88GttQ==
X-CSE-MsgGUID: 6gBOlrJSR0mDU6A4sodnBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="185591681"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 04 Jul 2025 05:42:52 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uXfkg-0003iJ-0i;
	Fri, 04 Jul 2025 12:42:50 +0000
Date: Fri, 04 Jul 2025 20:41:55 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 b8db3a9d4daeb7ff6a56c605ad6eca24e4da78ed
Message-ID: <202507042043.ZK7kntBT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: b8db3a9d4daeb7ff6a56c605ad6eca24e4da78ed  Bluetooth: hci_event: Fix not marking Broadcast Sink BIS as connected

elapsed time: 1224m

configs tested: 125
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250704    gcc-15.1.0
arc                   randconfig-002-20250704    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                          moxart_defconfig    gcc-15.1.0
arm                   randconfig-001-20250704    gcc-7.5.0
arm                   randconfig-002-20250704    clang-21
arm                   randconfig-003-20250704    gcc-7.5.0
arm                   randconfig-004-20250704    gcc-13.4.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250704    gcc-14.3.0
arm64                 randconfig-002-20250704    clang-21
arm64                 randconfig-003-20250704    clang-16
arm64                 randconfig-004-20250704    gcc-10.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250704    gcc-15.1.0
csky                  randconfig-002-20250704    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250704    clang-21
hexagon               randconfig-002-20250704    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250704    gcc-12
i386        buildonly-randconfig-002-20250704    clang-20
i386        buildonly-randconfig-003-20250704    clang-20
i386        buildonly-randconfig-004-20250704    clang-20
i386        buildonly-randconfig-005-20250704    clang-20
i386        buildonly-randconfig-006-20250704    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250704    gcc-15.1.0
loongarch             randconfig-002-20250704    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250704    gcc-7.5.0
nios2                 randconfig-002-20250704    gcc-10.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250704    gcc-14.3.0
parisc                randconfig-002-20250704    gcc-6.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                       eiger_defconfig    clang-21
powerpc               randconfig-001-20250704    clang-21
powerpc               randconfig-002-20250704    gcc-9.3.0
powerpc               randconfig-003-20250704    clang-21
powerpc                         wii_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250704    clang-18
powerpc64             randconfig-002-20250704    gcc-10.5.0
powerpc64             randconfig-003-20250704    clang-18
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250704    clang-21
riscv                 randconfig-002-20250704    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250704    gcc-15.1.0
s390                  randconfig-002-20250704    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          landisk_defconfig    gcc-15.1.0
sh                    randconfig-001-20250704    gcc-15.1.0
sh                    randconfig-002-20250704    gcc-13.4.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250704    gcc-11.5.0
sparc                 randconfig-002-20250704    gcc-6.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250704    gcc-13.4.0
sparc64               randconfig-002-20250704    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250704    clang-21
um                    randconfig-002-20250704    clang-21
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250704    clang-20
x86_64      buildonly-randconfig-002-20250704    gcc-12
x86_64      buildonly-randconfig-003-20250704    clang-20
x86_64      buildonly-randconfig-004-20250704    clang-20
x86_64      buildonly-randconfig-005-20250704    clang-20
x86_64      buildonly-randconfig-006-20250704    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250704    gcc-12.4.0
xtensa                randconfig-002-20250704    gcc-15.1.0
xtensa                         virt_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
