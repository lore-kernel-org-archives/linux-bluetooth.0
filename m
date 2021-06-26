Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15666C49EA5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jun 2021 18:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D4061C40
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jun 2021 18:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhFZS61 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Jun 2021 14:58:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:24096 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230107AbhFZS61 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Jun 2021 14:58:27 -0400
IronPort-SDR: 2+Mn6qz6j6ghkh8rcodAo0DCE8wvwgASq4IhGtWph6STIdvZ2dbSz+f6CCAVIKQGdAaQjLFsS+
 mfGSKUpo7Wag==
X-IronPort-AV: E=McAfee;i="6200,9189,10027"; a="229409290"
X-IronPort-AV: E=Sophos;i="5.83,302,1616482800"; 
   d="scan'208";a="229409290"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2021 11:56:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,302,1616482800"; 
   d="scan'208";a="455793882"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jun 2021 11:56:03 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lxDTG-0007qj-S1; Sat, 26 Jun 2021 18:56:02 +0000
Date:   Sun, 27 Jun 2021 02:55:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 1f0536139cb8e8175ca034e12706b86f77f9061e
Message-ID: <60d77820.n75F8mnwLUL/9aZK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 1f0536139cb8e8175ca034e12706b86f77f9061e  Bluetooth: hci_uart: Remove redundant assignment to fw_ptr

elapsed time: 725m

configs tested: 117
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                         ps3_defconfig
powerpc                      mgcoge_defconfig
sh                        sh7785lcr_defconfig
sh                           se7721_defconfig
sh                        edosk7705_defconfig
m68k                        mvme16x_defconfig
riscv                            allyesconfig
arm                           omap1_defconfig
arm                         axm55xx_defconfig
powerpc                 mpc834x_itx_defconfig
ia64                                defconfig
sh                             espt_defconfig
microblaze                      mmu_defconfig
arm                          pxa3xx_defconfig
arm                          moxart_defconfig
arm                           u8500_defconfig
arm                         palmz72_defconfig
powerpc                 mpc834x_mds_defconfig
arm                         s3c6400_defconfig
mips                      pic32mzda_defconfig
arc                            hsdk_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                     tqm8560_defconfig
arc                     nsimosci_hs_defconfig
powerpc                     pq2fads_defconfig
arm                         vf610m4_defconfig
m68k                            mac_defconfig
ia64                            zx1_defconfig
arm                        trizeps4_defconfig
powerpc                    socrates_defconfig
powerpc                          g5_defconfig
powerpc                        fsp2_defconfig
sparc64                             defconfig
sparc                       sparc32_defconfig
sh                          rsk7201_defconfig
arm                             pxa_defconfig
m68k                         amcore_defconfig
sh                           sh2007_defconfig
arm                           viper_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210625
x86_64               randconfig-a001-20210625
x86_64               randconfig-a005-20210625
x86_64               randconfig-a003-20210625
x86_64               randconfig-a004-20210625
x86_64               randconfig-a006-20210625
i386                 randconfig-a002-20210625
i386                 randconfig-a001-20210625
i386                 randconfig-a003-20210625
i386                 randconfig-a006-20210625
i386                 randconfig-a005-20210625
i386                 randconfig-a004-20210625
x86_64               randconfig-a012-20210622
x86_64               randconfig-a016-20210622
x86_64               randconfig-a015-20210622
x86_64               randconfig-a014-20210622
x86_64               randconfig-a013-20210622
x86_64               randconfig-a011-20210622
i386                 randconfig-a011-20210625
i386                 randconfig-a014-20210625
i386                 randconfig-a013-20210625
i386                 randconfig-a015-20210625
i386                 randconfig-a012-20210625
i386                 randconfig-a016-20210625
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210622
x86_64               randconfig-b001-20210625

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
