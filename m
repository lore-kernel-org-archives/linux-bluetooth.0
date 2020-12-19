Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58244C4361B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Dec 2020 10:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A34A23BDE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Dec 2020 10:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgLSKpy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Dec 2020 05:45:54 -0500
Received: from mga11.intel.com ([192.55.52.93]:28261 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgLSKpy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Dec 2020 05:45:54 -0500
IronPort-SDR: 7MS+ff1CpOEFku6uXZD5bPpdxrky1S6cIBXLpoC7QA2JYVd3+zornSfdgEshrGx/QmBKS4fclc
 2zlZr8BZ4cBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9839"; a="172059695"
X-IronPort-AV: E=Sophos;i="5.78,433,1599548400"; 
   d="scan'208";a="172059695"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2020 02:45:13 -0800
IronPort-SDR: xeJLHuR1lr3hPcS5tMP4BhHi1/nnVs9pUXmwFsZDFxBG2SMTVn5VJ5guZgnN6f3hFFE4HYklnz
 MkJIT9oeHDyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,433,1599548400"; 
   d="scan'208";a="414613831"
Received: from lkp-server02.sh.intel.com (HELO c4fb2a2464e8) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 19 Dec 2020 02:45:12 -0800
Received: from kbuild by c4fb2a2464e8 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kqZjb-0000iJ-NZ; Sat, 19 Dec 2020 10:45:11 +0000
Date:   Sat, 19 Dec 2020 18:44:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 89e65975fea5c25706e8cc3a89f9f97b20fc45ad
Message-ID: <5fddd983.ECKsfoyYkRvnh0wF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git  master
branch HEAD: 89e65975fea5c25706e8cc3a89f9f97b20fc45ad  Bluetooth: Cancel Inquiry before Create Connection

elapsed time: 720m

configs tested: 124
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
parisc                              defconfig
sh                               allmodconfig
powerpc                 mpc8560_ads_defconfig
sh                   secureedge5410_defconfig
powerpc                   motionpro_defconfig
parisc                           alldefconfig
arm                           omap1_defconfig
mips                            e55_defconfig
powerpc                      ep88xc_defconfig
xtensa                    xip_kc705_defconfig
alpha                               defconfig
powerpc                      ppc40x_defconfig
powerpc                 mpc834x_mds_defconfig
arm                           sama5_defconfig
powerpc                    klondike_defconfig
riscv                            alldefconfig
arm                           viper_defconfig
arm                         orion5x_defconfig
arm                         shannon_defconfig
ia64                                defconfig
mips                      maltasmvp_defconfig
arm                            zeus_defconfig
sh                            titan_defconfig
powerpc                           allnoconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
sh                        edosk7760_defconfig
powerpc                     asp8347_defconfig
mips                       lemote2f_defconfig
arm                          pxa3xx_defconfig
arm                         at91_dt_defconfig
mips                     cu1000-neo_defconfig
powerpc                     sequoia_defconfig
arm                     davinci_all_defconfig
arm                       mainstone_defconfig
m68k                        mvme16x_defconfig
sh                           se7343_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                     sbc8548_defconfig
mips                    maltaup_xpa_defconfig
powerpc                 canyonlands_defconfig
m68k                                defconfig
arm                        spear3xx_defconfig
sh                          urquell_defconfig
sh                          rsk7264_defconfig
mips                       capcella_defconfig
xtensa                  nommu_kc705_defconfig
m68k                         apollo_defconfig
sh                         apsh4a3a_defconfig
arm                          tango4_defconfig
mips                  decstation_64_defconfig
i386                             alldefconfig
mips                      fuloong2e_defconfig
riscv                               defconfig
arm                            mps2_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a003-20201217
x86_64               randconfig-a006-20201217
x86_64               randconfig-a002-20201217
x86_64               randconfig-a005-20201217
x86_64               randconfig-a004-20201217
x86_64               randconfig-a001-20201217
i386                 randconfig-a001-20201217
i386                 randconfig-a004-20201217
i386                 randconfig-a003-20201217
i386                 randconfig-a002-20201217
i386                 randconfig-a006-20201217
i386                 randconfig-a005-20201217
i386                 randconfig-a014-20201217
i386                 randconfig-a013-20201217
i386                 randconfig-a012-20201217
i386                 randconfig-a011-20201217
i386                 randconfig-a015-20201217
i386                 randconfig-a016-20201217
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a016-20201217
x86_64               randconfig-a012-20201217
x86_64               randconfig-a013-20201217
x86_64               randconfig-a015-20201217
x86_64               randconfig-a014-20201217
x86_64               randconfig-a011-20201217

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
