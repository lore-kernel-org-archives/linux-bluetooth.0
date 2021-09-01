Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AB6C432BE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Sep 2021 20:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19981610A2
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Sep 2021 20:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhIAUru (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Sep 2021 16:47:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:30757 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231373AbhIAUrt (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Sep 2021 16:47:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="215732396"
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="215732396"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 13:46:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="520654608"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 01 Sep 2021 13:46:44 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mLX87-0008Fu-W0; Wed, 01 Sep 2021 20:46:43 +0000
Date:   Thu, 02 Sep 2021 04:45:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 9bba12860fc79aa3676b613f6be024e69f30a685
Message-ID: <612fe67d.em5SFttCKaRpgtf4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 9bba12860fc79aa3676b613f6be024e69f30a685  Bluetooth: btusb: Add the new support ID for Realtek RTL8852A

elapsed time: 723m

configs tested: 142
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210901
i386                 randconfig-c001-20210831
nios2                         3c120_defconfig
powerpc                      mgcoge_defconfig
riscv                            allyesconfig
powerpc                 mpc836x_mds_defconfig
mips                        workpad_defconfig
i386                             alldefconfig
powerpc                    mvme5100_defconfig
sh                            titan_defconfig
arm                           u8500_defconfig
nds32                            alldefconfig
mips                           ip27_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                           jazz_defconfig
arm                         vf610m4_defconfig
mips                      maltaaprp_defconfig
powerpc                 mpc8313_rdb_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                            hisi_defconfig
mips                          ath25_defconfig
arm                       multi_v4t_defconfig
ia64                             allyesconfig
i386                             allyesconfig
arm                         hackkit_defconfig
sh                                  defconfig
xtensa                       common_defconfig
xtensa                  nommu_kc705_defconfig
sh                          lboxre2_defconfig
powerpc                  mpc866_ads_defconfig
arm                           h3600_defconfig
arm                         s5pv210_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20210831
x86_64               randconfig-a001-20210831
x86_64               randconfig-a003-20210831
x86_64               randconfig-a002-20210831
x86_64               randconfig-a004-20210831
x86_64               randconfig-a006-20210831
i386                 randconfig-a005-20210831
i386                 randconfig-a002-20210831
i386                 randconfig-a003-20210831
i386                 randconfig-a006-20210831
i386                 randconfig-a004-20210831
i386                 randconfig-a001-20210831
x86_64               randconfig-a016-20210901
x86_64               randconfig-a011-20210901
x86_64               randconfig-a012-20210901
x86_64               randconfig-a015-20210901
x86_64               randconfig-a014-20210901
x86_64               randconfig-a013-20210901
i386                 randconfig-a012-20210901
i386                 randconfig-a015-20210901
i386                 randconfig-a011-20210901
i386                 randconfig-a013-20210901
i386                 randconfig-a014-20210901
i386                 randconfig-a016-20210901
arc                  randconfig-r043-20210831
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
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
s390                 randconfig-c005-20210901
mips                 randconfig-c004-20210901
x86_64               randconfig-c007-20210901
powerpc              randconfig-c003-20210901
i386                 randconfig-c001-20210901
arm                  randconfig-c002-20210901
riscv                randconfig-c006-20210901
i386                 randconfig-c001-20210831
s390                 randconfig-c005-20210831
riscv                randconfig-c006-20210831
powerpc              randconfig-c003-20210831
mips                 randconfig-c004-20210831
arm                  randconfig-c002-20210831
x86_64               randconfig-c007-20210831
x86_64               randconfig-a004-20210901
x86_64               randconfig-a006-20210901
x86_64               randconfig-a003-20210901
x86_64               randconfig-a005-20210901
x86_64               randconfig-a001-20210901
x86_64               randconfig-a002-20210901
x86_64               randconfig-a014-20210831
x86_64               randconfig-a015-20210831
x86_64               randconfig-a013-20210831
x86_64               randconfig-a016-20210831
x86_64               randconfig-a012-20210831
x86_64               randconfig-a011-20210831
i386                 randconfig-a016-20210831
i386                 randconfig-a011-20210831
i386                 randconfig-a015-20210831
i386                 randconfig-a014-20210831
i386                 randconfig-a012-20210831
i386                 randconfig-a013-20210831
s390                 randconfig-r044-20210831
hexagon              randconfig-r041-20210831
hexagon              randconfig-r045-20210831
riscv                randconfig-r042-20210831
hexagon              randconfig-r045-20210901
hexagon              randconfig-r041-20210901

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
