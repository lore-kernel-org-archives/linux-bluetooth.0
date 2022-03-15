Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D3DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Mar 2022 15:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244772AbiCOPSR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Mar 2022 11:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243784AbiCOPSQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Mar 2022 11:18:16 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AF84EA1D
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Mar 2022 08:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647357424; x=1678893424;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=uWgOjMrQY8lDVqkKBQYogb25D86D9FBgpjf55SZvO8g=;
  b=SRRAm+DT6UE37+F3uFZDgsn51u+geeTYgOcjU+q8ecseWVigHkdizWXh
   dgkB+ltY4iVOtbnYGvLW+CtElT3kI8tiA+pVCdOaaq6RlQCDtGpBBCCW6
   mq+iZ5/TclOjsyM+JbQ4Fi62u4/5h2/sWyFqEF8BzpvHhwjCVgbfgJLnx
   Z1Au0MCPxMQngk+sBesI3svFL5UEZPWpxzNt0yyzCGJqsYo7trRz7gjM/
   eiQt3QVnY2M65l3qzgExkMFIeq8QubBDW/Z6b77x3419IsBb0bVyKQP+C
   Kq9xGM/KL0s8OP+bMbIQXCRkIEbO2fRRu++3XM2bHQBAUcYn02XHtptGh
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="319550024"
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="319550024"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 08:17:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="714200766"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 15 Mar 2022 08:16:59 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nU8uw-000B9J-WF; Tue, 15 Mar 2022 15:16:59 +0000
Date:   Tue, 15 Mar 2022 23:16:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD REGRESSION
 29197d4c1f9f313e748bf24cdaaf45066ddfabd1
Message-ID: <6230adb5.nTdJ1ZNCniUt9VBK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 29197d4c1f9f313e748bf24cdaaf45066ddfabd1  Bluetooth: Don't assign twice the same value

Error/Warning reports:

https://lore.kernel.org/linux-bluetooth/202203150608.Rb0JPSVD-lkp@intel.com

Error/Warning:

drivers/net/ethernet/mscc/ocelot.c:2920:14: error: 'IEEE_8021QAZ_MAX_TCS' undeclared (first use in this function)
drivers/net/ethernet/mscc/ocelot.c:2920:21: error: 'IEEE_8021QAZ_MAX_TCS' undeclared (first use in this function)

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-defconfig
|   `-- drivers-net-ethernet-mscc-ocelot.c:error:IEEE_8021QAZ_MAX_TCS-undeclared-(first-use-in-this-function)
`-- i386-randconfig-a001-20220314
    `-- drivers-net-ethernet-mscc-ocelot.c:error:IEEE_8021QAZ_MAX_TCS-undeclared-(first-use-in-this-function)

elapsed time: 871m

configs tested: 118
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
i386                          randconfig-c001
sh                        edosk7760_defconfig
powerpc                     taishan_defconfig
sh                          lboxre2_defconfig
arm                             pxa_defconfig
arc                         haps_hs_defconfig
h8300                    h8300h-sim_defconfig
sh                   secureedge5410_defconfig
csky                             alldefconfig
mips                           jazz_defconfig
powerpc                   currituck_defconfig
sh                           se7343_defconfig
sh                         apsh4a3a_defconfig
sparc64                          alldefconfig
sh                           se7751_defconfig
arm                           stm32_defconfig
arm                            mps2_defconfig
powerpc                       ppc64_defconfig
arm                  randconfig-c002-20220313
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
s390                                defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                               defconfig
sparc                            allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a003-20220314
x86_64               randconfig-a002-20220314
x86_64               randconfig-a001-20220314
x86_64               randconfig-a004-20220314
x86_64               randconfig-a006-20220314
x86_64               randconfig-a005-20220314
i386                 randconfig-a001-20220314
i386                 randconfig-a002-20220314
i386                 randconfig-a004-20220314
i386                 randconfig-a006-20220314
i386                 randconfig-a003-20220314
i386                 randconfig-a005-20220314
arc                  randconfig-r043-20220313
riscv                randconfig-r042-20220313
s390                 randconfig-r044-20220313
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
mips                   sb1250_swarm_defconfig
arm                     davinci_all_defconfig
arm                         s5pv210_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                     ppa8548_defconfig
powerpc                      pmac32_defconfig
arm                         lpc32xx_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a014-20220314
x86_64               randconfig-a013-20220314
x86_64               randconfig-a012-20220314
x86_64               randconfig-a011-20220314
x86_64               randconfig-a016-20220314
x86_64               randconfig-a015-20220314
i386                 randconfig-a012-20220314
i386                 randconfig-a011-20220314
i386                 randconfig-a013-20220314
i386                 randconfig-a014-20220314
i386                 randconfig-a015-20220314
i386                 randconfig-a016-20220314
hexagon              randconfig-r045-20220314
hexagon              randconfig-r045-20220313
riscv                randconfig-r042-20220314
hexagon              randconfig-r041-20220313
hexagon              randconfig-r041-20220314
s390                 randconfig-r044-20220314

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
