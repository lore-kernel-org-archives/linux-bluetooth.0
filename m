Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3A729827E
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 09:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776330159; cv=none; b=mgbI6y3UuaN1M83yMnSr7BgQpvme4HRNagZEiYlrsSV++XgofLb4aDN6uyatLIjWpfLQ45IstKzksE/47hFpvQSNRg5cKHA91BYBUpgMtrJR2wYG5QwA28X08vxnJYe2IaZwmJVOHLPSUWafXIcv8GhomTCjkmc4W3q+jfw6ivI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776330159; c=relaxed/simple;
	bh=0TAw0lBDjfDwlSg95dMmaVTcckEQ53qq40CRhZQ94LQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WAM2LQYA4BjDQPUpenggHk+cCphn/l6P4QUDkqckcT5WP8V3qF/dbQQd000bUo5vLeXNK5lFh01AjmalCYs8WbL3+x4jWZ+7rIM2x8nO/1Jo/m0sRJoviYdaUVpUZO0sC/dkVuv53x922DxWmyDh5ggAkZAvMTRKDgk6plLP1Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZK8J5VSG; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZK8J5VSG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776330158; x=1807866158;
  h=date:from:to:cc:subject:message-id;
  bh=0TAw0lBDjfDwlSg95dMmaVTcckEQ53qq40CRhZQ94LQ=;
  b=ZK8J5VSGkBJuYqCsk2R2Pa+OlTnL1Pn5LzP6qudeJMFA0vs/AMATAIuh
   Rv58lIDn5EdqmiMjEACRTcdoiTInKpY/Y1/UC3v2MpUG7BsVi+eygm3hb
   Z/xlCWLX2El+11rl0KjhSdz4G3tLxpYfHSu8ywwqmlHKRaQkQhQWQymrD
   J9vcXssYVnOJBq4bcwgsUxadk8f24nnbnkZOVkIN5qaD/ysnQvFEAhKlV
   Y748jrNKcxNyhbBcKnOFTXSOzzY6Y1TLBfg6IO+l9yPbqfDrzM2HZgYVl
   3LBnNRJGM21A7E6ZmUhWqUg5RQYWJX/LLR416d6MzxEBC80EaQxSqhEa6
   A==;
X-CSE-ConnectionGUID: ogcgs+oAQzmiowhkLficlQ==
X-CSE-MsgGUID: uGVcbejJRlS7yPsTVHGO1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="76492066"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="76492066"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 02:02:37 -0700
X-CSE-ConnectionGUID: Ll+VYp6pQQu56RXQfHAhjA==
X-CSE-MsgGUID: E4fBIukbT7CS2dhhRRNvGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="261100249"
Received: from lkp-server01.sh.intel.com (HELO 7f3b36e5d6a5) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 16 Apr 2026 02:02:35 -0700
Received: from kbuild by 7f3b36e5d6a5 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wDIcL-000000001Qc-0FDr;
	Thu, 16 Apr 2026 09:02:33 +0000
Date: Thu, 16 Apr 2026 17:02:09 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 345f69bfd48d60328ddf3a2083674e39bf23478f
Message-ID: <202604161701.pssQn2lA-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 345f69bfd48d60328ddf3a2083674e39bf23478f  Bluetooth: l2cap: defer conn param update to avoid conn->lock/hdev->lock inversion

elapsed time: 728m

configs tested: 196
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260416    gcc-14.3.0
arc                   randconfig-002-20260416    gcc-14.3.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                          ixp4xx_defconfig    gcc-15.2.0
arm                   randconfig-001-20260416    gcc-14.3.0
arm                   randconfig-002-20260416    gcc-14.3.0
arm                   randconfig-003-20260416    gcc-14.3.0
arm                   randconfig-004-20260416    gcc-14.3.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260416    gcc-8.5.0
arm64                 randconfig-002-20260416    gcc-10.5.0
arm64                 randconfig-002-20260416    gcc-8.5.0
arm64                 randconfig-003-20260416    clang-23
arm64                 randconfig-003-20260416    gcc-8.5.0
arm64                 randconfig-004-20260416    clang-16
arm64                 randconfig-004-20260416    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260416    gcc-14.3.0
csky                  randconfig-001-20260416    gcc-8.5.0
csky                  randconfig-002-20260416    gcc-14.3.0
csky                  randconfig-002-20260416    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260416    gcc-15.2.0
hexagon               randconfig-002-20260416    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260416    gcc-14
i386        buildonly-randconfig-002-20260416    gcc-12
i386        buildonly-randconfig-003-20260416    clang-20
i386        buildonly-randconfig-004-20260416    clang-20
i386        buildonly-randconfig-006-20260416    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260416    gcc-14
i386                  randconfig-002-20260416    clang-20
i386                  randconfig-002-20260416    gcc-14
i386                  randconfig-003-20260416    clang-20
i386                  randconfig-003-20260416    gcc-14
i386                  randconfig-004-20260416    clang-20
i386                  randconfig-004-20260416    gcc-14
i386                  randconfig-005-20260416    clang-20
i386                  randconfig-005-20260416    gcc-14
i386                  randconfig-006-20260416    clang-20
i386                  randconfig-006-20260416    gcc-14
i386                  randconfig-007-20260416    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260416    gcc-15.2.0
loongarch             randconfig-002-20260416    gcc-15.2.0
m68k                             alldefconfig    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260416    gcc-15.2.0
nios2                 randconfig-002-20260416    gcc-15.2.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260416    gcc-8.5.0
parisc                randconfig-002-20260416    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260416    gcc-8.5.0
powerpc               randconfig-002-20260416    gcc-8.5.0
powerpc64             randconfig-001-20260416    gcc-8.5.0
powerpc64             randconfig-002-20260416    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260416    clang-23
riscv                 randconfig-001-20260416    gcc-11.5.0
riscv                 randconfig-002-20260416    clang-23
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260416    clang-23
s390                  randconfig-002-20260416    clang-20
s390                  randconfig-002-20260416    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260416    clang-23
sh                    randconfig-001-20260416    gcc-9.5.0
sh                    randconfig-002-20260416    clang-23
sh                    randconfig-002-20260416    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260416    clang-23
sparc                 randconfig-001-20260416    gcc-15.2.0
sparc                 randconfig-002-20260416    clang-23
sparc                 randconfig-002-20260416    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260416    clang-23
sparc64               randconfig-002-20260416    clang-23
sparc64               randconfig-002-20260416    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260416    clang-23
um                    randconfig-002-20260416    clang-23
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20260416    gcc-12
x86_64                randconfig-012-20260416    gcc-12
x86_64                randconfig-013-20260416    gcc-12
x86_64                randconfig-014-20260416    gcc-12
x86_64                randconfig-015-20260416    gcc-12
x86_64                randconfig-016-20260416    gcc-12
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260416    clang-23
xtensa                randconfig-001-20260416    gcc-11.5.0
xtensa                randconfig-002-20260416    clang-23
xtensa                randconfig-002-20260416    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
