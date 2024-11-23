Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AFA52F76
	for <linux-bluetooth@vger.kernel.org>; Sat, 23 Nov 2024 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732378805; cv=none; b=jsYrmsdjM1YdI7XGfYs1npTI/0W6UChle7nrM9DE97okCmLSH2FUjGpUIMLMMk6gdQNdNIphlwF7v5iLLplsBGUzQ3kcOAfShs5ZKk+pRZWUFDlEBAJtDi3Cj6kQZEkpXaeR4olfNYEEF8yKjCEfV86l2JQprrLodKG15BygxrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732378805; c=relaxed/simple;
	bh=YheJpv+IHtlaJMK0GXkxIaIR9o+PZ5Dm1EImlBnr8x4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fT1b0bLST/SiFifR5RYHw98bkfl6Qeb0sOtWoebkawUBGZrRpY7j9WBsVeZDOmvqQNyilfgrep2sge9dCMNScfbULG0LE8upsqgH/eHIQqmP4mfGeBRKztIF8E4BYy0Mdz7a2M/U3auWglYer/PQXCBZTifa722tbrAoj9RrRCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=haFyfFgy; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="haFyfFgy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732378803; x=1763914803;
  h=date:from:to:cc:subject:message-id;
  bh=YheJpv+IHtlaJMK0GXkxIaIR9o+PZ5Dm1EImlBnr8x4=;
  b=haFyfFgy8cDwkL5oDkTId/7AYzEr+9SjkpNxZaMEHXqIC8J8jYp6YgNh
   DpMn8OaVdrDyOBTk4cbGTYZ2ENnJzNrTUqwPnX4hDPIVBkLvLPFHWCrW8
   JxoM50ABlsmTmfhNfz3hLQjv/iaJWhTKJwVh9Rpox/+/KUahdIeb40Zd4
   IJ6XrElfW/O/X5qqmbiEVnclu8nj+pxxOwU+MkxV4WiZlPzgRZ7kh3/6G
   wKkLEAsFYevKzt4VgxzZXq1cEQ0JRRMY1D5B1peL36zlTqTLa4sejXBHM
   BiLy61CzMt7fU3ZbpmPNXieYo1bAZvw1W4nKJTnJR884WW0gSGGEQcAP6
   Q==;
X-CSE-ConnectionGUID: 4oZujIXhTyu655Dxo8EPbw==
X-CSE-MsgGUID: 9D+zj6ahSBGgQ3aYec755g==
X-IronPort-AV: E=McAfee;i="6700,10204,11265"; a="43924804"
X-IronPort-AV: E=Sophos;i="6.12,179,1728975600"; 
   d="scan'208";a="43924804"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2024 08:20:02 -0800
X-CSE-ConnectionGUID: 9hf4PUXdRlinLAITFrCPsA==
X-CSE-MsgGUID: T0XVxjZ3RjK6FyLIDKvsCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,179,1728975600"; 
   d="scan'208";a="90480264"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 23 Nov 2024 08:20:01 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEsrX-0004j7-1K;
	Sat, 23 Nov 2024 16:19:59 +0000
Date: Sun, 24 Nov 2024 00:19:53 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 4ae007fdffc9715ae0729ca0d2cb446b83f8b64d
Message-ID: <202411240046.KA050O6y-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 4ae007fdffc9715ae0729ca0d2cb446b83f8b64d  Bluetooth: MGMT: Fix possible deadlocks

elapsed time: 1261m

