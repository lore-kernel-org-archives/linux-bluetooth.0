Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061254C96
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Oct 2024 03:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729395441; cv=none; b=N2EDz69r8D6Vmam9mrEWlsXMYCkLcipSfx1yXYhuSfltn41Wtc3qqi+9qKTmKYUduXY7Lu+PfVo+nYUvttgHZALtH1hUDLKoBBojjqRtFor7wdf4kPDXnHO8THvTu1zaA1xsPPXrMk20zYlM3xiQ6+TFpzf5blthGQYOdE5yNSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729395441; c=relaxed/simple;
	bh=cOJ2TdDJyisG3jpJKHgjOwLcjdhFSR93Ir3INuovlXU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=lyC+lyHB+EFxLM+k3CAFtJY21XfI6p2+/8FTgZykKzcJ1j3UDtsy/JSEIT4zWC9UDw6P/ngwQ1kxlrAuJ33ajhlLs8jJL1gw5YHTMxLSlCmx0GO2YtqbdMdHlw8RA8CFV4LIqYo1n8JjTSetPYHP1f6gG4lLnxymokysVvfGM50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i5fYqyGX; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i5fYqyGX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729395438; x=1760931438;
  h=date:from:to:cc:subject:message-id;
  bh=cOJ2TdDJyisG3jpJKHgjOwLcjdhFSR93Ir3INuovlXU=;
  b=i5fYqyGXM+uI8wQxODP0RdtxE9X0okTwsR93tBnFcppsnUUZpHEz6yyG
   clKxqOt+OTG096tHtNyujNtNUDEuHsJOfs/DuzQQ/Mpr2Pj9hY3VZl8x+
   F9WuoptMe2WCgJjsjSyC6lMUZFEGVeHAt8Y1bVUFMGAqINiAGb60rjXWa
   yiaUKLEm5aAvtFXh6MT9s+zzQMJ8tXmDjeiAxki/aujGAElb29K0Y6PSN
   ueA9mcY7xWwuEkQqRBRDDDpurftYOn52khzoFiSrxqKXJ4AVD0GSvWpGW
   JmqbZXtQ5no9mErFsBEPYo2Cp+nUZpJlgXR7WXU6GCdkIo7Xa5HjGNheV
   Q==;
X-CSE-ConnectionGUID: BhVZA/6lSHmhhDSPqCkh0A==
X-CSE-MsgGUID: hx03PdYrR3uKHxN9y37EOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29012102"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29012102"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2024 20:37:14 -0700
X-CSE-ConnectionGUID: y70HBIjnTtmiDoDahU796w==
X-CSE-MsgGUID: Z76xSjO0Sh2R5ipLHCjRlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,217,1725346800"; 
   d="scan'208";a="79548076"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 19 Oct 2024 20:37:13 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2Mkg-000PqX-2z;
	Sun, 20 Oct 2024 03:37:10 +0000
Date: Sun, 20 Oct 2024 11:37:04 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 4d67eb2b5444e1c872db4f04e7921ae8a95251fe
Message-ID: <202410201156.dqiHrEyW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 4d67eb2b5444e1c872db4f04e7921ae8a95251fe  Bluetooth: btintel: Do no pass vendor events to stack

elapsed time: 3489m

configs tested: 67
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                            allyesconfig    gcc-13.3.0
arc                               allnoconfig    gcc-13.2.0
arc                   randconfig-001-20241020    gcc-13.2.0
arc                   randconfig-002-20241020    gcc-13.2.0
arm                               allnoconfig    clang-20
arm                        keystone_defconfig    gcc-14.1.0
arm                        multi_v7_defconfig    gcc-14.1.0
arm                       netwinder_defconfig    gcc-14.1.0
arm                   randconfig-001-20241020    gcc-14.1.0
arm                   randconfig-002-20241020    gcc-14.1.0
arm                   randconfig-003-20241020    clang-20
arm                         socfpga_defconfig    gcc-14.1.0
arm                         wpcm450_defconfig    gcc-14.1.0
arm64                             allnoconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
hexagon                           allnoconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241019    gcc-12
i386        buildonly-randconfig-002-20241019    clang-18
i386        buildonly-randconfig-003-20241019    gcc-12
i386        buildonly-randconfig-004-20241019    gcc-12
i386        buildonly-randconfig-005-20241019    clang-18
i386        buildonly-randconfig-006-20241019    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20241019    gcc-12
i386                  randconfig-002-20241019    clang-18
i386                  randconfig-003-20241019    gcc-12
i386                  randconfig-004-20241019    clang-18
i386                  randconfig-005-20241019    clang-18
i386                  randconfig-006-20241019    gcc-12
i386                  randconfig-011-20241019    clang-18
i386                  randconfig-012-20241019    clang-18
i386                  randconfig-013-20241019    clang-18
i386                  randconfig-014-20241019    clang-18
i386                  randconfig-015-20241019    gcc-12
i386                  randconfig-016-20241019    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                        bcm63xx_defconfig    clang-17
nios2                             allnoconfig    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
