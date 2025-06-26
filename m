Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006AA1DF980
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jun 2025 21:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750974533; cv=none; b=Yektc2ZPCJjFjSsG8chhPwaJ1PAw3x5q5wnIl+0yPqZGFfwmfxvBWgpzNRAGSAVXsEP9wkN4O9tEKr3qvJM0LHQ/LqnbzTczTwlu3cGDAVDmHCJv5DjKhto3agZWdcYKa71/Ri9n4LxjucQd1yZjWGWR5mZobnDbt8c0pQun0Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750974533; c=relaxed/simple;
	bh=QzkrBq2pmItU5nclfjpVteMKcLMt9fLT6tVDqd6eo2k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=d5yIoTsudlR3OmAkUBlyr0mw/k1+PhWWEoYHtRgElC5qKpYhxHRI5RB1N/Qacmrns/NzHYp2Dm+Z6KBXLElYXpVslHk3gh1SRh6k2+OmM1uzvZiezuo2iFJbv8wC+CUJmRayEQLaRSTSrfdyB2Rfe6lSSeUt/XP6diCZBofmqG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b+E9RQ4V; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b+E9RQ4V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750974532; x=1782510532;
  h=date:from:to:cc:subject:message-id;
  bh=QzkrBq2pmItU5nclfjpVteMKcLMt9fLT6tVDqd6eo2k=;
  b=b+E9RQ4VqdcsWP9X1yuafGm9zj1BrbFGFEOsgFM3iBsl/0WsOdyC6RHP
   tv7oKOQYLJcSaQfpcK5D7x1KGBsHe9ZoxN2VQCkGAXfZQ68wROsF+erXy
   Vrim5ASPWgsUSfHXpAjZ5KsQ7TyQSU+vuEO+CAbLfQi3LIO9B4Xwmt5t3
   /W4lsH1uQNDC6721/VCG/raMiTgOMUK/WX1WtJParNi2I4h3GpC6jfBOO
   2OLpFp8k4JbyTy9BSc4us5WWGQHeol5jOvDdQiOdqQzmfrPEsd2bTl5U1
   wniYR+R3LN84Z4Z9iZ8hRlK3ZgYfQv09k8hy17bvSFTcdML7Wy70Bju3Y
   Q==;
X-CSE-ConnectionGUID: DrFngAgcSy6vPN+Yx/i1Cw==
X-CSE-MsgGUID: DUWhdB1xR42isxbo7j9NKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="57092051"
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="57092051"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 14:48:51 -0700
X-CSE-ConnectionGUID: 06WJYoxHS2S+ZtrmpBYVWQ==
X-CSE-MsgGUID: qoQmUCRFSFGQOgRw1ePQ/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="157010843"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 26 Jun 2025 14:48:51 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUuSd-000VYo-2D;
	Thu, 26 Jun 2025 21:48:47 +0000
Date: Fri, 27 Jun 2025 05:48:05 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 8dcd9b294572b6cf5ce780bd7f436dfa8a1c579a
Message-ID: <202506270555.fAN07se6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 8dcd9b294572b6cf5ce780bd7f436dfa8a1c579a  Bluetooth: MGMT: mesh_send: check instances prior disabling advertising

elapsed time: 1452m

configs tested: 64
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20250626    gcc-12.4.0
arc                   randconfig-002-20250626    gcc-13.3.0
arm                               allnoconfig    clang-21
arm                   randconfig-001-20250626    clang-21
arm                   randconfig-002-20250626    clang-20
arm                   randconfig-003-20250626    gcc-10.5.0
arm                   randconfig-004-20250626    clang-21
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250626    clang-21
arm64                 randconfig-002-20250626    clang-17
arm64                 randconfig-003-20250626    gcc-6.5.0
arm64                 randconfig-004-20250626    clang-21
csky                              allnoconfig    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20250626    clang-20
i386        buildonly-randconfig-002-20250626    clang-20
i386        buildonly-randconfig-003-20250626    clang-20
i386        buildonly-randconfig-004-20250626    clang-20
i386        buildonly-randconfig-005-20250626    clang-20
i386        buildonly-randconfig-006-20250626    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250626    clang-20
x86_64      buildonly-randconfig-002-20250626    clang-20
x86_64      buildonly-randconfig-003-20250626    clang-20
x86_64      buildonly-randconfig-004-20250626    clang-20
x86_64      buildonly-randconfig-005-20250626    clang-20
x86_64      buildonly-randconfig-006-20250626    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
