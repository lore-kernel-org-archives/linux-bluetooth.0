Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEA91E0081
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 12:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728046041; cv=none; b=ami6ixHJy8g//g8IyDecZ1qggNw5mJx6kvn+djA7bW8jNSdI5kg4bH/1OLhyuoawcHLraXpZZgHvn3s8xJ6CNrWdrheeowqAviBEBRbNcVl6KAOx531hAg/Is4NXlO9JgRiOcEaeyRHBZyXp2G5rnwNrOucqORLwjsR3qTRYhjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728046041; c=relaxed/simple;
	bh=dvNQribspnkIIiztmR5dwvK//+lR9ErYlYxKHa5Stoo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uhC2AQhKH8VTDfxy9C4EdSy5EKfxAj/947q53eP6lG4EVHvwCWBnDNWsaRRG0lPJWWiVUe0S0M7oM69oO0dbMzGYWS86OSRv0GK0yb2p+ebh6ZXDrkEZ/9V/lfCcs9W7fdMapH2pEbJRY3JOGUm/MItwAVwziZ3KD1kMeLtReN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dk4EKh/v; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dk4EKh/v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728046038; x=1759582038;
  h=date:from:to:cc:subject:message-id;
  bh=dvNQribspnkIIiztmR5dwvK//+lR9ErYlYxKHa5Stoo=;
  b=dk4EKh/vr4JxND8h+iX5kw0rtMf7gLRYOwefx4ySY3m5nqssHCVOvkQk
   gLMKZQ2drFlD4Ic4qHJLqFsKhAQfFIBk45hxcF9Rg+HeWYsNvGOLMWrty
   hMBHxWG9LPTTmlBnpPIAEaqrmq21+bt1U8XLgziABimFprqMN5Jniovqu
   3v6fSwo266Zfhj7y/k0C8qQVicvZ2SqRxR2GlaBFaccUH2/m773SNRiuL
   Facc2cCY69miYRmhrqB308xhnkHBtzE8/XFbgTSE2olEMOX+Ym7V8Zqhi
   gZPE8BLIaI1+peJEC3cXn1vJFtCazLm3/5LvfHPosCitLdvyi6okoCqnX
   g==;
X-CSE-ConnectionGUID: EDXvK3tMT7ODHm0ZjzjkJg==
X-CSE-MsgGUID: fuNr7wgvTxiZe4UqBzOlXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="37833528"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="37833528"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 05:47:17 -0700
X-CSE-ConnectionGUID: uMz4VfVzS2yZrP13UALxKA==
X-CSE-MsgGUID: qQA6SEOlQsGuY6qPJjtY/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="75506329"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 04 Oct 2024 05:47:16 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swhiE-0001co-2G;
	Fri, 04 Oct 2024 12:47:14 +0000
Date: Fri, 04 Oct 2024 20:46:40 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 81b3e33bb054c09a36d2acf84e144746338a5739
Message-ID: <202410042026.fNuSNNb5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 81b3e33bb054c09a36d2acf84e144746338a5739  Bluetooth: btusb: Don't fail external suspend requests

elapsed time: 1173m

configs tested: 82
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha            allnoconfig    gcc-14.1.0
alpha           allyesconfig    clang-20
alpha              defconfig    gcc-14.1.0
arc             allmodconfig    clang-20
arc              allnoconfig    gcc-14.1.0
arc             allyesconfig    clang-20
arc                defconfig    gcc-14.1.0
arm             allmodconfig    clang-20
arm              allnoconfig    gcc-14.1.0
arm             allyesconfig    clang-20
arm                defconfig    gcc-14.1.0
arm64           allmodconfig    clang-20
arm64            allnoconfig    gcc-14.1.0
arm64              defconfig    gcc-14.1.0
csky             allnoconfig    gcc-14.1.0
csky               defconfig    gcc-14.1.0
hexagon         allmodconfig    clang-20
hexagon          allnoconfig    gcc-14.1.0
hexagon         allyesconfig    clang-20
hexagon            defconfig    gcc-14.1.0
i386            allmodconfig    clang-18
i386             allnoconfig    clang-18
i386            allyesconfig    clang-18
i386               defconfig    clang-18
loongarch       allmodconfig    gcc-14.1.0
loongarch        allnoconfig    gcc-14.1.0
loongarch          defconfig    gcc-14.1.0
m68k            allmodconfig    gcc-14.1.0
m68k             allnoconfig    gcc-14.1.0
m68k            allyesconfig    gcc-14.1.0
m68k               defconfig    gcc-14.1.0
microblaze      allmodconfig    gcc-14.1.0
microblaze       allnoconfig    gcc-14.1.0
microblaze      allyesconfig    gcc-14.1.0
microblaze         defconfig    gcc-14.1.0
mips             allnoconfig    gcc-14.1.0
nios2            allnoconfig    gcc-14.1.0
nios2              defconfig    gcc-14.1.0
openrisc         allnoconfig    clang-20
openrisc         allnoconfig    gcc-14.1.0
openrisc        allyesconfig    gcc-14.1.0
openrisc           defconfig    gcc-12
parisc          allmodconfig    gcc-14.1.0
parisc           allnoconfig    clang-20
parisc           allnoconfig    gcc-14.1.0
parisc          allyesconfig    gcc-14.1.0
parisc             defconfig    gcc-12
parisc64           defconfig    gcc-14.1.0
powerpc         allmodconfig    gcc-14.1.0
powerpc          allnoconfig    clang-20
powerpc          allnoconfig    gcc-14.1.0
powerpc         allyesconfig    gcc-14.1.0
riscv           allmodconfig    gcc-14.1.0
riscv            allnoconfig    clang-20
riscv            allnoconfig    gcc-14.1.0
riscv           allyesconfig    gcc-14.1.0
riscv              defconfig    gcc-12
s390            allmodconfig    gcc-14.1.0
s390             allnoconfig    clang-20
s390            allyesconfig    gcc-14.1.0
s390               defconfig    gcc-12
sh              allmodconfig    gcc-14.1.0
sh               allnoconfig    gcc-14.1.0
sh              allyesconfig    gcc-14.1.0
sh                 defconfig    gcc-12
sparc           allmodconfig    gcc-14.1.0
sparc64            defconfig    gcc-12
um              allmodconfig    clang-20
um               allnoconfig    clang-17
um               allnoconfig    clang-20
um              allyesconfig    clang-20
um                 defconfig    gcc-12
um            i386_defconfig    gcc-12
um          x86_64_defconfig    gcc-12
x86_64           allnoconfig    clang-18
x86_64          allyesconfig    clang-18
x86_64             defconfig    clang-18
x86_64                 kexec    clang-18
x86_64                 kexec    gcc-12
x86_64              rhel-8.3    gcc-12
x86_64         rhel-8.3-rust    clang-18
xtensa           allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
