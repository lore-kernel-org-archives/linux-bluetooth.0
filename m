Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51C730C615
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 11:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777030569; cv=none; b=rO+TEIwqhnAz9z3r614qtNKDXKBNzqE3MeHlZ8TnDv3e1SJz36mHPCmMlmGLqFB6d1mn+uJJkpZSfpyv1Ob4qoj2ve87xXyJZEjTlnfvt5EYN132fs3ijZ/FVdPmIVoL72Jhs2M9u85M6Jt1/V6bwiMYF8vJaL3yqdMhS/qZjHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777030569; c=relaxed/simple;
	bh=meA3pLPH7BMA6aieBwfBQsNSbmstfvJnzj4TRMJWuEk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qu7jXbocOpN7rscJpBje19CvuT6djrL4ZlkolZLtfKOC6xVMfehn+S+i7065G6x8y0chjU9vnAZLug0s0/0pc/db2AwUQb2exJrHRbrmFFL23dLwTo9Tz78GkjZsX2+XTGUMLTUmZdElj81/QOhR+e5haqQjppYttmCI0fZtRbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BsqO3l4X; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BsqO3l4X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777030568; x=1808566568;
  h=date:from:to:cc:subject:message-id;
  bh=meA3pLPH7BMA6aieBwfBQsNSbmstfvJnzj4TRMJWuEk=;
  b=BsqO3l4XG5XJJFa9n0udlFoHvparEcJueITyoHJGuhkYmFwa4UbTPeoD
   GZfRxtvN9j88266nMBgw4iRz3epYDukU5vhKNHfHUniOx8HAJpPjHY4F9
   A5g4BwlY9+G7WUELijf24/aMAHXpaa8TsualRcxfVbG0XZ2J3utMqSn+r
   RpE+kB/ud2kd9zLba0tuBJJ3/YUeAD4KOyHSSpGbLiTk3cH2GSXKyRnoj
   IEF7Aa/ELLhgLI6aGFG68s/al9547Iez/A/amAaFuw8wYuKgnvcgqqctm
   xUuS6ONhZqdBS25OcgH2FaJmPDbcX4znThqPy+NNn6viob2cmWNPsBvEO
   g==;
X-CSE-ConnectionGUID: NQPAETkpQ3+u5+IPCiJJ0Q==
X-CSE-MsgGUID: ALaMe7RlTqipnBcl5yCSUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="81616486"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="81616486"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 04:36:08 -0700
X-CSE-ConnectionGUID: PDxlKnTpSLOxv8GrvfvSJg==
X-CSE-MsgGUID: jdBCewZ4Se2nGXL7b7x6Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="271057048"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 24 Apr 2026 04:36:07 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wGEpI-000000005cH-0D7c;
	Fri, 24 Apr 2026 11:36:04 +0000
Date: Fri, 24 Apr 2026 19:35:43 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 0105c3e2a97e33c37d582a32d4307df6fb3c4cc3
Message-ID: <202604241934.lgT1nFXC-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 0105c3e2a97e33c37d582a32d4307df6fb3c4cc3  Bluetooth: btusb: Add Mercusys MA530 for Realtek RTL8761BUV

elapsed time: 957m

configs tested: 70
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.2.0
alpha                  allyesconfig    gcc-15.2.0
arc                    allmodconfig    gcc-15.2.0
arc                     allnoconfig    gcc-15.2.0
arc                    allyesconfig    gcc-15.2.0
arm                     allnoconfig    clang-23
arm                    allyesconfig    gcc-15.2.0
arm                gemini_defconfig    clang-20
arm64                   allnoconfig    gcc-15.2.0
arm64       randconfig-001-20260424    gcc-12.5.0
arm64       randconfig-003-20260424    gcc-13.4.0
arm64       randconfig-004-20260424    gcc-10.5.0
csky                    allnoconfig    gcc-15.2.0
hexagon                allmodconfig    clang-17
hexagon                 allnoconfig    clang-23
hexagon     randconfig-001-20260424    clang-23
hexagon     randconfig-002-20260424    clang-23
i386                    allnoconfig    gcc-14
i386                   allyesconfig    gcc-14
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-23
loongarch   randconfig-001-20260424    gcc-14.3.0
loongarch   randconfig-002-20260424    clang-23
m68k                   allmodconfig    gcc-15.2.0
m68k                    allnoconfig    gcc-15.2.0
m68k                   allyesconfig    gcc-15.2.0
microblaze              allnoconfig    gcc-15.2.0
microblaze             allyesconfig    gcc-15.2.0
mips                   allmodconfig    gcc-15.2.0
mips                    allnoconfig    gcc-15.2.0
mips                   allyesconfig    gcc-15.2.0
nios2                  allmodconfig    gcc-11.5.0
nios2                   allnoconfig    gcc-11.5.0
nios2       randconfig-001-20260424    gcc-11.5.0
openrisc               allmodconfig    gcc-15.2.0
openrisc                allnoconfig    gcc-15.2.0
parisc                 allmodconfig    gcc-15.2.0
parisc                  allnoconfig    gcc-15.2.0
parisc                 allyesconfig    gcc-15.2.0
powerpc                allmodconfig    gcc-15.2.0
powerpc                 allnoconfig    gcc-15.2.0
riscv                  allmodconfig    clang-23
riscv                   allnoconfig    gcc-15.2.0
riscv                  allyesconfig    clang-16
riscv       randconfig-001-20260424    gcc-15.2.0
riscv       randconfig-002-20260424    clang-23
s390                   allmodconfig    clang-18
s390                    allnoconfig    clang-23
s390                   allyesconfig    gcc-15.2.0
s390        randconfig-001-20260424    gcc-8.5.0
s390        randconfig-002-20260424    clang-23
sh                     allmodconfig    gcc-15.2.0
sh                      allnoconfig    gcc-15.2.0
sh                     allyesconfig    gcc-15.2.0
sh          randconfig-001-20260424    gcc-15.2.0
sh          randconfig-002-20260424    gcc-15.2.0
sparc                   allnoconfig    gcc-15.2.0
sparc       randconfig-001-20260424    gcc-15.2.0
sparc       randconfig-002-20260424    gcc-13.4.0
sparc64                allmodconfig    clang-23
sparc64     randconfig-001-20260424    clang-23
sparc64     randconfig-002-20260424    gcc-15.2.0
um                     allmodconfig    clang-19
um                      allnoconfig    clang-23
um                     allyesconfig    gcc-14
x86_64                 allmodconfig    clang-20
x86_64                  allnoconfig    clang-20
x86_64                 allyesconfig    clang-20
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
