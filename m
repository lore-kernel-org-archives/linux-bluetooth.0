Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4124192FC
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Sep 2026 21:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788817843; cv=none; b=TzXYSRaj/XyjCTCBMhZkDCHctuKQnWxbAzXPKcUNVd9k1ScJ6tdrTt7XKYV2dG5NZaovXaCIxHYpA3W9yhXh2r8qbTAv48k91lYPE+3lQMKG2mrntXa+63Ki9nkAYSIjO4roklgCMG3t0CSwMgHbQ62QsWxgRXYb1wWe6qNRXgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788817843; c=relaxed/simple;
	bh=qLr0ZSU6bJxK7zaIPhwnE+UwXbXXa+JZLts/w9FT5NM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Z0wrU8QVLZpUWSxH7zbrUPMqt/yf9W2VzbMdoZw9TlLJ4VQjFhfmyU+P75PIHTE2Jw27g/BoNpdIu4yeAU/GT86xWuv2y4iGni3n19HaE/75oDCZW9FWPROhJ7mzL41Uft2aMc1zNUgA6Sv/cilgaUdOd3MoH1eTHtDecd4anlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IvkgpsX8; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IvkgpsX8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788817842; x=1820353842;
  h=date:from:to:cc:subject:message-id;
  bh=qLr0ZSU6bJxK7zaIPhwnE+UwXbXXa+JZLts/w9FT5NM=;
  b=IvkgpsX8QEJ7XXL2WPUR59glAVVn6tSaXgeO7+2G9iI/V7fyKVa8eKDQ
   65+pJL96TDtWjfTIyQYJ5sMotn8AcEiOxmem9wMe+Oo8j+sD7fKh3BKFZ
   3TFeJBC/rj5hyhUCZY+SzyZtE1MQJUfCBoyRNaY9RGNWU/rrmfZ4NsExX
   lc4t766odxp2uabhKPNPrKEnmUoxjEFQqanlVp41Mr8f9a+uA1ReIW5NX
   b6KZTL2SZM6NE7vd2H5SV/AUUfzMirEJClePNh+j4lvZEFaeddp7TrWBV
   fJxPXZCivh+misEWiQ1UfSFB/xH2/BwvRL/4Tx8oI0t0Hf2NeVeKRLcYM
   w==;
X-CSE-ConnectionGUID: GhiIbk1XRNCZxiz12t4szw==
X-CSE-MsgGUID: 63ScB+qLTX6Kp43G91LY+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="99876031"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="99876031"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 14:50:42 -0700
X-CSE-ConnectionGUID: BOyvVcmORKqFWMNGPhEPcA==
X-CSE-MsgGUID: yYH6voGpSPOA9iw1+8bMIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="276075665"
Received: from lkp-server01.sh.intel.com (HELO dff15f1b2031) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 Sep 2026 14:50:40 -0700
Received: from kbuild by dff15f1b2031 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x3hEc-000000001LJ-0llo;
	Mon, 07 Sep 2026 21:50:38 +0000
Date: Tue, 08 Sep 2026 05:50:20 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 755cf7adf8dd2d12627cb7de223d35b12228e2f5
Message-ID: <202609080517.oCD56zMt-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 755cf7adf8dd2d12627cb7de223d35b12228e2f5  Bluetooth: btintel_pcie: unified decoder coredump format

elapsed time: 4535m

configs tested: 70
configs skipped: 3

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
arm64        allmodconfig    clang-24
arm64         allnoconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
csky          allnoconfig    gcc-16.1.0
hexagon      allmodconfig    clang-24
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
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    clang-24
nios2         allnoconfig    gcc-11.5.0
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
sh           allyesconfig    gcc-16.1.0
sparc         allnoconfig    clang-24
sparc         allnoconfig    gcc-16.1.0
um           allmodconfig    clang-17
um            allnoconfig    clang-17
um            allnoconfig    clang-24
um           allyesconfig    gcc-14
um           allyesconfig    gcc-16.1.0
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-22
x86_64        allnoconfig    clang-24
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    clang-24
xtensa        allnoconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
