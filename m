Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339CC35AC3B
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 11:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786707117; cv=none; b=nam5rzVm9C2mSfihHpoAO3Y1gqQwp8VLNlzwYDPFhpuYWCWvlRrwH53tjEkcrzOP6/pRCPdaG40QGIcNq1oe4P2F1gXrxfM6uZeGC+YSc9CfowUz6F0SCpWoRrm91/oUsnjMbG67G7gKGSHNiAaCrn3JO2idsV3rrehpvvXY3DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786707117; c=relaxed/simple;
	bh=fMBdBr2ZpiJKYpQJ7h3M9QkHJL53CapDj7poIbP4HvM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=epmgwNA6OhLdrKdxxS0/PPAljB3j7wI+ZJVWcUFnxwU5ylutC0J5eZQYLmlgYwO2GqYmSyV8y0P8uvinz6A8D648nrjCoT7An+c37RwdVXpjkRAJFG91IJMjvjZ1wA2kgKpmXWGFrlkZuf2+u9WQDpCWlgDHHTdxdDda3eGPFJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SUoE2EyL; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SUoE2EyL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786707114; x=1818243114;
  h=date:from:to:cc:subject:message-id;
  bh=fMBdBr2ZpiJKYpQJ7h3M9QkHJL53CapDj7poIbP4HvM=;
  b=SUoE2EyLJhWP7Isl0dEAOjxMGwtqT5Zq/19fsHOdwavSWnvQ/GpJ06Ss
   EhYK5e3bWGUXK8XrEnmn8uUyHzi0Aa20wqcm9jD/eGI9aDeaRBzmPHAAf
   Ui+BW5vbRIShewAWjb/GJ3vV9/ksOrWuI5ypDZ/D0E+I21fibkbicy31k
   8/giWiYyqKReN0wsTbnoVjTWpMW2fc3WXbrqyKolaxjVdtZcLAlDcSO1l
   Bmkm0OcCKGVLqXpX/aRrhoXydkiSG5NrQLbGaZgoItnwd+RuEEq09zWNt
   P3qNZlFAtHfdtoZuXWbr9j0OMjCAozI70JNdLfJFrw5Gbi5QreR9VX3wp
   A==;
X-CSE-ConnectionGUID: FAnw+2dVRCG+J8XynD9eiw==
X-CSE-MsgGUID: UVXwauggSVCP+aYTa75GXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87307840"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="87307840"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 04:31:53 -0700
X-CSE-ConnectionGUID: vyPhnp2XQjync5U1BdXrhw==
X-CSE-MsgGUID: GlqumX4FTJiYHXIaV8PewQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="269389401"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 14 Aug 2026 04:31:52 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wuq8b-00000000YhG-3Rgn;
	Fri, 14 Aug 2026 11:31:49 +0000
Date: Fri, 14 Aug 2026 19:30:50 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 d67f4a43e7ef8cff8aa8fe1df2f088390af41b6d
Message-ID: <202608141936.W8KIEBcB-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: d67f4a43e7ef8cff8aa8fe1df2f088390af41b6d  Bluetooth: L2CAP: fix race l2cap_sock_cleanup_listen() vs. put_chan

elapsed time: 2888m

