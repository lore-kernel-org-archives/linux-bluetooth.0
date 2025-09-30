Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BF8C148
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Sep 2025 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759249398; cv=none; b=ci667mJZ0PybABwtrmh0Tr+/7camt4+ztLIapwRO9O44P5yaqm/TmYYDnaonxTlqAanDuAQgO3ivgKqO3K7I97GPeqaoZ4WeN6/tOQs6tNTKDN87vEEgDpnMtGIkf5BfIhPNIM+N1H+yWPGsXmLDvOyfT71TrBov0zUk/zj7Njk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759249398; c=relaxed/simple;
	bh=j12T+ErJt3o5O7+tP/24G6eN1YvLhxod8kIIxpa0WBY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Hhv9MxjL7TARZP5A6T7bewJy2LgETjOZTEWDMwvkBY896lq8LnNP9jgOHbDOtl+Mjh/jorgOmsV45XEdVpN+7y6odK+hIUHCk78q4TjaPnGCP2F8MLfu+PvLzzqz3CGv121ii3cVDgKTcGg5s9G1HZyWgvZ6Mnjza94nJoETfws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VydEZOzX; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VydEZOzX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759249397; x=1790785397;
  h=date:from:to:cc:subject:message-id;
  bh=j12T+ErJt3o5O7+tP/24G6eN1YvLhxod8kIIxpa0WBY=;
  b=VydEZOzXzAwMA+nFKbODNxhcsEx+1SiEmoO7jaDuD2l2mM2Pe94F0X24
   sgEvrtcgcEnJoXO1YWjcukJlQjY3HD67X0VDbXj4t2Q9D6hpf3qleg+ob
   iI6yk0hnnnhGpbE27ez0H/mMXW0Y0280DEP8z8NbIPMY/gS8ySLxb6glv
   /Mwqh0lB4N1GqMB8FDYX30o6fpanIw3ZENbXNDTgUvTx7ZBLYF8dWHnWb
   pdIR+ghnGk0mSNYGtI9brCzK1M0UdJqBqg9g2FwIZyJo1zZyDejb+13Vo
   2brCwCSVPKavZgARXzMkoDHNe++hQt6E4e5c3fXJdNb9MAvgn4PLJBXb9
   Q==;
X-CSE-ConnectionGUID: AhIOURB9RTKmSTO+0VH0KA==
X-CSE-MsgGUID: cftpZ+swT6CxOGxEk8sIOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61223284"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="61223284"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 09:23:16 -0700
X-CSE-ConnectionGUID: zOSLXheaT6i4I3Qp9VrPtg==
X-CSE-MsgGUID: mms67K1wRKOAOHqnFVCotA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="179322444"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 30 Sep 2025 09:23:14 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v3d8B-0002H0-2x;
	Tue, 30 Sep 2025 16:23:11 +0000
Date: Wed, 01 Oct 2025 00:23:00 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 8fe90a5ad3d94f36b564d98ac54c110842fb172a
Message-ID: <202510010051.4Xvc7Bur-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 8fe90a5ad3d94f36b564d98ac54c110842fb172a  Bluetooth: mediatek: add gpio pin to reset bt

elapsed time: 1450m

configs tested: 107
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250930    gcc-9.5.0
arc                   randconfig-002-20250930    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20250930    gcc-13.4.0
arm                   randconfig-002-20250930    gcc-8.5.0
arm                   randconfig-003-20250930    gcc-8.5.0
arm                   randconfig-004-20250930    gcc-10.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250930    clang-18
arm64                 randconfig-002-20250930    clang-22
arm64                 randconfig-003-20250930    clang-18
arm64                 randconfig-004-20250930    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250930    gcc-13.4.0
csky                  randconfig-002-20250930    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250930    clang-22
hexagon               randconfig-002-20250930    clang-22
i386        buildonly-randconfig-001-20250930    gcc-12
i386        buildonly-randconfig-002-20250930    gcc-14
i386        buildonly-randconfig-003-20250930    clang-20
i386        buildonly-randconfig-004-20250930    gcc-14
i386        buildonly-randconfig-005-20250930    clang-20
i386        buildonly-randconfig-006-20250930    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250930    clang-22
loongarch             randconfig-002-20250930    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250930    gcc-8.5.0
nios2                 randconfig-002-20250930    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250930    gcc-12.5.0
parisc                randconfig-002-20250930    gcc-9.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250930    gcc-8.5.0
powerpc               randconfig-002-20250930    gcc-14.3.0
powerpc               randconfig-003-20250930    gcc-15.1.0
powerpc64             randconfig-001-20250930    gcc-14.3.0
powerpc64             randconfig-002-20250930    gcc-12.5.0
powerpc64             randconfig-003-20250930    gcc-11.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250930    gcc-10.5.0
riscv                 randconfig-002-20250930    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250930    gcc-12.5.0
s390                  randconfig-002-20250930    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250930    gcc-15.1.0
sh                    randconfig-002-20250930    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250930    gcc-11.5.0
sparc                 randconfig-002-20250930    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250930    clang-22
sparc64               randconfig-002-20250930    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250930    gcc-14
um                    randconfig-002-20250930    gcc-12
um                           x86_64_defconfig    clang-22
x86_64      buildonly-randconfig-001-20250930    clang-20
x86_64      buildonly-randconfig-002-20250930    gcc-14
x86_64      buildonly-randconfig-003-20250930    gcc-14
x86_64      buildonly-randconfig-004-20250930    clang-20
x86_64      buildonly-randconfig-005-20250930    gcc-14
x86_64      buildonly-randconfig-006-20250930    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250930    gcc-12.5.0
xtensa                randconfig-002-20250930    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
