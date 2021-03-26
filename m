Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AAAC433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Mar 2021 19:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D02C619F2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Mar 2021 19:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhCZTpJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Mar 2021 15:45:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:17949 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230266AbhCZTpB (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Mar 2021 15:45:01 -0400
IronPort-SDR: Yy+XOSfHvSBOsNV6VgKOTzOYIubZ6SsuFeHbunDb+gkfKNDTHd1vAGFF1ekQJ1SCyvWRjIYsdJ
 deVG2GKSJvAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="276353377"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="276353377"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 12:45:01 -0700
IronPort-SDR: XiLhf3KDw3Ao5M7ElAP7+uSWZvHWCielKv3ggpRn3qa0k2eQEVyDMrhlXjtOeyuN3wANzicjm5
 3JM7tf9Ayf0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="443930746"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Mar 2021 12:44:59 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lPsOB-0002xv-9t; Fri, 26 Mar 2021 19:44:59 +0000
Date:   Sat, 27 Mar 2021 03:44:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 5153ceb9e622f4e27de461404edc73324da70f8c
Message-ID: <605e39b6.Jhv6j6tv2Mhhcfzh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 5153ceb9e622f4e27de461404edc73324da70f8c  Bluetooth: L2CAP: Rudimentary typo fixes

elapsed time: 723m

configs tested: 188
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
powerpc                     mpc5200_defconfig
arm                        shmobile_defconfig
powerpc                     ep8248e_defconfig
um                               allyesconfig
powerpc                     ksi8560_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                      cm5200_defconfig
powerpc                         wii_defconfig
arm                      jornada720_defconfig
powerpc                    adder875_defconfig
powerpc                      walnut_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                      loongson3_defconfig
mips                       lemote2f_defconfig
powerpc                    sam440ep_defconfig
sh                           se7750_defconfig
arm                        clps711x_defconfig
sh                               alldefconfig
mips                        nlm_xlr_defconfig
arm                       spear13xx_defconfig
mips                         tb0287_defconfig
arm                         s3c6400_defconfig
powerpc                     rainier_defconfig
powerpc64                        alldefconfig
arm                          moxart_defconfig
openrisc                            defconfig
sh                         microdev_defconfig
arm                          ixp4xx_defconfig
nios2                         10m50_defconfig
powerpc                       holly_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                         orion5x_defconfig
mips                         tb0219_defconfig
sh                          r7780mp_defconfig
arm                             mxs_defconfig
um                             i386_defconfig
powerpc                     tqm8560_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                      pasemi_defconfig
ia64                          tiger_defconfig
mips                      pistachio_defconfig
powerpc                 mpc837x_mds_defconfig
m68k                        m5307c3_defconfig
sh                               j2_defconfig
powerpc                      acadia_defconfig
mips                         cobalt_defconfig
powerpc                  iss476-smp_defconfig
h8300                       h8s-sim_defconfig
arm                           h3600_defconfig
arm                        mvebu_v7_defconfig
openrisc                 simple_smp_defconfig
powerpc                     ppa8548_defconfig
powerpc                      pcm030_defconfig
mips                            ar7_defconfig
xtensa                  audio_kc705_defconfig
arm                          pxa168_defconfig
arm                           sunxi_defconfig
powerpc                      bamboo_defconfig
mips                         mpc30x_defconfig
mips                       rbtx49xx_defconfig
arm                       cns3420vb_defconfig
powerpc                     asp8347_defconfig
mips                          ath25_defconfig
mips                  decstation_64_defconfig
um                            kunit_defconfig
riscv                               defconfig
mips                        nlm_xlp_defconfig
mips                     cu1830-neo_defconfig
mips                         db1xxx_defconfig
m68k                       bvme6000_defconfig
mips                    maltaup_xpa_defconfig
mips                          rb532_defconfig
mips                 decstation_r4k_defconfig
powerpc                      ppc64e_defconfig
arm                         lpc32xx_defconfig
arm                     eseries_pxa_defconfig
sh                            titan_defconfig
arm                          imote2_defconfig
arc                         haps_hs_defconfig
m68k                          multi_defconfig
mips                           mtx1_defconfig
sh                             shx3_defconfig
xtensa                  cadence_csp_defconfig
sh                          kfr2r09_defconfig
powerpc                      ppc6xx_defconfig
arm                        vexpress_defconfig
arm                           h5000_defconfig
arm                         palmz72_defconfig
arm                         mv78xx0_defconfig
mips                            gpr_defconfig
powerpc                     powernv_defconfig
powerpc                     tqm5200_defconfig
powerpc                       maple_defconfig
powerpc                    socrates_defconfig
m68k                                defconfig
nios2                            alldefconfig
mips                       capcella_defconfig
powerpc                      pmac32_defconfig
i386                             alldefconfig
mips                           ip22_defconfig
arm                        trizeps4_defconfig
sh                         apsh4a3a_defconfig
powerpc                     sbc8548_defconfig
arc                           tb10x_defconfig
h8300                               defconfig
arm                              alldefconfig
powerpc                  mpc885_ads_defconfig
mips                        omega2p_defconfig
powerpc                      katmai_defconfig
powerpc                 mpc8315_rdb_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20210326
i386                 randconfig-a003-20210326
i386                 randconfig-a001-20210326
i386                 randconfig-a002-20210326
i386                 randconfig-a006-20210326
i386                 randconfig-a005-20210326
x86_64               randconfig-a012-20210326
x86_64               randconfig-a015-20210326
x86_64               randconfig-a014-20210326
x86_64               randconfig-a013-20210326
x86_64               randconfig-a016-20210326
x86_64               randconfig-a011-20210326
i386                 randconfig-a014-20210326
i386                 randconfig-a011-20210326
i386                 randconfig-a015-20210326
i386                 randconfig-a016-20210326
i386                 randconfig-a012-20210326
i386                 randconfig-a013-20210326
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210326
x86_64               randconfig-a003-20210326
x86_64               randconfig-a001-20210326
x86_64               randconfig-a006-20210326
x86_64               randconfig-a004-20210326
x86_64               randconfig-a005-20210326

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
