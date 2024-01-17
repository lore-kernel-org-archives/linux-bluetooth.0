Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158EF241F8
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jan 2024 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705517536; cv=none; b=qQeiJKzrG9/JneauwvuLGuttH/hC8djzk99jQA9xlhPrkuaoFM+JRcYj6grdmsHndSLFFp1QtlJW3leNafrNq8Y35GP/SqdF4spGkUoWBJ03+nOX8j017gHnH8C6mklQxSrplb0aiiOkdF5wRAFfmQchrelHC1nReVnQbeaUNhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705517536; c=relaxed/simple;
	bh=9hmikyydxSTTuQuDlGYBHURXgaqvgMr1XoQUBf3h+yw=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:User-Agent; b=i6YiPehw6ihLZU18OdxMOVeF9Klw7IbZ7Ciu/8uX1BR/htTnq22psspNsDBjEBxbaOMe3m8mg0NgOwZeWteCj1IP9qfBYGPIFNLZ2NvR0rQ04lcxOe2DtJ4BtsrZRr1DE3pnM57C1FRDK62ll4MDbX3FYhduigBIfjWR9pP4BWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C+8ttyao; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C+8ttyao"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705517535; x=1737053535;
  h=date:from:to:cc:subject:message-id;
  bh=9hmikyydxSTTuQuDlGYBHURXgaqvgMr1XoQUBf3h+yw=;
  b=C+8ttyaoivE3ELapieeIqdlQ8tUdDdLrQ7xA7FS4eNDB7E9V5dlSk+K2
   gluJWSBosCo4g+uRNf3TtVi/qeBW29tOMs2hEYGbUz/jvVYAVSEH77MKG
   8bgSmSS6glvo2FqYr4PApwvLQj8BoZ5ZxZ1/fZBJEfRVRFdk87marhwPZ
   uc/rnKaPXWi0TgCbhZoRwBFHgTI55ceAcNKCIelmAhlKoMRs9I/8bTwip
   PhW2B0yHswnO/tOVnx7dRxEzqQZASWm0cyyHLfgPVrwHRvQ9KBoBdbhJV
   DFj0AxIBYljmD6jCgUfHUsFFiC6nPUdFuKV6ZWYV1WXxPS/z4AOr8i15W
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="464530662"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="464530662"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 10:52:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="1115748154"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="1115748154"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jan 2024 10:52:13 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQB1G-0002G2-1d;
	Wed, 17 Jan 2024 18:52:10 +0000
Date: Thu, 18 Jan 2024 02:51:48 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 6061d66bd0e5ac1eca2858356cd8d7c12f415176
Message-ID: <202401180246.kYKeEqHp-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 6061d66bd0e5ac1eca2858356cd8d7c12f415176  Bluetooth: Remove usage of the deprecated ida_simple_xx() API

elapsed time: 1554m

configs tested: 87
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240117   gcc  
arc                   randconfig-002-20240117   gcc  
arm                               allnoconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240117   gcc  
arm                   randconfig-002-20240117   gcc  
arm                   randconfig-003-20240117   gcc  
arm                   randconfig-004-20240117   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240117   gcc  
arm64                 randconfig-002-20240117   gcc  
arm64                 randconfig-003-20240117   gcc  
arm64                 randconfig-004-20240117   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240117   gcc  
csky                  randconfig-002-20240117   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240117   clang
hexagon               randconfig-002-20240117   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                                defconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240117   gcc  
loongarch             randconfig-002-20240117   gcc  
m68k                              allnoconfig   gcc  
m68k                                defconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
nios2                             allnoconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240117   gcc  
nios2                 randconfig-002-20240117   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240117   gcc  
parisc                randconfig-002-20240117   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc               randconfig-001-20240117   gcc  
powerpc               randconfig-002-20240117   gcc  
powerpc               randconfig-003-20240117   gcc  
powerpc64             randconfig-001-20240117   gcc  
powerpc64             randconfig-002-20240117   gcc  
powerpc64             randconfig-003-20240117   gcc  
riscv                             allnoconfig   clang
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240117   gcc  
riscv                 randconfig-002-20240117   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240117   clang
s390                  randconfig-002-20240117   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240117   gcc  
sparc64                             defconfig   gcc  
um                                allnoconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240117   gcc  
x86_64       buildonly-randconfig-002-20240117   gcc  
x86_64       buildonly-randconfig-003-20240117   gcc  
x86_64       buildonly-randconfig-004-20240117   gcc  
x86_64       buildonly-randconfig-005-20240117   gcc  
x86_64       buildonly-randconfig-006-20240117   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240117   clang
x86_64                randconfig-003-20240117   clang
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
