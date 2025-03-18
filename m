Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F521DC9B4
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 20:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742329363; cv=none; b=YY6Ro+WclMJS1XTjvZff3XUbBIbUcRkeSlxIyOlgG8dgjuBX4tlnPiX4Mwdgx95u0r7FIFJwulXDi+vIXAD2x3kUNfscUu27xVCJcJcibXY57cW4UKeWhHmOWpef/sAGQG1ZGF1Po8qiWKJ55pPhm+J3/LmotlF4O1bSmIi36wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742329363; c=relaxed/simple;
	bh=v8ZT0eXCVa56VFLjQso6S2vy2KXWOjobWMuHK/ffZXU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=g1HBQlKmxu0f23/eVyaJ1CbdJZCL495lh5hpdENoSF/kS6zj9d8yO3P7hukDbOsCIQENwSR5u+FBiY+zZinFIZM/4lSNpDwvBuplbjvV8mufTk0nMFAbge1spoSieE0AYg2hh9+4V1bXz3XccggBfFUfwVyaPRzTJuz7q2Qs6lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O0Tk+72M; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0Tk+72M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742329361; x=1773865361;
  h=date:from:to:cc:subject:message-id;
  bh=v8ZT0eXCVa56VFLjQso6S2vy2KXWOjobWMuHK/ffZXU=;
  b=O0Tk+72MJZzqVYvq+v9L6MCn3Eso4LhSQlEBBKLoe1Mzz+NekHYete2E
   sEAxbnzeofdlfMWKr8/7kFm9Dr07aXJGqSu9BS7pMrH7tqdoihscWPYjv
   MJ907FsHbTGa0Z30KOhrP69ZTOVLC/7NtFtc9UBRYw/yd3CTZwUacZaHx
   jY4Tc7akk0Edok/Mxb/I9OrSwwZGLsZS0RUXJa0ZJ3BhCm16YhbqnbnBU
   jyrBCRQXS0vB75acIbhlk2QU1ebpBqHQdr2vJzcv9q1QkYj/2VSQnGUJ8
   IAcgVSmdCy4ngUkfONfLMwQMg2+xh6SvuuD16sAsg0recwxY7FbAp2E8x
   Q==;
X-CSE-ConnectionGUID: KXv/PWJ8SUaUxqfktE+ALA==
X-CSE-MsgGUID: Xo740rWGS56uB/8+77FG5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="47379752"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="47379752"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 13:22:40 -0700
X-CSE-ConnectionGUID: BGnWOD6MSu6Mqvx2TDQKLQ==
X-CSE-MsgGUID: s5c0xMprRiKINM4008iDuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="122546651"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 18 Mar 2025 13:22:40 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tudSM-000E9e-0L;
	Tue, 18 Mar 2025 20:22:35 +0000
Date: Wed, 19 Mar 2025 04:21:54 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 482d9aaf2fd243483b3f0bf99d6948c2b63db3bd
Message-ID: <202503190439.qdeAoZdB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 482d9aaf2fd243483b3f0bf99d6948c2b63db3bd  Bluetooth: HCI: Add definition of hci_rp_remote_name_req_cancel

elapsed time: 1450m

configs tested: 121
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-13.3.0
arc                              allyesconfig    gcc-10.5.0
arc                   randconfig-001-20250318    gcc-13.2.0
arc                   randconfig-002-20250318    gcc-13.2.0
arm                              allmodconfig    gcc-13.3.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                      footbridge_defconfig    clang-17
arm                       netwinder_defconfig    gcc-9.3.0
arm                   randconfig-001-20250318    gcc-14.2.0
arm                   randconfig-002-20250318    clang-21
arm                   randconfig-003-20250318    gcc-14.2.0
arm                   randconfig-004-20250318    clang-21
arm                           stm32_defconfig    gcc-8.5.0
arm                         vf610m4_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-8.5.0
arm64                 randconfig-001-20250318    clang-21
arm64                 randconfig-002-20250318    clang-14
arm64                 randconfig-003-20250318    gcc-14.2.0
arm64                 randconfig-004-20250318    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250318    gcc-14.2.0
csky                  randconfig-002-20250318    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250318    clang-21
hexagon               randconfig-002-20250318    clang-17
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250318    clang-20
i386        buildonly-randconfig-002-20250318    clang-20
i386        buildonly-randconfig-003-20250318    clang-20
i386        buildonly-randconfig-004-20250318    clang-20
i386        buildonly-randconfig-005-20250318    clang-20
i386        buildonly-randconfig-006-20250318    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250318    gcc-14.2.0
loongarch             randconfig-002-20250318    gcc-14.2.0
m68k                             allmodconfig    gcc-8.5.0
m68k                              allnoconfig    gcc-5.5.0
m68k                             allyesconfig    gcc-6.5.0
m68k                       m5208evb_defconfig    gcc-14.2.0
m68k                        mvme16x_defconfig    gcc-11.5.0
m68k                          sun3x_defconfig    gcc-5.5.0
microblaze                       alldefconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-9.3.0
microblaze                        allnoconfig    gcc-11.5.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                   sb1250_swarm_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250318    gcc-14.2.0
nios2                 randconfig-002-20250318    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-5.5.0
parisc                            allnoconfig    gcc-5.5.0
parisc                           allyesconfig    gcc-9.3.0
parisc                randconfig-001-20250318    gcc-14.2.0
parisc                randconfig-002-20250318    gcc-14.2.0
powerpc                          allmodconfig    gcc-10.5.0
powerpc                           allnoconfig    gcc-8.5.0
powerpc                          allyesconfig    clang-21
powerpc                      cm5200_defconfig    clang-21
powerpc                   motionpro_defconfig    clang-15
powerpc                 mpc832x_rdb_defconfig    gcc-9.3.0
powerpc               randconfig-001-20250318    clang-21
powerpc               randconfig-002-20250318    clang-21
powerpc               randconfig-003-20250318    gcc-14.2.0
powerpc                     tqm8540_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250318    clang-21
powerpc64             randconfig-002-20250318    gcc-14.2.0
powerpc64             randconfig-003-20250318    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-7.5.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250318    clang-21
riscv                 randconfig-002-20250318    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250318    clang-15
s390                  randconfig-002-20250318    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-10.5.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250318    gcc-14.2.0
sh                    randconfig-002-20250318    gcc-14.2.0
sh                   sh7724_generic_defconfig    gcc-6.5.0
sh                        sh7785lcr_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-6.5.0
sparc                 randconfig-001-20250318    gcc-14.2.0
sparc                 randconfig-002-20250318    gcc-14.2.0
sparc64               randconfig-001-20250318    gcc-14.2.0
sparc64               randconfig-002-20250318    gcc-14.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250318    clang-21
um                    randconfig-002-20250318    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250318    clang-20
x86_64      buildonly-randconfig-002-20250318    clang-20
x86_64      buildonly-randconfig-003-20250318    clang-20
x86_64      buildonly-randconfig-004-20250318    clang-20
x86_64      buildonly-randconfig-005-20250318    gcc-12
x86_64      buildonly-randconfig-006-20250318    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250318    gcc-14.2.0
xtensa                randconfig-002-20250318    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
