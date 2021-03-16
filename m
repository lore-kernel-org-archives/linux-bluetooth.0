Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAFDC433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 09:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B25C164D9E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 09:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbhCPJja (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 05:39:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:32327 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232168AbhCPJjH (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 05:39:07 -0400
IronPort-SDR: VcrkphvZNvZWCctNc8Tvyy5ZXL99AKJegrmMmDm/KUp5o50pcC/UnnS2rjDw4vBD8K9ap/hM8i
 iFBqDm6R2PlQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="185869129"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="185869129"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 02:39:06 -0700
IronPort-SDR: 1Qhl+dsgRzXXRw+Z3N+8vBK8IVAR2NptlWFYVnhV1jvZZIuwPt6K8eWw8NJg+FezCiToabu9XE
 QJf/mRi+yZjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="388407757"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 16 Mar 2021 02:39:05 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lM6AK-00005h-RD; Tue, 16 Mar 2021 09:39:04 +0000
Date:   Tue, 16 Mar 2021 17:38:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 7cf3b1dd6aa603fd80969e9e7160becf1455a0eb
Message-ID: <60507c99.NrGCXXTsEr/x1PyU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 7cf3b1dd6aa603fd80969e9e7160becf1455a0eb  Bluetooth: L2CAP: Fix not checking for maximum number of DCID

elapsed time: 725m

configs tested: 136
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
x86_64                           allyesconfig
h8300                     edosk2674_defconfig
powerpc                    amigaone_defconfig
powerpc                 linkstation_defconfig
m68k                        m5407c3_defconfig
arc                 nsimosci_hs_smp_defconfig
openrisc                 simple_smp_defconfig
mips                      malta_kvm_defconfig
arm                          exynos_defconfig
ia64                         bigsur_defconfig
arm                            dove_defconfig
arm                       mainstone_defconfig
m68k                        mvme16x_defconfig
arm                         mv78xx0_defconfig
mips                       rbtx49xx_defconfig
h8300                    h8300h-sim_defconfig
h8300                               defconfig
nds32                            alldefconfig
arc                      axs103_smp_defconfig
arm                           u8500_defconfig
powerpc                      ppc6xx_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                         ps3_defconfig
arm                       omap2plus_defconfig
powerpc                        fsp2_defconfig
powerpc                     tqm8555_defconfig
sh                            migor_defconfig
mips                         bigsur_defconfig
mips                      bmips_stb_defconfig
sh                             espt_defconfig
arm                            xcep_defconfig
mips                        workpad_defconfig
mips                      fuloong2e_defconfig
mips                      pic32mzda_defconfig
m68k                          amiga_defconfig
arc                         haps_hs_defconfig
mips                           xway_defconfig
arm                       versatile_defconfig
arm                         lpc32xx_defconfig
sh                            shmin_defconfig
mips                           ip32_defconfig
powerpc                     mpc5200_defconfig
parisc                generic-64bit_defconfig
arm                            hisi_defconfig
riscv                               defconfig
powerpc                 mpc836x_mds_defconfig
arc                          axs101_defconfig
sh                           se7206_defconfig
arm                       spear13xx_defconfig
mips                      maltasmvp_defconfig
arm                          imote2_defconfig
powerpc                   motionpro_defconfig
arm                           h3600_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                          g5_defconfig
arm                         orion5x_defconfig
powerpc                 mpc837x_rdb_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
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
powerpc                           allnoconfig
x86_64               randconfig-a006-20210315
x86_64               randconfig-a001-20210315
x86_64               randconfig-a005-20210315
x86_64               randconfig-a004-20210315
x86_64               randconfig-a002-20210315
x86_64               randconfig-a003-20210315
i386                 randconfig-a001-20210315
i386                 randconfig-a005-20210315
i386                 randconfig-a003-20210315
i386                 randconfig-a002-20210315
i386                 randconfig-a004-20210315
i386                 randconfig-a006-20210315
i386                 randconfig-a001-20210316
i386                 randconfig-a005-20210316
i386                 randconfig-a002-20210316
i386                 randconfig-a003-20210316
i386                 randconfig-a004-20210316
i386                 randconfig-a006-20210316
i386                 randconfig-a013-20210315
i386                 randconfig-a016-20210315
i386                 randconfig-a011-20210315
i386                 randconfig-a012-20210315
i386                 randconfig-a014-20210315
i386                 randconfig-a015-20210315
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20210315
x86_64               randconfig-a016-20210315
x86_64               randconfig-a013-20210315
x86_64               randconfig-a015-20210315
x86_64               randconfig-a014-20210315
x86_64               randconfig-a012-20210315

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
