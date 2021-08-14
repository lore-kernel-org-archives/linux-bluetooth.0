Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3042CC4338F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Aug 2021 09:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08E7560EFE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Aug 2021 09:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237127AbhHNJ1f (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 14 Aug 2021 05:27:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:32119 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235202AbhHNJ1e (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 14 Aug 2021 05:27:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10075"; a="195258537"
X-IronPort-AV: E=Sophos;i="5.84,321,1620716400"; 
   d="scan'208";a="195258537"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2021 02:27:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,321,1620716400"; 
   d="scan'208";a="591694850"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 14 Aug 2021 02:27:05 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mEpwW-000Ogl-KA; Sat, 14 Aug 2021 09:27:04 +0000
Date:   Sat, 14 Aug 2021 17:26:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 55981d3541812234e687062926ff199c83f79a39
Message-ID: <61178c5e.xR7eqsjbytj73vLK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 55981d3541812234e687062926ff199c83f79a39  Bluetooth: btusb: check conditions before enabling USB ALT 3 for WBS

elapsed time: 5129m

configs tested: 149
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210812
i386                 randconfig-c001-20210810
parisc                           alldefconfig
sh                ecovec24-romimage_defconfig
powerpc                     mpc512x_defconfig
openrisc                 simple_smp_defconfig
arm                       omap2plus_defconfig
arm                         at91_dt_defconfig
arm                           omap1_defconfig
arm                           viper_defconfig
powerpc                    ge_imp3a_defconfig
arm                        spear6xx_defconfig
mips                            ar7_defconfig
arm                         palmz72_defconfig
xtensa                              defconfig
mips                     decstation_defconfig
mips                malta_qemu_32r6_defconfig
sh                          sdk7786_defconfig
powerpc                          g5_defconfig
riscv                             allnoconfig
powerpc                     stx_gp3_defconfig
powerpc                    adder875_defconfig
powerpc                     asp8347_defconfig
arm                            hisi_defconfig
arm                         s3c2410_defconfig
arm                       spear13xx_defconfig
s390                          debug_defconfig
powerpc                 mpc834x_itx_defconfig
nds32                               defconfig
mips                           jazz_defconfig
mips                           rs90_defconfig
powerpc                           allnoconfig
m68k                       m5208evb_defconfig
powerpc                     tqm5200_defconfig
powerpc                   lite5200b_defconfig
arm                   milbeaut_m10v_defconfig
mips                         cobalt_defconfig
xtensa                    xip_kc705_defconfig
arc                      axs103_smp_defconfig
arm                            lart_defconfig
alpha                            allyesconfig
mips                      maltasmvp_defconfig
xtensa                  cadence_csp_defconfig
arc                    vdk_hs38_smp_defconfig
sparc64                             defconfig
x86_64                            allnoconfig
powerpc                   currituck_defconfig
sh                           se7724_defconfig
arm64                            alldefconfig
powerpc                        cell_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                      pcm030_defconfig
arm                         s5pv210_defconfig
powerpc                     ppa8548_defconfig
powerpc                        icon_defconfig
arc                        vdk_hs38_defconfig
sh                   sh7724_generic_defconfig
arm                      pxa255-idp_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a004-20210810
x86_64               randconfig-a006-20210810
x86_64               randconfig-a003-20210810
x86_64               randconfig-a005-20210810
x86_64               randconfig-a002-20210810
x86_64               randconfig-a001-20210810
i386                 randconfig-a004-20210810
i386                 randconfig-a002-20210810
i386                 randconfig-a001-20210810
i386                 randconfig-a003-20210810
i386                 randconfig-a006-20210810
i386                 randconfig-a005-20210810
i386                 randconfig-a004-20210811
i386                 randconfig-a001-20210811
i386                 randconfig-a002-20210811
i386                 randconfig-a003-20210811
i386                 randconfig-a006-20210811
i386                 randconfig-a005-20210811
i386                 randconfig-a011-20210810
i386                 randconfig-a015-20210810
i386                 randconfig-a013-20210810
i386                 randconfig-a014-20210810
i386                 randconfig-a016-20210810
i386                 randconfig-a012-20210810
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210810
x86_64               randconfig-c001-20210811
x86_64               randconfig-a013-20210810
x86_64               randconfig-a011-20210810
x86_64               randconfig-a012-20210810
x86_64               randconfig-a016-20210810
x86_64               randconfig-a014-20210810
x86_64               randconfig-a015-20210810
x86_64               randconfig-a016-20210809
x86_64               randconfig-a012-20210809
x86_64               randconfig-a013-20210809
x86_64               randconfig-a011-20210809
x86_64               randconfig-a014-20210809
x86_64               randconfig-a015-20210809
x86_64               randconfig-a004-20210811
x86_64               randconfig-a006-20210811
x86_64               randconfig-a003-20210811
x86_64               randconfig-a002-20210811
x86_64               randconfig-a005-20210811
x86_64               randconfig-a001-20210811

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
