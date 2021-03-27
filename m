Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389F1C433C1
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Mar 2021 09:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07246619F7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Mar 2021 09:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhC0J0l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 27 Mar 2021 05:26:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:56846 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230329AbhC0J0G (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 27 Mar 2021 05:26:06 -0400
IronPort-SDR: U5GRaQXbb/7IKRMZZ2UAqa00039xR46z0VcO80+/yCiSSFKlLw4sVfg4tk+8RK+sTzmPSyanm3
 J9HEY5JOl99g==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="191316956"
X-IronPort-AV: E=Sophos;i="5.81,283,1610438400"; 
   d="scan'208";a="191316956"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2021 02:26:06 -0700
IronPort-SDR: Hb3ZFQRyQ0XRjuvM7/IGOUqluDFl+mb0y2iybP18HTUbpVVz3HFQYNL/+vUtApjQYOB4olaFKn
 qQ5a67jZFrJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,283,1610438400"; 
   d="scan'208";a="410277473"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 27 Mar 2021 02:26:04 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lQ5Cm-0003Kh-12; Sat, 27 Mar 2021 09:26:04 +0000
Date:   Sat, 27 Mar 2021 17:25:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 d58cf00dcedb9882ba6e933443371444d8a23b77
Message-ID: <605efa16.q7dx0Tb3WN59WRth%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: d58cf00dcedb9882ba6e933443371444d8a23b77  Bluetooth: Increment management interface revision

elapsed time: 724m

configs tested: 167
configs skipped: 2

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
sh                ecovec24-romimage_defconfig
arc                    vdk_hs38_smp_defconfig
m68k                         amcore_defconfig
m68k                           sun3_defconfig
powerpc                      pmac32_defconfig
powerpc                  mpc866_ads_defconfig
arm                          gemini_defconfig
powerpc                        icon_defconfig
powerpc                    sam440ep_defconfig
sh                           se7750_defconfig
arm                        clps711x_defconfig
sh                               alldefconfig
mips                        nlm_xlr_defconfig
arm                       spear13xx_defconfig
arm                          moxart_defconfig
powerpc                     ep8248e_defconfig
openrisc                            defconfig
sh                         microdev_defconfig
arm                          ixp4xx_defconfig
nios2                         10m50_defconfig
powerpc                       holly_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                         orion5x_defconfig
arm                            pleb_defconfig
m68k                        mvme147_defconfig
microblaze                          defconfig
powerpc                       ebony_defconfig
powerpc                      cm5200_defconfig
parisc                generic-64bit_defconfig
mips                             allmodconfig
riscv                             allnoconfig
mips                            ar7_defconfig
powerpc                          g5_defconfig
ia64                            zx1_defconfig
arc                          axs101_defconfig
arm                       imx_v4_v5_defconfig
m68k                       m5249evb_defconfig
arm                        mini2440_defconfig
ia64                             allyesconfig
arm                          pxa3xx_defconfig
arm                         hackkit_defconfig
arm                       aspeed_g5_defconfig
mips                     loongson1c_defconfig
sparc                            alldefconfig
mips                           rs90_defconfig
powerpc                          allyesconfig
sh                             sh03_defconfig
arm                   milbeaut_m10v_defconfig
arm                        multi_v7_defconfig
powerpc                   bluestone_defconfig
xtensa                generic_kc705_defconfig
powerpc                      acadia_defconfig
arm                       multi_v4t_defconfig
arm                            mps2_defconfig
arm                          pxa910_defconfig
arm                            qcom_defconfig
sh                          r7785rp_defconfig
powerpc                      arches_defconfig
arc                           tb10x_defconfig
mips                           ip32_defconfig
arc                          axs103_defconfig
powerpc                       eiger_defconfig
sparc                       sparc64_defconfig
arm                         s3c2410_defconfig
sh                          polaris_defconfig
powerpc                      walnut_defconfig
arm                         s3c6400_defconfig
m68k                             allmodconfig
arm                     eseries_pxa_defconfig
sh                            titan_defconfig
arm                       cns3420vb_defconfig
arm                          imote2_defconfig
mips                          rb532_defconfig
arm                         palmz72_defconfig
arm                         mv78xx0_defconfig
alpha                            allyesconfig
mips                            gpr_defconfig
powerpc                       maple_defconfig
powerpc                    socrates_defconfig
powerpc                      bamboo_defconfig
m68k                                defconfig
sh                           se7206_defconfig
sh                           sh2007_defconfig
powerpc                 mpc834x_mds_defconfig
nds32                             allnoconfig
sparc64                             defconfig
arm                           omap1_defconfig
sparc64                          alldefconfig
riscv             nommu_k210_sdcard_defconfig
arm                          simpad_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                      pcm030_defconfig
mips                        omega2p_defconfig
powerpc                      katmai_defconfig
powerpc                 mpc8315_rdb_defconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
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
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
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
