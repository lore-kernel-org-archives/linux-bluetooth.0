Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDD0EAD7
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 08:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715848489; cv=none; b=oTllR5OsOg3hKPGoMQYuKHGEo3J+0BZ7/GMzqN7th2gwcLzUz3qb/HtE9jD+2vAtNy0GpRvsKQZyKMDmfqBYZVR0OTN8Cb5wnKm6aBh1i6lUjg1M85EniVQ4FO+Mpy8LvG05vehw8XbOxVHE7zB3oHZXMpBaMYM49aWc3dINLNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715848489; c=relaxed/simple;
	bh=4P7BTNJxxHP8NyOZMYgw5iaLCskV1j84Moq85x64IDM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QEq2qJ5Xyf9XVYao/16bazf4DoyHA3n3Ac4u0YNgD4sWxnjVQ2+1f0EmYq1BbwuLqoiCXwe3Bz1uuNVacND07yVSPwCaha0AkLax+q94PAcTBlmm6WlRD2qBGEDL3sgvAQSAYbPX2xWsGQUboiRjvLp9ecWXQeJPjFJ4fpuDt1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BeRp5Pag; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BeRp5Pag"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715848488; x=1747384488;
  h=date:from:to:cc:subject:message-id;
  bh=4P7BTNJxxHP8NyOZMYgw5iaLCskV1j84Moq85x64IDM=;
  b=BeRp5PagkUFP6kcK7vKO6crUeRVCAS4Oi8wFPw/Y1lKaiGiVRop+xx5N
   V+VKt5jt3Fc09qw8gZh0BPSND3WDo5Q0WesoyAVxMMw0QUCcza7pXaK5c
   o8i6/R7vUpklbjEdBnXHYRA+7/fhvNyqmngJbSbJr7PAwhKl4FbF7wYnw
   WAf68BcqI9Y7IBI84yIkJ5EqFEKtcblSgrt6tSxdaFaGn7mI000u8hNm5
   bqEuk/ujGR/SI+WNb3aEuV/S1KkskpaxUiL7WMQyswogQa8aqVSlMZuSl
   t+loBY86u81R/hpt2SvZc/4RcRXvWg1cy3qhjjL3isEQTgwdZT85+C7s+
   A==;
X-CSE-ConnectionGUID: v/OmVGbLQciJLJIhsZWXcQ==
X-CSE-MsgGUID: H6giu7cwRjWos1EB1cYVvw==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="14895676"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="14895676"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 01:34:47 -0700
X-CSE-ConnectionGUID: mQVXQjONQ/CangYCevYOKQ==
X-CSE-MsgGUID: v2Hy3/zwQ6GKr65vqF+x7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="31925628"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 16 May 2024 01:34:46 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7WZX-000E22-2y;
	Thu, 16 May 2024 08:34:43 +0000
Date: Thu, 16 May 2024 16:33:50 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 3b42b64036e5c7d33b879fb1b8fe1391f82b1477
Message-ID: <202405161647.deVETjj3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 3b42b64036e5c7d33b879fb1b8fe1391f82b1477  Bluetooth: btnxpuart: Handle FW Download Abort scenario

elapsed time: 730m

configs tested: 136
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240516   gcc  
arc                   randconfig-002-20240516   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240516   gcc  
arm                   randconfig-002-20240516   clang
arm                   randconfig-003-20240516   gcc  
arm                   randconfig-004-20240516   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240516   gcc  
arm64                 randconfig-002-20240516   clang
arm64                 randconfig-003-20240516   clang
arm64                 randconfig-004-20240516   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240516   gcc  
csky                  randconfig-002-20240516   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240516   clang
hexagon               randconfig-002-20240516   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240516   clang
i386         buildonly-randconfig-002-20240516   clang
i386         buildonly-randconfig-003-20240516   clang
i386         buildonly-randconfig-004-20240516   gcc  
i386         buildonly-randconfig-005-20240516   gcc  
i386         buildonly-randconfig-006-20240516   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240516   gcc  
i386                  randconfig-002-20240516   gcc  
i386                  randconfig-003-20240516   clang
i386                  randconfig-004-20240516   clang
i386                  randconfig-005-20240516   clang
i386                  randconfig-006-20240516   clang
i386                  randconfig-011-20240516   gcc  
i386                  randconfig-012-20240516   gcc  
i386                  randconfig-013-20240516   clang
i386                  randconfig-014-20240516   gcc  
i386                  randconfig-015-20240516   gcc  
i386                  randconfig-016-20240516   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240516   gcc  
loongarch             randconfig-002-20240516   gcc  
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
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240516   gcc  
nios2                 randconfig-002-20240516   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240516   gcc  
parisc                randconfig-002-20240516   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240516   gcc  
powerpc               randconfig-002-20240516   clang
powerpc               randconfig-003-20240516   clang
powerpc64             randconfig-001-20240516   gcc  
powerpc64             randconfig-002-20240516   clang
powerpc64             randconfig-003-20240516   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240516   gcc  
riscv                 randconfig-002-20240516   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240516   gcc  
s390                  randconfig-002-20240516   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240516   gcc  
sh                    randconfig-002-20240516   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240516   gcc  
sparc64               randconfig-002-20240516   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240516   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
