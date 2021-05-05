Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD2EC433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 May 2021 22:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEAA5611ED
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 May 2021 22:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhEEW42 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 May 2021 18:56:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:27036 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229905AbhEEW41 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 May 2021 18:56:27 -0400
IronPort-SDR: WxyKqWpyqE6Zgj2k6ZA/2kaHKHEGIyk+u+K4kVei0LcBOZ5/3d/Q4s/NQxj1Koi5umD/133CNY
 XhbpiBuH8k2A==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="185788012"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="185788012"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 15:55:26 -0700
IronPort-SDR: tQiO5+QjFrS4G6zmKYzYqTZZ7fUTT74DwrAJF8FIRGXTGtRWgphsqyXPLwfe/5Ftu92XtLAvDa
 WC7zD/bN+5eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="396852584"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 05 May 2021 15:55:25 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1leQQO-000ACk-FH; Wed, 05 May 2021 22:55:24 +0000
Date:   Thu, 06 May 2021 06:54:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 c96a0ebb1514a543a2a4b84dbdcf3589d74fe6a4
Message-ID: <60932233.FlByRTtwMsgjnU8M%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: c96a0ebb1514a543a2a4b84dbdcf3589d74fe6a4  Bluetooth: Fix the HCI to MGMT status conversion table

elapsed time: 720m

configs tested: 133
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
arm                             mxs_defconfig
mips                             allyesconfig
mips                    maltaup_xpa_defconfig
arm                           viper_defconfig
arm                          imote2_defconfig
mips                      pic32mzda_defconfig
sh                          sdk7780_defconfig
mips                     loongson1c_defconfig
mips                         tb0226_defconfig
arm                           tegra_defconfig
sh                   rts7751r2dplus_defconfig
sh                          rsk7203_defconfig
xtensa                  audio_kc705_defconfig
arm                        multi_v5_defconfig
arm                      jornada720_defconfig
arm                              alldefconfig
arm                         cm_x300_defconfig
arm                        vexpress_defconfig
arm                        neponset_defconfig
ia64                          tiger_defconfig
m68k                       bvme6000_defconfig
powerpc                     tqm8548_defconfig
m68k                        m5272c3_defconfig
mips                           ip22_defconfig
powerpc                      makalu_defconfig
powerpc                  mpc866_ads_defconfig
mips                     cu1830-neo_defconfig
powerpc                     rainier_defconfig
sh                        dreamcast_defconfig
sh                     sh7710voipgw_defconfig
mips                          rm200_defconfig
mips                           xway_defconfig
sparc64                             defconfig
mips                             allmodconfig
powerpc                 mpc834x_mds_defconfig
arm                            zeus_defconfig
arm                          pcm027_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                     ppa8548_defconfig
powerpc                    sam440ep_defconfig
powerpc                      tqm8xx_defconfig
sh                                  defconfig
arm                       versatile_defconfig
h8300                               defconfig
xtensa                  cadence_csp_defconfig
openrisc                         alldefconfig
mips                           jazz_defconfig
arm                           u8500_defconfig
arm                          ixp4xx_defconfig
sh                           se7721_defconfig
arm                          gemini_defconfig
arm                        spear6xx_defconfig
parisc                           allyesconfig
m68k                        stmark2_defconfig
sh                           se7780_defconfig
powerpc                    adder875_defconfig
sh                           se7712_defconfig
mips                        nlm_xlp_defconfig
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
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210505
i386                 randconfig-a006-20210505
i386                 randconfig-a001-20210505
i386                 randconfig-a005-20210505
i386                 randconfig-a004-20210505
i386                 randconfig-a002-20210505
i386                 randconfig-a015-20210505
i386                 randconfig-a013-20210505
i386                 randconfig-a016-20210505
i386                 randconfig-a014-20210505
i386                 randconfig-a012-20210505
i386                 randconfig-a011-20210505
x86_64               randconfig-a001-20210505
x86_64               randconfig-a003-20210505
x86_64               randconfig-a005-20210505
x86_64               randconfig-a002-20210505
x86_64               randconfig-a006-20210505
x86_64               randconfig-a004-20210505
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
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
x86_64               randconfig-a014-20210505
x86_64               randconfig-a015-20210505
x86_64               randconfig-a012-20210505
x86_64               randconfig-a013-20210505
x86_64               randconfig-a011-20210505
x86_64               randconfig-a016-20210505

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
