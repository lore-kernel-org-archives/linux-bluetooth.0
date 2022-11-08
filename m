Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8225C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Nov 2022 20:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiKHUZE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Nov 2022 15:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKHUZD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Nov 2022 15:25:03 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A53220D9
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Nov 2022 12:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667939102; x=1699475102;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2Br8uR9Mh/pj4MWH2gqioWE54IOcej+xSzGiRHeWWxk=;
  b=Cv65Sr0OSERo28aqeEHrO5sHgEKI+BP9jOJv5ELIV0Uak5TJz/k1THGy
   LdoWuuoss5/zcnIFBSiI9dCTwxjGk1tFBjwBF9qkhJSaBzTot95pgyelX
   DK0tpdmMvwEEkX/C0pmdhLVhWEgpPw+l532unKdEdgkcOWzGzqtwgkmx6
   RBD6od1Fb5ddcaG9SoH+sDq6B9ZSBFvPLixsRUSDkKTY6eh2PG4tOc7HW
   14YhR/PrgRoozvoFIuuk8QwSY5WXErJPkddbMpiqS+JLIRsJAK2IWKzDk
   YQhXwaud+rVcsPjGsQBCuTbSbiYDSDxgbQ257onegNEDwAxI4ujGlS3JE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="294171484"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="294171484"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 12:25:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="965724311"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="965724311"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 08 Nov 2022 12:25:00 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1osV9X-0000ai-2m;
        Tue, 08 Nov 2022 20:24:59 +0000
Date:   Wed, 09 Nov 2022 04:24:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 ab80b2cec05fec4b9f3f93d33cc78463b33e8a6c
Message-ID: <636abaeb./fpFRALbfusOm7yv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: ab80b2cec05fec4b9f3f93d33cc78463b33e8a6c  Bluetooth: hci_bcm4377: Add new driver for BCM4377 PCIe boards

elapsed time: 728m

configs tested: 136
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                            allnoconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
ia64                             allmodconfig
arm                      footbridge_defconfig
arm                           tegra_defconfig
sh                           sh2007_defconfig
arc                    vdk_hs38_smp_defconfig
sparc                            alldefconfig
i386                             allyesconfig
i386                          randconfig-a016
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-a001-20221107
i386                 randconfig-a006-20221107
i386                 randconfig-a003-20221107
i386                 randconfig-a002-20221107
i386                 randconfig-a005-20221107
i386                 randconfig-a004-20221107
powerpc                        warp_defconfig
microblaze                          defconfig
m68k                        stmark2_defconfig
powerpc                      pasemi_defconfig
i386                                defconfig
x86_64               randconfig-a006-20221107
x86_64               randconfig-a001-20221107
x86_64               randconfig-a004-20221107
x86_64               randconfig-a003-20221107
x86_64               randconfig-a005-20221107
x86_64               randconfig-a002-20221107
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
powerpc                         ps3_defconfig
arm                           viper_defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
openrisc                    or1ksim_defconfig
powerpc                      ppc40x_defconfig
alpha                            alldefconfig
mips                        vocore2_defconfig
sh                             sh03_defconfig
powerpc                     rainier_defconfig
arm                           sama5_defconfig
sh                     sh7710voipgw_defconfig
arm                             pxa_defconfig
sh                            titan_defconfig
mips                  decstation_64_defconfig
powerpc                mpc7448_hpc2_defconfig
nios2                               defconfig
sh                          rsk7203_defconfig
powerpc                     asp8347_defconfig
nios2                            alldefconfig
powerpc                    sam440ep_defconfig
arm                             ezx_defconfig
sh                        edosk7705_defconfig
i386                          randconfig-c001
arc                              alldefconfig
sh                           se7751_defconfig
powerpc                 linkstation_defconfig
sh                           se7206_defconfig
ia64                         bigsur_defconfig
sh                          rsk7269_defconfig
arm                        shmobile_defconfig
arm                         at91_dt_defconfig
mips                      loongson3_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                     sequoia_defconfig
powerpc                     mpc83xx_defconfig
powerpc                       holly_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                             rpc_defconfig
sparc                       sparc32_defconfig
arm                          exynos_defconfig
mips                          rb532_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                        cerfcube_defconfig
arm                       aspeed_g5_defconfig
parisc                generic-32bit_defconfig
mips                           xway_defconfig
csky                             alldefconfig
sh                           se7712_defconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20221108
hexagon              randconfig-r045-20221108
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
powerpc                     tqm8560_defconfig
arm                           omap1_defconfig
mips                     cu1000-neo_defconfig
x86_64                        randconfig-k001
arm64                            allyesconfig
riscv                randconfig-r042-20221107
hexagon              randconfig-r041-20221107
hexagon              randconfig-r045-20221107
s390                 randconfig-r044-20221107

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
