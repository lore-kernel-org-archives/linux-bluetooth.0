Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E9E381E84
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789571507; cv=none; b=uk/ObjqKhLnBPh7JYil+8llHsQTpMWfjmcfqzWu3eQ5Ncr512uUNe4QYtpQ5Yo6a4tmOMe8gGeXyy2koqeWy5QgosHJqCh4Rou8LOeS3UOHuE5+TNy3/Olzs4XonlzV3Wqnxe2r02Z39ceweUDwQyjXfpWWWxQk90iSnwLI99F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789571507; c=relaxed/simple;
	bh=Cs75q37vnuvyAnRURkp8QkHE78+g5AuUbCOCFitvowU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Qzi4kefcSyZjVjiD2QHcsoJ1c0Z3kxc9HJBIcsy5+P70ZJaV2KLta5DbXOb/JO+lbuWcXeY2wcyQubkBre4uXPvLfxIsMxNkyLUWlx96OLy3JjzjyPRjRxDQbDfMOz41nqdljwCg2d5KNtNoZ39SWqe7NqBnyPSumAhyVCB7xoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PH0ivFm9; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PH0ivFm9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789571505; x=1821107505;
  h=date:from:to:cc:subject:message-id;
  bh=Cs75q37vnuvyAnRURkp8QkHE78+g5AuUbCOCFitvowU=;
  b=PH0ivFm9Ib7ZPEOh9K670d31p9aIE/Soigk8jvl0dRdyq2m2eMWTsf47
   nNc2MgB6VqEq9cypP6sfyDvkl5EKRzih3WctRtZtLI0IFZIig3zcISa03
   G7Dqlhme+oSfcSniVc77ll+9LhnSyDN95WpWfwfkjfdz/fE0LWAzl5rEo
   QVBsS3ajPwd6fLhonT8To2TdxghImMJDzAX3b0O118zKA+y1BOgtFxxTQ
   hyvTaUAqsRbzmFMCA/QEBo01rOq+YixhaezR7p4hr4CsST6TBWSnEBdRP
   BZy3v6N1AHZNLR/AVXRDFhWj85I/tznPHth6DeaWhP9ImB86vuv2Jp1QN
   g==;
X-CSE-ConnectionGUID: vlwawZyURduRZb/fS6pKiw==
X-CSE-MsgGUID: X0/xKkaxSay/dkq3ihyWDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89087335"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89087335"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 08:11:44 -0700
X-CSE-ConnectionGUID: mTEmGcMVTzO00EliBldEiw==
X-CSE-MsgGUID: r6hXUYH1SV2Yw8Zf5Lvk/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="272898470"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 16 Sep 2026 08:11:43 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x6rIS-000000006Gr-2v4p;
	Wed, 16 Sep 2026 15:11:40 +0000
Date: Wed, 16 Sep 2026 23:10:47 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 0186e4e1e5c26a21058a263cccd878fbf894677e
Message-ID: <202609162334.CJXqnqiL-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 0186e4e1e5c26a21058a263cccd878fbf894677e  Bluetooth: RFCOMM: avoid socket lock inversion in listener cleanup

elapsed time: 2851m

