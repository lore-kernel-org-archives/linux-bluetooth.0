Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FBAC43381
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 10:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 957B764F31
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 10:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238177AbhCDJ71 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Mar 2021 04:59:27 -0500
Received: from mga04.intel.com ([192.55.52.120]:62896 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233390AbhCDJ7D (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Mar 2021 04:59:03 -0500
IronPort-SDR: W5YkReXNvEEUaCccpc2biVMCKmFKq3HnFu/22niYz26EOm3N8dV0n3SPzn+PZGcuOXAIy06YoX
 EYhQS8XrA82A==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="184973625"
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="184973625"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 01:58:22 -0800
IronPort-SDR: MHgCHSVySotkvx+L9ON0rgvPhT7i7bT1KrinzgW/OY4F5hRNG5klUgsSrY7x7UzzXm85m8Grbq
 Hh2acEVAWUdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="407709571"
Received: from lkp-server02.sh.intel.com (HELO 2482ff9f8ac0) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 04 Mar 2021 01:58:21 -0800
Received: from kbuild by 2482ff9f8ac0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lHkkO-00027x-DO; Thu, 04 Mar 2021 09:58:20 +0000
Date:   Thu, 04 Mar 2021 17:58:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 ff02db13e9bfa01e0d66c5fa53da29bd1f1b208a
Message-ID: <6040af2d.o0Bdql3ZayDQaB/c%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: ff02db13e9bfa01e0d66c5fa53da29bd1f1b208a  Bluetooth: Allow scannable adv with extended MGMT APIs

elapsed time: 727m

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
arm                  colibri_pxa300_defconfig
mips                          malta_defconfig
h8300                               defconfig
ia64                      gensparse_defconfig
powerpc                      pmac32_defconfig
arc                          axs103_defconfig
powerpc                    sam440ep_defconfig
mips                         rt305x_defconfig
powerpc                      ppc6xx_defconfig
arm                      integrator_defconfig
openrisc                 simple_smp_defconfig
powerpc                       maple_defconfig
mips                      malta_kvm_defconfig
h8300                    h8300h-sim_defconfig
sh                          lboxre2_defconfig
arm                             pxa_defconfig
mips                        workpad_defconfig
sh                           se7751_defconfig
powerpc                       ebony_defconfig
mips                     cu1000-neo_defconfig
sh                         microdev_defconfig
mips                     decstation_defconfig
mips                        maltaup_defconfig
arm                           stm32_defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210304
i386                 randconfig-a003-20210304
i386                 randconfig-a002-20210304
i386                 randconfig-a004-20210304
i386                 randconfig-a006-20210304
i386                 randconfig-a001-20210304
i386                 randconfig-a005-20210303
i386                 randconfig-a003-20210303
i386                 randconfig-a002-20210303
i386                 randconfig-a004-20210303
i386                 randconfig-a006-20210303
i386                 randconfig-a001-20210303
x86_64               randconfig-a013-20210303
x86_64               randconfig-a016-20210303
x86_64               randconfig-a015-20210303
x86_64               randconfig-a014-20210303
x86_64               randconfig-a012-20210303
x86_64               randconfig-a011-20210303
i386                 randconfig-a016-20210303
i386                 randconfig-a012-20210303
i386                 randconfig-a014-20210303
i386                 randconfig-a013-20210303
i386                 randconfig-a011-20210303
i386                 randconfig-a015-20210303
i386                 randconfig-a016-20210304
i386                 randconfig-a012-20210304
i386                 randconfig-a013-20210304
i386                 randconfig-a014-20210304
i386                 randconfig-a011-20210304
i386                 randconfig-a015-20210304
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210303
x86_64               randconfig-a001-20210303
x86_64               randconfig-a004-20210303
x86_64               randconfig-a002-20210303
x86_64               randconfig-a005-20210303
x86_64               randconfig-a003-20210303
x86_64               randconfig-a013-20210304
x86_64               randconfig-a016-20210304
x86_64               randconfig-a015-20210304
x86_64               randconfig-a014-20210304
x86_64               randconfig-a012-20210304
x86_64               randconfig-a011-20210304

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
