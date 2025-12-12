Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE2430EF6D
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765553649; cv=none; b=PoZ0bUSC4vFOkABZ7iVFtp9/ejbmlWZbS3bTwXe9f0aPPWfGTVI1JNJ2m+D21tn5UA3n5PKmKAvkljxCgFk6kyeSjKcavDQC5AkocoHGsCo3gabtOr3b8sX5sjS7rsUmZJhAUQkUc9tXi9hy6COOTy8g/yM+PJ4a0JuT5Dsgab8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765553649; c=relaxed/simple;
	bh=mFvsFceFfxlAPJ4yV6e9cylhwBmMqsBFC820gIQawr0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ga/YL1gr6R5O5NbK7p2RmrLgqv6AkeQiEJY1ZilZuzNYHOgfNtVNfE0x17NBYo3kBzGeMcEVX2XtqHnbd7stEuF1paTP0fT9ZUvK79TwVOjJKfjC8IczNL+5xT2WZIZZXctkWBuEP702I3bgi2VJ3eRyLbcjCMfNCKSrxBHYF5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CIYaOSVy; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CIYaOSVy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765553647; x=1797089647;
  h=date:from:to:cc:subject:message-id;
  bh=mFvsFceFfxlAPJ4yV6e9cylhwBmMqsBFC820gIQawr0=;
  b=CIYaOSVy7L7wbSR243mIus6SStNBMM6hGOHkqszPVgUXXRFz0YDZN9NA
   LLz5xmogBvBQqinl8hDGUSfe1R3QVOp92Xmz8KJoOJdQtZTBhA2XHtKSq
   2HpGkdM4CIzJmjILqcWodKJST/ULGULedzfpkEEcq6ii2tE4njKaQBxLG
   ufJTdGCk5YtPwH/FXepnY2H+T0fZZFsECOQLF+vmi6BlfT345GDR72icE
   FDl3LLpcGu1yA7vYg2DEDEMrIB1CtcTG0dXKRepbEs0CBHZNsIEcUWNMS
   1arJhjSjrSuBvQcghUbTUY/YhVDeSGzda2ywu1dhtp/8D/pwAplbXzMCo
   w==;
X-CSE-ConnectionGUID: ptf5QsFZR4mZUgUkIB+KBQ==
X-CSE-MsgGUID: grNWJmXQRsS18PSPzxcIzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="71402957"
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="71402957"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 07:34:05 -0800
X-CSE-ConnectionGUID: By1GlGSsRo6ztiBtJf9rFw==
X-CSE-MsgGUID: IgPYkDKMQ8yTnbLTdXAyyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="228173112"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 12 Dec 2025 07:34:03 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vU59d-000000006EP-0WTW;
	Fri, 12 Dec 2025 15:34:01 +0000
Date: Fri, 12 Dec 2025 23:33:27 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 305c1c5dd5f4a915cb5a4a5c7115c0e3b3aa20c1
Message-ID: <202512122320.rvvzgaMV-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 305c1c5dd5f4a915cb5a4a5c7115c0e3b3aa20c1  Bluetooth: hci_conn: Fix using conn->le_{tx,rx}_phy as supported PHYs

elapsed time: 1185m

