Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F32EE6422
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Sep 2023 06:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbjIOGyk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Sep 2023 02:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbjIOGyk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Sep 2023 02:54:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CF62708
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Sep 2023 23:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694760873; x=1726296873;
  h=date:from:to:cc:subject:message-id;
  bh=64bi6C6xhr1ytLauTJr2biazAHGS4WS9rzB9Sd5Ml8Y=;
  b=GKdI9N1+RWxarFTDyb4ZwpraLbggJuLVMLMa2O5sQWCpN0/h4D8Bn7eb
   xqrGU/7dFIJZLdTA6H5TEEeY22jeI0XOWD43La8xe53GrbLbuVUGvL/Js
   KGOTpr6TxZEU8Jmnrw0u590QqUNcIC2HroOsnwiBwZreX6eKjhvVERd91
   jUvAYxUI54AW80MtzarjPU18yD6g29nd4VmfGwNdGlvbxnjtNpbBkDsAX
   CbhU/JK0D92XlqcOd/QQJcNGyKfIz8mxi3M0ytnmfrD8LOlhE82BJAzTk
   ahT9IcHGLZ+QGdg/lJIBENHF1HM1V6Umjl7mRlD9wioqxsjHYSN8TL61V
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="358589902"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="358589902"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 23:54:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="888123441"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="888123441"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 14 Sep 2023 23:53:57 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qh2ij-0002bw-0r;
        Fri, 15 Sep 2023 06:54:29 +0000
Date:   Fri, 15 Sep 2023 14:53:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 e1030955f7aa1c9d1d241a83588c57aa544135a3
Message-ID: <202309151446.EfOpewoj-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: e1030955f7aa1c9d1d241a83588c57aa544135a3  Bluetooth: qca: add support for QCA2066

elapsed time: 724m

configs tested: 148
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230915   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                   randconfig-001-20230915   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230915   gcc  
i386         buildonly-randconfig-002-20230915   gcc  
i386         buildonly-randconfig-003-20230915   gcc  
i386         buildonly-randconfig-004-20230915   gcc  
i386         buildonly-randconfig-005-20230915   gcc  
i386         buildonly-randconfig-006-20230915   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230915   gcc  
i386                  randconfig-002-20230915   gcc  
i386                  randconfig-003-20230915   gcc  
i386                  randconfig-004-20230915   gcc  
i386                  randconfig-005-20230915   gcc  
i386                  randconfig-006-20230915   gcc  
i386                  randconfig-011-20230915   gcc  
i386                  randconfig-012-20230915   gcc  
i386                  randconfig-013-20230915   gcc  
i386                  randconfig-014-20230915   gcc  
i386                  randconfig-015-20230915   gcc  
i386                  randconfig-016-20230915   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230915   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          malta_defconfig   clang
mips                        omega2p_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                          g5_defconfig   clang
powerpc                      mgcoge_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230915   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230915   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20230915   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230915   gcc  
x86_64       buildonly-randconfig-002-20230915   gcc  
x86_64       buildonly-randconfig-003-20230915   gcc  
x86_64       buildonly-randconfig-004-20230915   gcc  
x86_64       buildonly-randconfig-005-20230915   gcc  
x86_64       buildonly-randconfig-006-20230915   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20230915   gcc  
x86_64                randconfig-002-20230915   gcc  
x86_64                randconfig-003-20230915   gcc  
x86_64                randconfig-004-20230915   gcc  
x86_64                randconfig-005-20230915   gcc  
x86_64                randconfig-006-20230915   gcc  
x86_64                randconfig-011-20230915   gcc  
x86_64                randconfig-012-20230915   gcc  
x86_64                randconfig-013-20230915   gcc  
x86_64                randconfig-014-20230915   gcc  
x86_64                randconfig-015-20230915   gcc  
x86_64                randconfig-016-20230915   gcc  
x86_64                randconfig-071-20230915   gcc  
x86_64                randconfig-072-20230915   gcc  
x86_64                randconfig-073-20230915   gcc  
x86_64                randconfig-074-20230915   gcc  
x86_64                randconfig-075-20230915   gcc  
x86_64                randconfig-076-20230915   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
