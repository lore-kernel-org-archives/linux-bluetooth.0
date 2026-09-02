Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0B43290C8
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 18:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788374930; cv=none; b=X/e4ztAfQMaDq+cvexRpahemhpH/MdElbau+203GNqsVeukNAgkjzMSWaJRJqv5RPnBRWFStDQRxrwlk5y+eLGePMJcQxMGiS9iENniFElq20Rj8QOWFjzqpZDr9zHLfS3FTimwU7xLIeiCG5qk+PMEJK+WlytTAVri+cOthNOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788374930; c=relaxed/simple;
	bh=TM9RDbZfi4iY5km2cW3Rv0yL6DCFnUUqPT8adenz0jM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FUdqqs6w5gWvoo55rEeRUpsxv38+/ih5hImH3LpZr5/45z86BT6uy4vBGwCSf3iY98HyVlPG8Y1PJzbrGbH1DKtinsIwyIfQtODktc8o0kT1XSjWvXFmKQw+baoy71QwSM6eO3mjjrKfYgyg//6N7eFL2hyYFSRe4+IlJsfUQ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9LpO6v5; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9LpO6v5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788374929; x=1819910929;
  h=date:from:to:cc:subject:message-id;
  bh=TM9RDbZfi4iY5km2cW3Rv0yL6DCFnUUqPT8adenz0jM=;
  b=f9LpO6v5JNHWELfvjueOUqI0ugyfbuvoPPY5kwQdR187JTpdpcw+5OHQ
   4wKfhCEki/0N9zI9f1nlU5Yx9WEIwFoLchPvy9NWHO2tTT7Pai5kJL8kM
   LcPvoorwaPAbYu9YI+R1a4z/wVB0BnL8IRKjV2tdGUmkTdtG4agTN/FPE
   SivqyhJUxX3L0bHUlXqMms9gJCJwr0WhtgeYTybtJ638Jr42ZwcrnVs+A
   pa8qzVvzpMFL5lcz3cS82+avHgnc/6XdA16OYn6o9CKqSJmHSkI3ldZm6
   RU7xXC0Lyn9B+kGX7hUONi2HmH8xM4ksQ1WY/ArLmOpxr3hrXTa1zGKDu
   A==;
X-CSE-ConnectionGUID: r0a6rQl6S8Wwx/S4N29Pcw==
X-CSE-MsgGUID: pxklDyRDR3mWAqnHmmYSLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="106211844"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="106211844"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 11:48:48 -0700
X-CSE-ConnectionGUID: 5pdAP5vORJq9SKBVWGr4ZQ==
X-CSE-MsgGUID: Iqb6EBJTToehI9nkixCrIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="273246631"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 02 Sep 2026 11:48:48 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x1q0r-0000000039q-0rDu;
	Wed, 02 Sep 2026 18:48:45 +0000
Date: Thu, 03 Sep 2026 02:48:23 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 512bf44847667f5b11276747d578990e3033e585
Message-ID: <202609030212.G7q5tOCF-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 512bf44847667f5b11276747d578990e3033e585  Bluetooth: Properly disable remote wakeup for MT7922/MT7925 on Ryzen platform

elapsed time: 1022m

configs tested: 69
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    clang-24
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    clang-24
arm           allnoconfig    clang-17
arm           allnoconfig    gcc-16.1.0
arm          allyesconfig    clang-24
arm64        allmodconfig    clang-24
arm64         allnoconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
csky          allnoconfig    gcc-16.1.0
hexagon      allmodconfig    gcc-16.1.0
hexagon       allnoconfig    clang-24
hexagon       allnoconfig    gcc-16.1.0
i386         allmodconfig    clang-22
i386          allnoconfig    gcc-14
i386          allnoconfig    gcc-16.1.0
i386         allyesconfig    clang-22
loongarch    allmodconfig    clang-24
loongarch     allnoconfig    clang-20
loongarch     allnoconfig    gcc-16.1.0
m68k         allmodconfig    gcc-16.1.0
m68k          allnoconfig    gcc-16.1.0
m68k         allyesconfig    clang-24
microblaze    allnoconfig    gcc-16.1.0
microblaze   allyesconfig    gcc-16.1.0
mips         allmodconfig    gcc-16.1.0
mips          allnoconfig    gcc-16.1.0
mips         allyesconfig    gcc-16.1.0
nios2        allmodconfig    clang-20
nios2         allnoconfig    clang-24
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    clang-20
openrisc      allnoconfig    clang-24
openrisc      allnoconfig    gcc-16.1.0
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    clang-24
parisc        allnoconfig    gcc-16.1.0
parisc       allyesconfig    clang-17
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    clang-24
powerpc       allnoconfig    gcc-16.1.0
riscv        allmodconfig    clang-24
riscv         allnoconfig    clang-24
riscv         allnoconfig    gcc-16.1.0
riscv        allyesconfig    clang-24
s390         allmodconfig    clang-17
s390          allnoconfig    clang-24
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    clang-24
sh            allnoconfig    gcc-16.1.0
sh           allyesconfig    clang-17
sparc         allnoconfig    clang-24
sparc         allnoconfig    gcc-16.1.0
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-17
um            allnoconfig    clang-17
um            allnoconfig    clang-24
um           allyesconfig    gcc-16.1.0
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-22
x86_64        allnoconfig    clang-24
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    clang-24
xtensa        allnoconfig    gcc-16.1.0
xtensa       allyesconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
