Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B05B377AB4
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Aug 2026 20:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785960024; cv=none; b=tI/G41E38WjS4JcNUAjPW7D0brtZyvpNZDGFcofW0WzU/gZnq5lVTSxnzcyFuE3ZCrTXYTo7WEyY9caSfh48Y+VHADFSzv6s80wqeD47QnCWLtjzxMjLVa8yhXdj3252h+uLplC039ivu55w+fFrfvpZm9vZpTNm6C79LfwDR9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785960024; c=relaxed/simple;
	bh=Pn/GtJn7Qyv/rTt1Bj4rehpNVXtJGBfudcAOrNA7E+4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=a0CXDVS26pMkQrXkiTxmz7CbQAZ0KevJO8VWM4BDUGzOMyxlYPIcYijs+aQ6W9qYhBODW1apNQIrlAJ9SkXb+Nev6d7c/3smtPPXJPltFiRz0LTsb9H2vOftNdmE+/510VAsBr7a0f70p+0oEWCNqlCyMagoBFwY2fN9qxvJBy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ekO6MC1B; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ekO6MC1B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785960021; x=1817496021;
  h=date:from:to:cc:subject:message-id;
  bh=Pn/GtJn7Qyv/rTt1Bj4rehpNVXtJGBfudcAOrNA7E+4=;
  b=ekO6MC1BCEQx0Dh7ywZZcO0nIMr9WlS67hO8CunoI6l3w9oEcJLwYf3N
   QA7XEvp9/wVATYnYL9zDugjq/ZBz8mEfcetRsFp6GNHCEhiDIjJ50BTlc
   W0gO6nUk/HpDFRkDcwbiaXPZTOu52UToPIJleQ/AcijWHMR/CJieTmUbI
   MCLe2saQzur8M3BidYjUKyJevr+aw7lAJRjcgSGomFjtUMVkS/43Z7deC
   y6WaDvWVpqTksX2R8Ix++VCl7YfG9UZhO7YCUhS2eT4jUFoglSPa83rT0
   rMRJ6OjvtezSyWMoDBWcC9HAdDOR7wnMxg9i5ZpodqO3/9RcsUKPBl7XR
   g==;
X-CSE-ConnectionGUID: Qxuq04KjSwqt3qDq+uc2Fg==
X-CSE-MsgGUID: Tb0h9RgKTFOxEisteP6y/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86487317"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="86487317"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 13:00:20 -0700
X-CSE-ConnectionGUID: bs34kgPAQt+BF0R1x3mfXg==
X-CSE-MsgGUID: 4TRjya7qRL2ooH1PROOXMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="286555202"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 05 Aug 2026 13:00:18 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wrhmh-00000000DJx-3cta;
	Wed, 05 Aug 2026 20:00:15 +0000
Date: Thu, 06 Aug 2026 03:59:58 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 8b715ab95872c377f6813ec8dc29230d1021e418
Message-ID: <202608060345.2sgRBrxx-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 8b715ab95872c377f6813ec8dc29230d1021e418  Bluetooth: hci_sync: Fix accept list UAF during suspend

elapsed time: 1528m

