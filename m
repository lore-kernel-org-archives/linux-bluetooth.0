Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484B823BD1B
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676059; cv=none; b=j/sHScdWkuMsGFcDh+V15s3u4iqKUZNJrLv2fU71iAdk7I6e8nDJMHuwKvAoPBTGz5BVzk6DS+mJiFlXaqXUSo0BogMtg/siMe4O9LsZsslBSmQ7l5i4x9O9F4pimndZGla3PZKRs66sUL9dB0d9I9xADb2mDG90bcP2MTBt19c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676059; c=relaxed/simple;
	bh=y2dtPcY+Fq37/ifXIWt2yGRIoNr2X5Voi8MZ/klQ5Vw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=poOiqFH2UDotxCyjithoPovdsDgj2XJ3hqqs9f25fa3UNaV7giY3LoMjuPadKMn6ARkvklizmav/rR9OE0iIVnMevV9HNUAEt6W9ub1r8AiRodbeqYRT4AuALQpeA7dS5Vix+dog46z7DsqbSlFpTst07tmlaJRa1/n8jO010ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qa/h/OJi; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qa/h/OJi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752676059; x=1784212059;
  h=date:from:to:cc:subject:message-id;
  bh=y2dtPcY+Fq37/ifXIWt2yGRIoNr2X5Voi8MZ/klQ5Vw=;
  b=Qa/h/OJimbGDWLGKKm9CoU1aSSZ0XtwBGp1Pxo4uSV2Ged/qyOgc88lX
   VhgpP0uyhZ4sXMyYrlcURQwLQZyccNQywDjvpsC8iHb1F0aj0qmvUiR3r
   5nC9zsMiN42wGKfTJR/v69ADAV9+sf1uineUxJ5IHOO9W2fNsIx14/035
   q8vWpFMIXnzVjf9fSk3sNpfPAN7TmIQs5HsTVDCYOgEpMafMUs49GR0mt
   QSTwRK5GbEcYUoeivD5eN+unAZqzynz0VapBMt9ckGwYvKEYL87TMKrPu
   JfOnwfJcQXkDgnI0qvRYc2ciXrGW8/l3ZiGISSYfiBKAhCBWtunbcmuc/
   w==;
X-CSE-ConnectionGUID: 6CmkjZOfTsGYrBeVQrMC+Q==
X-CSE-MsgGUID: Lm57CEp6SfCzUKDbjChNjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="57533751"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="57533751"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 07:27:38 -0700
X-CSE-ConnectionGUID: Y0FO2esvR/+KXRs55mmT5Q==
X-CSE-MsgGUID: 1BND5rlOQuu1dZW8P8ViwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="188475262"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 16 Jul 2025 07:27:37 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uc36b-000CUl-2v;
	Wed, 16 Jul 2025 14:27:33 +0000
Date: Wed, 16 Jul 2025 22:27:06 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 6f40d15c70bc6ff0e35f2db1d5bc9f2240eb5d82
Message-ID: <202507162253.W2CIylUI-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 6f40d15c70bc6ff0e35f2db1d5bc9f2240eb5d82  Bluetooth: ISO: Support SCM_TIMESTAMPING for ISO TS

elapsed time: 1460m

configs tested: 118
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250715    gcc-8.5.0
arc                   randconfig-002-20250715    gcc-11.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250715    clang-21
arm                   randconfig-002-20250715    gcc-10.5.0
arm                   randconfig-003-20250715    clang-21
arm                   randconfig-004-20250715    gcc-12.4.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250715    clang-16
arm64                 randconfig-002-20250715    gcc-12.3.0
arm64                 randconfig-003-20250715    gcc-6.5.0
arm64                 randconfig-004-20250715    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250715    gcc-9.3.0
csky                  randconfig-002-20250715    gcc-12.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250715    clang-18
hexagon               randconfig-002-20250715    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250715    gcc-12
i386        buildonly-randconfig-002-20250715    gcc-12
i386        buildonly-randconfig-003-20250715    gcc-12
i386        buildonly-randconfig-004-20250715    clang-20
i386        buildonly-randconfig-005-20250715    clang-20
i386        buildonly-randconfig-006-20250715    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250715    clang-21
loongarch             randconfig-002-20250715    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        maltaup_defconfig    clang-21
mips                          rb532_defconfig    clang-18
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250715    gcc-11.5.0
nios2                 randconfig-002-20250715    gcc-7.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250715    gcc-10.5.0
parisc                randconfig-002-20250715    gcc-9.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                    amigaone_defconfig    gcc-15.1.0
powerpc                     mpc512x_defconfig    clang-21
powerpc                 mpc8315_rdb_defconfig    clang-21
powerpc               randconfig-001-20250715    clang-21
powerpc               randconfig-002-20250715    clang-21
powerpc               randconfig-003-20250715    gcc-5.5.0
powerpc64             randconfig-001-20250715    clang-21
powerpc64             randconfig-002-20250715    gcc-6.5.0
powerpc64             randconfig-003-20250715    clang-17
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250716    gcc-15.1.0
riscv                 randconfig-002-20250716    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250716    gcc-11.5.0
s390                  randconfig-002-20250716    gcc-11.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                        apsh4ad0a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250716    gcc-5.5.0
sh                    randconfig-002-20250716    gcc-14.3.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250716    gcc-6.5.0
sparc                 randconfig-002-20250716    gcc-14.3.0
sparc64               randconfig-001-20250716    clang-20
sparc64               randconfig-002-20250716    clang-21
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250716    gcc-11
um                    randconfig-002-20250716    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250715    clang-20
x86_64      buildonly-randconfig-002-20250715    gcc-12
x86_64      buildonly-randconfig-003-20250715    gcc-12
x86_64      buildonly-randconfig-004-20250715    gcc-11
x86_64      buildonly-randconfig-005-20250715    gcc-12
x86_64      buildonly-randconfig-006-20250715    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250716    gcc-9.3.0
xtensa                randconfig-002-20250716    gcc-13.4.0
xtensa                         virt_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
