Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26743194C86
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Dec 2024 22:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128174; cv=none; b=lLeDk3z65D2cLt97YjvnAyKJZO7Dw5wL9vdOtY8MXpKIo3e2ekiqcSda9FtdrGs9SAKsqOxs79sqgkIHCqmMxJ5O+HvBxF+tEbb0ClqAdz+BEs2nnTL+7eDumBXjPf7l/APmxZuCS+I4YM2WWwhds1RGA3DiHVk2Co2/N+1ZdCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128174; c=relaxed/simple;
	bh=abvZuP+XR/peLHTHB2cs6zv4nddi9soJW/nbDJI6UEE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=j4t8uXKXq9No+e65kk8LIsu34ty4qeCQU8hGTu6lpVP3TXFL72ARGFtq6easoTI6eAuUP6PXZZb0UwnAKuC3F8CvA0WnseZtm+4ppRDnyHWlAFAeQV4FAXIhx7RGwH1hP18tADpchjsLVu6zZu5zotKE3omZ1FVhdTCGJOEIxsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YE5C5w1r; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YE5C5w1r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734128173; x=1765664173;
  h=date:from:to:cc:subject:message-id;
  bh=abvZuP+XR/peLHTHB2cs6zv4nddi9soJW/nbDJI6UEE=;
  b=YE5C5w1rw7srqRLLJjCTt3uEU2vvlhXaHkBYnkmxBL/uPhDmYMGrrYk7
   6chfVksk3p/d+D3P74VbcWYCDUaS4OtUughIzLHC0zHsdgJlzXWRNtIcq
   /s3a10D5VhbFrAeawh63QTU5VW/Lw3vW0tTCFOSn26j69OIY6KLKhqMmF
   /27lk+owpFVIrAImIWCKK/HG2k/bzl+RmttpE2C+xI2efBuvezPwS8MRc
   kRN7PCvzUBg1yg6fXZcW83WqySUB8zP2VoROqJ6dU2C9s2ASYhyjHiPna
   28ZomptRg7/vDfs7seSMR4JU/4dAdMq04l/dR46Dr+IaqizF336j+FU4p
   Q==;
X-CSE-ConnectionGUID: /A6MidICSTCGop7+y/qUMg==
X-CSE-MsgGUID: PKV4My2tRZSxwAEm2sVxUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="33891347"
X-IronPort-AV: E=Sophos;i="6.12,232,1728975600"; 
   d="scan'208";a="33891347"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 14:16:13 -0800
X-CSE-ConnectionGUID: l421E7S/T1ixJo7QRoQlbg==
X-CSE-MsgGUID: HNbSjqjER5eN055DD1ypfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="127649749"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 13 Dec 2024 14:16:12 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMDxB-000CU1-21;
	Fri, 13 Dec 2024 22:16:09 +0000
Date: Sat, 14 Dec 2024 06:15:33 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 514e14b1a7c38520c955e59ec0ce09270cc4853c
Message-ID: <202412140627.wZpls5KL-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 514e14b1a7c38520c955e59ec0ce09270cc4853c  Bluetooth: MGMT: Mark LL Privacy as stable

elapsed time: 1453m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                  randconfig-001-20241213    gcc-13.2.0
arc                  randconfig-002-20241213    gcc-13.2.0
arm                  randconfig-001-20241213    clang-16
arm                  randconfig-002-20241213    clang-18
arm                  randconfig-003-20241213    gcc-14.2.0
arm                  randconfig-004-20241213    clang-18
arm64                randconfig-001-20241213    gcc-14.2.0
arm64                randconfig-002-20241213    gcc-14.2.0
arm64                randconfig-003-20241213    clang-18
arm64                randconfig-004-20241213    gcc-14.2.0
csky                 randconfig-001-20241213    gcc-14.2.0
csky                 randconfig-002-20241213    gcc-14.2.0
hexagon              randconfig-001-20241213    clang-20
hexagon              randconfig-002-20241213    clang-20
i386       buildonly-randconfig-001-20241213    clang-19
i386       buildonly-randconfig-002-20241213    gcc-12
i386       buildonly-randconfig-003-20241213    gcc-12
i386       buildonly-randconfig-004-20241213    clang-19
i386       buildonly-randconfig-005-20241213    gcc-12
i386       buildonly-randconfig-006-20241213    gcc-12
loongarch                       allmodconfig    gcc-14.2.0
loongarch            randconfig-001-20241213    gcc-14.2.0
loongarch            randconfig-002-20241213    gcc-14.2.0
m68k                            allmodconfig    gcc-14.2.0
m68k                            allyesconfig    gcc-14.2.0
m68k                       m5407c3_defconfig    gcc-14.2.0
nios2                randconfig-001-20241213    gcc-14.2.0
nios2                randconfig-002-20241213    gcc-14.2.0
parisc               randconfig-001-20241213    gcc-14.2.0
parisc               randconfig-002-20241213    gcc-14.2.0
powerpc              randconfig-001-20241213    gcc-14.2.0
powerpc              randconfig-002-20241213    clang-20
powerpc              randconfig-003-20241213    gcc-14.2.0
powerpc64            randconfig-001-20241213    gcc-14.2.0
powerpc64            randconfig-002-20241213    gcc-14.2.0
powerpc64            randconfig-003-20241213    gcc-14.2.0
riscv                randconfig-001-20241213    gcc-14.2.0
riscv                randconfig-002-20241213    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20241213    gcc-14.2.0
s390                 randconfig-002-20241213    clang-19
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20241213    gcc-14.2.0
sh                   randconfig-002-20241213    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20241213    gcc-14.2.0
sparc                randconfig-002-20241213    gcc-14.2.0
sparc64              randconfig-001-20241213    gcc-14.2.0
sparc64              randconfig-002-20241213    gcc-14.2.0
um                   randconfig-001-20241213    gcc-12
um                   randconfig-002-20241213    clang-16
x86_64                           allnoconfig    clang-19
x86_64     buildonly-randconfig-001-20241213    gcc-12
x86_64     buildonly-randconfig-002-20241213    gcc-12
x86_64     buildonly-randconfig-003-20241213    gcc-12
x86_64     buildonly-randconfig-004-20241213    gcc-12
x86_64     buildonly-randconfig-005-20241213    gcc-12
x86_64     buildonly-randconfig-006-20241213    clang-19
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20241213    gcc-14.2.0
xtensa               randconfig-002-20241213    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