configs tested: 126
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260805    gcc-12.5.0
arc                  randconfig-001-20260806    gcc-11.5.0
arc                  randconfig-002-20260805    gcc-12.5.0
arc                  randconfig-002-20260806    gcc-11.5.0
arm                  randconfig-001-20260805    gcc-12.5.0
arm                  randconfig-001-20260806    gcc-11.5.0
arm                  randconfig-002-20260805    gcc-12.5.0
arm                  randconfig-002-20260806    gcc-11.5.0
arm                  randconfig-003-20260805    gcc-12.5.0
arm                  randconfig-003-20260806    gcc-11.5.0
arm                  randconfig-004-20260805    gcc-12.5.0
arm                  randconfig-004-20260806    gcc-11.5.0
arm64                randconfig-001-20260805    gcc-10.5.0
arm64                randconfig-002-20260805    gcc-10.5.0
arm64                randconfig-003-20260805    gcc-10.5.0
arm64                randconfig-004-20260805    gcc-10.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260805    gcc-10.5.0
csky                 randconfig-002-20260805    gcc-10.5.0
hexagon              randconfig-001-20260805    clang-18
hexagon              randconfig-001-20260806    clang-24
hexagon              randconfig-002-20260805    clang-18
hexagon              randconfig-002-20260806    clang-24
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260805    clang-22
i386       buildonly-randconfig-002-20260805    clang-22
i386       buildonly-randconfig-003-20260805    clang-22
i386       buildonly-randconfig-004-20260805    clang-22
i386       buildonly-randconfig-005-20260805    clang-22
i386       buildonly-randconfig-006-20260805    clang-22
i386                 randconfig-001-20260805    gcc-13
i386                 randconfig-002-20260805    gcc-13
i386                 randconfig-003-20260805    gcc-13
i386                 randconfig-004-20260805    gcc-13
i386                 randconfig-005-20260805    gcc-13
i386                 randconfig-006-20260805    gcc-13
i386                 randconfig-007-20260805    gcc-13
i386                 randconfig-011-20260805    gcc-14
i386                 randconfig-012-20260805    gcc-14
i386                 randconfig-013-20260805    gcc-14
i386                 randconfig-014-20260805    gcc-14
i386                 randconfig-015-20260805    gcc-14
i386                 randconfig-016-20260805    gcc-14
i386                 randconfig-017-20260805    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260805    clang-18
loongarch            randconfig-001-20260806    clang-24
loongarch            randconfig-002-20260805    clang-18
loongarch            randconfig-002-20260806    clang-24
m68k                       mvme16x_defconfig    gcc-16.1.0
mips                          jazz_defconfig    clang-24
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260805    clang-18
nios2                randconfig-001-20260806    clang-24
nios2                randconfig-002-20260805    clang-18
nios2                randconfig-002-20260806    clang-24
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260805    gcc-9.5.0
parisc               randconfig-002-20260805    gcc-9.5.0
powerpc                    asp8347_defconfig    clang-24
powerpc              randconfig-001-20260805    gcc-9.5.0
powerpc              randconfig-002-20260805    gcc-9.5.0
powerpc64            randconfig-001-20260805    gcc-9.5.0
powerpc64            randconfig-002-20260805    gcc-9.5.0
riscv                         randconfig-001    gcc-8.5.0
riscv                randconfig-001-20260805    gcc-8.5.0
riscv                randconfig-001-20260806    gcc-13.4.0
riscv                randconfig-002-20260805    gcc-8.5.0
riscv                randconfig-002-20260806    gcc-13.4.0
s390                 randconfig-001-20260805    gcc-8.5.0
s390                 randconfig-001-20260806    gcc-13.4.0
s390                 randconfig-002-20260805    gcc-8.5.0
s390                 randconfig-002-20260806    gcc-13.4.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260805    gcc-8.5.0
sh                   randconfig-001-20260806    gcc-13.4.0
sh                   randconfig-002-20260805    gcc-8.5.0
sh                   randconfig-002-20260806    gcc-13.4.0
sparc                randconfig-001-20260805    gcc-11.5.0
sparc                randconfig-002-20260805    gcc-11.5.0
sparc64              randconfig-001-20260805    gcc-11.5.0
sparc64              randconfig-002-20260805    gcc-11.5.0
um                   randconfig-001-20260805    gcc-11.5.0
um                   randconfig-002-20260805    gcc-11.5.0
x86_64     buildonly-randconfig-001-20260805    gcc-14
x86_64     buildonly-randconfig-001-20260806    clang-22
x86_64     buildonly-randconfig-002-20260805    gcc-14
x86_64     buildonly-randconfig-002-20260806    clang-22
x86_64     buildonly-randconfig-003-20260805    gcc-14
x86_64     buildonly-randconfig-003-20260806    clang-22
x86_64     buildonly-randconfig-004-20260805    gcc-14
x86_64     buildonly-randconfig-004-20260806    clang-22
x86_64     buildonly-randconfig-005-20260805    gcc-14
x86_64     buildonly-randconfig-005-20260806    clang-22
x86_64     buildonly-randconfig-006-20260805    gcc-14
x86_64     buildonly-randconfig-006-20260806    clang-22
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260805    gcc-14
x86_64               randconfig-002-20260805    gcc-14
x86_64               randconfig-003-20260805    gcc-14
x86_64               randconfig-004-20260805    gcc-14
x86_64               randconfig-005-20260805    gcc-14
x86_64               randconfig-006-20260805    gcc-14
x86_64               randconfig-011-20260805    gcc-14
x86_64               randconfig-012-20260805    gcc-14
x86_64               randconfig-013-20260805    gcc-14
x86_64               randconfig-014-20260805    gcc-14
x86_64               randconfig-015-20260805    gcc-14
x86_64               randconfig-016-20260805    gcc-14
x86_64               randconfig-071-20260805    clang-22
x86_64               randconfig-072-20260805    clang-22
x86_64               randconfig-073-20260805    clang-22
x86_64               randconfig-074-20260805    clang-22
x86_64               randconfig-075-20260805    clang-22
x86_64               randconfig-076-20260805    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260805    gcc-11.5.0
xtensa               randconfig-002-20260805    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
