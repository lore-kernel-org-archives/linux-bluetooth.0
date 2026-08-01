Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A513C1FDE31
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Aug 2026 22:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785622042; cv=none; b=rOrKdrqjYAG9tdcdIGacMAmhqjfAVUpw+dAw4xafKc2W0XTU2U5M3mMuiWI1C40NWlhlCeOgk7raC6mejf5p3QLaLqyT8W46EPT0RmE/quU/l8t2JtLe/pf8PxAyPD9qlF8WIyc3iPfju2a9mODUp2SdEPmBBP7m80DDi4RN58I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785622042; c=relaxed/simple;
	bh=tayL1V3KVMD+v+qo87L45OctS3NYqzWw+y4aFNF8J4Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OTnoKSbRXQd/FEq5gJE4dbPqlSSqjb6OxLv6S4lILmPSO9Tobi0+yIPZydq5h046JpQc1sLi+sGhHta837CXeyzJqtEjb+dwp6+LchsN3+5rgzlt39HfiFTP3W3VulPfB4EPGH6gWSsE9dXRXyi+5DJ5fsR2RrrlagZ2lDTcH2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TqVLtoaE; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TqVLtoaE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785622041; x=1817158041;
  h=date:from:to:cc:subject:message-id;
  bh=tayL1V3KVMD+v+qo87L45OctS3NYqzWw+y4aFNF8J4Q=;
  b=TqVLtoaE/P/ciWkYG30jpX9QpkKE96F3W6VrvD26Xkd9Oc2lVzU8ReIA
   cwwAFe6WpelSeCkR/2TS6qAVf8PYMTu1C2hImW+pUNk+z6G756zv8PS+C
   hPHh8JKDBwqFsTOTQ6JPpYowJkECOv6uUU0zR7DMzJn3DG7oNZp7wv8ji
   CIc9HAqBiagw3lsmA94Hu5xR4kc+Nb8acvSylDU2rCh9asSnWdeBQirLj
   5XpVbdeNlFFG21MAHrcJjTsnoWN05MS/8WZLZZegIlbGIysDAvgWtVpn9
   zVi0dplsAGBqcclwCPPyATNVWeGOdP2xqafMOcEKVRVebwYjm1zAxXFcw
   A==;
X-CSE-ConnectionGUID: lzvr26tRQFqev8S/4SuPyA==
X-CSE-MsgGUID: HSFDqqk4Qq+S9NhWlDf45Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11862"; a="86330802"
X-IronPort-AV: E=Sophos;i="6.25,199,1779174000"; 
   d="scan'208";a="86330802"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2026 15:07:20 -0700
X-CSE-ConnectionGUID: +TWY9wJTTHWA8GUCn1Tn4Q==
X-CSE-MsgGUID: APEw/5VCTYG9e+u2X7l/pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,199,1779174000"; 
   d="scan'208";a="285496071"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 01 Aug 2026 15:07:19 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wqHrQ-000000003xR-2snX;
	Sat, 01 Aug 2026 22:07:16 +0000
Date: Sun, 02 Aug 2026 06:06:34 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 d264c90ca22e2034ef46b1831d38b1f47af44380
Message-ID: <202608020622.zl1CYpJA-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: d264c90ca22e2034ef46b1831d38b1f47af44380  Bluetooth: virtio_bt: avoid OOB read of build info string

elapsed time: 756m

