Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76823C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Mar 2022 19:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243577AbiCSTky (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Mar 2022 15:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbiCSTkx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Mar 2022 15:40:53 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126D52529B
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Mar 2022 12:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647718772; x=1679254772;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=cpg9axSMuQQecaI/3UgkNpdCXnm4PQ0n75nNOCdbpoU=;
  b=FHo0HYuG20wQkEEtgClNDY5Nev7cCcN7xMaeWoSNp7KXsdqc5d6cfFM/
   YW4AQK2D36cUO7EH4n4es8ZBT1ry4aoRAQ0vR8eypCs9y1zQqgIgICIXk
   WIWDo3Y54f0CQsUm/fBSW3/oci4gBQuzbh9DqLQBIPY7BATs9pHRxeWRZ
   bKmES8yUfr51RgPmrJZwE1ncAmL3TediB251lBf+iCK659e/43wvUpBPk
   drvESVmi6Rtj/eDEPr+TnSWt/C4A7T+ApbWKj0ZtG3FDLUc7VOFzXhKUv
   w48sHm8lkLpCFBWl1f4LsFNZLx6QXRNVRDsoSHKCnqjp0ztTSFlVGaQPU
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="320527781"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="320527781"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 12:39:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="559214443"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 19 Mar 2022 12:39:30 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVevB-000GFZ-Bk; Sat, 19 Mar 2022 19:39:29 +0000
Date:   Sun, 20 Mar 2022 03:39:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 d5f497b889794161facc1522d86720b587d1c0b7
Message-ID: <62363161.6Rd+xIP02sZkcTx5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: d5f497b889794161facc1522d86720b587d1c0b7  ptp: ocp: use snprintf() in ptp_ocp_verify()

elapsed time: 724m

configs tested: 147
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20220319
nios2                         3c120_defconfig
arm                           tegra_defconfig
powerpc                      tqm8xx_defconfig
mips                           gcw0_defconfig
powerpc                     redwood_defconfig
arm                            pleb_defconfig
sparc                       sparc32_defconfig
sh                          rsk7203_defconfig
arm                           corgi_defconfig
s390                             allmodconfig
powerpc                      arches_defconfig
ia64                          tiger_defconfig
parisc                           allyesconfig
arm                        trizeps4_defconfig
mips                         db1xxx_defconfig
arm                           stm32_defconfig
sh                        apsh4ad0a_defconfig
xtensa                           alldefconfig
powerpc                   motionpro_defconfig
arc                     nsimosci_hs_defconfig
sh                           se7750_defconfig
arm                        clps711x_defconfig
powerpc                        cell_defconfig
sh                         ecovec24_defconfig
mips                 decstation_r4k_defconfig
sh                             sh03_defconfig
sh                           se7724_defconfig
mips                        bcm47xx_defconfig
sh                              ul2_defconfig
sh                        sh7757lcr_defconfig
powerpc                         ps3_defconfig
arc                              allyesconfig
powerpc                mpc7448_hpc2_defconfig
arm                     eseries_pxa_defconfig
alpha                            alldefconfig
um                           x86_64_defconfig
parisc64                            defconfig
sh                     sh7710voipgw_defconfig
arc                          axs101_defconfig
sh                           se7712_defconfig
m68k                       bvme6000_defconfig
m68k                          multi_defconfig
arm                         cm_x300_defconfig
powerpc                     asp8347_defconfig
arm                         assabet_defconfig
arm                           h5000_defconfig
sh                               j2_defconfig
arm                            zeus_defconfig
mips                          rb532_defconfig
sh                           se7721_defconfig
powerpc64                        alldefconfig
mips                        vocore2_defconfig
arm                  randconfig-c002-20220319
arm                  randconfig-c002-20220320
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
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
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a015
arc                  randconfig-r043-20220319
riscv                randconfig-r042-20220319
s390                 randconfig-r044-20220319
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220319
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220319
riscv                randconfig-c006-20220319
mips                 randconfig-c004-20220319
i386                          randconfig-c001
powerpc                      ppc64e_defconfig
arm                   milbeaut_m10v_defconfig
arm                       spear13xx_defconfig
arm                       imx_v4_v5_defconfig
powerpc                      ppc44x_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                        icon_defconfig
powerpc                    ge_imp3a_defconfig
arm                          moxart_defconfig
mips                        workpad_defconfig
arm                         lpc32xx_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                     tqm8560_defconfig
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
hexagon              randconfig-r045-20220319
hexagon              randconfig-r041-20220319

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
