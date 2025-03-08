Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8414B146D6A
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Mar 2025 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741448377; cv=none; b=jid2NKBRuGyT4tWgnzebVOX5fKKtB7lMnMg4xEQXpe5EwIzohkMDKoq8rNtR13XA1TyiLtgucq1sO5AP0crf9DH+XIB4m2cYPPdLCwAJ92wEu+9/k3wdDmrNhsc40qTkBRIul/c+iAXhLtYrLyXyS+KaRTSjRfLyzi9tDtKn7JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741448377; c=relaxed/simple;
	bh=IN9gA8jVlzJIC8dYGQ6vumDwJVdbenFlIEJnrR4vo2c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=l0oXh3x1OjhgrVB6hDG2xMcXhw7keiBs9NG8ZJz3QHZjJIvAAJzmlHoALpGFTNRXGiHi3S5sNmcBvlvL3RkypL/35YyCacOvZSbrXP/fmbckVSFXmTRsjxDF5Mo6LRqoz+DImVnkrq1fMpIPocMzK+6ByTTlzllnOuXjzhHElfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ExTKigSE; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ExTKigSE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741448376; x=1772984376;
  h=date:from:to:cc:subject:message-id;
  bh=IN9gA8jVlzJIC8dYGQ6vumDwJVdbenFlIEJnrR4vo2c=;
  b=ExTKigSEQgTiRS3buxVSgnony//glyBZNlIt5W1dS8mXBmY74BF+b7GF
   g+VoloDkvGf3cr51lFJ2UlQNu24jGywky7ycDNpeN3ynDwqlnmseAYngl
   MT8AguY58dBTIMHLGxWmTJv1490/t4ZdhgAgAsc7eJK8nmoYnkipL9HtA
   TyfOp3SfStxY/K+mUfDO80TLiRrIOdrYARWmDuAqLabFykr8iwZT7qWjk
   oTnYPyEnRKIy9gjhWVFs1Lp2YY6eTGnE6cpMkmvDeT1wkG5Ee6UKD6ZF/
   2Bh32Hpp9KwhhWbFDtkSDktdB9LsG3vw92xBFtuBAWgMj92aijztNCD5P
   Q==;
X-CSE-ConnectionGUID: xglEZFm/Q6a/u0odqoknLQ==
X-CSE-MsgGUID: LkZ9jNWJRxyIL6Htt5Z2YQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="41646908"
X-IronPort-AV: E=Sophos;i="6.14,232,1736841600"; 
   d="scan'208";a="41646908"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 07:39:35 -0800
X-CSE-ConnectionGUID: 7qpN7v5PQ9KxOVdvpOLZWg==
X-CSE-MsgGUID: FhdQ8SHpSf6wHMStuWqjHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150527452"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 08 Mar 2025 07:39:34 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqwGn-00020K-0k;
	Sat, 08 Mar 2025 15:39:29 +0000
Date: Sat, 08 Mar 2025 23:38:19 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 dfa48dfca48ec34b44686d8c4a59e7aaa25beadd
Message-ID: <202503082313.620FPsGr-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: dfa48dfca48ec34b44686d8c4a59e7aaa25beadd  Bluetooth: btintel_pci: Fix build warning

elapsed time: 1446m

configs tested: 64
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                  randconfig-001-20250308    gcc-13.2.0
arc                  randconfig-002-20250308    gcc-13.2.0
arm                  randconfig-001-20250308    gcc-14.2.0
arm                  randconfig-002-20250308    gcc-14.2.0
arm                  randconfig-003-20250308    gcc-14.2.0
arm                  randconfig-004-20250308    gcc-14.2.0
arm64                randconfig-001-20250308    gcc-14.2.0
arm64                randconfig-002-20250308    gcc-14.2.0
arm64                randconfig-003-20250308    clang-16
arm64                randconfig-004-20250308    gcc-14.2.0
csky                 randconfig-001-20250308    gcc-14.2.0
csky                 randconfig-002-20250308    gcc-14.2.0
hexagon              randconfig-001-20250308    clang-19
hexagon              randconfig-002-20250308    clang-21
i386       buildonly-randconfig-001-20250308    gcc-12
i386       buildonly-randconfig-002-20250308    gcc-11
i386       buildonly-randconfig-003-20250308    clang-19
i386       buildonly-randconfig-004-20250308    clang-19
i386       buildonly-randconfig-005-20250308    clang-19
i386       buildonly-randconfig-006-20250308    gcc-12
loongarch            randconfig-001-20250308    gcc-14.2.0
loongarch            randconfig-002-20250308    gcc-14.2.0
nios2                randconfig-001-20250308    gcc-14.2.0
nios2                randconfig-002-20250308    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc               randconfig-001-20250308    gcc-14.2.0
parisc               randconfig-002-20250308    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20250308    clang-18
powerpc              randconfig-002-20250308    gcc-14.2.0
powerpc              randconfig-003-20250308    gcc-14.2.0
powerpc64            randconfig-001-20250308    gcc-14.2.0
powerpc64            randconfig-003-20250308    clang-21
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20250308    clang-21
riscv                randconfig-002-20250308    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-15
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250308    clang-19
s390                 randconfig-002-20250308    clang-17
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250308    gcc-14.2.0
sh                   randconfig-002-20250308    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250308    gcc-14.2.0
sparc                randconfig-002-20250308    gcc-14.2.0
sparc64              randconfig-001-20250308    gcc-14.2.0
sparc64              randconfig-002-20250308    gcc-14.2.0
um                               allnoconfig    clang-18
um                   randconfig-001-20250308    gcc-12
um                   randconfig-002-20250308    gcc-12
x86_64                           allnoconfig    clang-19
x86_64     buildonly-randconfig-001-20250308    gcc-12
x86_64     buildonly-randconfig-002-20250308    clang-19
x86_64     buildonly-randconfig-003-20250308    gcc-12
x86_64     buildonly-randconfig-004-20250308    clang-19
x86_64     buildonly-randconfig-005-20250308    clang-19
x86_64     buildonly-randconfig-006-20250308    clang-19
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250308    gcc-14.2.0
xtensa               randconfig-002-20250308    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
