Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABDC156F5F
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 May 2024 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715014040; cv=none; b=qgMuAJ0u8dWK36GDo1/j2Pc6Sc0bZIm0MSSfam2oHfb//V+GnJlifT5V+i6AMcyBFdWALms8JVpOGy2E9Tugro8a2kZgaBMXCvHmZaHNy4QNBVfy+AooYuG+j9fu3yjwa2ctq/TDsSKn30XDuP3i5W0T57ZkX31l5txxv6owZbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715014040; c=relaxed/simple;
	bh=rzoGwDn3bz4QAXPeIs2S1PFFLcVF4qI3gdSH64FfTnQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hfHKe6mC1r7CVX89LfiIc852Ob6DYu3xvXriO+KDPtOPt92Wbamtj49Y2ojwW83Qkzt3afP44SO/TeXWOszX1L/DzgTzJ6AmzxvB/xya5HFd6YMcx5xaAGvIPkS8bJ74k1WPJCfoCB9h2HJGeWTgg2CYn2R+0NHpjfFscZABsJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JtnCfAbq; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JtnCfAbq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715014038; x=1746550038;
  h=date:from:to:cc:subject:message-id;
  bh=rzoGwDn3bz4QAXPeIs2S1PFFLcVF4qI3gdSH64FfTnQ=;
  b=JtnCfAbqhWK3RCxIwkOYur8c3Vq1kB8FqwcVhyiqNXH9QRFApSd7D9A/
   1EhUI/Rh+GOvmqJt0I8cigMgKqLy/q71BN2RvJe5ecsalctbpxKBeMhnC
   yJOlmN61I3HqdtPbTjK2miSUnJFTDaHHiv1tWfo1h2Zyy1epxADho7k1C
   /5NeL+alJp4fRj9Dmsgj/b21jkC+O0/Urfwt1dEIImTmmWGWPBFPatryl
   2q1FhfIPiZUHKu4OKXL4vyWWRU5nssRYHgzCtKzTnNHxlqUP06nkBZIda
   PjmYTFzPjH9wOanW7uuVc+d/LtgIrhklHLQDeZY1TjrYSYbSR6F3UM/d+
   g==;
X-CSE-ConnectionGUID: WEx35doJR5SJrku6L6Qayw==
X-CSE-MsgGUID: bdIK6fx7Ro6+evebv26WPw==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10987015"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="10987015"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 09:47:17 -0700
X-CSE-ConnectionGUID: ViJRQIRiTrKtm88JJWRdmA==
X-CSE-MsgGUID: Pt1mSvX1QHuDM+HDOdbObA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="28213997"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 06 May 2024 09:47:16 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s41Uf-0000oO-2z;
	Mon, 06 May 2024 16:47:13 +0000
Date: Tue, 07 May 2024 00:47:02 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 linux-bluetooth@vger.kernel.org
Subject: [linux-next:pending-fixes] BUILD SUCCESS
 a185dbfbbbbdc7182a72f909bd8de736a3793de9
Message-ID: <202405070058.KTQUvarF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git pending-fixes
branch HEAD: a185dbfbbbbdc7182a72f909bd8de736a3793de9  Merge branch 'for-linux-next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git

Unverified Warning (likely false positive, please contact us if interested):

