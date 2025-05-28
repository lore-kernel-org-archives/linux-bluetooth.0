Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F1C382
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 05:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748411656; cv=none; b=dNi4sAgUzPwq/PZa4IjWGaDy2GOUq+KRbiMLNxVUsEPyFWuzuBRkuUo1qQExm12XSwXRFDA5F4xuPimHKHOSD3S2PmrECm3UGb1QVLBhkYU4JOsKd/fxKKdhgNl1KVl9vKs+smduQVg+LLqpbY5hkoib59nE3b4zYEAhRFmpBz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748411656; c=relaxed/simple;
	bh=9KUFBX5QHV7gknNtxW4zXEQ5+U62K/CymLkNUSAt8kE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=s3qKpeMpXve4WNGsLl56TX0lliY0Rzv2RJ9q5UzLtlmyKH3k2h5/Cy0FWriD5ustw1U9TxyNDcrhkTAtWMtDTzhUwoDDoFPL0P+VvKSYK8HEWrQu3IAiriDaGLaAsCus/RyLEGbL5gVET192nbM+PIoqW/86r3CBESoUIb2ZJYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V8TM8E/p; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V8TM8E/p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748411654; x=1779947654;
  h=date:from:to:cc:subject:message-id;
  bh=9KUFBX5QHV7gknNtxW4zXEQ5+U62K/CymLkNUSAt8kE=;
  b=V8TM8E/pPhgdRNnyWRR71ySMrErF7dCk3o6iBVa8tBprgvg4A3IBYP2o
   LS1RBaZnMtk0bcxTQMwJwZ1SOZCNnImbM47GfQe6gAAqaWULZpGhdB8/+
   sl2dDLfUkk/0Iy7yCDcjxKXdnAo7odusoHLm4chA3iOwNUdCYaGaHNfd6
   t/edaNQOXyQJDhMX7y8sDI4yLXrkYkMR+thjnInE11ng9Vy68hPS1F9Qi
   FZMIfQ1WeN5OegAw06SD1gWn3zJZE9fW2lwZuxeX5QElH2qOdGQ6eIqSP
   pmCFdQ8wUsgvkJaOw11rjgjjfK66CrazuU1qrVDez7lnfeMQXJBj7QeN4
   Q==;
X-CSE-ConnectionGUID: CeoQkEGsRFOt0MRMXQzNqQ==
X-CSE-MsgGUID: WSzTeUtRSz+kgG2Qf77rrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50530357"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="50530357"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 22:54:13 -0700
X-CSE-ConnectionGUID: caKtQGP6TraEr8LCz0Skcw==
X-CSE-MsgGUID: 8qPhjkpjTR2TIUzRCAk7ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="180361587"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 27 May 2025 22:54:13 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uK9ju-000VJE-2p;
	Wed, 28 May 2025 05:54:10 +0000
Date: Wed, 28 May 2025 13:53:21 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 8df2c74d466c3f31b23978bd705e924522ebee8f
Message-ID: <202505281311.lUvzup2z-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 8df2c74d466c3f31b23978bd705e924522ebee8f  Bluetooth: hci_qca: move the SoC type check to the right place

elapsed time: 982m

configs tested: 130
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250527    gcc-10.5.0
arc                   randconfig-002-20250527    gcc-10.5.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                         assabet_defconfig    clang-18
arm                   milbeaut_m10v_defconfig    clang-19
arm                            qcom_defconfig    clang-21
arm                   randconfig-001-20250527    clang-21
arm                   randconfig-002-20250527    gcc-7.5.0
arm                   randconfig-003-20250527    clang-19
arm                   randconfig-004-20250527    clang-21
arm                        spear3xx_defconfig    clang-17
arm                           stm32_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250527    gcc-8.5.0
arm64                 randconfig-002-20250527    gcc-8.5.0
arm64                 randconfig-003-20250527    clang-16
arm64                 randconfig-004-20250527    gcc-6.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250527    gcc-12.4.0
csky                  randconfig-002-20250527    gcc-12.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250527    clang-21
hexagon               randconfig-002-20250527    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250527    gcc-12
i386        buildonly-randconfig-002-20250527    clang-20
i386        buildonly-randconfig-003-20250527    clang-20
i386        buildonly-randconfig-004-20250527    clang-20
i386        buildonly-randconfig-005-20250527    gcc-11
i386        buildonly-randconfig-006-20250527    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250527    gcc-15.1.0
loongarch             randconfig-002-20250527    gcc-15.1.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       alldefconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250527    gcc-14.2.0
nios2                 randconfig-002-20250527    gcc-10.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
openrisc                 simple_smp_defconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250527    gcc-9.3.0
parisc                randconfig-002-20250527    gcc-11.5.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                    amigaone_defconfig    gcc-14.2.0
powerpc                      chrp32_defconfig    clang-19
powerpc                     ep8248e_defconfig    gcc-14.2.0
powerpc                    gamecube_defconfig    clang-21
powerpc               randconfig-001-20250527    gcc-6.5.0
powerpc               randconfig-002-20250527    clang-18
powerpc               randconfig-003-20250527    gcc-8.5.0
powerpc64             randconfig-001-20250527    clang-21
powerpc64             randconfig-002-20250527    clang-21
powerpc64             randconfig-003-20250527    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250527    gcc-8.5.0
riscv                 randconfig-002-20250527    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250527    gcc-6.5.0
s390                  randconfig-002-20250527    gcc-9.3.0
s390                       zfcpdump_defconfig    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                             espt_defconfig    gcc-14.2.0
sh                            migor_defconfig    gcc-14.2.0
sh                    randconfig-001-20250527    gcc-10.5.0
sh                    randconfig-002-20250527    gcc-15.1.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250527    gcc-11.5.0
sparc                 randconfig-002-20250527    gcc-7.5.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250527    gcc-5.5.0
sparc64               randconfig-002-20250527    gcc-7.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250527    clang-21
um                    randconfig-002-20250527    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250527    gcc-12
x86_64      buildonly-randconfig-002-20250527    clang-20
x86_64      buildonly-randconfig-003-20250527    gcc-12
x86_64      buildonly-randconfig-004-20250527    clang-20
x86_64      buildonly-randconfig-005-20250527    clang-20
x86_64      buildonly-randconfig-006-20250527    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250527    gcc-9.3.0
xtensa                randconfig-002-20250527    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
