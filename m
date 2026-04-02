Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058ED1E47CC
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 06:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775112412; cv=none; b=O31/KcVO4eLeGquYR2gzlejdVlTobnUk+qntYgqLb/15AIuJ67r/ApWdR4+XCFGKj/C4eI+YEBPRy+4a8T410sJCIb82arQkEboGVgl5g++SDkrDgPNvUytJm3Am6HXwSS/52Kyf1kvgrkDByRjlnVZ4mw4nxNOS/49oGScAQPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775112412; c=relaxed/simple;
	bh=gAVKWD6+LI3jINFccfSCDiEz5yLYnuoIxU1ZaPOSS8Y=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LM7yr7t5PI3/5qTz2PQHruvjE7B8PAszHXi1JmyF/IJqt8hVdorZzojS+lmn8ENPN/Gsb9IyPvJElSjFsSpYXdsUMUezy9W9C2FyUC3YLckNDMt+IjOExv2+kvw/Cwtby+2njvs7A9MlGvzPKK0S2IFxCOk2j+efOZm4oZIMKUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zg3P458r; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zg3P458r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775112411; x=1806648411;
  h=date:from:to:cc:subject:message-id;
  bh=gAVKWD6+LI3jINFccfSCDiEz5yLYnuoIxU1ZaPOSS8Y=;
  b=Zg3P458r8jWgUwfR2fMw7ymYpIieW5QqApP5Knh6LQIUGt4PO1Q9bo8g
   4NSZG5XKEGt61pr72dsed9WYKcpyaUtjouyXt9NQ7r5wuoBoEiX/pgE1S
   a8m7r6pgB1ki3aAYlNabTuzMtQUJruCWOmVJsHvI7kQIRpCFZr8pidn7j
   uvOZNY/JiXicGQa/3vYlPI7eHSE6V+jnvi3ccONNXvd/srTiJaiL+4TSE
   Py+gdk83Wl8jgQJSvsDRPRUeyOtfZ2P5BcsgPxAlKggupS0ryVknvlLEt
   uxy1h6ZXmRRGmZSv+fzc3XAAj//x1X7JFABQSarZJ0XvWj3CsHBJTL1SQ
   g==;
X-CSE-ConnectionGUID: lsN4w0lkTiCTBdKGsJXQRA==
X-CSE-MsgGUID: RgbNnvsgRxO2YD08GAXZJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="76130496"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="76130496"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 23:46:51 -0700
X-CSE-ConnectionGUID: g91NbO3lTlC/EHU4ho2WmQ==
X-CSE-MsgGUID: aHiIUmYHTbSTv4bd15Sgnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="231298413"
Received: from lkp-server02.sh.intel.com (HELO cedfeeed6c12) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 01 Apr 2026 23:46:50 -0700
Received: from kbuild by cedfeeed6c12 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w8BpG-000000000BK-2nm5;
	Thu, 02 Apr 2026 06:46:46 +0000
Date: Thu, 02 Apr 2026 10:01:03 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS WITH WARNING
 b65fdb465d5475e9ec1b70aa38b3fd79e237a089
Message-ID: <202604021055.CPVbrLG4-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: b65fdb465d5475e9ec1b70aa38b3fd79e237a089  Bluetooth: btusb: Add MT7927 ID for ASUS X870E / ProArt X870E-Creator

Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202604012104.Gah2a7JG-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202604012134.9zH5FiWa-lkp@intel.com

    drivers/bluetooth/btmtk.c:35:3: warning: 'btmtk_mt6639_devs' defined but not used [-Wunused-const-variable=]
    drivers/bluetooth/btmtk.c:35:3: warning: unused variable 'btmtk_mt6639_devs' [-Wunused-const-variable]

Warning ids grouped by kconfigs:

recent_errors
|-- arm64-randconfig-001-20260401
|   `-- drivers-bluetooth-btmtk.c:warning:unused-variable-btmtk_mt6639_devs
|-- i386-randconfig-015-20260401
|   `-- drivers-bluetooth-btmtk.c:warning:unused-variable-btmtk_mt6639_devs
|-- i386-randconfig-017-20260401
|   `-- drivers-bluetooth-btmtk.c:warning:btmtk_mt6639_devs-defined-but-not-used
|-- powerpc64-randconfig-002-20260401
|   `-- drivers-bluetooth-btmtk.c:warning:btmtk_mt6639_devs-defined-but-not-used
|-- sparc64-randconfig-001-20260401
|   `-- drivers-bluetooth-btmtk.c:warning:unused-variable-btmtk_mt6639_devs
|-- x86_64-randconfig-005-20260401
|   `-- drivers-bluetooth-btmtk.c:warning:unused-variable-btmtk_mt6639_devs
|-- x86_64-randconfig-012-20260401
|   `-- drivers-bluetooth-btmtk.c:warning:btmtk_mt6639_devs-defined-but-not-used
|-- x86_64-randconfig-016-20260401
|   `-- drivers-bluetooth-btmtk.c:warning:btmtk_mt6639_devs-defined-but-not-used
`-- x86_64-randconfig-161-20260401
    `-- drivers-bluetooth-btmtk.c:warning:btmtk_mt6639_devs-defined-but-not-used

