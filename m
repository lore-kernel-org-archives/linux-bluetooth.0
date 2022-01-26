Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8BEC28CF5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jan 2022 12:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241218AbiAZMW4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jan 2022 07:22:56 -0500
Received: from mga05.intel.com ([192.55.52.43]:16441 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241286AbiAZMWz (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jan 2022 07:22:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643199775; x=1674735775;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=hgA0BxvZDvRZeOoJawMqHQFXxBcK8EUzBCH/n39g608=;
  b=NV5SlDU4gBH5st95ExKzxgDEIsQIumo+B7tnn6vN1VCzvb72gXGj2fDv
   uWhGZvC5CC5X/fGduzBtGzvTHSl5s9KbGt9U7YVZ95oFZqJf3oc/8X/Ms
   3XAUYDxmB2axE/ZK0vvlQ8WYN1rJMESaFVQ7tBgABEnD0Ei/Mf5D5Zzk2
   xLS3MtOiaclifR3mgZF9qyLSSl4KMRJ7dZZa1QNL9Z6mqij6+R6hnKJuT
   z6f6CAfTU3g/iMfQfmB3PHhlR0IH/MFsQRTYpaMgEkf9iAmJrFQ1XJpiA
   sREa4qp//YiEKjV0nk414Zh5qqm7ZZUKT4N7R9MU6sOhbvXwsavjWwlfP
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="332891893"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="332891893"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 04:22:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="628289226"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Jan 2022 04:22:53 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nChK8-000LB4-OL; Wed, 26 Jan 2022 12:22:52 +0000
Date:   Wed, 26 Jan 2022 20:22:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 314d8cd2787418c5ac6b02035c344644f47b292b
Message-ID: <61f13d0b.2oGdfeiPQD4dMepl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 314d8cd2787418c5ac6b02035c344644f47b292b  Bluetooth: hci_event: Fix HCI_EV_VENDOR max_len

elapsed time: 724m

configs tested: 158
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220124
i386                          randconfig-c001
powerpc              randconfig-c003-20220124
sh                           se7206_defconfig
powerpc                     redwood_defconfig
arm                        spear6xx_defconfig
powerpc                mpc7448_hpc2_defconfig
riscv                    nommu_k210_defconfig
m68k                        m5407c3_defconfig
sh                ecovec24-romimage_defconfig
powerpc                     rainier_defconfig
powerpc                    sam440ep_defconfig
h8300                       h8s-sim_defconfig
sh                         ap325rxa_defconfig
powerpc                         ps3_defconfig
nios2                            alldefconfig
sh                 kfr2r09-romimage_defconfig
sh                          urquell_defconfig
mips                         cobalt_defconfig
openrisc                  or1klitex_defconfig
arc                         haps_hs_defconfig
sh                        apsh4ad0a_defconfig
arm                        trizeps4_defconfig
sh                           se7780_defconfig
mips                            ar7_defconfig
mips                        vocore2_defconfig
arm                      jornada720_defconfig
mips                             allmodconfig
mips                         rt305x_defconfig
arm                        mini2440_defconfig
ia64                             alldefconfig
arc                        nsimosci_defconfig
arc                          axs101_defconfig
arm                          gemini_defconfig
arm                     eseries_pxa_defconfig
arc                        nsim_700_defconfig
alpha                            alldefconfig
xtensa                          iss_defconfig
sh                           se7619_defconfig
sh                         apsh4a3a_defconfig
um                               alldefconfig
sh                           se7721_defconfig
powerpc                     tqm8541_defconfig
openrisc                            defconfig
i386                                defconfig
arm                            zeus_defconfig
nios2                         10m50_defconfig
powerpc                 mpc834x_mds_defconfig
s390                             allyesconfig
sh                          sdk7780_defconfig
arc                            hsdk_defconfig
mips                  decstation_64_defconfig
xtensa                           alldefconfig
arc                                 defconfig
powerpc                       ppc64_defconfig
mips                            gpr_defconfig
sh                           se7724_defconfig
powerpc                     ep8248e_defconfig
sh                             espt_defconfig
powerpc                        warp_defconfig
mips                      fuloong2e_defconfig
sh                          landisk_defconfig
arm                           stm32_defconfig
arm                  randconfig-c002-20220124
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
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                              debian-10.3
sparc                               defconfig
i386                   debian-10.3-kselftests
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20220124
x86_64               randconfig-a003-20220124
x86_64               randconfig-a001-20220124
x86_64               randconfig-a004-20220124
x86_64               randconfig-a005-20220124
x86_64               randconfig-a006-20220124
i386                 randconfig-a002-20220124
i386                 randconfig-a005-20220124
i386                 randconfig-a003-20220124
i386                 randconfig-a004-20220124
i386                 randconfig-a001-20220124
i386                 randconfig-a006-20220124
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220124
riscv                randconfig-c006-20220124
i386                 randconfig-c001-20220124
powerpc              randconfig-c003-20220124
mips                 randconfig-c004-20220124
x86_64               randconfig-c007-20220124
powerpc                      katmai_defconfig
powerpc                   lite5200b_defconfig
arm                           omap1_defconfig
powerpc                    socrates_defconfig
arm                         orion5x_defconfig
powerpc                        fsp2_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a011-20220124
x86_64               randconfig-a013-20220124
x86_64               randconfig-a015-20220124
x86_64               randconfig-a016-20220124
x86_64               randconfig-a014-20220124
x86_64               randconfig-a012-20220124
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                 randconfig-a011-20220124
i386                 randconfig-a016-20220124
i386                 randconfig-a013-20220124
i386                 randconfig-a014-20220124
i386                 randconfig-a015-20220124
i386                 randconfig-a012-20220124
riscv                randconfig-r042-20220124
hexagon              randconfig-r045-20220124
hexagon              randconfig-r041-20220124

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
