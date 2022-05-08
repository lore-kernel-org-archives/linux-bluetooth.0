Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E07C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 May 2022 13:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbiEHNJn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 8 May 2022 09:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiEHNJl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 8 May 2022 09:09:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7060538F
        for <linux-bluetooth@vger.kernel.org>; Sun,  8 May 2022 06:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652015151; x=1683551151;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=fEBWk8SQT+J6ngaMgRhqPI7/r2f50dPhT3bC5rJL1FY=;
  b=eOtruFnE8wESSI2MiFrOuj8us7uVpxW4Vp21WgCNZ1MeBtLtSdMV2/3n
   sJV09VmSznN2krs74sepCF5hwEqZFGjlr3wTVjBABP6RNwlHwdeE6pdfY
   CnDHPfUkbwpTEjp08loCJwdyLDEbgsCSO9HrlZFt0KMMtK7wy8xaSckUI
   Nhhh3TiHVId+zZ4XoVezXJ4NnoxLCNr4G3eQuB9oTnoUfidnt50Z8BOw9
   MTp2w/IIbigo28IV2p1I1kuNnLD/CXs87XjXE0N9hZmYmZAUbxNfs7MEV
   NfeY0c0iglco/d9VKZvEosyZCqpZ6QMn5Bs0WXfeWLTL1SrXfegOKkjYq
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10340"; a="248739924"
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="248739924"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 06:05:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="892592344"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 08 May 2022 06:05:49 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nngbd-000FUh-5Z;
        Sun, 08 May 2022 13:05:49 +0000
Date:   Sun, 08 May 2022 21:05:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 a99a4899aae6d5f2f868215f46509d260bf3bbf3
Message-ID: <6277c022.r8wR4bXGpbx/Mscp%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: a99a4899aae6d5f2f868215f46509d260bf3bbf3  Bluetooth: btusb: Add a new PID/VID 0489/e0c8 for MT7921

elapsed time: 11770m

