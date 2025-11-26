Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2558730E83F
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Nov 2025 05:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764134075; cv=none; b=HFUCZYebaIxowWU4aP1fCLSyVNM1Ckn1BcvR791E6IIWr4atFAjGJvAM7LEJi3gORcVKASpqvCza1sFX0NGlHBdqnH73y/3yL/qlbkWG0s5FXRQ96rhoKkjJOEXtg4LnRYqbq5gfLl/WcitBPn9HAZD8RYnjGrE/qS9FW32GSy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764134075; c=relaxed/simple;
	bh=TIjF/UjNb+SCjJ+YwH1D39RQJnDMJVxD7r9qJOFoJFE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iF+uJLpzxWVxfZUFMY6fAcLHs0T8VMSUNJ7Ttqk+4k/1S9VXVA69+/G95ky1hI1MoJwZtY4SBP7Jzt1I4kdndEMKqzl5qE91Eusi/42+/ORnEAVhkI7x+R1FflZShU9CclRkMB48ntZAqiZjoQZMMLqvgtQUmYqCU0KQoh20PT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HCQwgSpP; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HCQwgSpP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764134073; x=1795670073;
  h=date:from:to:cc:subject:message-id;
  bh=TIjF/UjNb+SCjJ+YwH1D39RQJnDMJVxD7r9qJOFoJFE=;
  b=HCQwgSpPF62oBJOhO5mVXlNLLJRx1eEOF5pFjHWZnbhqLwTjLQCgceyo
   4IrT40uHRKW/SMUoi8FBCV4cxjAW6fsPvwxoJfcO+x9YsKzNEsE4wAtcB
   r9gQItotG9zfZYI7ilTGSccS7sXRjMQheexgZuAwfH3x70jA2hmmQiQW8
   PnZ4qSQ2Pm1oXNlRa9nxZj30QnkGSwZTYouVHvh+kp5zPUwNyiXiBmwlg
   1LX0Npv0PvkV/XMAz4R6EU+6UncsMfE5s0OAqu0hfX78+VOOMJScPy4tG
   +PsxZ0p8yFT0LpcYQ3PWEq5HH+YLaOrS1NlUVgzTeUKtT4IS79d/ZxwdC
   g==;
X-CSE-ConnectionGUID: SrzNi75nQTqGkmgf6rGF3Q==
X-CSE-MsgGUID: OX95cC7tT6u60+GOGNhj2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="66204793"
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="66204793"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 21:14:32 -0800
X-CSE-ConnectionGUID: mZKIy9K+SaCy0X+zvJlDMg==
X-CSE-MsgGUID: v3lHFgcqSdebGknFACUpXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="192477947"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 25 Nov 2025 21:14:31 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vO7rI-000000002VJ-3ep1;
	Wed, 26 Nov 2025 05:14:28 +0000
Date: Wed, 26 Nov 2025 13:13:31 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 74d9900f3087b955b23f1f679accf654e16b35dc
Message-ID: <202511261325.bnQ3tSVB-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 74d9900f3087b955b23f1f679accf654e16b35dc  Bluetooth: SMP: Fix not generating mackey and ltk when repairing

elapsed time: 7598m

configs tested: 55
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-15.1.0
alpha        allyesconfig    gcc-15.1.0
arc          allmodconfig    gcc-15.1.0
arc           allnoconfig    gcc-15.1.0
arc          allyesconfig    gcc-15.1.0
arm           allnoconfig    clang-22
arm          allyesconfig    gcc-15.1.0
arm64        allmodconfig    clang-19
arm64         allnoconfig    gcc-15.1.0
csky         allmodconfig    gcc-15.1.0
csky          allnoconfig    gcc-15.1.0
hexagon      allmodconfig    clang-17
hexagon       allnoconfig    clang-22
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-22
m68k         allmodconfig    gcc-15.1.0
m68k          allnoconfig    gcc-15.1.0
m68k         allyesconfig    gcc-15.1.0
microblaze    allnoconfig    gcc-15.1.0
microblaze   allyesconfig    gcc-15.1.0
mips         allmodconfig    gcc-15.1.0
mips          allnoconfig    gcc-15.1.0
mips         allyesconfig    gcc-15.1.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-15.1.0
openrisc      allnoconfig    gcc-15.1.0
parisc       allmodconfig    gcc-15.1.0
parisc        allnoconfig    gcc-15.1.0
parisc       allyesconfig    gcc-15.1.0
powerpc      allmodconfig    gcc-15.1.0
powerpc       allnoconfig    gcc-15.1.0
riscv        allmodconfig    clang-22
riscv         allnoconfig    gcc-15.1.0
riscv        allyesconfig    clang-16
s390         allmodconfig    clang-18
s390          allnoconfig    clang-22
s390         allyesconfig    gcc-15.1.0
sh           allmodconfig    gcc-15.1.0
sh            allnoconfig    gcc-15.1.0
sh           allyesconfig    gcc-15.1.0
sparc         allnoconfig    gcc-15.1.0
sparc64      allmodconfig    clang-22
um           allmodconfig    clang-19
um            allnoconfig    clang-22
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-20
x86_64        allnoconfig    clang-20
x86_64       allyesconfig    clang-20
x86_64      rhel-9.4-rust    clang-20
xtensa        allnoconfig    gcc-15.1.0
xtensa       allyesconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
