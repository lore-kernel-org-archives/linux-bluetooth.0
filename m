Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5044F3AFAEF
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2026 03:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792380434; cv=none; b=t9245P5+E31YxrJ7TWu7OI2ab7HwWpXn2fBcNs36lY6/TaK7VX7vZicYLEg0Hx4QL0tNnBynbI9YoGUPB5BcJlPSCNyXG1oVzm8dLmCsbH/bfvc9JeWXLEmAahAH7CwV+CMi3+/F0k2AyfDHTBz83JmSk65QCKier4OBnJNSkUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792380434; c=relaxed/simple;
	bh=AFkArs684x8wUu9vUzxIWFaaAo3rRoo1REBxaJBHz4k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GUsnNRaokUlf0aP1VPk37z9mFhwHhjz4K/nQTI+pJSC72kBgingnvcpNgTM4SpbF9UxKf23E7MC1/OLhkI8pP0fMHoJMrx8Bjmw9G1/nouVJCWwM2Z+HOocrB403TQNWHEqW+onuqIoAg3IHWmDyZe9137/KctoL5llfOkkrAhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=drUh/jUg; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="drUh/jUg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792380433; x=1823916433;
  h=date:from:to:cc:subject:message-id;
  bh=AFkArs684x8wUu9vUzxIWFaaAo3rRoo1REBxaJBHz4k=;
  b=drUh/jUgKgwTU2NNdsJqAHiF9T4025wjHn9StFZDByaVE9LpkFZv3T1u
   Rc3oVylRTNWIk77lgya61QJm3MDQbhUXOU1uwy6sJ6g++KVlJjXjXFbpC
   cWj2gRhK2AVsfzBO2LpXZs0jZbfVeTvp0iQ0fXy5aEf7McCRTnVXx0KCe
   OGf/eHtM+/O6CIufQjzUtaBLkDTUDW1/6UqXH2zupjVoikXQw2UvufKbk
   b3jJOVyOAEeyTZUXEmS353xBt9n0/DQO614cMVzCWKfau7E+ICvxwVSby
   4/13LoVEZf3/fHIyJp/hDtlLAb1JwapsDUZJ84xj8I7lL7H5CvSgppSzu
   A==;
X-CSE-ConnectionGUID: 72iP6PPASzWmFfppdxAVgw==
X-CSE-MsgGUID: Gyws4mvbTj2ByGjaefjRvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1051307"
X-IronPort-AV: E=Sophos;i="6.27,166,1787036400"; 
   d="scan'208";a="1051307"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 20:27:10 -0700
X-CSE-ConnectionGUID: K8MZ2RQRRgqUOxRcxK3RJQ==
X-CSE-MsgGUID: s5s0+Tt9SQ+uEgCJ2Hv8Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,166,1787036400"; 
   d="scan'208";a="2799501"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 18 Oct 2026 20:27:08 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xIe1i-00000000LCo-0UdF;
	Mon, 19 Oct 2026 03:27:06 +0000
Date: Mon, 19 Oct 2026 11:26:45 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 185c11232d5f586489bb3b74e6bcc7a6560ddd40
Message-ID: <202610191142.TXEEdUuU-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 185c11232d5f586489bb3b74e6bcc7a6560ddd40  Bluetooth: hci_nokia: use skb_put_padto()

elapsed time: 1296m

