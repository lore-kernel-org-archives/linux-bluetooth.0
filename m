Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B993C1F
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 00:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781656262; cv=none; b=smtSXl+3iV0vsNYlCgv4KMVdRaNd39HpQtkq3VBY6IyuShEcr9EiTdXQ4oIjjYr+IRimGFJJhyJSFYaFZJVh86UUeEM04ZIKI9Rqn2QUxjoBIyvCLSnkghx2aOhuucai2eYSXM+MDvLFNZoR4kp8JsNhaZ7zI60qijnGp1EJfzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781656262; c=relaxed/simple;
	bh=1ULWgkpgmKAUZlZUemDviPuTsvpR9i9hO9YCnPKx+CM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fAkHt4exeaeE0in5DbBVrSpgfZyhhePVsKYOzL9tnCKI2sI7AXU0iKg79j9V7q11wSIyl5E21j6tBCPqQC54D+U1plUlUDp8ZUDx6DBuzFombBfI/4RDyeAGSqDSNfH1Irt/WfRf8rAfjtKfmlrFO7iDbZ5eKDS093Ivdc/TOJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mScU69F4; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mScU69F4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781656261; x=1813192261;
  h=date:from:to:cc:subject:message-id;
  bh=1ULWgkpgmKAUZlZUemDviPuTsvpR9i9hO9YCnPKx+CM=;
  b=mScU69F41IbigMFUMHdMfqYg9nKjXbRgN4BxP5GvZqGHLad7XCdT4Jiz
   BTD+UJyBv5xRtTjpx3ubsHqKzkIjiXYCGHOkhM+jzw3ZFDaQOyMCRwSZe
   vtPRdYjVM7n4yw6pMnE/98yNYm7B/DY3m1YzgWY53Br8EhAtWoi9/C6z6
   fEgK0a8cOJHkFDkvHeKuduyiRSyyh8mgXjxS6ChLloGo2tqundtvNdDTy
   Q+rf0DbgoByvzm4tg8JV3P4EEcorJgWiQKXYpAtDljVVjvPur2LsCvuK0
   sOK8zT//0HurkuNshEOvSaingPrYxas+GRQAFRV/ZaqprDkBu2mlSEXeG
   Q==;
X-CSE-ConnectionGUID: R0jFk6J5R+2S67ptrQLIeA==
X-CSE-MsgGUID: AIdBII/RQYGbzVrjF04FGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="100008298"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="100008298"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 17:31:00 -0700
X-CSE-ConnectionGUID: CzHmlzjgQDmLrX3sWJe/jg==
X-CSE-MsgGUID: rVwpMl4wS6ueRBtjVz6CcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="253028983"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 16 Jun 2026 17:30:59 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wZeBE-00000000Tww-26Xx;
	Wed, 17 Jun 2026 00:30:56 +0000
Date: Wed, 17 Jun 2026 08:30:45 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 cb20f6afc25b2b54c0fec61b45ac0ec9eb875d59
Message-ID: <202606170837.JyIG656e-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: cb20f6afc25b2b54c0fec61b45ac0ec9eb875d59  Bluetooth: MGMT: Fix UAF of hci_conn_params in add_device_complete

elapsed time: 986m