configs tested: 101
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                    nsimosci_hs_defconfig    gcc-16.1.0
arc                  randconfig-001-20260801    gcc-14.3.0
arc                  randconfig-002-20260801    gcc-12.5.0
arm                  randconfig-001-20260801    clang-24
arm                  randconfig-002-20260801    gcc-8.5.0
arm                  randconfig-003-20260801    gcc-12.5.0
arm                  randconfig-004-20260801    clang-18
arm64                randconfig-001-20260801    clang-21
arm64                randconfig-002-20260801    clang-21
arm64                randconfig-003-20260801    gcc-14.3.0
arm64                randconfig-004-20260801    clang-24
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260801    gcc-12.5.0
csky                 randconfig-002-20260801    gcc-10.5.0
hexagon              randconfig-001-20260801    clang-24
hexagon              randconfig-002-20260801    clang-16
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260801    clang-22
i386       buildonly-randconfig-002-20260801    clang-22
i386       buildonly-randconfig-003-20260801    clang-22
i386       buildonly-randconfig-004-20260801    clang-22
i386       buildonly-randconfig-005-20260801    gcc-14
i386       buildonly-randconfig-006-20260801    gcc-14
i386                 randconfig-001-20260802    gcc-14
i386                 randconfig-002-20260802    clang-22
i386                 randconfig-003-20260802    gcc-14
i386                 randconfig-004-20260802    gcc-14
i386                 randconfig-005-20260802    clang-22
i386                 randconfig-006-20260802    gcc-14
i386                 randconfig-007-20260802    gcc-14
i386                          randconfig-011    clang-22
i386                 randconfig-011-20260801    clang-22
i386                 randconfig-012-20260801    gcc-14
i386                 randconfig-013-20260801    gcc-14
i386                 randconfig-014-20260801    clang-22
i386                 randconfig-015-20260801    clang-22
i386                 randconfig-016-20260801    gcc-14
i386                 randconfig-017-20260801    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260801    clang-18
loongarch            randconfig-002-20260801    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260801    gcc-8.5.0
nios2                randconfig-002-20260801    gcc-11.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260801    gcc-11.5.0
parisc               randconfig-002-20260801    gcc-9.5.0
powerpc              randconfig-001-20260801    clang-20
powerpc              randconfig-002-20260801    gcc-10.5.0
powerpc64            randconfig-001-20260801    clang-24
powerpc64            randconfig-002-20260801    clang-24
riscv                randconfig-001-20260801    gcc-14.3.0
riscv                randconfig-002-20260801    clang-20
s390                 randconfig-001-20260801    gcc-15.2.0
s390                 randconfig-002-20260801    clang-24
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260801    gcc-16.1.0
sh                   randconfig-002-20260801    gcc-16.1.0
sparc                randconfig-001-20260801    gcc-8.5.0
sparc                randconfig-002-20260801    gcc-11.5.0
sparc64              randconfig-001-20260801    gcc-9.5.0
sparc64              randconfig-002-20260801    gcc-15.2.0
um                   randconfig-001-20260801    clang-24
um                   randconfig-002-20260801    gcc-14
x86_64     buildonly-randconfig-001-20260801    clang-22
x86_64     buildonly-randconfig-002-20260801    clang-22
x86_64     buildonly-randconfig-003-20260801    gcc-13
x86_64     buildonly-randconfig-004-20260801    clang-22
x86_64     buildonly-randconfig-005-20260801    clang-22
x86_64     buildonly-randconfig-006-20260801    clang-22
x86_64               randconfig-001-20260801    clang-22
x86_64               randconfig-002-20260801    gcc-14
x86_64               randconfig-003-20260801    gcc-14
x86_64               randconfig-004-20260801    clang-22
x86_64               randconfig-005-20260801    gcc-14
x86_64               randconfig-006-20260801    gcc-14
x86_64                        randconfig-011    gcc-14
x86_64               randconfig-011-20260801    clang-22
x86_64               randconfig-012-20260801    gcc-14
x86_64               randconfig-013-20260801    clang-22
x86_64               randconfig-014-20260801    gcc-14
x86_64               randconfig-015-20260801    clang-22
x86_64               randconfig-016-20260801    clang-22
x86_64                        randconfig-071    gcc-14
x86_64               randconfig-071-20260801    gcc-14
x86_64               randconfig-072-20260801    gcc-14
x86_64               randconfig-073-20260801    clang-22
x86_64               randconfig-074-20260801    gcc-14
x86_64               randconfig-075-20260801    clang-22
x86_64               randconfig-076-20260801    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260801    gcc-9.5.0
xtensa               randconfig-002-20260801    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