configs tested: 194
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                         haps_hs_defconfig    gcc-15.1.0
arc                            hsdk_defconfig    gcc-15.1.0
arc                   randconfig-001-20251212    clang-22
arc                   randconfig-002-20251212    clang-22
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    gcc-15.1.0
arm                       netwinder_defconfig    clang-19
arm                   randconfig-001-20251212    clang-22
arm                   randconfig-002-20251212    clang-22
arm                   randconfig-003-20251212    clang-22
arm                   randconfig-004-20251212    clang-22
arm                             rpc_defconfig    gcc-15.1.0
arm                    vt8500_v6_v7_defconfig    clang-19
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251212    clang-22
arm64                 randconfig-002-20251212    clang-22
arm64                 randconfig-003-20251212    clang-22
arm64                 randconfig-004-20251212    clang-22
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251212    clang-22
csky                  randconfig-002-20251212    clang-22
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251212    gcc-11.5.0
hexagon               randconfig-002-20251212    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251212    gcc-14
i386        buildonly-randconfig-002-20251212    gcc-14
i386        buildonly-randconfig-003-20251212    gcc-14
i386        buildonly-randconfig-004-20251212    gcc-14
i386        buildonly-randconfig-005-20251212    gcc-14
i386        buildonly-randconfig-006-20251212    gcc-14
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251212    gcc-14
i386                  randconfig-002-20251212    gcc-14
i386                  randconfig-003-20251212    gcc-14
i386                  randconfig-004-20251212    gcc-14
i386                  randconfig-005-20251212    gcc-14
i386                  randconfig-006-20251212    gcc-14
i386                  randconfig-007-20251212    gcc-14
i386                  randconfig-011-20251212    gcc-14
i386                  randconfig-012-20251212    gcc-14
i386                  randconfig-013-20251212    gcc-14
i386                  randconfig-014-20251212    gcc-14
i386                  randconfig-015-20251212    gcc-14
i386                  randconfig-016-20251212    gcc-14
i386                  randconfig-017-20251212    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251212    gcc-11.5.0
loongarch             randconfig-002-20251212    gcc-11.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.1.0
m68k                         amcore_defconfig    clang-19
m68k                                defconfig    clang-19
m68k                           sun3_defconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                          rb532_defconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251212    gcc-11.5.0
nios2                 randconfig-002-20251212    gcc-11.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251212    clang-22
parisc                randconfig-002-20251212    clang-22
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                    amigaone_defconfig    gcc-15.1.0
powerpc                   motionpro_defconfig    clang-19
powerpc                      ppc64e_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251212    clang-22
powerpc               randconfig-002-20251212    clang-22
powerpc                      tqm8xx_defconfig    clang-19
powerpc64             randconfig-001-20251212    clang-22
powerpc64             randconfig-002-20251212    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251212    clang-17
riscv                 randconfig-002-20251212    clang-17
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251212    clang-17
s390                  randconfig-002-20251212    clang-17
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251212    clang-17
sh                    randconfig-002-20251212    clang-17
sh                          rsk7269_defconfig    clang-19
sh                          sdk7786_defconfig    gcc-15.1.0
sh                        sh7757lcr_defconfig    gcc-15.1.0
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251212    gcc-8.5.0
sparc                 randconfig-002-20251212    gcc-8.5.0
sparc                       sparc32_defconfig    clang-19
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251212    gcc-8.5.0
sparc64               randconfig-002-20251212    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251212    gcc-8.5.0
um                    randconfig-002-20251212    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251212    clang-20
x86_64      buildonly-randconfig-002-20251212    clang-20
x86_64      buildonly-randconfig-003-20251212    clang-20
x86_64      buildonly-randconfig-004-20251212    clang-20
x86_64      buildonly-randconfig-005-20251212    clang-20
x86_64      buildonly-randconfig-006-20251212    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251212    clang-20
x86_64                randconfig-002-20251212    clang-20
x86_64                randconfig-003-20251212    clang-20
x86_64                randconfig-004-20251212    clang-20
x86_64                randconfig-005-20251212    clang-20
x86_64                randconfig-006-20251212    clang-20
x86_64                randconfig-011-20251212    clang-20
x86_64                randconfig-012-20251212    clang-20
x86_64                randconfig-013-20251212    clang-20
x86_64                randconfig-014-20251212    clang-20
x86_64                randconfig-015-20251212    clang-20
x86_64                randconfig-016-20251212    clang-20
x86_64                randconfig-071-20251212    clang-20
x86_64                randconfig-072-20251212    clang-20
x86_64                randconfig-073-20251212    clang-20
x86_64                randconfig-074-20251212    clang-20
x86_64                randconfig-075-20251212    clang-20
x86_64                randconfig-076-20251212    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251212    gcc-8.5.0
xtensa                randconfig-002-20251212    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