configs tested: 289
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260616    gcc-9.5.0
arc                   randconfig-001-20260617    gcc-16.1.0
arc                   randconfig-002-20260616    gcc-9.5.0
arc                   randconfig-002-20260617    gcc-16.1.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                         lpc18xx_defconfig    clang-23
arm                   randconfig-001-20260616    gcc-9.5.0
arm                   randconfig-001-20260617    gcc-16.1.0
arm                   randconfig-002-20260616    gcc-9.5.0
arm                   randconfig-002-20260617    gcc-16.1.0
arm                   randconfig-003-20260616    gcc-9.5.0
arm                   randconfig-003-20260617    gcc-16.1.0
arm                   randconfig-004-20260616    gcc-9.5.0
arm                   randconfig-004-20260617    gcc-16.1.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260617    gcc-12.5.0
arm64                 randconfig-002-20260617    gcc-12.5.0
arm64                 randconfig-003-20260617    gcc-12.5.0
arm64                 randconfig-004-20260617    gcc-12.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260617    gcc-12.5.0
csky                  randconfig-002-20260617    gcc-12.5.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260616    clang-23
hexagon               randconfig-001-20260617    clang-17
hexagon               randconfig-002-20260616    clang-23
hexagon               randconfig-002-20260617    clang-17
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260616    gcc-14
i386        buildonly-randconfig-001-20260617    gcc-14
i386        buildonly-randconfig-002-20260616    clang-22
i386        buildonly-randconfig-002-20260617    gcc-14
i386        buildonly-randconfig-003-20260616    gcc-14
i386        buildonly-randconfig-003-20260617    gcc-14
i386        buildonly-randconfig-004-20260616    gcc-14
i386        buildonly-randconfig-004-20260617    gcc-14
i386        buildonly-randconfig-005-20260616    gcc-14
i386        buildonly-randconfig-005-20260617    gcc-14
i386        buildonly-randconfig-006-20260616    gcc-14
i386        buildonly-randconfig-006-20260617    gcc-14
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260616    gcc-14
i386                  randconfig-001-20260617    gcc-13
i386                  randconfig-002-20260616    gcc-14
i386                  randconfig-002-20260617    gcc-13
i386                  randconfig-003-20260616    gcc-14
i386                  randconfig-003-20260617    gcc-13
i386                  randconfig-004-20260616    gcc-14
i386                  randconfig-004-20260617    gcc-13
i386                  randconfig-005-20260616    gcc-14
i386                  randconfig-005-20260617    gcc-13
i386                  randconfig-006-20260616    gcc-14
i386                  randconfig-006-20260617    gcc-13
i386                  randconfig-007-20260616    gcc-14
i386                  randconfig-007-20260617    gcc-13
i386                  randconfig-011-20260616    gcc-14
i386                  randconfig-011-20260617    clang-22
i386                  randconfig-012-20260616    gcc-14
i386                  randconfig-012-20260617    clang-22
i386                  randconfig-013-20260616    gcc-14
i386                  randconfig-013-20260617    clang-22
i386                  randconfig-014-20260616    gcc-14
i386                  randconfig-014-20260617    clang-22
i386                  randconfig-015-20260616    gcc-14
i386                  randconfig-015-20260617    clang-22
i386                  randconfig-016-20260616    clang-22
i386                  randconfig-016-20260617    clang-22
i386                  randconfig-017-20260616    clang-22
i386                  randconfig-017-20260617    clang-22
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260616    clang-23
loongarch             randconfig-001-20260617    clang-17
loongarch             randconfig-002-20260616    clang-23
loongarch             randconfig-002-20260617    clang-17
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
m68k                                defconfig    gcc-16.1.0
m68k                          hp300_defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
microblaze                          defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                      malta_kvm_defconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-23
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260616    clang-23
nios2                 randconfig-001-20260617    clang-17
nios2                 randconfig-002-20260616    clang-23
nios2                 randconfig-002-20260617    clang-17
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260617    gcc-15.2.0
parisc                randconfig-002-20260617    gcc-15.2.0
parisc64                            defconfig    clang-23
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc               randconfig-001-20260617    gcc-15.2.0
powerpc               randconfig-002-20260617    gcc-15.2.0
powerpc64             randconfig-001-20260617    gcc-15.2.0
powerpc64             randconfig-002-20260617    gcc-15.2.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    gcc-13.4.0
riscv                 randconfig-001-20260616    gcc-9.5.0
riscv                 randconfig-001-20260617    gcc-16.1.0
riscv                          randconfig-002    clang-23
riscv                 randconfig-002-20260616    clang-23
riscv                 randconfig-002-20260617    gcc-16.1.0
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    gcc-15.2.0
s390                  randconfig-001-20260616    clang-23
s390                  randconfig-001-20260617    gcc-16.1.0
s390                           randconfig-002    clang-18
s390                  randconfig-002-20260616    clang-18
s390                  randconfig-002-20260617    gcc-16.1.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                             randconfig-001    gcc-14.3.0
sh                    randconfig-001-20260616    gcc-16.1.0
sh                    randconfig-001-20260617    gcc-16.1.0
sh                             randconfig-002    gcc-9.5.0
sh                    randconfig-002-20260616    gcc-13.4.0
sh                    randconfig-002-20260617    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260616    gcc-8.5.0
sparc                 randconfig-001-20260617    gcc-16.1.0
sparc                 randconfig-002-20260616    gcc-8.5.0
sparc                 randconfig-002-20260617    gcc-16.1.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260616    gcc-8.5.0
sparc64               randconfig-001-20260617    gcc-16.1.0
sparc64               randconfig-002-20260616    gcc-8.5.0
sparc64               randconfig-002-20260617    gcc-16.1.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260616    gcc-8.5.0
um                    randconfig-001-20260617    gcc-16.1.0
um                    randconfig-002-20260616    gcc-8.5.0
um                    randconfig-002-20260617    gcc-16.1.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260616    gcc-14
x86_64      buildonly-randconfig-001-20260617    clang-22
x86_64      buildonly-randconfig-002-20260616    gcc-14
x86_64      buildonly-randconfig-002-20260617    clang-22
x86_64      buildonly-randconfig-003-20260616    gcc-12
x86_64      buildonly-randconfig-003-20260617    clang-22
x86_64      buildonly-randconfig-004-20260616    gcc-12
x86_64      buildonly-randconfig-004-20260617    clang-22
x86_64      buildonly-randconfig-005-20260616    gcc-14
x86_64      buildonly-randconfig-005-20260617    clang-22
x86_64      buildonly-randconfig-006-20260616    gcc-14
x86_64      buildonly-randconfig-006-20260617    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260617    clang-22
x86_64                randconfig-002-20260617    clang-22
x86_64                randconfig-003-20260617    clang-22
x86_64                randconfig-004-20260617    clang-22
x86_64                randconfig-005-20260617    clang-22
x86_64                randconfig-006-20260617    clang-22
x86_64                         randconfig-011    clang-22
x86_64                         randconfig-011    gcc-14
x86_64                randconfig-011-20260616    clang-22
x86_64                randconfig-011-20260616    gcc-14
x86_64                randconfig-011-20260617    clang-22
x86_64                         randconfig-012    clang-22
x86_64                         randconfig-012    gcc-14
x86_64                randconfig-012-20260616    clang-22
x86_64                randconfig-012-20260616    gcc-14
x86_64                randconfig-012-20260617    clang-22
x86_64                         randconfig-013    clang-22
x86_64                randconfig-013-20260616    clang-22
x86_64                randconfig-013-20260617    clang-22
x86_64                         randconfig-014    clang-22
x86_64                         randconfig-014    gcc-14
x86_64                randconfig-014-20260616    clang-22
x86_64                randconfig-014-20260617    clang-22
x86_64                         randconfig-015    clang-22
x86_64                         randconfig-015    gcc-14
x86_64                randconfig-015-20260616    clang-22
x86_64                randconfig-015-20260617    clang-22
x86_64                         randconfig-016    clang-22
x86_64                randconfig-016-20260616    clang-22
x86_64                randconfig-016-20260616    gcc-14
x86_64                randconfig-016-20260617    clang-22
x86_64                         randconfig-071    gcc-13
x86_64                         randconfig-071    gcc-14
x86_64                randconfig-071-20260616    gcc-13
x86_64                randconfig-071-20260616    gcc-14
x86_64                randconfig-071-20260617    clang-22
x86_64                         randconfig-072    gcc-13
x86_64                         randconfig-072    gcc-14
x86_64                randconfig-072-20260616    clang-22
x86_64                randconfig-072-20260616    gcc-13
x86_64                randconfig-072-20260617    clang-22
x86_64                         randconfig-073    clang-22
x86_64                         randconfig-073    gcc-13
x86_64                randconfig-073-20260616    gcc-13
x86_64                randconfig-073-20260616    gcc-14
x86_64                randconfig-073-20260617    clang-22
x86_64                         randconfig-074    gcc-13
x86_64                         randconfig-074    gcc-14
x86_64                randconfig-074-20260616    gcc-13
x86_64                randconfig-074-20260616    gcc-14
x86_64                randconfig-074-20260617    clang-22
x86_64                         randconfig-075    gcc-13
x86_64                randconfig-075-20260616    gcc-12
x86_64                randconfig-075-20260616    gcc-13
x86_64                randconfig-075-20260617    clang-22
x86_64                         randconfig-076    clang-22
x86_64                         randconfig-076    gcc-13
x86_64                randconfig-076-20260616    gcc-13
x86_64                randconfig-076-20260616    gcc-14
x86_64                randconfig-076-20260617    clang-22
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-20
xtensa                           allyesconfig    gcc-16.1.0
xtensa                randconfig-001-20260616    gcc-8.5.0
xtensa                randconfig-001-20260617    gcc-16.1.0
xtensa                randconfig-002-20260616    gcc-8.5.0
xtensa                randconfig-002-20260617    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
