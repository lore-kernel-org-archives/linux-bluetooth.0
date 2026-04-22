Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652C82E1C7C
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 06:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776839344; cv=none; b=VYO46PxQE9MaXK1u5PtYGcPOK5e4Gm9ZV9ZMmtlzDmgRjrxRvYj8WAubnJA7cRi3lyeuO5mkZfZZo6rmnxEPk8F8RvdMMCSMao+OHWNlOijavQZifOw0fWDj0cfsWCZ8FdCxUn0hmr3Theu0OKu4SmIKGRYoYi6vfyapb/ZKZvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776839344; c=relaxed/simple;
	bh=1r/xJAC4CjQh5/zVgq3sCrzEJEZ8o0MC1ZIcRLUITMY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Pw2ECeyMNnwYEMbkGLql8ZClNLVzwM6ZlgWzSBgeORbE9qweVP/9Ql9NTq5xcLDxkwUPzep6QIBn54kQDDvK/yd2x7hzvRiMvoPkBDfAJXgz61llqvpv5p2TsGMTHuuVYHDB65NA01bKld1JctUAz/C6J4Rr2z91Ng3npztH5F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XHf1i26U; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XHf1i26U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776839342; x=1808375342;
  h=date:from:to:cc:subject:message-id;
  bh=1r/xJAC4CjQh5/zVgq3sCrzEJEZ8o0MC1ZIcRLUITMY=;
  b=XHf1i26U/9y+/VtYvu5bYki2iurQnxs507ruXJ69xRm4Tuzhx+LxCsFL
   N4d3k75Bj3Z+1xidr8tR/CcNspsS3S4g0XLDR0WJwCJ+/L26Nc11Yr405
   eSRQVm3DKZjzYxrcFtL9eXSb63opU+P46RFtFENzaFmsZ6o9sJ/LDD5NA
   vme/pyGXSFpSEe951/WjBLNnwTBDLmk2VOzetPXri0IvE/483EYWOMnGy
   DDsznVsis+8w7/6y2BTp2fllq7SeVBz0TSl9ybMgtU3R64WxcLv8F0pTU
   edz8Ecyu/BVsmYZAZkRegKmPaXzq/VZ5XH5l3QfhiBB2M9AX/AqEUxuI3
   w==;
X-CSE-ConnectionGUID: wqRASQMqRs6lJIZfatdVIw==
X-CSE-MsgGUID: Eo/OhiuWSN+PVwSHYtEEfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="88087408"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="88087408"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 23:29:02 -0700
X-CSE-ConnectionGUID: kLKQdEvuRLWqLogCVn+vyA==
X-CSE-MsgGUID: 1mPSPNm4RkSVAxrgbM4CTg==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 21 Apr 2026 23:29:00 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wFR50-000000000CT-0Goc;
	Wed, 22 Apr 2026 06:28:58 +0000
Date: Wed, 22 Apr 2026 14:28:49 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 006b9943b9822c8e6230010c1753aa577b4df6fc
Message-ID: <202604221440.whwW9qs3-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 006b9943b9822c8e6230010c1753aa577b4df6fc  Bluetooth: btmtk: validate WMT event SKB length before struct access

elapsed time: 769m

configs tested: 77
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                   randconfig-001-20260422    gcc-9.5.0
arc                   randconfig-002-20260422    gcc-11.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                   randconfig-001-20260422    gcc-8.5.0
arm                   randconfig-002-20260422    gcc-8.5.0
arm                   randconfig-003-20260422    clang-20
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                randconfig-001-20260422    gcc-14.3.0
parisc                randconfig-002-20260422    gcc-9.5.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260422    gcc-13.4.0
powerpc               randconfig-002-20260422    gcc-14.3.0
powerpc64             randconfig-001-20260422    clang-23
powerpc64             randconfig-002-20260422    gcc-15.2.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260422    gcc-14
x86_64      buildonly-randconfig-002-20260422    gcc-14
x86_64      buildonly-randconfig-003-20260422    gcc-14
x86_64      buildonly-randconfig-004-20260422    clang-20
x86_64      buildonly-randconfig-005-20260422    gcc-14
x86_64                randconfig-001-20260422    clang-20
x86_64                randconfig-002-20260422    gcc-14
x86_64                randconfig-003-20260422    gcc-14
x86_64                randconfig-004-20260422    clang-20
x86_64                randconfig-005-20260422    gcc-14
x86_64                randconfig-006-20260422    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
