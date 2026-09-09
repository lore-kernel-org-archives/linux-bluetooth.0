Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D764C32A3D7
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 17:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973530; cv=none; b=fnaCR0TtHz3mxpn1pSSgPXXOr4aMWMsYVWBBXEL/K+E9IopS7AROllz82g94StGuXVKDDWdeojGRg3bMnrQzPE0xNvalUscSMXOHOzSHaiPeOfL9x5+IvNDJaA3pm8Wd6gKtDKNrsVvePbkHkBGnKwOLPbXpihsHicSuHfmyyiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973530; c=relaxed/simple;
	bh=9VT0tl2rP+WOde+4Ssi+o95sdv65v6LyjN9Z3+p4i3I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AQP+nXBAftGqq1eUjaKGdIr4WiGnxIYfF5oNZWoh4Nnbv7c2g/NYEhML5ZBYcAnMHR4z1pdjizL0Zrfp0c99SCnlAOUA+rbe8x0CqGFzSQRQkhAf8K+M+mPxgtZFXDYSMCRcHwpYiKByM0mZynwTwEZgTwCp/ymKH80lIoUuIjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QNnA57Jc; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QNnA57Jc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788973529; x=1820509529;
  h=date:from:to:cc:subject:message-id;
  bh=9VT0tl2rP+WOde+4Ssi+o95sdv65v6LyjN9Z3+p4i3I=;
  b=QNnA57JcKN5dt9LwwbTXZO901TFvE0Ji0zeGh4b3N4LT9br04d0XCBkW
   LX+ktAZpkqiijlsQIPNlSWxyEY0ea63lXmkcOIPGZzh1PXwkXGhrGzZUh
   uXJI0ncOjPpvJY3oVhivVP3+esufnSDipmX94J0sQg61ksuLu6Pz7kjWO
   1utkreNWdJGOSnyYAvLuZ/wnV0G6W4ADw/7BZvqYCCTc2wqHVWeUbFOog
   d6xesgCm/eaZRGsLIe49LZWv72eILK2w5RTLOo9wg1POJe/n8DiSwpFgY
   ++dL+foBubT87FY+OTOlYG2zZIBuuRd10JCIT6ogthNsXOLCEpaakTPci
   A==;
X-CSE-ConnectionGUID: 9qJwvvqwTJS8EBu7BGOvxA==
X-CSE-MsgGUID: BiDGe1j1TlmsEr3dyuUjNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89439436"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="89439436"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 10:05:17 -0700
X-CSE-ConnectionGUID: ziZJ6awKRT2UGcH/Udrmcg==
X-CSE-MsgGUID: eqE9gTdQRb6wePr1OTqScw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="301269007"
Received: from lkp-server01.sh.intel.com (HELO a3e91e2cf319) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 09 Sep 2026 10:05:16 -0700
Received: from kbuild by a3e91e2cf319 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x4LjV-000000000fc-2dJv;
	Wed, 09 Sep 2026 17:05:13 +0000
Date: Thu, 10 Sep 2026 01:04:32 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 701ca71884b3d101fd25b7adbf972355056ef352
Message-ID: <202609100128.Q6z6YexN-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 701ca71884b3d101fd25b7adbf972355056ef352  Bluetooth: coredump: Quiesce dump work on unregister

elapsed time: 1465m

configs tested: 67
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    clang-24
arc          allmodconfig    gcc-16.1.0
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    clang-24
arm           allnoconfig    clang-17
arm           allnoconfig    gcc-16.1.0
arm          allyesconfig    clang-24
arm          allyesconfig    gcc-16.1.0
arm64        allmodconfig    clang-24
arm64         allnoconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
csky          allnoconfig    gcc-16.1.0
hexagon      allmodconfig    clang-24
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
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    clang-20
openrisc     allmodconfig    gcc-16.1.0
openrisc      allnoconfig    gcc-16.1.0
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    gcc-16.1.0
parisc       allyesconfig    clang-17
parisc       allyesconfig    gcc-16.1.0
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    gcc-16.1.0
riscv        allmodconfig    clang-24
riscv         allnoconfig    gcc-16.1.0
riscv        allyesconfig    clang-24
s390         allmodconfig    clang-17
s390         allmodconfig    clang-24
s390          allnoconfig    clang-24
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    gcc-16.1.0
sh           allyesconfig    clang-17
sh           allyesconfig    gcc-16.1.0
sparc         allnoconfig    gcc-16.1.0
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-17
um            allnoconfig    clang-17
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-22
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    gcc-16.1.0
xtensa       allyesconfig    clang-20
xtensa       allyesconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
