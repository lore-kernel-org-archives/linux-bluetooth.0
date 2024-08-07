Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E721C7B8F
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Aug 2024 07:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723015918; cv=none; b=tiOEkl7lZ8g44LkaWb1BX3HmbabtXS4VnTaqWR8b+1n8e2yfs5kvdKEcsE1KRIxo4lJJtbvUorA614F4N7ik6Uf6ig+NdU2uWlx2BM9PS33Qk8Pwp4cl26sUn95jV1iWZr4j2OFBuIQom1VSAKFAOpzIoG89A5H0J13CH8BKa2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723015918; c=relaxed/simple;
	bh=7CKxee13IE83t0qX0HBtQWheSZ6VVw3VNEIUK0SbjGQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CCllLG6amysnBhGjN4Dny4f/dJYOA8CYVWP+M15epAb6tkCD/P/pXLHJgkapHboy1Tf65NJiiH9XC/a5Sz7xuyHTcnWY993YMkkSF5QdCyBl7CbHMp3/+/QBFpY3QZE5HsXwx5u9Fljh23iHrrkmcYt1Uq+FXQaVPDnw2VGo5Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fT3exgGo; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fT3exgGo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723015916; x=1754551916;
  h=date:from:to:cc:subject:message-id;
  bh=7CKxee13IE83t0qX0HBtQWheSZ6VVw3VNEIUK0SbjGQ=;
  b=fT3exgGomchWgCVYu0IED9ip3ZfbmAL7crN5FSmvh2LradAEMvrE+D89
   qg2CafgCHOmmnsReRLyTllpfK+PkR32VHglmBEGD9GPj1G0+NIDCZP1S3
   +BDFCjWHfJ3ki1O7v5gkt5HwjqLLtTiYuMpXGy1Vy7bmuCtQQrM60DTTP
   DapAMMUxAYnOmHD43ljDvsE1PBVDvQbnco4hO9kN4pEq4cQRlQ+Rj18Ly
   PDQJcfsG7Few+YjJW2A0kFOTEweMrOYkjfSewLFlcTVuKMtaaE+uXk4nY
   PHAbnoykubfCWNREb8/9l4nVmyj6+9vvC9ijW5IaaZ1NQ4vNOXbXoHDbp
   g==;
X-CSE-ConnectionGUID: hnXvtu32RcetoYjsq1CTPg==
X-CSE-MsgGUID: 2OlwzjMLSdOqmsCu7+h8mQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="21244470"
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="21244470"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 00:31:56 -0700
X-CSE-ConnectionGUID: l3GV0TJkSMyj567wuYuwAQ==
X-CSE-MsgGUID: FQ9xakA0RY2QgtUsOpKpkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="56992248"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 07 Aug 2024 00:31:55 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbb97-0005Cq-1l;
	Wed, 07 Aug 2024 07:31:48 +0000
Date: Wed, 07 Aug 2024 15:31:26 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 bd0b4dae74b0f0ee9ea37818e1c132b56a26d6dd
Message-ID: <202408071524.JwCwxCxc-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: bd0b4dae74b0f0ee9ea37818e1c132b56a26d6dd  Bluetooth: btusb: Add MediaTek MT7925-B22M support ID 0x13d3:0x3604

Warning ids grouped by kconfigs:

recent_errors
`-- arm64-randconfig-051-20240807
    |-- arch-arm64-boot-dts-qcom-sm8650-qrd.dtb:bluetooth:vddrfa1p8-supply-is-a-required-property
    |-- arch-arm64-boot-dts-qcom-sm8650-qrd.dtb:bluetooth:vddrfacmn-supply-is-a-required-property
    |-- arch-arm64-boot-dts-qcom-sm8650-qrd.dtb:bluetooth:vddwlcx-supply-is-a-required-property
    `-- arch-arm64-boot-dts-qcom-sm8650-qrd.dtb:bluetooth:vddwlmx-supply-is-a-required-property

elapsed time: 729m

configs tested: 149
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240807   gcc-13.2.0
arc                   randconfig-002-20240807   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                   randconfig-001-20240807   clang-20
arm                   randconfig-002-20240807   gcc-14.1.0
arm                   randconfig-003-20240807   gcc-14.1.0
arm                   randconfig-004-20240807   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240807   gcc-14.1.0
arm64                 randconfig-002-20240807   clang-17
arm64                 randconfig-003-20240807   clang-15
arm64                 randconfig-004-20240807   clang-20
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240807   gcc-14.1.0
csky                  randconfig-002-20240807   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240807   clang-14
hexagon               randconfig-002-20240807   clang-20
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240807   clang-18
i386         buildonly-randconfig-002-20240807   clang-18
i386         buildonly-randconfig-003-20240807   clang-18
i386         buildonly-randconfig-003-20240807   gcc-12
i386         buildonly-randconfig-004-20240807   clang-18
i386         buildonly-randconfig-005-20240807   clang-18
i386         buildonly-randconfig-006-20240807   clang-18
i386         buildonly-randconfig-006-20240807   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240807   clang-18
i386                  randconfig-001-20240807   gcc-12
i386                  randconfig-002-20240807   clang-18
i386                  randconfig-003-20240807   clang-18
i386                  randconfig-004-20240807   clang-18
i386                  randconfig-004-20240807   gcc-12
i386                  randconfig-005-20240807   clang-18
i386                  randconfig-005-20240807   gcc-12
i386                  randconfig-006-20240807   clang-18
i386                  randconfig-011-20240807   clang-18
i386                  randconfig-012-20240807   clang-18
i386                  randconfig-012-20240807   gcc-11
i386                  randconfig-013-20240807   clang-18
i386                  randconfig-014-20240807   clang-18
i386                  randconfig-015-20240807   clang-18
i386                  randconfig-016-20240807   clang-18
i386                  randconfig-016-20240807   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240807   gcc-14.1.0
loongarch             randconfig-002-20240807   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240807   gcc-14.1.0
nios2                 randconfig-002-20240807   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240807   gcc-14.1.0
parisc                randconfig-002-20240807   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc               randconfig-001-20240807   clang-20
powerpc               randconfig-002-20240807   clang-20
powerpc               randconfig-003-20240807   gcc-14.1.0
powerpc64             randconfig-001-20240807   clang-15
powerpc64             randconfig-002-20240807   gcc-14.1.0
powerpc64             randconfig-003-20240807   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   clang-20
riscv                 randconfig-001-20240807   clang-20
riscv                 randconfig-002-20240807   clang-20
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                  randconfig-001-20240807   gcc-14.1.0
s390                  randconfig-002-20240807   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240807   gcc-14.1.0
sh                    randconfig-002-20240807   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240807   gcc-14.1.0
sparc64               randconfig-002-20240807   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                                  defconfig   clang-20
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240807   gcc-12
um                    randconfig-002-20240807   clang-20
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240807   clang-18
x86_64       buildonly-randconfig-002-20240807   clang-18
x86_64       buildonly-randconfig-003-20240807   clang-18
x86_64       buildonly-randconfig-004-20240807   clang-18
x86_64       buildonly-randconfig-005-20240807   clang-18
x86_64       buildonly-randconfig-006-20240807   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240807   clang-18
x86_64                randconfig-002-20240807   gcc-12
x86_64                randconfig-003-20240807   clang-18
x86_64                randconfig-004-20240807   gcc-12
x86_64                randconfig-006-20240807   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240807   gcc-14.1.0
xtensa                randconfig-002-20240807   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