configs tested: 239
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                 randconfig-r073-20260915    gcc-14.3.0
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-r071-20260915    gcc-14.3.0
arc                  randconfig-r1300-20260916    gcc-14     sparse
arc                            tb10x_defconfig    clang-17
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                              mxs_defconfig    clang-17
arm                          orion5x_defconfig    clang-17
arm                   randconfig-r052-20260915    gcc-9.5.0
arm                   randconfig-r061-20260915    clang-22
arm                   randconfig-r062-20260915    clang-24
arm                  randconfig-r1306-20260916    clang-18   sparse
arm                  randconfig-r1308-20260916    clang-18   sparse
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260916    gcc-14.3.0
arm64                 randconfig-1001-20260916    gcc-14.3.0
arm64                 randconfig-1002-20260916    gcc-14.3.0
arm64                 randconfig-1003-20260916    gcc-14.3.0
arm64                 randconfig-r064-20260915    clang-22
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260916    gcc-14.3.0
csky                  randconfig-1001-20260916    gcc-14.3.0
csky                  randconfig-r054-20260915    gcc-15.2.0
csky                  randconfig-r073-20260914    gcc-11.5.0
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260916    gcc-16.1.0
hexagon               randconfig-1001-20260916    gcc-16.1.0
hexagon               randconfig-r061-20260914    clang-22
hexagon               randconfig-r071-20260914    clang-24
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20260916    clang-22
i386        buildonly-randconfig-1001-20260916    clang-22
i386        buildonly-randconfig-1002-20260916    clang-22
i386        buildonly-randconfig-1003-20260916    clang-22
i386        buildonly-randconfig-1004-20260916    clang-22
i386        buildonly-randconfig-1005-20260916    clang-22
i386                                 defconfig    gcc-16.1.0
i386                   randconfig-051-20260914    clang-22
i386                   randconfig-051-20260915    clang-22
i386                   randconfig-052-20260914    clang-22
i386                   randconfig-052-20260915    clang-22
i386                   randconfig-053-20260914    clang-22
i386                   randconfig-053-20260915    clang-22
i386                   randconfig-054-20260914    clang-22
i386                   randconfig-054-20260915    clang-22
i386                  randconfig-1000-20260916    gcc-14
i386                  randconfig-1001-20260916    gcc-14
i386                  randconfig-1002-20260916    gcc-14
i386                  randconfig-1003-20260916    gcc-14
i386                  randconfig-1004-20260916    gcc-14
i386                  randconfig-1005-20260916    gcc-14
i386                  randconfig-1006-20260916    gcc-14
i386                  randconfig-1007-20260916    clang-22
i386                  randconfig-1008-20260916    clang-22
i386                  randconfig-1009-20260916    clang-22
i386                  randconfig-1010-20260916    clang-22
i386                  randconfig-1011-20260916    clang-22
i386                  randconfig-1012-20260916    clang-22
i386                  randconfig-1013-20260916    clang-22
i386                  randconfig-1300-20260916    clang-22   sparse
i386                  randconfig-1301-20260916    clang-22   sparse
i386                  randconfig-1302-20260916    clang-22   sparse
i386                   randconfig-141-20260914    gcc-14
i386                   randconfig-141-20260915    clang-22
i386                  randconfig-r051-20260915    gcc-9.5.0
i386                  randconfig-r072-20260914    clang-22
i386                 randconfig-r1301-20260916    gcc-14     sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260916    gcc-16.1.0
loongarch             randconfig-1001-20260916    gcc-16.1.0
loongarch             randconfig-r051-20260914    gcc-15.2.0
loongarch             randconfig-r052-20260915    gcc-15.2.0
loongarch             randconfig-r054-20260915    clang-22
loongarch             randconfig-r062-20260915    gcc-13
loongarch            randconfig-r1305-20260916    gcc-14     sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                        m5282evb_defconfig    clang-17
m68k                  randconfig-r061-20260915    clang-24
m68k                  randconfig-r064-20260915    gcc-13
m68k                 randconfig-r1303-20260916    gcc-14     sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze            randconfig-r053-20260915    clang-22
microblaze            randconfig-r053-20260915    gcc-9.5.0
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                  randconfig-r054-20260915    gcc-9.5.0
mips                    sb1250_swarm_defconfig    clang-17
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20260916    gcc-16.1.0
nios2                 randconfig-1001-20260916    gcc-16.1.0
nios2                 randconfig-r053-20260914    gcc-15.2.0
nios2                 randconfig-r063-20260915    gcc-13
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260916    gcc-10.5.0
parisc                randconfig-1001-20260916    gcc-10.5.0
parisc                randconfig-r072-20260915    gcc-8.5.0
parisc               randconfig-r1304-20260916    gcc-14     sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc               randconfig-1000-20260916    gcc-10.5.0
powerpc               randconfig-1001-20260916    gcc-10.5.0
powerpc               randconfig-r053-20260915    gcc-15.2.0
powerpc               randconfig-r054-20260914    gcc-15.2.0
powerpc               randconfig-r063-20260914    clang-22
powerpc               randconfig-r063-20260915    clang-24
powerpc               randconfig-r064-20260915    clang-24
powerpc               randconfig-r072-20260915    gcc-9.5.0
powerpc              randconfig-r1307-20260916    clang-18   sparse
powerpc64             randconfig-1000-20260916    gcc-10.5.0
powerpc64             randconfig-1001-20260916    gcc-10.5.0
powerpc64             randconfig-r071-20260915    gcc-10.5.0
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-r051-20260915    gcc-15.2.0
s390                  randconfig-r063-20260915    clang-22
s390                  randconfig-r072-20260915    gcc-9.5.0
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                              espt_defconfig    clang-17
sh                    randconfig-r051-20260915    clang-22
sh                              shx3_defconfig    clang-17
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260916    clang-24
sparc                 randconfig-1001-20260916    clang-24
sparc                 randconfig-r052-20260914    gcc-15.2.0
sparc                randconfig-r1309-20260916    clang-18   sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260916    clang-24
sparc64               randconfig-1001-20260916    clang-24
sparc64               randconfig-r064-20260914    clang-22
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260916    clang-24
um                    randconfig-1001-20260916    clang-24
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20260916    gcc-14
x86_64      buildonly-randconfig-1001-20260916    gcc-14
x86_64      buildonly-randconfig-1002-20260916    gcc-14
x86_64      buildonly-randconfig-1003-20260916    gcc-14
x86_64      buildonly-randconfig-1004-20260916    gcc-14
x86_64      buildonly-randconfig-1005-20260916    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260916    clang-22
x86_64                randconfig-1001-20260916    clang-22
x86_64                randconfig-1002-20260916    clang-22
x86_64                randconfig-1003-20260916    clang-22
x86_64                randconfig-1004-20260916    clang-22
x86_64                randconfig-1005-20260916    clang-22
x86_64                randconfig-1006-20260916    clang-22
x86_64                randconfig-1007-20260916    clang-22
x86_64                randconfig-1008-20260916    clang-22
x86_64                randconfig-1009-20260916    clang-22
x86_64                 randconfig-101-20260914    gcc-14
x86_64                 randconfig-101-20260915    clang-22
x86_64                randconfig-1010-20260916    clang-22
x86_64                randconfig-1011-20260916    clang-22
x86_64                 randconfig-102-20260914    gcc-14
x86_64                 randconfig-102-20260915    clang-22
x86_64                 randconfig-103-20260914    gcc-14
x86_64                 randconfig-103-20260915    clang-22
x86_64                 randconfig-104-20260914    gcc-14
x86_64                 randconfig-104-20260915    clang-22
x86_64                randconfig-1300-20260916    clang-22   sparse
x86_64                randconfig-1301-20260916    clang-22   sparse
x86_64                randconfig-1302-20260916    clang-22   sparse
x86_64                 randconfig-161-20260914    clang-22
x86_64                 randconfig-161-20260915    clang-22
x86_64                randconfig-r052-20260915    clang-22
x86_64                randconfig-r061-20260915    gcc-13
x86_64                randconfig-r062-20260914    clang-22
x86_64                randconfig-r062-20260915    clang-22
x86_64                randconfig-r071-20260915    clang-22
x86_64                randconfig-r073-20260915    gcc-14
x86_64               randconfig-r1302-20260916    gcc-14     sparse
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20260916    clang-24
xtensa                randconfig-1001-20260916    clang-24

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
