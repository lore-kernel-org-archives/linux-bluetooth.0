Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13694A2D
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 May 2025 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746883881; cv=none; b=WxxcEtWmdc2L/LEyBL/QAt6M/VLyEIpPZJWIk17OQxCyOvQ3tOD7CkfcEcItNieFC/micJNJqk95JDIJfJfXm8dRPh7GCxlj4/RfP7lN3YAFxSPVMvuDkdB6/RrknegRKV9lbIq+lsjtD0n5GjXFzsl+osS6xjpRSKrxEeUyZRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746883881; c=relaxed/simple;
	bh=63d1y9gzTgaeya+1XLhqY/mcNEWqckReutyCq31jiuk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=a9Qms2DoZkbBshOIEOOkFQK1+VVfoutMAXJ48YBl0IRRS1LQxZ2SqKKnX/iE9At3VImf2IHTL49+Cnl0BzpbCjTMO7pxkR+SvoEhewQ6HoMBCE3qWIVcxAiUZM1xzrOzvGbC0h6uldnrqjH3PF6ZEwDvSbfWIONPThW3FAhpWWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W3qF4izL; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3qF4izL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746883879; x=1778419879;
  h=date:from:to:cc:subject:message-id;
  bh=63d1y9gzTgaeya+1XLhqY/mcNEWqckReutyCq31jiuk=;
  b=W3qF4izLNb+uuy2VZowH/HY1tIh9xNKiKrGl1IjEW2SDvme4zqGQoGCl
   ACM57yzFp19AYpoStpRseWEi2oxWDTiUZbinc3GGJwX8n+JJuvSTgQPHi
   P0P1fxImosMvi+LJAXab5UCCSHTM8/XWaAqRfy0Z1osCoIJcMiUOgLBqr
   ZMPW/PLkXoTH1opp2uSbhvHBYqmlbs9oiyQJ6bN/Hn3JsEgNwZBgSpce5
   Z25FgKtW/SnNozoadHvbgZl4XzNpd4uy7S8zkq8CvFkgLWRXh5xvZHrE7
   tg6GIe6Fd1ifGmx+HA7vBOR/RlViS6DFVq1+/fzNto2unwPTWYEU7pVu5
   w==;
X-CSE-ConnectionGUID: nSaHeqtrTyqBZ+nErklo3g==
X-CSE-MsgGUID: 6Wup/l8lRauXq8tgTECFhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11429"; a="48716192"
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="48716192"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 06:31:19 -0700
X-CSE-ConnectionGUID: 0O5pVA9rRLWh1jJtRhBDrQ==
X-CSE-MsgGUID: rl2IzNhDQMqZDkXh7VOmZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="174045332"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 10 May 2025 06:31:17 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uDkIN-000D6d-0r;
	Sat, 10 May 2025 13:31:15 +0000
Date: Sat, 10 May 2025 21:30:51 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 259a6d602310cb07538746a6a0a7a2f89d6d0135
Message-ID: <202505102137.XUFvxZH1-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 259a6d602310cb07538746a6a0a7a2f89d6d0135  Bluetooth: btusb: use skb_pull to avoid unsafe access in QCA dump handling

elapsed time: 1359m

configs tested: 130
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                        nsim_700_defconfig    gcc-14.2.0
arc                   randconfig-001-20250509    gcc-13.3.0
arc                   randconfig-002-20250509    gcc-13.3.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                       aspeed_g5_defconfig    gcc-14.2.0
arm                       imx_v4_v5_defconfig    clang-21
arm                          moxart_defconfig    gcc-14.2.0
arm                         mv78xx0_defconfig    clang-19
arm                   randconfig-001-20250509    gcc-7.5.0
arm                   randconfig-002-20250509    gcc-6.5.0
arm                   randconfig-003-20250509    gcc-10.5.0
arm                   randconfig-004-20250509    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250509    gcc-7.5.0
arm64                 randconfig-002-20250509    gcc-7.5.0
arm64                 randconfig-003-20250509    clang-21
arm64                 randconfig-004-20250509    gcc-5.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250510    gcc-14.2.0
csky                  randconfig-002-20250510    gcc-13.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250510    clang-21
hexagon               randconfig-002-20250510    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250509    gcc-11
i386        buildonly-randconfig-002-20250509    gcc-12
i386        buildonly-randconfig-003-20250509    clang-20
i386        buildonly-randconfig-004-20250509    clang-20
i386        buildonly-randconfig-005-20250509    gcc-12
i386        buildonly-randconfig-006-20250509    gcc-11
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250510    gcc-13.3.0
loongarch             randconfig-002-20250510    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          eyeq6_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250510    gcc-11.5.0
nios2                 randconfig-002-20250510    gcc-7.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250510    gcc-6.5.0
parisc                randconfig-002-20250510    gcc-12.4.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                      chrp32_defconfig    clang-19
powerpc               mpc834x_itxgp_defconfig    clang-21
powerpc                      ppc64e_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250510    gcc-7.5.0
powerpc               randconfig-002-20250510    clang-17
powerpc               randconfig-003-20250510    clang-21
powerpc                  storcenter_defconfig    gcc-14.2.0
powerpc                     tqm8541_defconfig    clang-21
powerpc64             randconfig-001-20250510    clang-18
powerpc64             randconfig-002-20250510    gcc-10.5.0
powerpc64             randconfig-003-20250510    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250510    gcc-14.2.0
riscv                 randconfig-002-20250510    gcc-7.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250510    gcc-7.5.0
s390                  randconfig-002-20250510    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        apsh4ad0a_defconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                             espt_defconfig    gcc-14.2.0
sh                            migor_defconfig    gcc-14.2.0
sh                    randconfig-001-20250510    gcc-9.3.0
sh                    randconfig-002-20250510    gcc-11.5.0
sh                             sh03_defconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250510    gcc-12.4.0
sparc                 randconfig-002-20250510    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250510    gcc-10.5.0
sparc64               randconfig-002-20250510    gcc-14.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250510    gcc-12
um                    randconfig-002-20250510    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250509    gcc-11
x86_64      buildonly-randconfig-002-20250509    gcc-11
x86_64      buildonly-randconfig-003-20250509    clang-20
x86_64      buildonly-randconfig-004-20250509    clang-20
x86_64      buildonly-randconfig-005-20250509    gcc-12
x86_64      buildonly-randconfig-006-20250509    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250510    gcc-8.5.0
xtensa                randconfig-002-20250510    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