net/bluetooth/l2cap_core.c:4017:2-8: preceding lock on line 3926

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- parisc-randconfig-r051-20240506
|   `-- net-bluetooth-l2cap_core.c:preceding-lock-on-line
|-- sh-randconfig-r061-20240506
|   `-- net-bluetooth-l2cap_core.c:preceding-lock-on-line
|-- sh-randconfig-r064-20240506
|   `-- net-bluetooth-l2cap_core.c:preceding-lock-on-line
|-- sparc-randconfig-r053-20240506
|   `-- net-bluetooth-l2cap_core.c:preceding-lock-on-line
|-- x86_64-randconfig-102-20240506
|   `-- net-bluetooth-l2cap_core.c:preceding-lock-on-line
`-- xtensa-randconfig-r062-20240506
    `-- net-bluetooth-l2cap_core.c:preceding-lock-on-line

elapsed time: 963m

configs tested: 176
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240506   gcc  
arc                   randconfig-002-20240506   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                             pxa_defconfig   gcc  
arm                   randconfig-001-20240506   clang
arm                   randconfig-002-20240506   clang
arm                   randconfig-003-20240506   gcc  
arm                   randconfig-004-20240506   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240506   gcc  
arm64                 randconfig-002-20240506   gcc  
arm64                 randconfig-003-20240506   clang
arm64                 randconfig-004-20240506   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240506   gcc  
csky                  randconfig-002-20240506   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240506   clang
hexagon               randconfig-002-20240506   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240506   gcc  
i386         buildonly-randconfig-002-20240506   clang
i386         buildonly-randconfig-003-20240506   gcc  
i386         buildonly-randconfig-004-20240506   gcc  
i386         buildonly-randconfig-005-20240506   gcc  
i386         buildonly-randconfig-006-20240506   clang
i386                                defconfig   clang
i386                  randconfig-001-20240506   gcc  
i386                  randconfig-002-20240506   clang
i386                  randconfig-003-20240506   gcc  
i386                  randconfig-004-20240506   clang
i386                  randconfig-005-20240506   clang
i386                  randconfig-006-20240506   gcc  
i386                  randconfig-011-20240506   gcc  
i386                  randconfig-012-20240506   gcc  
i386                  randconfig-013-20240506   gcc  
i386                  randconfig-014-20240506   clang
i386                  randconfig-015-20240506   clang
i386                  randconfig-016-20240506   clang
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240506   gcc  
loongarch             randconfig-002-20240506   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   gcc  
mips                           ci20_defconfig   clang
mips                         db1xxx_defconfig   clang
mips                      maltasmvp_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240506   gcc  
nios2                 randconfig-002-20240506   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20240506   gcc  
parisc                randconfig-002-20240506   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      pcm030_defconfig   clang
powerpc                       ppc64_defconfig   clang
powerpc               randconfig-001-20240506   gcc  
powerpc               randconfig-002-20240506   clang
powerpc               randconfig-003-20240506   gcc  
powerpc64             randconfig-001-20240506   clang
powerpc64             randconfig-002-20240506   clang
powerpc64             randconfig-003-20240506   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240506   clang
riscv                 randconfig-002-20240506   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240506   gcc  
s390                  randconfig-002-20240506   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240506   gcc  
sh                    randconfig-002-20240506   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240506   gcc  
sparc64               randconfig-002-20240506   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240506   clang
um                    randconfig-002-20240506   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240506   gcc  
x86_64       buildonly-randconfig-002-20240506   gcc  
x86_64       buildonly-randconfig-003-20240506   gcc  
x86_64       buildonly-randconfig-004-20240506   clang
x86_64       buildonly-randconfig-005-20240506   clang
x86_64       buildonly-randconfig-006-20240506   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240506   clang
x86_64                randconfig-002-20240506   clang
x86_64                randconfig-003-20240506   clang
x86_64                randconfig-004-20240506   clang
x86_64                randconfig-005-20240506   clang
x86_64                randconfig-006-20240506   clang
x86_64                randconfig-011-20240506   gcc  
x86_64                randconfig-012-20240506   gcc  
x86_64                randconfig-013-20240506   gcc  
x86_64                randconfig-014-20240506   gcc  
x86_64                randconfig-015-20240506   gcc  
x86_64                randconfig-016-20240506   gcc  
x86_64                randconfig-071-20240506   gcc  
x86_64                randconfig-072-20240506   clang
x86_64                randconfig-073-20240506   gcc  
x86_64                randconfig-074-20240506   clang
x86_64                randconfig-075-20240506   gcc  
x86_64                randconfig-076-20240506   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240506   gcc  
xtensa                randconfig-002-20240506   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
