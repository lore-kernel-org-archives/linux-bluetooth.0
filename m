Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC53221D93
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024750; cv=none; b=J/4TH9p1mJoM6tbp+hlXqj2kvMKqhqy2a+WK+bu0QFSsUxBMTjD9BIitW+ZPglZSntbWaICWJxbMqxrRQjE/VS8zSOh86RiZv1DDxJt5FWyuYH27AoQa4mN1HzmpS+Y5qJSdFGkMhx8K9EWir5++6bTsulbh17cTuuuCymZcCKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024750; c=relaxed/simple;
	bh=XQh6RbCweiGn5sGLhAkIyofAUfz3aCqc1j9u644PtTc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hAfYZFIxuwBDOIaGtRU0b12bPP9Pxasc03sZ8GtWKo7MYdqBLJtHOTg5Rwf/XnGlOL5ESTJaJNFVDgOS3gq50lc4RwxHz67b7Kjfo0eyqwArtRoulm9vIJ8V+Wzki4CYL59J0cI77GKFjPxguMmx2p1UyWZJ1H1CJCHvqXkqXyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JgjbyZl6; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JgjbyZl6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734024748; x=1765560748;
  h=date:from:to:cc:subject:message-id;
  bh=XQh6RbCweiGn5sGLhAkIyofAUfz3aCqc1j9u644PtTc=;
  b=JgjbyZl6dgzY196iQItK5XaUSdiQIpQX0hfeSdcFGOid80VY0PDkgWDM
   XcBvn24NJg2Wdd3XbhhwWyJ/uXe4qki/yu4vMDfcE98o5skb5yNx4ZJjQ
   ozLj6ea4248XWY/waRLLyQ5QAasGFaMYk4LwXiI8KF5csUinvLsH1cH98
   UQdQDvZToU+EKJCpooS+2da554AfrnswigTg97mpwp3jVbo7ydJfaOrkw
   Han0U7FhAL947WwVKIminsbR0kkhGABf4alI4Ddl0YWVKLgjOpqUHDp6g
   yDGqsKro+xZir5i/L3z2VzRA7sOJcoLVlsthRBOwAFZtIHWc3rjoyPK3s
   w==;
X-CSE-ConnectionGUID: kBavqwixQzKApkHIRB0y5A==
X-CSE-MsgGUID: 9TIwjQweTpGzmZB3wrEZHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="38141750"
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="38141750"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 09:32:26 -0800
X-CSE-ConnectionGUID: UPDOrMXhS7ygWkLXcT3gxA==
X-CSE-MsgGUID: 65LzbL9ESmewVOS73NT7KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="133668010"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 12 Dec 2024 09:32:25 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLn30-000AVh-2c;
	Thu, 12 Dec 2024 17:32:22 +0000
Date: Fri, 13 Dec 2024 01:31:59 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 845b4c649f56ed8efa76eeed17572a95d08de34c
Message-ID: <202412130153.zuoZEFWm-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 845b4c649f56ed8efa76eeed17572a95d08de34c  Bluetooth: btmtk: avoid UAF in btmtk_process_coredump

elapsed time: 1447m

configs tested: 65
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                  randconfig-001-20241212    gcc-13.2.0
arc                  randconfig-002-20241212    gcc-13.2.0
arm                  randconfig-001-20241212    gcc-14.2.0
arm                  randconfig-002-20241212    clang-20
arm                  randconfig-003-20241212    clang-19
arm                  randconfig-004-20241212    clang-20
arm64                randconfig-001-20241212    clang-20
arm64                randconfig-002-20241212    clang-15
arm64                randconfig-003-20241212    clang-20
arm64                randconfig-004-20241212    gcc-14.2.0
csky                 randconfig-001-20241212    gcc-14.2.0
csky                 randconfig-002-20241212    gcc-14.2.0
hexagon              randconfig-001-20241212    clang-14
hexagon              randconfig-002-20241212    clang-16
i386       buildonly-randconfig-001-20241212    clang-19
i386       buildonly-randconfig-002-20241212    clang-19
i386       buildonly-randconfig-003-20241212    clang-19
i386       buildonly-randconfig-004-20241212    clang-19
i386       buildonly-randconfig-005-20241212    clang-19
i386       buildonly-randconfig-006-20241212    gcc-12
loongarch            randconfig-001-20241212    gcc-14.2.0
loongarch            randconfig-002-20241212    gcc-14.2.0
m68k                            allmodconfig    gcc-14.2.0
m68k                            allyesconfig    gcc-14.2.0
nios2                randconfig-001-20241212    gcc-14.2.0
nios2                randconfig-002-20241212    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc               randconfig-001-20241212    gcc-14.2.0
parisc               randconfig-002-20241212    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20241212    gcc-14.2.0
powerpc              randconfig-002-20241212    clang-20
powerpc              randconfig-003-20241212    clang-15
powerpc64            randconfig-001-20241212    clang-20
powerpc64            randconfig-002-20241212    gcc-14.2.0
powerpc64            randconfig-003-20241212    gcc-14.2.0
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20241212    clang-17
riscv                randconfig-002-20241212    clang-20
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-20
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20241212    clang-18
s390                 randconfig-002-20241212    clang-20
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20241212    gcc-14.2.0
sh                   randconfig-002-20241212    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20241212    gcc-14.2.0
sparc                randconfig-002-20241212    gcc-14.2.0
sparc64              randconfig-001-20241212    gcc-14.2.0
sparc64              randconfig-002-20241212    gcc-14.2.0
um                               allnoconfig    clang-18
um                   randconfig-001-20241212    gcc-12
um                   randconfig-002-20241212    clang-20
x86_64     buildonly-randconfig-001-20241212    clang-19
x86_64     buildonly-randconfig-002-20241212    gcc-12
x86_64     buildonly-randconfig-003-20241212    clang-19
x86_64     buildonly-randconfig-004-20241212    clang-19
x86_64     buildonly-randconfig-005-20241212    gcc-11
x86_64     buildonly-randconfig-006-20241212    clang-19
xtensa               randconfig-001-20241212    gcc-14.2.0
xtensa               randconfig-002-20241212    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
