Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4D43D75CF
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 10:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776163959; cv=none; b=YxIQ/4aUR7cyHlIGqzNyU9BGBkVWnQObYrNMBmqd2OC2aQeHpf+QAYcp/u4RYLvY0iLtn6s7qUYbqERV26xApYbTd7Z4D4JV0VDfkoSI8kjxot/KJTwWj4AahwyclQQ876TahTOxlVkv+ICxiQ3mW5DS79LaQd+YGldDM/+oZzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776163959; c=relaxed/simple;
	bh=vIwtEOJpzeFsp2fL7W/rXbGqInl0kOdZsvhfJvRr68w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jelDzQSAv+5l3WvXP1vyIA3SeTM9ht86iI/DKuMX6JY0eM5YPfmjo5PZD/3G4aHFQzBCRWvBNXEjfVRGopOFu+W01mHPy3dC1on5BqPX8JQH7GZYmTSkEN1dXzUdywwDj21Gbrc5JGRvcXxA/rSZDF+T6hLh87H7TWJCtJcfcG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xn5JdGTq; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xn5JdGTq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776163957; x=1807699957;
  h=date:from:to:cc:subject:message-id;
  bh=vIwtEOJpzeFsp2fL7W/rXbGqInl0kOdZsvhfJvRr68w=;
  b=Xn5JdGTqzdsbtDum2UaHIPIqsVxnpRkMM2Xmay3/aILLZnwX5EBgb5mv
   nSgYDDrboWpTDvu1ljQbK47Bc6Mbb5Su8R5+gOLOrk6x7YVi6v0uZrIJX
   HJsUn3TeVGUe5alTCB7cXCG1jniPBO393zADCb2M8k1w1FXle474xlRhd
   mmaF/mRKUceuTGE/f1PX0HrQZKL/sDqPeKR/659DShI8v0wwDKWqR/T1I
   FSjxLEDoEXAFQv1g8SwVEkfFpx0s7/tRiTj+gKVuBVRanUGy499dfkTu9
   ueRspNhJKf7NNDeLtAV7C7r1gxq/UdhD+E1j9de5HYfGn9F7vrh0p+hZb
   A==;
X-CSE-ConnectionGUID: zlBNR0Q2TNqQJWOKG45FsQ==
X-CSE-MsgGUID: XyxfPGhbSnC61MFGC5P7uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="76148841"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="76148841"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 03:52:36 -0700
X-CSE-ConnectionGUID: VZsipf0zRwCJhoXfWVWH9Q==
X-CSE-MsgGUID: osqZS0D4RZq0eS4ltqB3cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="234993863"
Received: from lkp-server01.sh.intel.com (HELO 7b0b59b3a0d4) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 14 Apr 2026 03:52:35 -0700
Received: from kbuild by 7b0b59b3a0d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wCbNh-000000001Mr-0NVe;
	Tue, 14 Apr 2026 10:52:33 +0000
Date: Tue, 14 Apr 2026 18:51:40 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 912a499a7955a2773a20f33e495a5ce24d7279f0
Message-ID: <202604141833.HLXiKMrQ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 912a499a7955a2773a20f33e495a5ce24d7279f0  Bluetooth: btintel_pcie: Support Product level reset

elapsed time: 873m

configs tested: 89
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.2.0
alpha                  allyesconfig    gcc-15.2.0
arc                    allmodconfig    gcc-15.2.0
arc                     allnoconfig    gcc-15.2.0
arc                    allyesconfig    gcc-15.2.0
arm                     allnoconfig    clang-23
arm                     allnoconfig    gcc-15.2.0
arm                    allyesconfig    gcc-15.2.0
arm         randconfig-002-20260414    gcc-15.2.0
arm64                  allmodconfig    clang-19
arm64                   allnoconfig    gcc-15.2.0
csky                   allmodconfig    gcc-15.2.0
csky                    allnoconfig    gcc-15.2.0
hexagon                allmodconfig    clang-17
hexagon                 allnoconfig    clang-23
hexagon                 allnoconfig    gcc-15.2.0
hexagon     randconfig-001-20260414    clang-23
hexagon     randconfig-002-20260414    clang-16
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-14
i386                    allnoconfig    gcc-15.2.0
i386                   allyesconfig    gcc-14
i386        randconfig-014-20260414    gcc-14
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-23
loongarch               allnoconfig    gcc-15.2.0
loongarch   randconfig-001-20260414    clang-18
loongarch   randconfig-002-20260414    clang-23
m68k                   allmodconfig    gcc-15.2.0
m68k                    allnoconfig    gcc-15.2.0
m68k                   allyesconfig    gcc-15.2.0
microblaze              allnoconfig    gcc-15.2.0
microblaze             allyesconfig    gcc-15.2.0
mips                   allmodconfig    gcc-15.2.0
mips                    allnoconfig    gcc-15.2.0
mips                   allyesconfig    gcc-15.2.0
nios2                  allmodconfig    gcc-11.5.0
nios2                   allnoconfig    clang-23
nios2                   allnoconfig    gcc-11.5.0
nios2       randconfig-001-20260414    gcc-11.5.0
nios2       randconfig-002-20260414    gcc-11.5.0
openrisc               allmodconfig    gcc-15.2.0
openrisc                allnoconfig    clang-23
openrisc                allnoconfig    gcc-15.2.0
openrisc                  defconfig    gcc-15.2.0
parisc                 allmodconfig    gcc-15.2.0
parisc                  allnoconfig    clang-23
parisc                  allnoconfig    gcc-15.2.0
parisc                 allyesconfig    gcc-15.2.0
parisc                    defconfig    gcc-15.2.0
powerpc                allmodconfig    gcc-15.2.0
powerpc                 allnoconfig    clang-23
powerpc                 allnoconfig    gcc-15.2.0
riscv                  allmodconfig    clang-23
riscv                   allnoconfig    clang-23
riscv                   allnoconfig    gcc-15.2.0
riscv                  allyesconfig    clang-16
riscv       randconfig-001-20260414    clang-23
riscv       randconfig-002-20260414    gcc-8.5.0
s390                   allmodconfig    clang-18
s390                    allnoconfig    clang-23
s390                   allyesconfig    gcc-15.2.0
s390        randconfig-001-20260414    clang-23
s390        randconfig-002-20260414    clang-23
sh                     allmodconfig    gcc-15.2.0
sh                      allnoconfig    clang-23
sh                      allnoconfig    gcc-15.2.0
sh                     allyesconfig    gcc-15.2.0
sh          randconfig-001-20260414    gcc-15.2.0
sh          randconfig-002-20260414    gcc-15.2.0
sparc                   allnoconfig    clang-23
sparc                   allnoconfig    gcc-15.2.0
sparc64                allmodconfig    clang-23
um                     allmodconfig    clang-19
um                      allnoconfig    clang-23
um                     allyesconfig    gcc-14
x86_64                 allmodconfig    clang-20
x86_64                  allnoconfig    clang-20
x86_64                  allnoconfig    clang-23
x86_64                 allyesconfig    clang-20
x86_64      randconfig-001-20260414    gcc-14
x86_64      randconfig-003-20260414    gcc-14
x86_64      randconfig-004-20260414    clang-20
x86_64      randconfig-005-20260414    clang-20
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    clang-23
xtensa                  allnoconfig    gcc-15.2.0
xtensa                 allyesconfig    gcc-15.2.0
xtensa        cadence_csp_defconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