elapsed time: 1531m

configs tested: 149
configs skipped: 7

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260401    gcc-8.5.0
arc                   randconfig-002-20260401    gcc-11.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260401    clang-23
arm                   randconfig-002-20260401    clang-23
arm                   randconfig-003-20260401    clang-23
arm                   randconfig-004-20260401    gcc-12.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260401    clang-18
arm64                 randconfig-002-20260401    gcc-8.5.0
arm64                 randconfig-003-20260401    gcc-8.5.0
arm64                 randconfig-004-20260401    gcc-11.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260401    gcc-13.4.0
csky                  randconfig-002-20260401    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260401    clang-23
hexagon               randconfig-002-20260401    clang-17
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260401    gcc-14
i386        buildonly-randconfig-002-20260401    clang-20
i386        buildonly-randconfig-003-20260401    gcc-14
i386        buildonly-randconfig-004-20260401    gcc-14
i386        buildonly-randconfig-005-20260401    gcc-14
i386        buildonly-randconfig-006-20260401    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260401    gcc-14
i386                  randconfig-003-20260401    clang-20
i386                  randconfig-004-20260401    gcc-12
i386                  randconfig-005-20260401    gcc-14
i386                  randconfig-006-20260401    gcc-14
i386                  randconfig-007-20260401    gcc-14
i386                  randconfig-011-20260401    clang-20
i386                  randconfig-012-20260401    clang-20
i386                  randconfig-013-20260401    clang-20
i386                  randconfig-014-20260401    clang-20
i386                  randconfig-015-20260401    clang-20
i386                  randconfig-016-20260401    gcc-14
i386                  randconfig-017-20260401    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260401    gcc-15.2.0
loongarch             randconfig-002-20260401    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                       alldefconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260401    gcc-8.5.0
nios2                 randconfig-002-20260401    gcc-9.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                randconfig-001-20260401    gcc-8.5.0
parisc                randconfig-002-20260401    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260401    gcc-8.5.0
powerpc64             randconfig-001-20260401    gcc-14.3.0
powerpc64             randconfig-002-20260401    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20260401    gcc-8.5.0
riscv                 randconfig-002-20260401    gcc-11.5.0
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                  randconfig-001-20260401    gcc-9.5.0
s390                  randconfig-002-20260401    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260401    gcc-10.5.0
sh                    randconfig-002-20260401    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                 randconfig-001-20260401    gcc-8.5.0
sparc                 randconfig-002-20260401    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260401    clang-23
sparc64               randconfig-002-20260401    clang-23
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260401    clang-16
um                    randconfig-002-20260401    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260401    gcc-14
x86_64      buildonly-randconfig-002-20260401    gcc-14
x86_64      buildonly-randconfig-003-20260401    gcc-12
x86_64      buildonly-randconfig-004-20260401    gcc-12
x86_64      buildonly-randconfig-005-20260401    clang-20
x86_64      buildonly-randconfig-006-20260401    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260401    gcc-14
x86_64                randconfig-002-20260401    clang-20
x86_64                randconfig-003-20260401    gcc-14
x86_64                randconfig-004-20260401    gcc-14
x86_64                randconfig-005-20260401    clang-20
x86_64                randconfig-006-20260401    clang-20
x86_64                randconfig-011-20260401    gcc-14
x86_64                randconfig-012-20260401    gcc-14
x86_64                randconfig-013-20260401    gcc-14
x86_64                randconfig-014-20260401    clang-20
x86_64                randconfig-015-20260401    clang-20
x86_64                randconfig-016-20260401    gcc-14
x86_64                randconfig-071-20260401    gcc-14
x86_64                randconfig-072-20260401    clang-20
x86_64                randconfig-073-20260401    gcc-14
x86_64                randconfig-074-20260401    gcc-14
x86_64                randconfig-075-20260401    clang-20
x86_64                randconfig-076-20260401    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260401    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
