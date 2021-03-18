Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E99FC433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Mar 2021 21:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5558564F4D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Mar 2021 21:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbhCRV52 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Mar 2021 17:57:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:5928 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233254AbhCRV45 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Mar 2021 17:56:57 -0400
IronPort-SDR: IRBz6p7EI2tiZAtNkbHKex/WSWbxdpgNE2MtcBJpDpRAKCjAP5oc26dFEbFbjG1pF+AN/HcSOm
 ophBsJuXDdbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="169073532"
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="169073532"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 14:56:57 -0700
IronPort-SDR: uwjXx5WTiO4OwdtJk1AFROTz/+Y0BIEs7gvpY8ExEV77NJYLNAh6oTfhuDMjps6uwpQRiA3T10
 Ll+fcAKj56Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="374721247"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 18 Mar 2021 14:56:55 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lN0dT-0001Rd-4M; Thu, 18 Mar 2021 21:56:55 +0000
Date:   Fri, 19 Mar 2021 05:56:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 81534d4835de52758176909f3e446f1d49809241
Message-ID: <6053cc9a.5ZIZ+B5cB6704cY7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 81534d4835de52758176909f3e446f1d49809241  Bluetooth: btbcm: Add BCM4330 and BCM4334 compatibles

elapsed time: 721m

configs tested: 130
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
arm                       omap2plus_defconfig
arm                        clps711x_defconfig
m68k                       m5475evb_defconfig
sparc                            alldefconfig
powerpc                        icon_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                    socrates_defconfig
arm                         assabet_defconfig
h8300                    h8300h-sim_defconfig
mips                  decstation_64_defconfig
arm                         nhk8815_defconfig
arm                       cns3420vb_defconfig
powerpc                     sbc8548_defconfig
arm                        magician_defconfig
mips                         tb0226_defconfig
mips                        jmr3927_defconfig
arm                     davinci_all_defconfig
sh                           se7750_defconfig
mips                  maltasmvp_eva_defconfig
mips                        qi_lb60_defconfig
xtensa                           alldefconfig
mips                     decstation_defconfig
arm                          exynos_defconfig
mips                            gpr_defconfig
arm                       multi_v4t_defconfig
arm                          moxart_defconfig
powerpc                    klondike_defconfig
sh                            migor_defconfig
riscv                          rv32_defconfig
sh                     magicpanelr2_defconfig
powerpc                      chrp32_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                   lite5200b_defconfig
csky                             alldefconfig
powerpc                      acadia_defconfig
sh                          rsk7269_defconfig
mips                          rm200_defconfig
mips                     cu1000-neo_defconfig
powerpc                     tqm8560_defconfig
arm                          pxa910_defconfig
arm                          simpad_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                      ppc40x_defconfig
powerpc                     stx_gp3_defconfig
arm                        multi_v7_defconfig
arm                           sama5_defconfig
arc                            hsdk_defconfig
mips                        nlm_xlp_defconfig
sh                             sh03_defconfig
sh                               j2_defconfig
powerpc                      makalu_defconfig
arm                          pxa3xx_defconfig
sh                         ap325rxa_defconfig
powerpc                      ppc64e_defconfig
um                            kunit_defconfig
sh                        edosk7705_defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210318
i386                 randconfig-a005-20210318
i386                 randconfig-a003-20210318
i386                 randconfig-a002-20210318
i386                 randconfig-a006-20210318
i386                 randconfig-a004-20210318
x86_64               randconfig-a011-20210318
x86_64               randconfig-a016-20210318
x86_64               randconfig-a013-20210318
x86_64               randconfig-a015-20210318
x86_64               randconfig-a014-20210318
x86_64               randconfig-a012-20210318
i386                 randconfig-a013-20210318
i386                 randconfig-a016-20210318
i386                 randconfig-a011-20210318
i386                 randconfig-a014-20210318
i386                 randconfig-a015-20210318
i386                 randconfig-a012-20210318
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210318
x86_64               randconfig-a001-20210318
x86_64               randconfig-a005-20210318
x86_64               randconfig-a002-20210318
x86_64               randconfig-a003-20210318
x86_64               randconfig-a004-20210318

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
