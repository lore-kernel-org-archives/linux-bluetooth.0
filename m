Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ACE184D
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jul 2024 01:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719797520; cv=none; b=VliA8aLkLNHtjoIFUY4Z3DVaCls/5FUzEt5g5O5VZfYlxj4Rs9loJrQbJ/Cr/r+bpSVhrOF3hKmBODqSgBf4SBHIPvFfBzlKhLHXmvi5Np78FqdECUcDodfBhhQbbY800NcO1AxDhguqXRSYGXnMF4C1gzkBlTAl8xUwZVMGnf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719797520; c=relaxed/simple;
	bh=XKNv3NxkRbs/scdpIh6hjreYMGDTXBkRZnrBaJkwKd4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=S089aOTQbHpohFDhXJIjgY7kUg8EkEdRbBp0Cn5r98pdqOH/zAjffBY6ByzC3KIHP/kM5FAMck7WhOubYx7XgnLRIrXjHmqBJzybiK6UVCcUfMv0CJqSMCEVgzmWqJtk0FMc25kGTLWnYy13reRO9DtO7ORxuBJyo6YC43eD5aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JyIsxPvy; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JyIsxPvy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719797518; x=1751333518;
  h=date:from:to:cc:subject:message-id;
  bh=XKNv3NxkRbs/scdpIh6hjreYMGDTXBkRZnrBaJkwKd4=;
  b=JyIsxPvyYfCFM2AN4tLTQseBTLZgW9QZQkaJqR8PG48gGIDzcwHMFMIP
   7LClmaNIwJqTQfO3nYQDr9Y37I8XGsu9ZUftTcw/gMY7muq+3boYQYpR1
   3S8CBjy0axHgSwF5Ujyp2s1RxEJbLpSFohwgPnVBxrgN+zSYmRK9VPBx8
   /eMi70cGZUZmf5e18CKXy0767hHGdYDtcVK+ydyLQ36mrlrTLW9xvbB05
   hSJFEzRpR+FvJCsdgX05nF2yDT3+29Lj6aZoV7iM4nQVybWDFp7GjtVRd
   c7YqsPhqxmmeFwxhb2K6Cy6O7BQbqyMMMJztVbUtwqO42NXzbzvYXeSwL
   w==;
X-CSE-ConnectionGUID: vdmG+cNLQ7CrK8tFkuVYSg==
X-CSE-MsgGUID: I3crluAqRUKMG/1IEW4v8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="17033129"
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="17033129"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2024 18:31:58 -0700
X-CSE-ConnectionGUID: smA3rjHNRU++HQBgkJsfKA==
X-CSE-MsgGUID: GNvtnt8jScWhcxT1vGopbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="45759562"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 30 Jun 2024 18:31:57 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sO5ta-000MHq-1b;
	Mon, 01 Jul 2024 01:31:54 +0000
Date: Mon, 01 Jul 2024 09:31:00 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 989e25f5b99ece9d5d13fc5efb21afd8dc157390
Message-ID: <202407010958.PpdfWkRi-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 989e25f5b99ece9d5d13fc5efb21afd8dc157390  Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x13d3:0x3591

elapsed time: 3268m

configs tested: 64
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240701   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                   randconfig-001-20240701   gcc-13.2.0
arm                   randconfig-002-20240701   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
hexagon                           allnoconfig   clang-19
i386         buildonly-randconfig-001-20240629   gcc-7
i386         buildonly-randconfig-001-20240630   clang-18
i386         buildonly-randconfig-002-20240629   gcc-7
i386         buildonly-randconfig-002-20240630   clang-18
i386         buildonly-randconfig-003-20240629   gcc-7
i386         buildonly-randconfig-003-20240630   clang-18
i386         buildonly-randconfig-004-20240629   gcc-7
i386         buildonly-randconfig-004-20240630   clang-18
i386         buildonly-randconfig-005-20240629   gcc-7
i386         buildonly-randconfig-005-20240630   clang-18
i386         buildonly-randconfig-006-20240629   gcc-7
i386         buildonly-randconfig-006-20240630   clang-18
i386                  randconfig-001-20240629   gcc-7
i386                  randconfig-001-20240630   clang-18
i386                  randconfig-002-20240629   gcc-7
i386                  randconfig-002-20240630   clang-18
i386                  randconfig-003-20240629   gcc-7
i386                  randconfig-003-20240630   clang-18
i386                  randconfig-004-20240629   gcc-7
i386                  randconfig-004-20240630   clang-18
i386                  randconfig-005-20240629   gcc-7
i386                  randconfig-005-20240630   clang-18
i386                  randconfig-006-20240629   gcc-7
i386                  randconfig-006-20240630   clang-18
i386                  randconfig-011-20240629   gcc-7
i386                  randconfig-011-20240630   clang-18
i386                  randconfig-012-20240629   gcc-7
i386                  randconfig-012-20240630   clang-18
i386                  randconfig-013-20240629   gcc-7
i386                  randconfig-013-20240630   clang-18
i386                  randconfig-014-20240629   gcc-7
i386                  randconfig-014-20240630   clang-18
i386                  randconfig-015-20240629   gcc-7
i386                  randconfig-015-20240630   clang-18
i386                  randconfig-016-20240629   gcc-7
i386                  randconfig-016-20240630   clang-18
loongarch                         allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
s390                              allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
um                                allnoconfig   gcc-13.2.0
x86_64                                  kexec   clang-18
x86_64                               rhel-8.3   clang-18
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
