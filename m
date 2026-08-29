Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3123433D4E4
	for <linux-bluetooth@vger.kernel.org>; Sat, 29 Aug 2026 03:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787975090; cv=none; b=S7npGn71HRr4FY3o8azefjaHhAb++crFTuL3USy2Ftm4Tyx9AuOq36djrfhAhMkrpPjb1kOuVKGnrQzxepqIvBgjkX5IIj5o8CcpVJjZbEMuUZZLcvJpnazRndRcrUwoyXfwfzbuCkkdfg0gtbX6YR8RVV/z91p8orKsoQF/oGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787975090; c=relaxed/simple;
	bh=sD6bYtdNmcmdwcjpC6HunqQwOp/JPDRzeBxobjybtPY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SuKnB0KSH8QydB+AJ5EBH7tEaRinWqvxPrHJfnnO2rF9rLdDRaX3sgvZ/H/4DFjuZv0FytLVlEm3qlq5zk2xvj+890bNGv8JGwLhn9LAHWV2HOFubyIkj1NOng8mO9LIdWjkwXz9gyIfniFmRtDUR9fp2SOzjrCDT8RqW1Nt0EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BkEFCbqq; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BkEFCbqq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787975088; x=1819511088;
  h=date:from:to:cc:subject:message-id;
  bh=sD6bYtdNmcmdwcjpC6HunqQwOp/JPDRzeBxobjybtPY=;
  b=BkEFCbqqFvzlLPuq1E+uXWvLE/S8t6iwX1/iaPDeDE5CIwjJHpkmnMJp
   KwuU/+Dj92I+NN36FVkl4j9jUDLccWMXPpsHSGo09WgmvXcKWF6schsde
   bFAq5oHZlyvIqhWgFJYbasn1CsRpRW9fC/yatVyIAH/TZeL1KO9H0inD1
   bOZvzW7xkyN+FBLy8zZFqpf0RiCw7KvjGuPNrCELY9jSo4Nmgyu5wvhd3
   dv4lVQqRmC3rct09cq173nf4b/IDMKm/95fRkKrTnrUjpJ1RAjx0XAL+F
   Az0W4TRrfeqXOCmb65U+uf+uWgCR69AOg+vl3SHTuryeSDyXG39HyxC+1
   w==;
X-CSE-ConnectionGUID: pN7izOUrRNmdrTtq9XKRGw==
X-CSE-MsgGUID: kAvRIOxRTq+cb1mo5XrThA==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="99077718"
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; 
   d="scan'208";a="99077718"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 20:44:47 -0700
X-CSE-ConnectionGUID: PLNTVyS5SPerUGYQT1sedA==
X-CSE-MsgGUID: q7riSVWXTpidJtCjb0CGxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; 
   d="scan'208";a="268366570"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 28 Aug 2026 20:44:46 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x09zo-00000000CLI-1OQb;
	Sat, 29 Aug 2026 03:44:44 +0000
Date: Sat, 29 Aug 2026 11:44:04 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 bcb621272aa04a116a74ab5fcc9324231ffa3acb
Message-ID: <202608291151.fuW0N60Y-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: bcb621272aa04a116a74ab5fcc9324231ffa3acb  Bluetooth: btintel_pcie: Clear automask on spurious interrupts

elapsed time: 789m

configs tested: 80
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha               allnoconfig    gcc-16.1.0
alpha              allyesconfig    gcc-16.1.0
alpha                 defconfig    gcc-16.1.0
arc                allmodconfig    clang-24
arc                 allnoconfig    gcc-16.1.0
arc                allyesconfig    clang-24
arc                   defconfig    gcc-16.1.0
arm                 allnoconfig    gcc-16.1.0
arm                allyesconfig    clang-24
arm                   defconfig    gcc-16.1.0
arm64              allmodconfig    clang-24
arm64               allnoconfig    gcc-16.1.0
arm64                 defconfig    gcc-16.1.0
csky               allmodconfig    gcc-16.1.0
csky                allnoconfig    gcc-16.1.0
csky                  defconfig    gcc-16.1.0
hexagon            allmodconfig    gcc-16.1.0
hexagon             allnoconfig    gcc-16.1.0
hexagon               defconfig    gcc-16.1.0
i386               allmodconfig    clang-22
i386                allnoconfig    gcc-16.1.0
i386               allyesconfig    clang-22
i386                  defconfig    gcc-16.1.0
loongarch          allmodconfig    clang-24
loongarch           allnoconfig    gcc-16.1.0
loongarch             defconfig    clang-24
m68k               allmodconfig    gcc-16.1.0
m68k                allnoconfig    gcc-16.1.0
m68k               allyesconfig    clang-24
m68k                  defconfig    clang-24
microblaze          allnoconfig    gcc-16.1.0
microblaze         allyesconfig    gcc-16.1.0
microblaze            defconfig    clang-24
mips               allmodconfig    gcc-16.1.0
mips                allnoconfig    gcc-16.1.0
mips               allyesconfig    gcc-16.1.0
nios2              allmodconfig    clang-20
nios2               allnoconfig    clang-24
nios2                 defconfig    clang-24
openrisc           allmodconfig    clang-20
openrisc            allnoconfig    clang-24
parisc             allmodconfig    gcc-16.1.0
parisc              allnoconfig    clang-24
parisc             allyesconfig    clang-17
parisc64              defconfig    clang-24
powerpc            allmodconfig    gcc-16.1.0
powerpc             allnoconfig    clang-24
riscv              allmodconfig    clang-24
riscv               allnoconfig    clang-24
riscv              allyesconfig    clang-24
s390               allmodconfig    clang-17
s390                allnoconfig    clang-24
s390               allyesconfig    gcc-16.1.0
sh                 allmodconfig    gcc-16.1.0
sh                  allnoconfig    clang-24
sh                 allyesconfig    clang-17
sh                    defconfig    gcc-14
sparc               allnoconfig    clang-24
sparc64            allmodconfig    clang-20
sparc64               defconfig    gcc-14
um                 allmodconfig    clang-17
um                  allnoconfig    clang-24
um                 allyesconfig    gcc-16.1.0
um                    defconfig    gcc-14
um               i386_defconfig    gcc-14
um             x86_64_defconfig    gcc-14
x86_64             allmodconfig    clang-22
x86_64              allnoconfig    clang-24
x86_64             allyesconfig    clang-22
x86_64                defconfig    gcc-14
x86_64                    kexec    clang-22
x86_64                 rhel-9.4    clang-22
x86_64             rhel-9.4-bpf    gcc-14
x86_64            rhel-9.4-func    clang-22
x86_64      rhel-9.4-kselftests    clang-22
x86_64           rhel-9.4-kunit    gcc-14
x86_64             rhel-9.4-ltp    gcc-14
x86_64            rhel-9.4-rust    clang-22
xtensa              allnoconfig    clang-24
xtensa             allyesconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
