Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97301AF4E9
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Jan 2025 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736606722; cv=none; b=VKt1bQcm+wKFII63tMjE02oTqKMffDKYb3nBN5yDxKZPO1/PMkwHMCU5cpXSpnlKeBVu2eBf7+leqC0vITkvgzmbeH5ptmPLCJ7x5uag+/PJLTDiU4r82XBU8X6Dt89n/P4FnzwWeQH82V1wWXsHdWnHJKiQJMBom+QuowKjIqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736606722; c=relaxed/simple;
	bh=r3sv86PzNcyTg6lxan9ILC1gagFzMsSMlrp8U6WDEHg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CWhQ2qA9YgZrjgf1Fp9QqFyvR4TqdviRob2w4JLALUPBcepDVSIFsbM2awINijTyHBRr86rymIGG3I6ZdH+uhwz6fcB8eZGJwqP49b86Ayi4MqXmEs9pNrylh64cxsMDAJG5wGGyYN+5YmmEEojy4TzTd7H9FbahKmbZmggyFFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qd+mVjvd; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qd+mVjvd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736606720; x=1768142720;
  h=date:from:to:cc:subject:message-id;
  bh=r3sv86PzNcyTg6lxan9ILC1gagFzMsSMlrp8U6WDEHg=;
  b=Qd+mVjvd9PxHDQMsopgsHJRu9iekMObwRFY0XtZSyPsVd3NFby45xE/6
   2occ1kJr3/OOWZstYC4QvZ4NR4a/pWNgdoNnqAV5KzltH4QxGB5BT8YlX
   tUt77BCVbEfJfvdUgmM+IxYj14AWkY+Nt0dN+ppoOOp+hdVQmHEB/ycps
   bIDWaWfVc+ebd60Ym86/WDp4CaVaLjBUAUuPKwQFPhJ0RKappNYZ6/O/Z
   +cjce55ZWmlyx9pC+ByrKpsKduqih4y7rVtFK8lAmvnkB/6ewicb5zDPB
   v1czco/UbNP/Xlivp5dIHVSnGjbbr8v95he+G0mngdllMBUNJhQGqjl7A
   w==;
X-CSE-ConnectionGUID: PqyB4yC6R1i8w13drZ7mjQ==
X-CSE-MsgGUID: Tzgsnj0HSZ+wv5iqHJ+OXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11312"; a="40829185"
X-IronPort-AV: E=Sophos;i="6.12,307,1728975600"; 
   d="scan'208";a="40829185"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2025 06:45:18 -0800
X-CSE-ConnectionGUID: kr9VXSEUTq6dDCfHfacBpg==
X-CSE-MsgGUID: Z6+ep4JjS4iyj+ySZMMKOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="127280701"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 11 Jan 2025 06:45:17 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWcjj-000Kkl-19;
	Sat, 11 Jan 2025 14:45:15 +0000
Date: Sat, 11 Jan 2025 22:44:30 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 a723753d039fd9a6c5998340ac65f4d9e2966ba8
Message-ID: <202501112224.AoDgqMr8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: a723753d039fd9a6c5998340ac65f4d9e2966ba8  Bluetooth: L2CAP: handle NULL sock pointer in l2cap_sock_alloc

elapsed time: 1447m

configs tested: 76
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
arc                              allnoconfig    gcc-13.2.0
arc                  randconfig-001-20250111    gcc-13.2.0
arc                  randconfig-002-20250111    gcc-13.2.0
arm                              allnoconfig    clang-17
arm                  randconfig-001-20250111    clang-16
arm                  randconfig-002-20250111    gcc-14.2.0
arm                  randconfig-003-20250111    clang-20
arm                  randconfig-004-20250111    clang-20
arm64                            allnoconfig    gcc-14.2.0
arm64                randconfig-001-20250111    gcc-14.2.0
arm64                randconfig-002-20250111    clang-20
arm64                randconfig-003-20250111    clang-18
arm64                randconfig-004-20250111    clang-16
csky                             allnoconfig    gcc-14.2.0
csky                 randconfig-001-20250111    gcc-14.2.0
csky                 randconfig-002-20250111    gcc-14.2.0
hexagon                          allnoconfig    clang-20
hexagon              randconfig-001-20250111    clang-20
hexagon              randconfig-002-20250111    clang-15
i386       buildonly-randconfig-001-20250111    gcc-12
i386       buildonly-randconfig-002-20250111    gcc-11
i386       buildonly-randconfig-003-20250111    gcc-12
i386       buildonly-randconfig-004-20250111    gcc-12
i386       buildonly-randconfig-005-20250111    gcc-12
i386       buildonly-randconfig-006-20250111    clang-19
loongarch                        allnoconfig    gcc-14.2.0
loongarch            randconfig-001-20250111    gcc-14.2.0
loongarch            randconfig-002-20250111    gcc-14.2.0
nios2                randconfig-001-20250111    gcc-14.2.0
nios2                randconfig-002-20250111    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
openrisc                        allyesconfig    gcc-14.2.0
parisc                          allmodconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc                          allyesconfig    gcc-14.2.0
parisc               randconfig-001-20250111    gcc-14.2.0
parisc               randconfig-002-20250111    gcc-14.2.0
powerpc                         allmodconfig    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc                         allyesconfig    clang-16
powerpc              randconfig-001-20250111    gcc-14.2.0
powerpc              randconfig-002-20250111    gcc-14.2.0
powerpc              randconfig-003-20250111    gcc-14.2.0
powerpc64            randconfig-001-20250111    gcc-14.2.0
powerpc64            randconfig-002-20250111    gcc-14.2.0
riscv                           allmodconfig    clang-20
riscv                            allnoconfig    gcc-14.2.0
riscv                           allyesconfig    clang-20
riscv                randconfig-001-20250111    clang-18
riscv                randconfig-002-20250111    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-20
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250111    clang-20
s390                 randconfig-002-20250111    clang-19
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250111    gcc-14.2.0
sh                   randconfig-002-20250111    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250111    gcc-14.2.0
sparc                randconfig-002-20250111    gcc-14.2.0
sparc64              randconfig-001-20250111    gcc-14.2.0
sparc64              randconfig-002-20250111    gcc-14.2.0
um                               allnoconfig    clang-18
um                   randconfig-001-20250111    clang-18
um                   randconfig-002-20250111    clang-20
x86_64     buildonly-randconfig-001-20250111    clang-19
x86_64     buildonly-randconfig-002-20250111    gcc-12
x86_64     buildonly-randconfig-003-20250111    gcc-12
x86_64     buildonly-randconfig-004-20250111    clang-19
x86_64     buildonly-randconfig-005-20250111    gcc-12
x86_64     buildonly-randconfig-006-20250111    gcc-12
xtensa               randconfig-001-20250111    gcc-14.2.0
xtensa               randconfig-002-20250111    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
