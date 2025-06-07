Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D7119CD16
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Jun 2025 10:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749292002; cv=none; b=Ro+6eViN1dbqZOTZ4W+pZ9L3JSQ0aXEkMKlFJRzM4yjghKRMBX7k2lTTDbY1W0s817xISU+ZmC0u5SNtuOyO5IOVQmMSDN2CTml4uq5RoV2Hb/Pt32s8LKw7btmAKQATf3o9ClRyBPscCS2xs13AIPxsS/IfcThH3kj2+sbr+DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749292002; c=relaxed/simple;
	bh=VxsRqVvrkOnsLU7Zs/Gv/0DC4b4B/6bDGDmcp1G/RME=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MTJyV1vKO+jTG486MMaVcwpqqsMjmnBb/7IqsYXgqhb9BY9PXcqMSgkR7G2WmwZsbc+2v/+uWgRLy6VJBlnbLg14UOttIy2iTsFxxNmwqaqsqtSj6d3otrSBjRqcgjIH5qtYZRIZgJZHt5vaxm0m7Kv+RzCvta/gbcSLlJDKJa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FwNFt3vz; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FwNFt3vz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749292000; x=1780828000;
  h=date:from:to:cc:subject:message-id;
  bh=VxsRqVvrkOnsLU7Zs/Gv/0DC4b4B/6bDGDmcp1G/RME=;
  b=FwNFt3vzCqVr3+eJIPP+Hi5PDzjzM7969tmWX7lN5AMuOjzFZBQSv7vu
   bfkd0v4YPcD3Pz+7UkScoz98+EOKssVfLz2FCdwfze61WQPVQf8HPrJ1d
   AYcZwoG0r+aSz0zjOHj/etXdechoTVhPXipUcPhSoTo+FM4l+f40ElkQn
   jZgAxGJBgP3JrkqJNBdKBxwjKTAW0lIENc2DYnRbEZOcwSmBowaFQunlR
   Z4VrnzoW0d9Eg+ztJUH/8Vt8XSMcI2vgz+cElgpLAmFqeMVA4w+02+yA7
   4OprUnQNgZACu2Y+avseZvAeY1ce99vmFzFvITC2feFIC/ANNQp+CV+bW
   w==;
X-CSE-ConnectionGUID: z1b7KEd5RGOqfsiyzAFO5g==
X-CSE-MsgGUID: NKXAfEz8T2a/UeG9odtkJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="50542486"
X-IronPort-AV: E=Sophos;i="6.16,217,1744095600"; 
   d="scan'208";a="50542486"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2025 03:26:39 -0700
X-CSE-ConnectionGUID: xrtcNPvvSM6+3ntCq/eP5A==
X-CSE-MsgGUID: TP7HzavCS0qO+OdGGPct/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,217,1744095600"; 
   d="scan'208";a="147006012"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 07 Jun 2025 03:26:37 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uNql1-0005iX-1w;
	Sat, 07 Jun 2025 10:26:35 +0000
Date: Sat, 07 Jun 2025 18:25:58 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 b4da091fed83d4cf3c217c1b6c563888ba058819
Message-ID: <202506071848.fqFH1K5e-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: b4da091fed83d4cf3c217c1b6c563888ba058819  Bluetooth: hci_sync: Fix broadcast/PA when using an existing instance

elapsed time: 916m

configs tested: 129
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250607    gcc-15.1.0
arc                   randconfig-002-20250607    gcc-15.1.0
arc                    vdk_hs38_smp_defconfig    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250607    clang-21
arm                   randconfig-002-20250607    gcc-13.3.0
arm                   randconfig-003-20250607    gcc-15.1.0
arm                   randconfig-004-20250607    gcc-14.3.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250607    clang-21
arm64                 randconfig-002-20250607    clang-21
arm64                 randconfig-003-20250607    clang-21
arm64                 randconfig-004-20250607    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250607    gcc-12.4.0
csky                  randconfig-002-20250607    gcc-9.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250607    clang-21
hexagon               randconfig-002-20250607    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250607    clang-20
i386        buildonly-randconfig-002-20250607    gcc-12
i386        buildonly-randconfig-003-20250607    gcc-12
i386        buildonly-randconfig-004-20250607    gcc-12
i386        buildonly-randconfig-005-20250607    clang-20
i386        buildonly-randconfig-006-20250607    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch             randconfig-001-20250607    gcc-13.3.0
loongarch             randconfig-002-20250607    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                     loongson1b_defconfig    clang-21
mips                         rt305x_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250607    gcc-10.5.0
nios2                 randconfig-002-20250607    gcc-5.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-32bit_defconfig    gcc-15.1.0
parisc                randconfig-001-20250607    gcc-12.4.0
parisc                randconfig-002-20250607    gcc-12.4.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                   lite5200b_defconfig    clang-21
powerpc                     mpc512x_defconfig    clang-21
powerpc                 mpc834x_itx_defconfig    clang-16
powerpc                  mpc866_ads_defconfig    clang-21
powerpc               randconfig-001-20250607    gcc-10.5.0
powerpc               randconfig-002-20250607    clang-21
powerpc               randconfig-003-20250607    clang-21
powerpc                     skiroot_defconfig    clang-21
powerpc                     tqm8548_defconfig    clang-21
powerpc64             randconfig-001-20250607    clang-19
powerpc64             randconfig-002-20250607    clang-21
powerpc64             randconfig-003-20250607    gcc-7.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250607    clang-21
riscv                 randconfig-002-20250607    clang-16
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250607    clang-16
s390                  randconfig-002-20250607    gcc-14.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                        apsh4ad0a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                         ecovec24_defconfig    gcc-15.1.0
sh                    randconfig-001-20250607    gcc-14.3.0
sh                    randconfig-002-20250607    gcc-9.3.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250607    gcc-10.3.0
sparc                 randconfig-002-20250607    gcc-12.4.0
sparc64                             defconfig    gcc-15.1.0
sparc64               randconfig-001-20250607    gcc-9.3.0
sparc64               randconfig-002-20250607    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250607    clang-21
um                    randconfig-002-20250607    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250607    clang-20
x86_64      buildonly-randconfig-002-20250607    clang-20
x86_64      buildonly-randconfig-003-20250607    clang-20
x86_64      buildonly-randconfig-004-20250607    gcc-12
x86_64      buildonly-randconfig-005-20250607    gcc-12
x86_64      buildonly-randconfig-006-20250607    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250607    gcc-10.5.0
xtensa                randconfig-002-20250607    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