configs tested: 117
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260813    gcc-13.4.0
arc                  randconfig-002-20260813    gcc-13.4.0
arm                         exynos_defconfig    clang-17
arm                       keystone_defconfig    gcc-16.1.0
arm                  randconfig-001-20260813    gcc-13.4.0
arm                  randconfig-002-20260813    gcc-13.4.0
arm                  randconfig-003-20260813    gcc-13.4.0
arm                  randconfig-004-20260813    gcc-13.4.0
arm64                randconfig-001-20260813    gcc-16.1.0
arm64                randconfig-002-20260813    gcc-16.1.0
arm64                randconfig-003-20260813    gcc-16.1.0
arm64                randconfig-004-20260813    gcc-16.1.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260813    gcc-16.1.0
csky                 randconfig-002-20260813    gcc-16.1.0
hexagon              randconfig-001-20260813    gcc-11.5.0
hexagon              randconfig-002-20260813    gcc-11.5.0
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    gcc-14
i386       buildonly-randconfig-001-20260813    gcc-14
i386       buildonly-randconfig-001-20260814    clang-22
i386       buildonly-randconfig-002-20260813    gcc-14
i386       buildonly-randconfig-002-20260814    clang-22
i386       buildonly-randconfig-003-20260813    gcc-14
i386       buildonly-randconfig-003-20260814    clang-22
i386       buildonly-randconfig-004-20260813    gcc-14
i386       buildonly-randconfig-004-20260814    clang-22
i386       buildonly-randconfig-005-20260813    gcc-14
i386       buildonly-randconfig-005-20260814    clang-22
i386       buildonly-randconfig-006-20260813    gcc-14
i386       buildonly-randconfig-006-20260814    clang-22
i386                 randconfig-001-20260813    clang-22
i386                 randconfig-002-20260813    clang-22
i386                 randconfig-003-20260813    clang-22
i386                 randconfig-004-20260813    clang-22
i386                 randconfig-005-20260813    clang-22
i386                 randconfig-006-20260813    clang-22
i386                 randconfig-007-20260813    clang-22
i386                          randconfig-011    clang-22
i386                 randconfig-011-20260813    clang-22
i386                 randconfig-012-20260813    clang-22
i386                 randconfig-013-20260813    clang-22
i386                 randconfig-014-20260813    clang-22
i386                 randconfig-015-20260813    clang-22
i386                 randconfig-016-20260813    clang-22
i386                 randconfig-017-20260813    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260813    gcc-11.5.0
loongarch            randconfig-002-20260813    gcc-11.5.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260813    gcc-11.5.0
nios2                randconfig-002-20260813    gcc-11.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260813    gcc-10.5.0
parisc               randconfig-002-20260813    gcc-10.5.0
powerpc              randconfig-001-20260813    gcc-10.5.0
powerpc              randconfig-002-20260813    gcc-10.5.0
powerpc64            randconfig-001-20260813    gcc-10.5.0
powerpc64            randconfig-002-20260813    gcc-10.5.0
riscv                randconfig-001-20260813    gcc-10.5.0
riscv                randconfig-002-20260813    gcc-10.5.0
s390                 randconfig-001-20260813    gcc-10.5.0
s390                 randconfig-002-20260813    gcc-10.5.0
sh                                 defconfig    gcc-16.1.0
sh               ecovec24-romimage_defconfig    gcc-16.1.0
sh                   randconfig-001-20260813    gcc-10.5.0
sh                   randconfig-002-20260813    gcc-10.5.0
sparc                randconfig-001-20260813    clang-20
sparc                randconfig-002-20260813    clang-20
sparc64              randconfig-001-20260813    clang-20
sparc64              randconfig-002-20260813    clang-20
um                   randconfig-001-20260813    clang-20
um                   randconfig-002-20260813    clang-20
um                          x86_64_defconfig    clang-24
x86_64     buildonly-randconfig-001-20260813    gcc-14
x86_64     buildonly-randconfig-002-20260813    gcc-14
x86_64     buildonly-randconfig-003-20260813    gcc-14
x86_64     buildonly-randconfig-004-20260813    gcc-14
x86_64     buildonly-randconfig-005-20260813    gcc-14
x86_64     buildonly-randconfig-006-20260813    gcc-14
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260813    gcc-13
x86_64               randconfig-002-20260813    gcc-13
x86_64               randconfig-003-20260813    gcc-13
x86_64               randconfig-004-20260813    gcc-13
x86_64               randconfig-005-20260813    gcc-13
x86_64               randconfig-006-20260813    gcc-13
x86_64               randconfig-011-20260813    gcc-14
x86_64               randconfig-012-20260813    gcc-14
x86_64               randconfig-013-20260813    gcc-14
x86_64               randconfig-014-20260813    gcc-14
x86_64               randconfig-015-20260813    gcc-14
x86_64               randconfig-016-20260813    gcc-14
x86_64                        randconfig-071    gcc-14
x86_64               randconfig-071-20260813    gcc-14
x86_64               randconfig-071-20260814    gcc-13
x86_64               randconfig-072-20260813    gcc-14
x86_64               randconfig-072-20260814    gcc-13
x86_64               randconfig-073-20260813    gcc-14
x86_64               randconfig-073-20260814    gcc-13
x86_64               randconfig-074-20260813    gcc-14
x86_64               randconfig-074-20260814    gcc-13
x86_64               randconfig-075-20260813    gcc-14
x86_64               randconfig-075-20260814    gcc-13
x86_64               randconfig-076-20260813    gcc-14
x86_64               randconfig-076-20260814    gcc-13
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260813    clang-20
xtensa               randconfig-002-20260813    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
