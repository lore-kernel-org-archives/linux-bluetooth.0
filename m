Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B334C47089
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 May 2021 05:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E05FF613B5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 May 2021 05:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbhE0FD5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 May 2021 01:03:57 -0400
Received: from mga01.intel.com ([192.55.52.88]:44405 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234964AbhE0FDy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 May 2021 01:03:54 -0400
IronPort-SDR: N9CJ/ptmjs7mWTQjoqpTzpIiNvLLi2+c6tE+I3ccuzqLKFOf8GYIHNvhsf7ZAo9tQQmoFGSLv6
 7WzIztTW04gg==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="223849043"
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="223849043"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 22:02:22 -0700
IronPort-SDR: SVwnRG6yCtaQ0y3LTKZSRFsNI95TL2DJDuvjkEm9dom/nJbenGt2O3tCBf2HDDBUss+ApGzx2g
 BpRytPoDOrDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="465127522"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 26 May 2021 22:02:20 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lm8A0-0002aF-5a; Thu, 27 May 2021 05:02:20 +0000
Date:   Thu, 27 May 2021 13:01:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 a29cbfbf673f9d7e6aff90ebf24d731580568a98
Message-ID: <60af27b4.3nc0KUXWRvRDvg2X%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: a29cbfbf673f9d7e6aff90ebf24d731580568a98  Bluetooth: disable filter dup when scan for adv monitor

elapsed time: 722m

configs tested: 191
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                          pcm027_defconfig
powerpc                          g5_defconfig
mips                       capcella_defconfig
powerpc                     tqm8555_defconfig
arm                             ezx_defconfig
mips                           ip32_defconfig
m68k                         amcore_defconfig
mips                        jmr3927_defconfig
powerpc                      ppc44x_defconfig
mips                        nlm_xlp_defconfig
powerpc                  iss476-smp_defconfig
powerpc                    sam440ep_defconfig
sh                        edosk7760_defconfig
arm                          iop32x_defconfig
arm                         lpc32xx_defconfig
arm                          ixp4xx_defconfig
sh                          lboxre2_defconfig
powerpc                       maple_defconfig
sh                          sdk7780_defconfig
mips                      malta_kvm_defconfig
arm                         palmz72_defconfig
mips                       bmips_be_defconfig
arm                           sunxi_defconfig
mips                         rt305x_defconfig
arc                        vdk_hs38_defconfig
arc                      axs103_smp_defconfig
parisc                generic-32bit_defconfig
um                            kunit_defconfig
arm                          imote2_defconfig
powerpc                     tqm8560_defconfig
powerpc                     skiroot_defconfig
m68k                        m5307c3_defconfig
sh                           se7712_defconfig
arm                        keystone_defconfig
m68k                       m5475evb_defconfig
m68k                         apollo_defconfig
mips                  maltasmvp_eva_defconfig
arm                      footbridge_defconfig
mips                  decstation_64_defconfig
openrisc                 simple_smp_defconfig
arm                     davinci_all_defconfig
sparc64                          alldefconfig
arm                          pxa910_defconfig
powerpc                 mpc8313_rdb_defconfig
arc                     nsimosci_hs_defconfig
mips                         tb0287_defconfig
arm64                            alldefconfig
mips                        bcm47xx_defconfig
h8300                               defconfig
sh                     sh7710voipgw_defconfig
mips                           ip22_defconfig
powerpc                    amigaone_defconfig
mips                    maltaup_xpa_defconfig
mips                        maltaup_defconfig
arm                        realview_defconfig
mips                         mpc30x_defconfig
arm                          collie_defconfig
m68k                        stmark2_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                       ebony_defconfig
mips                        vocore2_defconfig
mips                        workpad_defconfig
arm                          moxart_defconfig
mips                          malta_defconfig
powerpc                     pseries_defconfig
powerpc                 mpc834x_mds_defconfig
mips                            ar7_defconfig
powerpc                      bamboo_defconfig
arm                           u8500_defconfig
arm                         s3c2410_defconfig
parisc                           allyesconfig
mips                          rm200_defconfig
riscv                    nommu_virt_defconfig
arm                          ep93xx_defconfig
sh                           se7343_defconfig
mips                           gcw0_defconfig
arm                           corgi_defconfig
arm                      tct_hammer_defconfig
powerpc                    mvme5100_defconfig
microblaze                      mmu_defconfig
powerpc                   lite5200b_defconfig
alpha                               defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                     tqm8548_defconfig
arm                        multi_v5_defconfig
mips                            e55_defconfig
mips                        omega2p_defconfig
arm                        mini2440_defconfig
arm                          badge4_defconfig
ia64                             alldefconfig
powerpc                 mpc836x_mds_defconfig
arm                      jornada720_defconfig
powerpc                      mgcoge_defconfig
openrisc                            defconfig
mips                     loongson1c_defconfig
nios2                         3c120_defconfig
sh                          kfr2r09_defconfig
arm                        cerfcube_defconfig
mips                           ci20_defconfig
xtensa                  cadence_csp_defconfig
xtensa                           allyesconfig
arm                       omap2plus_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                     mpc83xx_defconfig
microblaze                          defconfig
arm                            qcom_defconfig
arm                       cns3420vb_defconfig
arc                        nsim_700_defconfig
mips                        nlm_xlr_defconfig
mips                     cu1830-neo_defconfig
mips                     cu1000-neo_defconfig
parisc                generic-64bit_defconfig
sh                            shmin_defconfig
arm                        mvebu_v5_defconfig
mips                      maltaaprp_defconfig
x86_64                            allnoconfig
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
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20210526
x86_64               randconfig-a001-20210526
x86_64               randconfig-a006-20210526
x86_64               randconfig-a003-20210526
x86_64               randconfig-a004-20210526
x86_64               randconfig-a002-20210526
i386                 randconfig-a001-20210526
i386                 randconfig-a002-20210526
i386                 randconfig-a005-20210526
i386                 randconfig-a004-20210526
i386                 randconfig-a003-20210526
i386                 randconfig-a006-20210526
i386                 randconfig-a011-20210526
i386                 randconfig-a016-20210526
i386                 randconfig-a015-20210526
i386                 randconfig-a012-20210526
i386                 randconfig-a014-20210526
i386                 randconfig-a013-20210526
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210526
x86_64               randconfig-a013-20210526
x86_64               randconfig-a012-20210526
x86_64               randconfig-a014-20210526
x86_64               randconfig-a016-20210526
x86_64               randconfig-a015-20210526
x86_64               randconfig-a011-20210526

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
