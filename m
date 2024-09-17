Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30AF27470
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Sep 2024 21:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726607265; cv=none; b=WjR56BNKxsN/P8TfysdRAxAnoHVXmNg629NUmpi2fQ+ZKSK5Z2nHyZcdw4RFhsFyszoLrHwwKfPNBwr4vjGuvuPYwi7y4M470DdLnQDffWNJjlKGi5ryDPILX2ACB5frllIfgbUa7KuV1zVJrfCpJ1bglbTRTtC1OzdDjBWBiuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726607265; c=relaxed/simple;
	bh=S73REelFOMXOmU1vo91RagsIjtLlpeiHbInYDCiF7Ro=;
	h=Date:From:To:Cc:Subject:Message-ID; b=afF1wQ9j6vf6lPdumU4SIbGyoQbgSzGnLDMTgF0foKKr8cVgAlBHzM0Ejfywh1YE/Ny+4dB0AElF4Xo6vzPsWt/RTOb1/RoiXExDveNVDhVnzTEiRGNfrFZLjIzqElqEfhgfOSW1y0zNRtt1CeZtsttKgpaRd26l5pO3hMFYtQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E+yqEOHg; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E+yqEOHg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726607263; x=1758143263;
  h=date:from:to:cc:subject:message-id;
  bh=S73REelFOMXOmU1vo91RagsIjtLlpeiHbInYDCiF7Ro=;
  b=E+yqEOHgg/ktINSGNzK8SAHI/ERo+yawH7vW9+v9qR7ztSj/u+zOum4+
   DRXF7AaVML5HvaNfWpgElpP0iJ1z/WxKuQaW21cRZveiZMF/GqBWfwkjM
   bgknfSCv6PJW+GFZS4c/gDuBdwqqngv5aPK6b96odFHkVvpCeZlxxnXBw
   xekJCoAkg5mZ9xGF7teTahtVOidFyRQV15hnaStPxHojGjUbIyNnmsQon
   tRNZHF83uLdtALeWc765e33BNIcBcB5yPCV4DDaT7IsgP0+NNVfVJc0+v
   7ilxbIp2liTZbDwPYh8vys68xBGgm18jSVQ4SZG8G33/Be0jce100gdqE
   Q==;
X-CSE-ConnectionGUID: IT9jmYIPSiSJTgmWDaqAmQ==
X-CSE-MsgGUID: Qwra64+vQhWhkzptFk1d3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="25647475"
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="25647475"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 14:07:37 -0700
X-CSE-ConnectionGUID: tLjGIWwxTj+RZvYJWWNpcg==
X-CSE-MsgGUID: rxzlSOc7RwCwO9iNaAJqWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="74317318"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 17 Sep 2024 14:07:36 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sqfQ6-000BXI-0Q;
	Tue, 17 Sep 2024 21:07:34 +0000
Date: Wed, 18 Sep 2024 05:06:47 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 eb3ad76a07b6cdaaa156766da5fe6c384a12930b
Message-ID: <202409180539.NYp2q75j-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: eb3ad76a07b6cdaaa156766da5fe6c384a12930b  Bluetooth: MGMT: Fix possible crash on mgmt_index_removed

elapsed time: 1722m

configs tested: 122
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                          ixp4xx_defconfig    gcc-14.1.0
arm                        multi_v7_defconfig    gcc-14.1.0
arm                          sp7021_defconfig    gcc-14.1.0
arm                        spear3xx_defconfig    gcc-14.1.0
arm64                            alldefconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                           allnoconfig    gcc-14.1.0
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240917    clang-18
i386        buildonly-randconfig-002-20240917    clang-18
i386        buildonly-randconfig-002-20240917    gcc-12
i386        buildonly-randconfig-003-20240917    clang-18
i386        buildonly-randconfig-004-20240917    clang-18
i386        buildonly-randconfig-005-20240917    clang-18
i386        buildonly-randconfig-006-20240917    clang-18
i386        buildonly-randconfig-006-20240917    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20240917    clang-18
i386                  randconfig-001-20240917    gcc-12
i386                  randconfig-002-20240917    clang-18
i386                  randconfig-002-20240917    gcc-12
i386                  randconfig-003-20240917    clang-18
i386                  randconfig-004-20240917    clang-18
i386                  randconfig-004-20240917    gcc-12
i386                  randconfig-005-20240917    clang-18
i386                  randconfig-005-20240917    gcc-12
i386                  randconfig-006-20240917    clang-18
i386                  randconfig-011-20240917    clang-18
i386                  randconfig-011-20240917    gcc-12
i386                  randconfig-012-20240917    clang-18
i386                  randconfig-013-20240917    clang-18
i386                  randconfig-014-20240917    clang-18
i386                  randconfig-015-20240917    clang-18
i386                  randconfig-015-20240917    gcc-12
i386                  randconfig-016-20240917    clang-18
i386                  randconfig-016-20240917    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                 decstation_r4k_defconfig    gcc-14.1.0
mips                  maltasmvp_eva_defconfig    gcc-14.1.0
mips                        omega2p_defconfig    gcc-14.1.0
mips                          rm200_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                     akebono_defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
powerpc                       eiger_defconfig    gcc-14.1.0
powerpc                        fsp2_defconfig    gcc-14.1.0
powerpc                     mpc5200_defconfig    gcc-14.1.0
powerpc                     mpc83xx_defconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                           se7206_defconfig    gcc-14.1.0
sh                  sh7785lcr_32bit_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                                allnoconfig    clang-17
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                           rhel-8.3-bpf    clang-18
x86_64                           rhel-8.3-bpf    gcc-12
x86_64                         rhel-8.3-kunit    clang-18
x86_64                         rhel-8.3-kunit    gcc-12
x86_64                           rhel-8.3-ltp    clang-18
x86_64                           rhel-8.3-ltp    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