configs tested: 176
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20241123    gcc-13.2.0
arc                   randconfig-002-20241123    gcc-13.2.0
arc                        vdk_hs38_defconfig    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                         assabet_defconfig    clang-15
arm                                 defconfig    clang-14
arm                       imx_v4_v5_defconfig    clang-16
arm                          moxart_defconfig    gcc-14.2.0
arm                   randconfig-001-20241123    gcc-14.2.0
arm                   randconfig-002-20241123    clang-20
arm                   randconfig-003-20241123    clang-20
arm                   randconfig-004-20241123    gcc-14.2.0
arm                         s5pv210_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241123    clang-20
arm64                 randconfig-002-20241123    gcc-14.2.0
arm64                 randconfig-003-20241123    gcc-14.2.0
arm64                 randconfig-004-20241123    clang-20
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241123    gcc-14.2.0
csky                  randconfig-002-20241123    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    clang-20
hexagon               randconfig-001-20241123    clang-20
hexagon               randconfig-002-20241123    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241123    clang-19
i386        buildonly-randconfig-002-20241123    clang-19
i386        buildonly-randconfig-003-20241123    gcc-12
i386        buildonly-randconfig-004-20241123    clang-19
i386        buildonly-randconfig-005-20241123    clang-19
i386        buildonly-randconfig-006-20241123    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241123    clang-19
i386                  randconfig-002-20241123    clang-19
i386                  randconfig-003-20241123    gcc-12
i386                  randconfig-004-20241123    clang-19
i386                  randconfig-005-20241123    clang-19
i386                  randconfig-006-20241123    clang-19
i386                  randconfig-011-20241123    gcc-12
i386                  randconfig-012-20241123    clang-19
i386                  randconfig-013-20241123    gcc-12
i386                  randconfig-014-20241123    gcc-12
i386                  randconfig-015-20241123    clang-19
i386                  randconfig-016-20241123    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241123    gcc-14.2.0
loongarch             randconfig-002-20241123    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        omega2p_defconfig    clang-20
mips                       rbtx49xx_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241123    gcc-14.2.0
nios2                 randconfig-002-20241123    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
openrisc                  or1klitex_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241123    gcc-14.2.0
parisc                randconfig-002-20241123    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-20
powerpc                       maple_defconfig    clang-20
powerpc                      ppc64e_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241123    gcc-14.2.0
powerpc               randconfig-002-20241123    clang-20
powerpc               randconfig-003-20241123    clang-20
powerpc64             randconfig-001-20241123    gcc-14.2.0
powerpc64             randconfig-002-20241123    clang-20
powerpc64             randconfig-003-20241123    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-20
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241123    clang-20
riscv                 randconfig-002-20241123    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-20
s390                                defconfig    gcc-12
s390                  randconfig-001-20241123    gcc-14.2.0
s390                  randconfig-002-20241123    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                        dreamcast_defconfig    gcc-14.2.0
sh                    randconfig-001-20241123    gcc-14.2.0
sh                    randconfig-002-20241123    gcc-14.2.0
sh                           se7721_defconfig    gcc-14.2.0
sh                           se7751_defconfig    gcc-14.2.0
sh                   sh7724_generic_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241123    gcc-14.2.0
sparc64               randconfig-002-20241123    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241123    clang-20
um                    randconfig-002-20241123    clang-20
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241123    gcc-12
x86_64      buildonly-randconfig-002-20241123    gcc-12
x86_64      buildonly-randconfig-003-20241123    gcc-11
x86_64      buildonly-randconfig-004-20241123    gcc-12
x86_64      buildonly-randconfig-005-20241123    gcc-12
x86_64      buildonly-randconfig-006-20241123    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241123    clang-19
x86_64                randconfig-002-20241123    gcc-12
x86_64                randconfig-003-20241123    clang-19
x86_64                randconfig-004-20241123    clang-19
x86_64                randconfig-005-20241123    gcc-12
x86_64                randconfig-006-20241123    clang-19
x86_64                randconfig-011-20241123    gcc-12
x86_64                randconfig-012-20241123    clang-19
x86_64                randconfig-013-20241123    gcc-12
x86_64                randconfig-014-20241123    clang-19
x86_64                randconfig-015-20241123    clang-19
x86_64                randconfig-016-20241123    gcc-12
x86_64                randconfig-071-20241123    clang-19
x86_64                randconfig-072-20241123    clang-19
x86_64                randconfig-073-20241123    gcc-12
x86_64                randconfig-074-20241123    clang-19
x86_64                randconfig-075-20241123    gcc-11
x86_64                randconfig-076-20241123    clang-19
x86_64                               rhel-9.4    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241123    gcc-14.2.0
xtensa                randconfig-002-20241123    gcc-14.2.0
xtensa                         virt_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