configs tested: 233
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
sh                             espt_defconfig
i386                                defconfig
powerpc                     tqm8555_defconfig
mips                         tb0226_defconfig
powerpc                      cm5200_defconfig
powerpc                       holly_defconfig
xtensa                           allyesconfig
powerpc                         ps3_defconfig
arc                     haps_hs_smp_defconfig
arc                            hsdk_defconfig
arm                         vf610m4_defconfig
arm                         lubbock_defconfig
m68k                                defconfig
sh                          sdk7780_defconfig
arm                      footbridge_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     pq2fads_defconfig
mips                         cobalt_defconfig
powerpc                 canyonlands_defconfig
arm                     eseries_pxa_defconfig
sh                           se7780_defconfig
arc                              alldefconfig
parisc                generic-32bit_defconfig
h8300                            alldefconfig
powerpc                       eiger_defconfig
sh                          kfr2r09_defconfig
powerpc                   currituck_defconfig
mips                            gpr_defconfig
arm                      integrator_defconfig
microblaze                          defconfig
mips                         rt305x_defconfig
alpha                            alldefconfig
powerpc                      ep88xc_defconfig
arm                           imxrt_defconfig
arm                       multi_v4t_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                    klondike_defconfig
arm                         lpc18xx_defconfig
parisc64                            defconfig
sh                         ap325rxa_defconfig
xtensa                  nommu_kc705_defconfig
arm                         at91_dt_defconfig
arm                            mps2_defconfig
mips                      maltasmvp_defconfig
sparc64                             defconfig
arm                           sunxi_defconfig
powerpc                       maple_defconfig
m68k                       m5249evb_defconfig
mips                           ip32_defconfig
powerpc                     asp8347_defconfig
powerpc                     taishan_defconfig
arm                       omap2plus_defconfig
mips                  decstation_64_defconfig
mips                      fuloong2e_defconfig
nios2                         3c120_defconfig
m68k                        stmark2_defconfig
powerpc64                           defconfig
sh                        edosk7760_defconfig
s390                          debug_defconfig
sh                      rts7751r2d1_defconfig
powerpc                    adder875_defconfig
mips                            ar7_defconfig
arm                          lpd270_defconfig
openrisc                  or1klitex_defconfig
ia64                            zx1_defconfig
sh                          rsk7269_defconfig
xtensa                    xip_kc705_defconfig
powerpc                           allnoconfig
parisc                              defconfig
sh                        sh7757lcr_defconfig
powerpc64                        alldefconfig
arm                           sama5_defconfig
m68k                        m5307c3_defconfig
sh                        apsh4ad0a_defconfig
powerpc                     sequoia_defconfig
powerpc                     mpc83xx_defconfig
powerpc                    amigaone_defconfig
xtensa                  audio_kc705_defconfig
m68k                            q40_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                            xcep_defconfig
arm                        oxnas_v6_defconfig
powerpc                      ppc40x_defconfig
arm                            lart_defconfig
powerpc                      arches_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                             allyesconfig
h8300                       h8s-sim_defconfig
sh                           sh2007_defconfig
xtensa                    smp_lx200_defconfig
um                             i386_defconfig
sh                           se7721_defconfig
sh                           se7705_defconfig
sh                          polaris_defconfig
m68k                         amcore_defconfig
m68k                       m5475evb_defconfig
arm                        keystone_defconfig
alpha                            allyesconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220501
arm                  randconfig-c002-20220505
x86_64               randconfig-c001-20220502
i386                 randconfig-c001-20220502
arm                  randconfig-c002-20220502
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
nios2                               defconfig
arc                              allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a006-20220502
x86_64               randconfig-a001-20220502
x86_64               randconfig-a003-20220502
x86_64                        randconfig-a002
i386                 randconfig-a004-20220502
i386                 randconfig-a006-20220502
i386                 randconfig-a002-20220502
i386                 randconfig-a003-20220502
i386                 randconfig-a001-20220502
x86_64                        randconfig-a011
x86_64                        randconfig-a013
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220501
s390                 randconfig-r044-20220501
riscv                randconfig-r042-20220501
arc                  randconfig-r043-20220505
s390                 randconfig-r044-20220505
riscv                randconfig-r042-20220505
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220501
riscv                randconfig-c006-20220501
mips                 randconfig-c004-20220501
arm                  randconfig-c002-20220501
powerpc              randconfig-c003-20220505
riscv                randconfig-c006-20220505
arm                  randconfig-c002-20220505
arm                       mainstone_defconfig
arm                         bcm2835_defconfig
arm                          collie_defconfig
mips                     loongson2k_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                    ge_imp3a_defconfig
mips                   sb1250_swarm_defconfig
arm                        magician_defconfig
riscv                             allnoconfig
powerpc                 mpc836x_rdk_defconfig
arm                           sama7_defconfig
riscv                    nommu_virt_defconfig
powerpc                  mpc866_ads_defconfig
mips                  cavium_octeon_defconfig
arm                          ep93xx_defconfig
arm                        neponset_defconfig
arm                          moxart_defconfig
powerpc                          g5_defconfig
mips                      maltaaprp_defconfig
hexagon                          alldefconfig
arm                         s3c2410_defconfig
powerpc                        fsp2_defconfig
powerpc                   microwatt_defconfig
mips                       lemote2f_defconfig
mips                        workpad_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                            dove_defconfig
powerpc                      katmai_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                     tqm8540_defconfig
mips                malta_qemu_32r6_defconfig
riscv                          rv32_defconfig
arm                        multi_v5_defconfig
powerpc                     kmeter1_defconfig
arm                       versatile_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a015-20220502
x86_64               randconfig-a012-20220502
x86_64               randconfig-a016-20220502
x86_64               randconfig-a014-20220502
x86_64               randconfig-a013-20220502
x86_64               randconfig-a011-20220502
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
hexagon              randconfig-r041-20220428
hexagon              randconfig-r045-20220430
riscv                randconfig-r042-20220428
hexagon              randconfig-r041-20220430
hexagon              randconfig-r045-20220428
hexagon              randconfig-r045-20220501
hexagon              randconfig-r041-20220501

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
