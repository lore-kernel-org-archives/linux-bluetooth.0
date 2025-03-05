Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7C82E3362
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Mar 2025 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741188287; cv=none; b=PkRl8tRN5NStn8mSVdELXJCvjA4F5eXwDcvV2KKxd8tVBIa33PfdtctulD13l2s24pBtxb0sy0sxGbFTc5UMbCuq+b1FfMhpsH11jx710o3YOipzsxbjQOwW7RnBrk9cQ89DCwUjJbeEIokUI//j9Dn8iFL6fBNTGlKa51ETFrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741188287; c=relaxed/simple;
	bh=KKEziiXbSCtPV+6eb+uKMZ+EAF6vdKOTZXoQzobhAOQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=p0vGDjpxLYjRrAcp/bqLr2MRkTmEcZNeXNNdytu4JlZcVZ5aDBI6cw+B3W1vPhaZpjp7jb2lt0xN2bPMazn0Zft+qKOV37LqZDmmB8Eqh/lXqCUD9qi/gt4D5bOlW53lVxlIe+2eP9VJXCRAChwNpbZgI7B8GHr/9zeDK/jA5aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PPTuSvHs; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PPTuSvHs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741188286; x=1772724286;
  h=date:from:to:cc:subject:message-id;
  bh=KKEziiXbSCtPV+6eb+uKMZ+EAF6vdKOTZXoQzobhAOQ=;
  b=PPTuSvHsT1/t3Y92dOVRwAO1jWwhIq/UJf+vXXgKkfa0cj6fXHpm6iL7
   blWBjOF5rSd8Rmc8fRb42JY8XVARAmBxN/HND999URhrzICsRGDqeRYLJ
   DzPv/olL30sqwHHTyJtdgARU5bwR5ev6A/BjG79JUxKJhAWJXqrUQJaBo
   dqA+Q3zdlLyUJ8YyWSYz6qgUjJFJq3CDy8eMgsknwqauGuJWyA5FLuCBy
   gkWUHjJIqpid+kNDhsat0dHcQZjAV/G8pF5Q7vpUtSrPRYZ5nyfpuytTS
   R9D4In32YkRBi3TJqvv2IT0l/EWEi6J4/K+XtkM3lEUdOu5kVAW5tH/yd
   w==;
X-CSE-ConnectionGUID: aDPi0jdtQN2rS1sceKrdmQ==
X-CSE-MsgGUID: hUPqCpJ3R1KLh2erbfaJCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="29738512"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="29738512"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 07:24:44 -0800
X-CSE-ConnectionGUID: JJCrpzfuTrqFKrO7U97uHg==
X-CSE-MsgGUID: fXdm+dPXRfmUVhDK/4d84w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="118733612"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 05 Mar 2025 07:24:42 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpqbU-000L90-1s;
	Wed, 05 Mar 2025 15:24:17 +0000
Date: Wed, 05 Mar 2025 23:23:57 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 aaa9cc6993d387818a3376d976e14eeca2732940
Message-ID: <202503052351.ClbRxZ6T-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: aaa9cc6993d387818a3376d976e14eeca2732940  Bluetooth: btintel_pcie: Add support for device coredump

elapsed time: 1448m

configs tested: 87
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
alpha                           allyesconfig    gcc-14.2.0
arc                             allmodconfig    gcc-13.2.0
arc                              allnoconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                  randconfig-001-20250305    gcc-13.2.0
arc                  randconfig-002-20250305    gcc-13.2.0
arm                             allmodconfig    gcc-14.2.0
arm                              allnoconfig    clang-17
arm                             allyesconfig    gcc-14.2.0
arm                  randconfig-001-20250305    gcc-14.2.0
arm                  randconfig-002-20250305    clang-19
arm                  randconfig-003-20250305    gcc-14.2.0
arm                  randconfig-004-20250305    gcc-14.2.0
arm64                           allmodconfig    clang-18
arm64                            allnoconfig    gcc-14.2.0
arm64                randconfig-001-20250305    clang-15
arm64                randconfig-002-20250305    gcc-14.2.0
arm64                randconfig-003-20250305    clang-21
arm64                randconfig-004-20250305    gcc-14.2.0
csky                             allnoconfig    gcc-14.2.0
csky                 randconfig-001-20250305    gcc-14.2.0
csky                 randconfig-002-20250305    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                          allnoconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250305    clang-21
hexagon              randconfig-002-20250305    clang-18
i386                            allmodconfig    gcc-12
i386                             allnoconfig    gcc-12
i386                            allyesconfig    gcc-12
i386       buildonly-randconfig-001-20250305    clang-19
i386       buildonly-randconfig-002-20250305    clang-19
i386       buildonly-randconfig-003-20250305    clang-19
i386       buildonly-randconfig-004-20250305    clang-19
i386       buildonly-randconfig-005-20250305    clang-19
i386       buildonly-randconfig-006-20250305    gcc-12
i386                               defconfig    clang-19
loongarch                        allnoconfig    gcc-14.2.0
loongarch            randconfig-001-20250305    gcc-14.2.0
loongarch            randconfig-002-20250305    gcc-14.2.0
nios2                randconfig-001-20250305    gcc-14.2.0
nios2                randconfig-002-20250305    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc               randconfig-001-20250305    gcc-14.2.0
parisc               randconfig-002-20250305    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20250305    clang-17
powerpc              randconfig-002-20250305    gcc-14.2.0
powerpc              randconfig-003-20250305    gcc-14.2.0
powerpc64            randconfig-001-20250305    clang-19
powerpc64            randconfig-002-20250305    clang-17
powerpc64            randconfig-003-20250305    clang-19
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20250305    clang-19
riscv                randconfig-002-20250305    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-15
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250305    gcc-14.2.0
s390                 randconfig-002-20250305    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250305    gcc-14.2.0
sh                   randconfig-002-20250305    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250305    gcc-14.2.0
sparc                randconfig-002-20250305    gcc-14.2.0
sparc64              randconfig-001-20250305    gcc-14.2.0
sparc64              randconfig-002-20250305    gcc-14.2.0
um                              allmodconfig    clang-21
um                               allnoconfig    clang-18
um                              allyesconfig    gcc-12
um                   randconfig-001-20250305    clang-19
um                   randconfig-002-20250305    gcc-12
x86_64                           allnoconfig    clang-19
x86_64                          allyesconfig    clang-19
x86_64     buildonly-randconfig-001-20250305    clang-19
x86_64     buildonly-randconfig-002-20250305    gcc-12
x86_64     buildonly-randconfig-003-20250305    clang-19
x86_64     buildonly-randconfig-004-20250305    gcc-12
x86_64     buildonly-randconfig-005-20250305    clang-19
x86_64     buildonly-randconfig-006-20250305    clang-19
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250305    gcc-14.2.0
xtensa               randconfig-002-20250305    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
