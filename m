Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBB01E505
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Aug 2024 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723816320; cv=none; b=Fynfthf5PoXo3rmRMXCAweaTF4u5GDQP50iuMyHXXdcJETEx5vQVDsvjbjDI3oaJDACxw8P+QQ2wxXtsC0PubbxFyUXgTxpoICkIyOT778Cymg1wtezMdW5hMrMnNA6+8wQp5qEDrxMztnhHklYOVi1ON5p73/oRFEOTCYNhEMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723816320; c=relaxed/simple;
	bh=x0BJ/sA37LN6MMfRy6a/jeWVHSD8uvhGwAbX4kf3RCo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VI5gCMXPmb4BRwfQs2RRm5uXkpKn6k7zduph4dFJW0pp4BuTMI1vKykkixiSfTC9mmnNO02GBK7aqLDtv2OgRsLDl405Blj5kYui+YFJfa0KENL8C5A1OUGHAWA4aql7rIgPAWElzatEJ3JKSNWH6JMwbSfV/OxMM4ntskecWgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KVwVyJAI; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KVwVyJAI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723816318; x=1755352318;
  h=date:from:to:cc:subject:message-id;
  bh=x0BJ/sA37LN6MMfRy6a/jeWVHSD8uvhGwAbX4kf3RCo=;
  b=KVwVyJAIx78sqlJ4Oqqak19zzQw7d6HRMbbgJL1Za2INV6OCu01VEB80
   5tqWTG8jn+wAFmfAusbrH24LtmlZQpbK1QJmaKG4qR9AGfV63VbVjNm7P
   4iW5UhOipCwY+kSYleHbn+qHENQIi8ITkG7mQTNgnD+oz4Khq5semqLnb
   xuaR2HKj+XVpmyeSTEYQAqCoH3tG0lvftfV5R0fnYqmpaqUGqordg4ouV
   3e6MMBLCg46g4T0x1EW/qUxz71E0uM/U1k0Nbl4HKliIxGfcWW6Q+yOaH
   1eImgoUXTxWkVSInQSESxYoS9g31cR1SKOjjDyzuIVPjl5XHfWK3pw11F
   Q==;
X-CSE-ConnectionGUID: I7gRrJlETmKcVpYV59wsAw==
X-CSE-MsgGUID: eo6rhPQARAOpqdn1Y+cLSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="21988779"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="21988779"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 06:51:58 -0700
X-CSE-ConnectionGUID: 6XpTCBWXQbaPaAGiLf1f5Q==
X-CSE-MsgGUID: iXHDFvL3TDuc1A+TCwSKZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="64518374"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 16 Aug 2024 06:51:56 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sexMw-0006TS-1V;
	Fri, 16 Aug 2024 13:51:54 +0000
Date: Fri, 16 Aug 2024 21:51:25 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 7285ef081977e1ce8ddfc32798b891da7a381df9
Message-ID: <202408162122.AQmpRUDB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 7285ef081977e1ce8ddfc32798b891da7a381df9  Bluetooth: MGMT: Add error handling to pair_device()

elapsed time: 1239m

configs tested: 117
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240816   gcc-13.2.0
arc                   randconfig-002-20240816   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                              allyesconfig   gcc-14.1.0
arm                   randconfig-001-20240816   clang-20
arm                   randconfig-002-20240816   clang-20
arm                   randconfig-003-20240816   clang-20
arm                   randconfig-004-20240816   clang-20
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240816   clang-20
arm64                 randconfig-002-20240816   clang-20
arm64                 randconfig-003-20240816   clang-20
arm64                 randconfig-004-20240816   clang-20
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240816   gcc-14.1.0
csky                  randconfig-002-20240816   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240816   clang-20
hexagon               randconfig-002-20240816   clang-20
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240816   gcc-12
i386         buildonly-randconfig-002-20240816   clang-18
i386         buildonly-randconfig-003-20240816   clang-18
i386         buildonly-randconfig-004-20240816   clang-18
i386         buildonly-randconfig-005-20240816   gcc-11
i386         buildonly-randconfig-006-20240816   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240816   clang-18
i386                  randconfig-002-20240816   gcc-12
i386                  randconfig-003-20240816   gcc-11
i386                  randconfig-004-20240816   gcc-12
i386                  randconfig-005-20240816   clang-18
i386                  randconfig-006-20240816   gcc-11
i386                  randconfig-011-20240816   gcc-12
i386                  randconfig-012-20240816   clang-18
i386                  randconfig-013-20240816   clang-18
i386                  randconfig-014-20240816   gcc-12
i386                  randconfig-015-20240816   gcc-12
i386                  randconfig-016-20240816   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240816   gcc-14.1.0
loongarch             randconfig-002-20240816   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240816   gcc-14.1.0
nios2                 randconfig-002-20240816   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240816   gcc-14.1.0
parisc                randconfig-002-20240816   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc               randconfig-002-20240816   clang-20
powerpc64             randconfig-001-20240816   gcc-14.1.0
powerpc64             randconfig-002-20240816   clang-20
powerpc64             randconfig-003-20240816   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                 randconfig-001-20240816   clang-20
riscv                 randconfig-002-20240816   clang-20
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                  randconfig-001-20240816   gcc-14.1.0
s390                  randconfig-002-20240816   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240816   gcc-14.1.0
sh                    randconfig-002-20240816   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64               randconfig-001-20240816   gcc-14.1.0
sparc64               randconfig-002-20240816   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
um                    randconfig-001-20240816   clang-20
um                    randconfig-002-20240816   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240816   clang-18
x86_64       buildonly-randconfig-002-20240816   gcc-12
x86_64       buildonly-randconfig-003-20240816   gcc-12
x86_64       buildonly-randconfig-004-20240816   clang-18
x86_64       buildonly-randconfig-005-20240816   clang-18
x86_64       buildonly-randconfig-006-20240816   gcc-12
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240816   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240816   gcc-14.1.0
xtensa                randconfig-002-20240816   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
