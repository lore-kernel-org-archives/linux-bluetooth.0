Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF9FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Sep 2021 16:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6072F61139
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Sep 2021 16:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350135AbhIHRAm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Sep 2021 13:00:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:12620 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235666AbhIHRAm (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Sep 2021 13:00:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="220573414"
X-IronPort-AV: E=Sophos;i="5.85,278,1624345200"; 
   d="scan'208";a="220573414"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 09:56:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,278,1624345200"; 
   d="scan'208";a="524903374"
Received: from lkp-server01.sh.intel.com (HELO 730d49888f40) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 08 Sep 2021 09:56:09 -0700
Received: from kbuild by 730d49888f40 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mO0ro-0002S9-N0; Wed, 08 Sep 2021 16:56:08 +0000
Date:   Thu, 09 Sep 2021 00:55:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 9682d36c21196c4019d84e77eae3921128927ce2
Message-ID: <6138eafe.mlbeqecaNuUgNMu7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 9682d36c21196c4019d84e77eae3921128927ce2  Bluetooth: hci_vhci: Add support for offload codecs over SCO

elapsed time: 1067m

configs tested: 111
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210908
powerpc                    socrates_defconfig
ia64                         bigsur_defconfig
sh                             shx3_defconfig
xtensa                           alldefconfig
nios2                         3c120_defconfig
mips                           jazz_defconfig
sh                     sh7710voipgw_defconfig
powerpc                     ppa8548_defconfig
m68k                             alldefconfig
powerpc                    adder875_defconfig
mips                       capcella_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                     mpc5200_defconfig
sh                 kfr2r09-romimage_defconfig
sh                          kfr2r09_defconfig
powerpc                       ebony_defconfig
sh                            shmin_defconfig
sh                           se7724_defconfig
sh                               j2_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                          moxart_defconfig
powerpc                     pq2fads_defconfig
sh                        sh7763rdp_defconfig
arc                           tb10x_defconfig
openrisc                 simple_smp_defconfig
mips                   sb1250_swarm_defconfig
sh                          rsk7264_defconfig
powerpc                    gamecube_defconfig
ia64                            zx1_defconfig
powerpc                     tqm8560_defconfig
arm                        trizeps4_defconfig
x86_64               randconfig-c001-20210908
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
nios2                               defconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nds32                             allnoconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210908
i386                 randconfig-a004-20210908
i386                 randconfig-a006-20210908
i386                 randconfig-a002-20210908
i386                 randconfig-a001-20210908
i386                 randconfig-a003-20210908
arc                  randconfig-r043-20210906
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
s390                 randconfig-c005-20210908
powerpc              randconfig-c003-20210908
mips                 randconfig-c004-20210908
i386                 randconfig-c001-20210908
x86_64               randconfig-a016-20210908
x86_64               randconfig-a011-20210908
x86_64               randconfig-a012-20210908
x86_64               randconfig-a014-20210908
x86_64               randconfig-a013-20210908
i386                 randconfig-a012-20210908
i386                 randconfig-a015-20210908
i386                 randconfig-a011-20210908
i386                 randconfig-a013-20210908
i386                 randconfig-a014-20210908
i386                 randconfig-a016-20210908
s390                 randconfig-r044-20210908
riscv                randconfig-r042-20210906
hexagon              randconfig-r045-20210906
s390                 randconfig-r044-20210906
hexagon              randconfig-r041-20210906

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
