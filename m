Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC1AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Apr 2022 22:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiDFWSx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Apr 2022 18:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiDFWSx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Apr 2022 18:18:53 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE5CA76D1
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Apr 2022 15:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649283415; x=1680819415;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=SmxEe1miYMt9Fa2o3KaxLC0OkzmxAW4/2fx3oA+nIaY=;
  b=PmA5F10wu8EcuI5WHkrhnpK//UsULmIzX1qeT4X32QVAhrgkHLazqgIY
   sSB8qH76QIolSPf3alBAJSCkEKQDAyLfT+v2DeWI2PRmu5TxqIVn4d0ou
   fLLTT4UhAyViy199QP5lYFuSDojxk0e/HdJKPO63Ya5XhpkF8FCxVm4O/
   OoauA1TDQu+6ugTYoeSc4pzSLQ2lZGUY9SNFR/a7FOaZqWyyXVOQJCd4I
   A0KwbHjYQVb0e1277WEwvxsQxyelG+Yizk0DB9CVbCXZ7JLvqgdhkKwmA
   nRgcuqJQuCEmKzu3VzVn7CeM0T9FoV/JD4Su/QBqS3s7qZzpfboJ+0V+B
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="324332389"
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="324332389"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 15:16:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="549745243"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 06 Apr 2022 15:16:53 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncDxM-0004oF-Rx;
        Wed, 06 Apr 2022 22:16:52 +0000
Date:   Thu, 07 Apr 2022 06:16:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 38a1944deda4d96ca04b9aaa51ee5ae879b61aa0
Message-ID: <624e1122.QC5Fldcg8UwfjyUf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 38a1944deda4d96ca04b9aaa51ee5ae879b61aa0  Bluetooth: btusb: Set HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN for QCA

elapsed time: 1666m

configs tested: 122
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arm                        spear6xx_defconfig
sh                        sh7757lcr_defconfig
xtensa                generic_kc705_defconfig
sh                           se7712_defconfig
m68k                         apollo_defconfig
sparc                               defconfig
mips                      loongson3_defconfig
xtensa                           alldefconfig
arc                     haps_hs_smp_defconfig
sh                           se7343_defconfig
openrisc                            defconfig
openrisc                         alldefconfig
sh                        edosk7705_defconfig
h8300                    h8300h-sim_defconfig
arm                        keystone_defconfig
powerpc                     sequoia_defconfig
arm                        multi_v7_defconfig
sh                          sdk7780_defconfig
m68k                          atari_defconfig
arm                           stm32_defconfig
powerpc                     stx_gp3_defconfig
powerpc                      cm5200_defconfig
parisc                              defconfig
h8300                       h8s-sim_defconfig
arm                         s3c6400_defconfig
powerpc                         ps3_defconfig
sh                          sdk7786_defconfig
arm                        realview_defconfig
s390                             allmodconfig
arc                 nsimosci_hs_smp_defconfig
m68k                       m5475evb_defconfig
xtensa                  nommu_kc705_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220406
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
s390                                defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                            allyesconfig
i386                             allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a016
i386                          randconfig-a012
i386                          randconfig-a014
arc                  randconfig-r043-20220405
arc                  randconfig-r043-20220406
s390                 randconfig-r044-20220406
riscv                randconfig-r042-20220406
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                                  kexec
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                          rm200_defconfig
mips                   sb1250_swarm_defconfig
arm                          pcm027_defconfig
powerpc                     mpc512x_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                 mpc8560_ads_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a015
hexagon              randconfig-r041-20220405
hexagon              randconfig-r045-20220405
s390                 randconfig-r044-20220405
riscv                randconfig-r042-20220405

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