configs tested: 249
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                randconfig-r2110-20261017    gcc-16.1.0 cocci
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261019    clang-21
arc                   randconfig-1001-20261019    clang-21
arc                   randconfig-2000-20261017    gcc-15.2.0
arc                   randconfig-2001-20261017    gcc-13.4.0
arc                  randconfig-r2105-20261017    gcc-14.3.0 cocci
arc                  randconfig-r2311-20261017    gcc-15.2.0 sparse
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                       integrator_defconfig    gcc-16.2.0
arm                           pxa3xx_defconfig    gcc-16.2.0
arm                   randconfig-1000-20261019    clang-21
arm                   randconfig-1001-20261019    clang-21
arm                   randconfig-1002-20261019    clang-21
arm                   randconfig-1003-20261019    clang-21
arm                   randconfig-2000-20261017    gcc-8.5.0
arm                   randconfig-2001-20261017    gcc-8.5.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261019    clang-24
arm64                 randconfig-1001-20261019    clang-24
arm64                 randconfig-1002-20261019    clang-24
arm64                 randconfig-1003-20261019    clang-24
arm64                 randconfig-2000-20261017    clang-17
arm64                 randconfig-2001-20261017    gcc-10.5.0
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261019    clang-24
csky                  randconfig-1001-20261019    clang-24
csky                  randconfig-2000-20261017    gcc-15.2.0
csky                  randconfig-2001-20261017    gcc-9.5.0
csky                 randconfig-r2103-20261017    gcc-16.1.0 cocci
csky                 randconfig-r2104-20261017    gcc-16.1.0 cocci
csky                 randconfig-r2109-20261017    gcc-16.1.0 cocci
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261019    clang-24
hexagon               randconfig-1001-20261019    clang-24
hexagon               randconfig-2000-20261017    clang-24
hexagon               randconfig-2001-20261017    clang-24
hexagon              randconfig-r2306-20261017    clang-24   sparse
i386                               allnoconfig    gcc-16.2.0
i386        buildonly-randconfig-1000-20261018    clang-22
i386        buildonly-randconfig-1001-20261018    clang-22
i386        buildonly-randconfig-1002-20261018    clang-22
i386        buildonly-randconfig-1003-20261018    clang-22
i386        buildonly-randconfig-1004-20261018    clang-22
i386        buildonly-randconfig-1005-20261018    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261019    clang-22
i386                  randconfig-1001-20261019    clang-22
i386                  randconfig-1002-20261019    clang-22
i386                  randconfig-1003-20261019    clang-22
i386                  randconfig-1004-20261019    clang-22
i386                  randconfig-1005-20261019    clang-22
i386                  randconfig-1006-20261019    clang-22
i386                  randconfig-1007-20261018    gcc-14
i386                  randconfig-1008-20261018    gcc-14
i386                  randconfig-1009-20261018    gcc-14
i386                  randconfig-1010-20261018    gcc-14
i386                  randconfig-1011-20261018    gcc-14
i386                  randconfig-1012-20261018    gcc-14
i386                  randconfig-1013-20261018    gcc-14
i386                  randconfig-2000-20261017    clang-22
i386                  randconfig-2001-20261017    clang-22
i386                  randconfig-2100-20261017    gcc-14     cocci
i386                  randconfig-2101-20261017    clang-22   cocci
i386                  randconfig-2102-20261017    clang-22   cocci
i386                  randconfig-2103-20261017    gcc-14     cocci
i386                  randconfig-2104-20261017    gcc-14     cocci
i386                  randconfig-2105-20261017    gcc-14     cocci
i386                  randconfig-2200-20261017    clang-22   smatch
i386                  randconfig-2300-20261017    clang-22   sparse
i386                  randconfig-2301-20261017    clang-22   sparse
i386                  randconfig-2302-20261017    gcc-14     sparse
i386                 randconfig-r2302-20261017    gcc-14     sparse
i386                 randconfig-r2310-20261017    gcc-14     sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261019    clang-24
loongarch             randconfig-1001-20261019    clang-24
loongarch             randconfig-2000-20261017    clang-24
loongarch             randconfig-2001-20261017    clang-24
loongarch            randconfig-r2307-20261017    gcc-16.1.0 sparse
loongarch            randconfig-r2308-20261017    gcc-12.5.0 sparse
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                             mac_defconfig    gcc-16.2.0
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2101-20261017    gcc-8.5.0  cocci
microblaze           randconfig-r2107-20261017    gcc-8.5.0  cocci
microblaze           randconfig-r2303-20261017    gcc-15.2.0 sparse
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                 randconfig-r2304-20261017    clang-24   sparse
mips                        rbtx49xx_defconfig    gcc-16.2.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261019    clang-24
nios2                 randconfig-1001-20261019    clang-24
nios2                 randconfig-2000-20261017    gcc-11.5.0
nios2                 randconfig-2001-20261017    gcc-9.5.0
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc             randconfig-r2202-20261017    gcc-16.1.0 smatch
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261018    clang-24
parisc                randconfig-1001-20261018    clang-24
parisc                randconfig-2000-20261017    gcc-9.5.0
parisc                randconfig-2001-20261017    gcc-15.2.0
parisc               randconfig-r2102-20261017    gcc-8.5.0  cocci
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc               randconfig-1000-20261018    clang-24
powerpc               randconfig-1001-20261018    clang-24
powerpc               randconfig-2000-20261017    clang-24
powerpc               randconfig-2001-20261017    gcc-16.1.0
powerpc              randconfig-r2111-20261017    clang-24   cocci
powerpc              randconfig-r2309-20261017    gcc-12.5.0 sparse
powerpc64             randconfig-1000-20261018    clang-24
powerpc64             randconfig-1001-20261018    clang-24
powerpc64             randconfig-2000-20261017    gcc-8.5.0
powerpc64             randconfig-2001-20261017    clang-24
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261018    clang-17
riscv                 randconfig-1001-20261018    clang-17
riscv                 randconfig-2000-20261017    gcc-14.3.0
riscv                 randconfig-2001-20261017    gcc-12.5.0
riscv                randconfig-r2108-20261017    gcc-8.5.0  cocci
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261018    clang-17
s390                  randconfig-1001-20261018    clang-17
s390                  randconfig-2000-20261017    gcc-8.5.0
s390                  randconfig-2001-20261017    clang-21
s390                 randconfig-r2300-20261017    gcc-12.5.0 sparse
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261018    clang-17
sh                    randconfig-1001-20261018    clang-17
sh                    randconfig-2000-20261017    gcc-15.2.0
sh                    randconfig-2001-20261017    gcc-16.1.0
sh                           rsk7264_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261019    clang-20
sparc                 randconfig-1001-20261019    clang-20
sparc                 randconfig-2000-20261017    gcc-15.2.0
sparc                 randconfig-2001-20261017    gcc-8.5.0
sparc                randconfig-r2106-20261017    gcc-15.2.0 cocci
sparc                randconfig-r2201-20261017    gcc-12.5.0 smatch
sparc                randconfig-r2301-20261017    gcc-11.5.0 sparse
sparc                        sparc64_defconfig    gcc-16.2.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261019    clang-20
sparc64               randconfig-1001-20261019    clang-20
sparc64               randconfig-2000-20261017    clang-24
sparc64               randconfig-2001-20261017    clang-20
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261019    clang-20
um                    randconfig-1001-20261019    clang-20
um                    randconfig-2000-20261017    gcc-14
um                    randconfig-2001-20261017    gcc-14
um                   randconfig-r2200-20261017    gcc-14     smatch
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-24
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261018    clang-22
x86_64                randconfig-1001-20261018    clang-22
x86_64                randconfig-1002-20261018    clang-22
x86_64                randconfig-1003-20261018    clang-22
x86_64                randconfig-1004-20261018    clang-22
x86_64                randconfig-1005-20261018    clang-22
x86_64                randconfig-1006-20261018    clang-22
x86_64                randconfig-1007-20261018    clang-22
x86_64                randconfig-1008-20261018    clang-22
x86_64                randconfig-1009-20261018    clang-22
x86_64                randconfig-1010-20261018    clang-22
x86_64                randconfig-1011-20261018    clang-22
x86_64                randconfig-1012-20261019    gcc-14
x86_64                randconfig-1013-20261019    gcc-14
x86_64                randconfig-1014-20261019    gcc-14
x86_64                randconfig-1015-20261019    gcc-14
x86_64                randconfig-1016-20261019    gcc-14
x86_64                randconfig-1017-20261019    gcc-14
x86_64                randconfig-2000-20261017    clang-22
x86_64                randconfig-2001-20261017    clang-22
x86_64                randconfig-2100-20261017    clang-22   cocci
x86_64                randconfig-2101-20261017    gcc-14     cocci
x86_64                randconfig-2102-20261017    gcc-12     cocci
x86_64                randconfig-2103-20261017    clang-22   cocci
x86_64                randconfig-2104-20261017    clang-22   cocci
x86_64                randconfig-2105-20261017    clang-22   cocci
x86_64                randconfig-2200-20261017    clang-22   smatch
x86_64                randconfig-2300-20261017    gcc-14     sparse
x86_64                randconfig-2301-20261017    gcc-14     sparse
x86_64                randconfig-2302-20261017    clang-22   sparse
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261019    clang-20
xtensa                randconfig-1001-20261019    clang-20
xtensa                randconfig-2000-20261017    gcc-13.4.0
xtensa                randconfig-2001-20261017    gcc-11.5.0
xtensa               randconfig-r2100-20261017    gcc-16.1.0 cocci
xtensa               randconfig-r2305-20261017    gcc-16.1.0 sparse
xtensa                          virt_defconfig    gcc-16.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
