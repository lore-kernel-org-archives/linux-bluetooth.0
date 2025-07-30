Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2120E55B
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Jul 2025 07:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753859004; cv=none; b=d4k236eL36zH74I9BPqVJEv36yF8uX2VDxV+LOC2GHEXE+1oNxsbGN/TqPio+OgKi2F9m7R7tB/QB0qnY3T2ycHmvw77stS6cFZVUwua2bbZbG6v2iGhmayKJfxUJepF16Z1EKemXMxNy+MdB9pTjh91vxp83PmoQadA2N9+8Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753859004; c=relaxed/simple;
	bh=+wn0Dq3toeP3xfTV99D6IuhxTNxtlOKku+lM8tea3+c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tRORr7ItpzQ7zzJjoCfv/LHpxBb1JLoWGPtxhw7hPufZoKaVPewFB/roV/uMSAVrk8HfgacBNyXfOmUYKNrDus34mdTdGBgzw/3tKwug6zJlM+4uTYzNhLtsVA3MLU90af52Splw6hXNYJ4Ec16pfXPs2muoxPq5mR3UCXHNLOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BhukflrJ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BhukflrJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753859003; x=1785395003;
  h=date:from:to:cc:subject:message-id;
  bh=+wn0Dq3toeP3xfTV99D6IuhxTNxtlOKku+lM8tea3+c=;
  b=BhukflrJacE7a6InGEsYAyv1eSqoSgALlGKBLsYOjakYu5kJjSzCveOB
   m2e1K5nxIrUlEba0E8pF0dNgtxXeTfXP1ehmn1UmCOONOrtOp02yTpsjm
   t0ZiQ++/XjvDeHlE0ZyIfkdGL8l9Tobkw3myUBaLIbsjp5LkgHxuVaJ58
   43GdTPfybfJSA10GSuLQyLbvOGJ42P1YiD932TOPjslZIbdP8r/pvzgk0
   wlbUG5YNP80Zj2Oc4mjLSFMcuCL93vFmvreVZuEEm8NkUU9RhnuxAjIGu
   KZhBj+CvkmotzKqscJisA4Zmx5O5EKijm6uSXs2ROCI2nV4gtYWXaP+45
   A==;
X-CSE-ConnectionGUID: vABvCH08TYeAb9vwE++gxw==
X-CSE-MsgGUID: ewVQpaa3SnKqPPbHVlOjxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="56298000"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="56298000"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 00:03:22 -0700
X-CSE-ConnectionGUID: Jw8cc761QK62elomwwI3IA==
X-CSE-MsgGUID: /kN/V7/OQ1epnfopUgrNFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="163690375"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 30 Jul 2025 00:03:21 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uh0qN-00028q-0o;
	Wed, 30 Jul 2025 07:03:19 +0000
Date: Wed, 30 Jul 2025 15:02:52 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 9c533991fe15be60ad9f9a7629c25dbc5b09788d
Message-ID: <202507301545.yPdBFW67-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 9c533991fe15be60ad9f9a7629c25dbc5b09788d  Bluetooth: hci_conn: Fix not cleaning up Broadcaster/Broadcast Source

elapsed time: 722m

configs tested: 120
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250730    gcc-8.5.0
arc                   randconfig-002-20250730    gcc-14.3.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250730    clang-22
arm                   randconfig-002-20250730    clang-20
arm                   randconfig-003-20250730    gcc-8.5.0
arm                   randconfig-004-20250730    gcc-14.3.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250730    clang-22
arm64                 randconfig-002-20250730    clang-20
arm64                 randconfig-003-20250730    clang-17
arm64                 randconfig-004-20250730    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250730    gcc-14.3.0
csky                  randconfig-002-20250730    gcc-12.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250730    clang-20
hexagon               randconfig-002-20250730    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250730    clang-20
i386        buildonly-randconfig-002-20250730    clang-20
i386        buildonly-randconfig-003-20250730    gcc-12
i386        buildonly-randconfig-004-20250730    gcc-12
i386        buildonly-randconfig-005-20250730    clang-20
i386        buildonly-randconfig-006-20250730    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250730    clang-22
loongarch             randconfig-002-20250730    clang-20
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                        mvme16x_defconfig    gcc-15.1.0
m68k                        stmark2_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250730    gcc-11.5.0
nios2                 randconfig-002-20250730    gcc-9.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250730    gcc-14.3.0
parisc                randconfig-002-20250730    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                       ebony_defconfig    clang-22
powerpc                   motionpro_defconfig    clang-22
powerpc                 mpc837x_rdb_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250730    gcc-8.5.0
powerpc               randconfig-002-20250730    gcc-8.5.0
powerpc               randconfig-003-20250730    clang-22
powerpc                     tqm8540_defconfig    gcc-15.1.0
powerpc64                        alldefconfig    clang-22
powerpc64             randconfig-001-20250730    clang-22
powerpc64             randconfig-002-20250730    clang-22
powerpc64             randconfig-003-20250730    gcc-10.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250730    gcc-10.5.0
riscv                 randconfig-002-20250730    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250730    clang-20
s390                  randconfig-002-20250730    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250730    gcc-12.5.0
sh                    randconfig-002-20250730    gcc-15.1.0
sh                          rsk7201_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250730    gcc-14.3.0
sparc                 randconfig-002-20250730    gcc-14.3.0
sparc64               randconfig-001-20250730    clang-22
sparc64               randconfig-002-20250730    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250730    gcc-11
um                    randconfig-002-20250730    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250730    gcc-12
x86_64      buildonly-randconfig-002-20250730    clang-20
x86_64      buildonly-randconfig-003-20250730    clang-20
x86_64      buildonly-randconfig-004-20250730    clang-20
x86_64      buildonly-randconfig-005-20250730    clang-20
x86_64      buildonly-randconfig-006-20250730    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250730    gcc-11.5.0
xtensa                randconfig-002-20250730    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
