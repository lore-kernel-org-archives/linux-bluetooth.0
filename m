Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF9F273D8D
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 11:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776771591; cv=none; b=mBSrPXwyjqgNxRydJv53WVIrmXZ87jsJQpvvCJt3U/AJZ5ndTsL2rCy9KIr19MkbyH7EmEDIljy/A4uEU4NzRnL4BZKCN/3W85zCjv+F232WJ4C1od0EG0gn929InO3lIZ/fkzlvcNu7wVysEYcgIOsEn5mi8kywvGNk04nPvQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776771591; c=relaxed/simple;
	bh=h7S/ld7goOrE/CWkmK9o1DwbT6XWkYTS6mq7JebWl0g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kM38c4aOZmXZ/8D018XSeC/ezjdjxMAMawBDsIVHs2rdYK0u44vHbC40asXgb5i0Nljui63BxDgqXxYqfhkjGDmHtpePPWUYqUKD/pKaBW6wNZJE3uLRB51Xzfs6ijA0XYNX312jQjZ76++wTHMUYsO8YnuLX+eGNgkzQGyB+cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gfX3ihHF; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gfX3ihHF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776771590; x=1808307590;
  h=date:from:to:cc:subject:message-id;
  bh=h7S/ld7goOrE/CWkmK9o1DwbT6XWkYTS6mq7JebWl0g=;
  b=gfX3ihHFWxCow6V3QTsF1qxNayQ/6q/ej4qEXoREzIQ5ruNBLeXdKkNh
   5KryVlVXpHDE+NWaXxunwiBIdHc2cVHygcfxWzsKxOQfRr320T2fltP6Z
   AXcytavsItXsoEzNLoSl4n39IiOjQnQUtyRxFjd2D++oLd3kPDZL868QE
   KXDOOY35Q0IPcolekveXazsYZT4cWxcBdMurAEwi8gCipNBVjWeuSHY3R
   xcDjd0V5Jw3KsE2wwzpO4jAOsv4sZJeJtMUhb7SR8xLI+3lIbd5zK4Zp7
   ah8OMIEbaOiRuXnDtVgOdOOtzdK4m6dRWR06Gjmn+/3G/XBMgkiOOSap5
   A==;
X-CSE-ConnectionGUID: ZnyXdd5IRpy481gzqjR6FQ==
X-CSE-MsgGUID: QGxLk16FQ1ySHULsiBd2Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77577175"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="77577175"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 04:39:49 -0700
X-CSE-ConnectionGUID: cOSgoiFoTRyJJ7GL1OdWwg==
X-CSE-MsgGUID: Z7cd+8CCQzu3B6vPTF9wYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="255478540"
Received: from lkp-server01.sh.intel.com (HELO 7e48d0ff8e22) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 21 Apr 2026 04:39:48 -0700
Received: from kbuild by 7e48d0ff8e22 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wF9SE-000000003S8-00GS;
	Tue, 21 Apr 2026 11:39:46 +0000
Date: Tue, 21 Apr 2026 19:39:20 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 dbcf6151ff1e3c4ddf95daf1df30a9704e21c11e
Message-ID: <202604211910.k3snkhb9-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: dbcf6151ff1e3c4ddf95daf1df30a9704e21c11e  Bluetooth: btintel_pcie: treat boot stage bit 12 as warning

elapsed time: 854m

configs tested: 96
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                   randconfig-002-20260421    gcc-10.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                   randconfig-002-20260421    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-002-20260421    gcc-13.4.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                  randconfig-001-20260421    gcc-13.4.0
csky                  randconfig-002-20260421    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon               randconfig-001-20260421    clang-23
hexagon               randconfig-002-20260421    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260421    gcc-14
i386        buildonly-randconfig-002-20260421    gcc-14
i386        buildonly-randconfig-004-20260421    clang-20
i386        buildonly-randconfig-005-20260421    clang-20
i386        buildonly-randconfig-006-20260421    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch             randconfig-001-20260421    clang-23
loongarch             randconfig-002-20260421    clang-19
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260421    gcc-11.5.0
nios2                 randconfig-002-20260421    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                randconfig-001-20260421    gcc-15.2.0
parisc                randconfig-002-20260421    gcc-9.5.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260421    clang-20
powerpc               randconfig-002-20260421    clang-23
powerpc64             randconfig-001-20260421    gcc-13.4.0
powerpc64             randconfig-002-20260421    clang-17
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20260421    clang-23
riscv                 randconfig-002-20260421    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                  randconfig-001-20260421    gcc-11.5.0
s390                  randconfig-002-20260421    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260421    gcc-15.2.0
sh                    randconfig-002-20260421    gcc-11.5.0
sh                           se7722_defconfig    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                 randconfig-001-20260421    gcc-15.2.0
sparc                 randconfig-002-20260421    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260421    gcc-9.5.0
sparc64               randconfig-002-20260421    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
