Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09DBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Mar 2022 05:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiCQFs3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Mar 2022 01:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiCQFs0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Mar 2022 01:48:26 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B85265E97
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Mar 2022 22:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647494319; x=1679030319;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=mDKK/ah47WsYylGYCBV8cwmm+BRPyV1ufw8pZRV8nws=;
  b=Xc9iwseyLMuOJq8uFBbTSXIZtqW5zkRM6jwaOzo/XEzULwU2qKjQyVkH
   //mMW/NpO/sVo/rmvh7rclZP+MejLoIXDBR2Oct/xV9+2V8VpF6BZm3RY
   vTCYgLmsEBvnltS6F91N1eXmpQJ266EjjpwwQgcwg4rwpK8CmYeZWtxww
   7JwfVy24qP1G6fWkixxXnPw3tEput4k2Mgs5W0nwv5IIGkbpDUulCahZg
   VlrmiMArwRSaufNZdmP5vbDfn0GM8YVJcOP7rk3UhkJhF3f0/YgcvqenV
   edwRv1kO3d+jOyxjpx5paISMrfJyOpht/Tq8EYZGED03QLa6OYHjyrfiQ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="343220760"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="343220760"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 22:18:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="541228566"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 16 Mar 2022 22:18:36 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUiWx-000DK2-VW; Thu, 17 Mar 2022 05:18:35 +0000
Date:   Thu, 17 Mar 2022 13:17:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 7c686a32a512b795a45e76224855c69e3a8070d7
Message-ID: <6232c47b.hTx83HMTaE2RMohw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 7c686a32a512b795a45e76224855c69e3a8070d7  Bluetooth: call hci_le_conn_failed with hdev lock in hci_le_conn_failed

elapsed time: 724m

configs tested: 138
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
i386                          randconfig-c001
mips                       bmips_be_defconfig
sh                         ecovec24_defconfig
arm                        oxnas_v6_defconfig
mips                           ci20_defconfig
powerpc                  storcenter_defconfig
sh                           sh2007_defconfig
h8300                       h8s-sim_defconfig
sh                               alldefconfig
powerpc                      arches_defconfig
sh                           se7343_defconfig
powerpc                     stx_gp3_defconfig
powerpc                     ep8248e_defconfig
parisc                generic-64bit_defconfig
xtensa                           alldefconfig
sh                              ul2_defconfig
arm                           sama5_defconfig
powerpc                     tqm8548_defconfig
m68k                          atari_defconfig
powerpc                     tqm8541_defconfig
powerpc                     tqm8555_defconfig
h8300                               defconfig
sh                          urquell_defconfig
sh                          sdk7780_defconfig
powerpc                      ppc40x_defconfig
m68k                       m5475evb_defconfig
arc                        nsimosci_defconfig
nios2                            alldefconfig
sh                           se7750_defconfig
sh                        apsh4ad0a_defconfig
ia64                          tiger_defconfig
openrisc                 simple_smp_defconfig
xtensa                         virt_defconfig
arm                  randconfig-c002-20220313
arm                  randconfig-c002-20220314
ia64                                defconfig
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
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                               defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                 randconfig-a003-20220314
i386                 randconfig-a004-20220314
i386                 randconfig-a001-20220314
i386                 randconfig-a006-20220314
i386                 randconfig-a002-20220314
i386                 randconfig-a005-20220314
x86_64               randconfig-a004-20220314
x86_64               randconfig-a005-20220314
x86_64               randconfig-a003-20220314
x86_64               randconfig-a002-20220314
x86_64               randconfig-a006-20220314
x86_64               randconfig-a001-20220314
arc                  randconfig-r043-20220313
arc                  randconfig-r043-20220314
riscv                randconfig-r042-20220313
s390                 randconfig-r044-20220313
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                       rbtx49xx_defconfig
arm                       mainstone_defconfig
mips                            e55_defconfig
arm                          ep93xx_defconfig
arm                          ixp4xx_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a014-20220314
x86_64               randconfig-a015-20220314
x86_64               randconfig-a016-20220314
x86_64               randconfig-a012-20220314
x86_64               randconfig-a013-20220314
x86_64               randconfig-a011-20220314
i386                 randconfig-a013-20220314
i386                 randconfig-a015-20220314
i386                 randconfig-a014-20220314
i386                 randconfig-a011-20220314
i386                 randconfig-a016-20220314
i386                 randconfig-a012-20220314
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220314
hexagon              randconfig-r045-20220313
riscv                randconfig-r042-20220314
hexagon              randconfig-r041-20220313
hexagon              randconfig-r041-20220314

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
