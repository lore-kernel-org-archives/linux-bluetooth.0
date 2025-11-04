Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B452A381C4
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762281608; cv=none; b=sjnhbPjxKCT2yywNGMP3n08ObR7oMUJC6uZTlF8aOUopqtcH0+WLxCX90J1/O3ofYScjisXQPqRyGKdAw4sgbYRoGdc5F92aHt2kKCBAFTziEpivgUYyPRf/JaS9UstWDWZYlqnYiu147IAqihh7fe6W10zRzLIX6q4A/Kj8riA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762281608; c=relaxed/simple;
	bh=QGiYbNC6yMdsFyC/01kl7c02qYpJBJHq/kejlIP1u5s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ye7RZLe1jZcsMzhT/lRaqy6LU0LiVMkqxX404ILMlOpAPnopzdQpCgyTj+xcgCb5duHpsJ9Ligl9BcLsY69I7v9DoMfehzzK8dPGM5td4Qp5niONOf5PeZSr7K6sF4DaZxaf9FI3KLDlgBBBNRbVWIFD5N0s7WfeCajeU3x30Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AGO/PFVt; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AGO/PFVt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762281607; x=1793817607;
  h=date:from:to:cc:subject:message-id;
  bh=QGiYbNC6yMdsFyC/01kl7c02qYpJBJHq/kejlIP1u5s=;
  b=AGO/PFVtMFdiotrwWvZrvjcH5jabng3KFw42w+sr8B4kI61PRKTQONHW
   VTeiltD9kUE0M6LlYuQa3dhhhVt2hJn3msFOYEQ2m18NpDC6vy9XiSc7r
   ToUqaoOG6p72JZwyLKJRlegtcCRpNL0KaYLJ0IHivNKSaSyG/YmwYCLzK
   Bzm0h0UPV8+FnGCfIOfi0MyaXyKhsfEaFk0+8iNSKbvH6o5zux8TGcfDe
   iwCP4HAKmMvq/jrtKNhUM4tfpjgz8jBvt+p2zK4BZcrsfBqHFzIyiBgoT
   YP6hh2tokaSgM2O9eKvJv0IxVXA4l9L+0EIFJSlCbJVdC8+VLy2NkkrCI
   w==;
X-CSE-ConnectionGUID: EhEnNisITF2h49tfE8PXVQ==
X-CSE-MsgGUID: sboJs5c0SUSRH3ntZc+XKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="63396136"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="63396136"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 10:40:05 -0800
X-CSE-ConnectionGUID: JgZ0uL6NTVudA24KZMuY/Q==
X-CSE-MsgGUID: w65o1ZJ4SyeiwRD4facahQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="186474950"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 04 Nov 2025 10:40:04 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGLwn-000Rjo-1q;
	Tue, 04 Nov 2025 18:40:01 +0000
Date: Wed, 05 Nov 2025 02:39:33 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 2747d929617743ecba08eeeb310283b4be681383
Message-ID: <202511050228.PpgMgcwk-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 2747d929617743ecba08eeeb310283b4be681383  Bluetooth: MGMT: cancel mesh send timer when hdev removed

elapsed time: 1479m

configs tested: 110
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20251104    gcc-12.5.0
arc                   randconfig-002-20251104    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                        mvebu_v7_defconfig    clang-22
arm                             pxa_defconfig    gcc-15.1.0
arm                   randconfig-001-20251104    gcc-14.3.0
arm                   randconfig-002-20251104    gcc-10.5.0
arm                   randconfig-003-20251104    clang-22
arm                   randconfig-004-20251104    gcc-8.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251104    gcc-13.4.0
arm64                 randconfig-002-20251104    clang-22
arm64                 randconfig-003-20251104    gcc-13.4.0
arm64                 randconfig-004-20251104    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251104    gcc-10.5.0
csky                  randconfig-002-20251104    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251104    clang-22
hexagon               randconfig-002-20251104    clang-16
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251104    gcc-14
i386        buildonly-randconfig-002-20251104    clang-20
i386        buildonly-randconfig-003-20251104    gcc-12
i386        buildonly-randconfig-004-20251104    gcc-14
i386        buildonly-randconfig-005-20251104    gcc-12
i386        buildonly-randconfig-006-20251104    gcc-14
i386                  randconfig-011-20251104    gcc-13
i386                  randconfig-012-20251104    clang-20
i386                  randconfig-013-20251104    gcc-14
i386                  randconfig-014-20251104    clang-20
i386                  randconfig-015-20251104    gcc-14
i386                  randconfig-016-20251104    clang-20
i386                  randconfig-017-20251104    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251104    gcc-15.1.0
loongarch             randconfig-002-20251104    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                            mac_defconfig    gcc-15.1.0
m68k                        mvme16x_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20251104    gcc-8.5.0
nios2                 randconfig-002-20251104    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                 simple_smp_defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                randconfig-001-20251104    gcc-8.5.0
parisc                randconfig-002-20251104    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                   lite5200b_defconfig    clang-22
powerpc                      ppc44x_defconfig    clang-22
powerpc               randconfig-001-20251104    gcc-15.1.0
powerpc               randconfig-002-20251104    clang-22
powerpc64             randconfig-001-20251104    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20251104    gcc-8.5.0
riscv                 randconfig-002-20251104    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20251104    clang-22
s390                  randconfig-002-20251104    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251104    gcc-13.4.0
sh                    randconfig-002-20251104    gcc-11.5.0
sh                           se7343_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20251104    gcc-13.4.0
sparc                 randconfig-002-20251104    gcc-12.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251104    gcc-8.5.0
sparc64               randconfig-002-20251104    clang-22
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251104    clang-22
um                    randconfig-002-20251104    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251104    clang-20
x86_64      buildonly-randconfig-002-20251104    gcc-12
x86_64      buildonly-randconfig-003-20251104    gcc-14
x86_64      buildonly-randconfig-004-20251104    gcc-14
x86_64      buildonly-randconfig-005-20251104    gcc-12
x86_64      buildonly-randconfig-006-20251104    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20251104    gcc-14
x86_64                randconfig-012-20251104    gcc-14
x86_64                randconfig-013-20251104    clang-20
x86_64                randconfig-014-20251104    clang-20
x86_64                randconfig-015-20251104    gcc-14
x86_64                randconfig-016-20251104    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251104    gcc-13.4.0
xtensa                randconfig-002-20251104    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
