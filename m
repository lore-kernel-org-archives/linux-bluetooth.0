Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6A6C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Dec 2020 11:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 491D7222F9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Dec 2020 11:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgLWLTV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Dec 2020 06:19:21 -0500
Received: from mga14.intel.com ([192.55.52.115]:40065 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbgLWLTV (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Dec 2020 06:19:21 -0500
IronPort-SDR: JwmOZPbehlNzdWotfByTygdJxq37GNBecHhkUpkL2cjRapM1x+pQm7oOmQ1TSVrYJevr9dkzSW
 9bgV0A1suukA==
X-IronPort-AV: E=McAfee;i="6000,8403,9843"; a="175225997"
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="175225997"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2020 03:18:40 -0800
IronPort-SDR: PB0ncry+Ove7EwtULJ49RMvmytC7CCduKvzPlwvkk0QgJ1vNKOQ0cc4DNbAxPgafPkk7YU90AL
 8faKR/NSdGnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="397964587"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Dec 2020 03:18:39 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ks2AA-0000H3-U0; Wed, 23 Dec 2020 11:18:38 +0000
Date:   Wed, 23 Dec 2020 19:17:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 05672a2c14a4ea20b7e31a1d8d847292c2b60c10
Message-ID: <5fe32759.zF00Ot0rDAhXNoCS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git  master
branch HEAD: 05672a2c14a4ea20b7e31a1d8d847292c2b60c10  Bluetooth: btrtl: Enable central-peripheral role

elapsed time: 724m

configs tested: 150
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      ppc64e_defconfig
arm                         vf610m4_defconfig
powerpc                 canyonlands_defconfig
sh                  sh7785lcr_32bit_defconfig
c6x                        evmc6474_defconfig
arm                         bcm2835_defconfig
m68k                          amiga_defconfig
powerpc                     kilauea_defconfig
arm                       aspeed_g4_defconfig
mips                           ip27_defconfig
parisc                generic-64bit_defconfig
arm                       spear13xx_defconfig
arc                     nsimosci_hs_defconfig
h8300                            allyesconfig
mips                malta_kvm_guest_defconfig
arm                       imx_v4_v5_defconfig
arc                                 defconfig
ia64                      gensparse_defconfig
s390                       zfcpdump_defconfig
arm                           efm32_defconfig
arm                         axm55xx_defconfig
arm                      footbridge_defconfig
powerpc                      ppc44x_defconfig
powerpc                 mpc834x_itx_defconfig
m68k                            q40_defconfig
m68k                       m5208evb_defconfig
arm                           h5000_defconfig
arm                          pxa168_defconfig
powerpc                        icon_defconfig
mips                           ip28_defconfig
powerpc                  mpc866_ads_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                      bamboo_defconfig
powerpc                      ppc6xx_defconfig
powerpc                    gamecube_defconfig
mips                           gcw0_defconfig
arm                              zx_defconfig
powerpc                      acadia_defconfig
mips                        nlm_xlr_defconfig
sh                           se7206_defconfig
mips                     decstation_defconfig
m68k                        mvme16x_defconfig
i386                                defconfig
arm                  colibri_pxa300_defconfig
arm                         socfpga_defconfig
sh                        edosk7760_defconfig
sh                            titan_defconfig
arm                    vt8500_v6_v7_defconfig
arm                     eseries_pxa_defconfig
mips                           mtx1_defconfig
um                             i386_defconfig
m68k                       bvme6000_defconfig
sh                           sh2007_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20201223
x86_64               randconfig-a006-20201223
x86_64               randconfig-a002-20201223
x86_64               randconfig-a004-20201223
x86_64               randconfig-a003-20201223
x86_64               randconfig-a005-20201223
i386                 randconfig-a005-20201222
i386                 randconfig-a002-20201222
i386                 randconfig-a006-20201222
i386                 randconfig-a004-20201222
i386                 randconfig-a003-20201222
i386                 randconfig-a001-20201222
i386                 randconfig-a002-20201223
i386                 randconfig-a005-20201223
i386                 randconfig-a006-20201223
i386                 randconfig-a004-20201223
i386                 randconfig-a003-20201223
i386                 randconfig-a001-20201223
i386                 randconfig-a011-20201221
i386                 randconfig-a016-20201221
i386                 randconfig-a014-20201221
i386                 randconfig-a012-20201221
i386                 randconfig-a015-20201221
i386                 randconfig-a013-20201221
i386                 randconfig-a011-20201223
i386                 randconfig-a016-20201223
i386                 randconfig-a014-20201223
i386                 randconfig-a012-20201223
i386                 randconfig-a015-20201223
i386                 randconfig-a013-20201223
x86_64               randconfig-a001-20201221
x86_64               randconfig-a006-20201221
x86_64               randconfig-a002-20201221
x86_64               randconfig-a004-20201221
x86_64               randconfig-a003-20201221
x86_64               randconfig-a005-20201221
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
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
x86_64               randconfig-a015-20201223
x86_64               randconfig-a014-20201223
x86_64               randconfig-a016-20201223
x86_64               randconfig-a012-20201223
x86_64               randconfig-a013-20201223
x86_64               randconfig-a011-20201223
x86_64               randconfig-a001-20201222
x86_64               randconfig-a006-20201222
x86_64               randconfig-a002-20201222
x86_64               randconfig-a004-20201222
x86_64               randconfig-a003-20201222
x86_64               randconfig-a005-20201222

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
