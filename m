Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F3A2EE965
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jun 2025 19:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750794122; cv=none; b=Pubmc9mrA3TzIBhQnMhr2Hbd4G1SYNUxTudRBzUiNisVrNN7ld6B6zvWOq814Oc/d+5pdvWLzqtCMI9b3iWv2Mrh4oppgAdmzUaHI5jBu3Whx6hNxMyZEAwT6OwzxjEL6brVvNyvvMMP9JPh2vYmr8Abjs9qBMdIOZzNTaWdahc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750794122; c=relaxed/simple;
	bh=qeOj8SePu9jNexMtXWzFxvYh2R5iwFOa1HVYWc1B+co=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RhzWlPeIXeoCBXrjawmQ87JfKNwpERjR6R9KNOEz7eHNdjxF391XR8d9Pxi9ziC836Y5RP7nmSdYD4tOSowzLO72Uh7OO3kSFwzD3R8rfnG55NmgELRBo7EjmQSLnKn7zaT3RQgZ/aYMJgrb3bZBuq7PqzkQ1qOqelN6rchc7eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T97S4Upu; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T97S4Upu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750794120; x=1782330120;
  h=date:from:to:cc:subject:message-id;
  bh=qeOj8SePu9jNexMtXWzFxvYh2R5iwFOa1HVYWc1B+co=;
  b=T97S4UpuxXJSd+147UhKM8b9/N9QM/UaRCP2L6eykegRZTS/amfi0R7e
   /wpqQ2Uma0ijN3m1XgNS+XaqQpLI3zgNqNkneR5RdJKKgmzYMeH13Kj1T
   h+CCUzD3uhDCy7C2YthXJfrCbgubZUsbBd0M2L3nJSb9+nGFZhvKKz0e3
   +e3aVQgEmK1OV19f+nvIg/Zj4sTVx1QxfYUhK/rCnWSR08Gqdtmo1lHPH
   EPxdQ6wMroVWZXhbNZPKErfioDDk2tHFNZR8eiUXfYJHjUdZdXfsabXqJ
   vy750Koi+JmGu7zXw+SOkvO9Mrr+DcZu5Yr9FpajBHOndTdrgtZjwLJZi
   A==;
X-CSE-ConnectionGUID: V9lN4MIhQf+Md8hUvYtvGg==
X-CSE-MsgGUID: MCgVB19tSIWdTlxEhqjNDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="53145793"
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="53145793"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 12:42:00 -0700
X-CSE-ConnectionGUID: UPLRTf/iT1CSPy1iT3iGQA==
X-CSE-MsgGUID: bDt81waUQNi8m6s5HABnXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="157497454"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 24 Jun 2025 12:41:59 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uU9Wm-000SSM-1k;
	Tue, 24 Jun 2025 19:41:56 +0000
Date: Wed, 25 Jun 2025 03:41:07 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 03bddf7c2ed6c02634583fec2526b44ec5e46f84
Message-ID: <202506250357.mhQv513Q-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 03bddf7c2ed6c02634583fec2526b44ec5e46f84  Bluetooth: btnxpuart: Add support for 4M baudrate

elapsed time: 1452m

configs tested: 54
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20250624    gcc-12.4.0
arc                   randconfig-002-20250624    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                   randconfig-001-20250624    gcc-13.3.0
arm                   randconfig-002-20250624    gcc-8.5.0
arm                   randconfig-003-20250624    gcc-12.4.0
arm                   randconfig-004-20250624    clang-17
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250624    clang-21
arm64                 randconfig-002-20250624    gcc-10.5.0
arm64                 randconfig-003-20250624    clang-21
arm64                 randconfig-004-20250624    clang-21
csky                              allnoconfig    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
i386        buildonly-randconfig-001-20250624    clang-20
i386        buildonly-randconfig-002-20250624    gcc-12
i386        buildonly-randconfig-003-20250624    clang-20
i386        buildonly-randconfig-004-20250624    clang-20
i386        buildonly-randconfig-005-20250624    clang-20
i386        buildonly-randconfig-006-20250624    gcc-12
loongarch                         allnoconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
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
x86_64      buildonly-randconfig-001-20250624    clang-20
x86_64      buildonly-randconfig-002-20250624    gcc-12
x86_64      buildonly-randconfig-003-20250624    clang-20
x86_64      buildonly-randconfig-004-20250624    clang-20
x86_64      buildonly-randconfig-005-20250624    clang-20
x86_64      buildonly-randconfig-006-20250624    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
