Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BF120330
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Nov 2025 01:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762652845; cv=none; b=IyQjEFRPVONpbXRLgnsa1OI9qm8XueeiACp4tbdaQkbtBzF31jr9j3nV3I9a6NJXKMmgCcQr9B5QTva2bOu5WqvWT+hVEYSBYHibmF9nYovbx+ACcIdSuEXTamtX8gr+mVLr4yM/HZA4eP8gDlSn1iv3cIf4IKfIFWybKfaEu9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762652845; c=relaxed/simple;
	bh=nJUBalX4wukZ4q+Z3ZF1IZ5YFT8fAOBLA8Ag46q+Mew=;
	h=Date:From:To:Cc:Subject:Message-ID; b=t1addVI0WJelykP8q32wSmkPINrvBRhzd+sg/9hQPJMiHQZl5e1Lu8V8ASwDVUEI6TuEk4MOXdEFj77A+c92Cz+QbJZok2iatZT5jbGceida0LHz96fwTPRahGNFA1p2spc+WYn+IljvwOQbzRRx5fa7Oi9HCR/fyV4vW/jhaeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kX52kBBU; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kX52kBBU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762652844; x=1794188844;
  h=date:from:to:cc:subject:message-id;
  bh=nJUBalX4wukZ4q+Z3ZF1IZ5YFT8fAOBLA8Ag46q+Mew=;
  b=kX52kBBUD68VQFvvJLMkQ8SVAHYw7LOMxkZjZd2kr9suNwWhOXEqoyWg
   lAoi6/uKSeVeNEW0yZ5sI6saN25DnA7aIE0jfwDM+zxHLne5zpq+Ftkd/
   UxafjyChYo9j+Waqc5HVJ2TfU74Kzf24AYpYtNSG8M6O+iuCekCBaM156
   75X2E5eihQHvR10Q/0+rn81MBCMxbE9Rj0LxH1tTMotSQl4RPHZI4K/gi
   VHGokA33chCidFgUtJtNh2VGbdbS1cdFJLzwHmMSm7EZT3XzUt8zLH5jh
   VmahT7aomkUdHcA/74SRr79eOAr7tq8HoDih1N2MYCqU+sVK1S1B9mMla
   w==;
X-CSE-ConnectionGUID: R3wTRskYSO6m38q14WzZ1Q==
X-CSE-MsgGUID: Zuq7bCj1RYe8uYDvuPghAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="87383257"
X-IronPort-AV: E=Sophos;i="6.19,290,1754982000"; 
   d="scan'208";a="87383257"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2025 17:47:22 -0800
X-CSE-ConnectionGUID: j/IW/VHPR9KDu0mAuW+8BA==
X-CSE-MsgGUID: swQKcrbDQt25TAGH6zBVtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,290,1754982000"; 
   d="scan'208";a="188623101"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 08 Nov 2025 17:47:20 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHuWU-0001fP-1e;
	Sun, 09 Nov 2025 01:47:18 +0000
Date: Sun, 09 Nov 2025 09:46:32 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 59e5396a25793eb6cb32763163e975c242ef3eef
Message-ID: <202511090927.kAOzG6SL-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 59e5396a25793eb6cb32763163e975c242ef3eef  Bluetooth: hci_event: Fix not handling PA Sync Lost event

elapsed time: 1847m

configs tested: 101
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                        nsimosci_defconfig    gcc-15.1.0
arc                   randconfig-001-20251108    gcc-12.5.0
arc                   randconfig-002-20251108    gcc-8.5.0
arc                           tb10x_defconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                            qcom_defconfig    clang-22
arm                   randconfig-001-20251108    gcc-14.3.0
arm                   randconfig-002-20251108    gcc-15.1.0
arm                   randconfig-003-20251108    clang-22
arm                   randconfig-004-20251108    gcc-10.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251109    gcc-15.1.0
arm64                 randconfig-002-20251109    gcc-12.5.0
arm64                 randconfig-003-20251109    clang-19
arm64                 randconfig-004-20251109    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251109    gcc-14.3.0
csky                  randconfig-002-20251109    gcc-11.5.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251108    clang-22
hexagon               randconfig-002-20251108    clang-22
i386                             alldefconfig    gcc-14
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251109    gcc-14
i386        buildonly-randconfig-002-20251109    gcc-13
i386        buildonly-randconfig-003-20251109    clang-20
i386        buildonly-randconfig-004-20251109    clang-20
i386        buildonly-randconfig-005-20251109    clang-20
i386        buildonly-randconfig-006-20251109    clang-20
i386                  randconfig-002-20251109    gcc-14
i386                  randconfig-003-20251109    clang-20
i386                  randconfig-004-20251109    clang-20
i386                  randconfig-005-20251109    gcc-14
i386                  randconfig-006-20251109    clang-20
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251108    gcc-12.5.0
loongarch             randconfig-002-20251108    gcc-12.5.0
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                        m5272c3_defconfig    gcc-15.1.0
m68k                        m5307c3_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251108    gcc-8.5.0
nios2                 randconfig-002-20251108    gcc-9.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251108    gcc-8.5.0
parisc                randconfig-002-20251108    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251108    gcc-8.5.0
powerpc               randconfig-002-20251108    gcc-9.5.0
powerpc64             randconfig-001-20251108    gcc-8.5.0
powerpc64             randconfig-002-20251108    gcc-8.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251108    clang-19
riscv                 randconfig-002-20251108    gcc-12.5.0
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                  randconfig-001-20251108    clang-22
s390                  randconfig-002-20251108    gcc-8.5.0
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251108    gcc-15.1.0
sh                    randconfig-002-20251108    gcc-13.4.0
sh                          sdk7780_defconfig    gcc-15.1.0
sh                           se7722_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251108    gcc-14.3.0
sparc                 randconfig-002-20251108    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251108    clang-20
sparc64               randconfig-002-20251108    clang-20
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251108    gcc-14
um                    randconfig-002-20251108    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20251109    gcc-14
x86_64                randconfig-012-20251109    clang-20
x86_64                randconfig-013-20251109    gcc-14
x86_64                randconfig-014-20251109    clang-20
x86_64                randconfig-015-20251109    clang-20
x86_64                randconfig-016-20251109    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251108    gcc-8.5.0
xtensa                randconfig-002-20251108    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
