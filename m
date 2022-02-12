Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1054C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Feb 2022 06:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbiBLGid (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Feb 2022 01:38:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiBLGic (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Feb 2022 01:38:32 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEC1275CF
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Feb 2022 22:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644647910; x=1676183910;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=u2rPHXxXEJMFyge2T+l5yLLD94oSS3hTsSUnE7uuDew=;
  b=dGA/bAr366AZzOTUYa+f3vd2iHQA91Nj14kJj5Cffto5NGBGWT8dT+aM
   YBUqb8vgJ9neq8WEDwvveQMIz+ZwbfgFnwmFj4yYO5wVYKVDimI+rMyGW
   HDfElR1e9nkOQ32bXVSH13bQzslR5yGbHWGYYqV/0bfVz94wSoERFH0zq
   cjyQPuwl3uzOAatm1MpXVB4tlWe4XzMQlDQEmUAM6fKwsGdH0aPJBSh66
   hEa+hmAEaVfk0sdZoweacaJAqsqncAXCfE9zPD/aSTXCj1nOnurhKgtcf
   UoUW+Xd5oMSIn7GKK2oM1yi+tDFC3AGoBMqiFWOgfZQmvJAFLqeGknDl3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="250066133"
X-IronPort-AV: E=Sophos;i="5.88,363,1635231600"; 
   d="scan'208";a="250066133"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 22:38:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,363,1635231600"; 
   d="scan'208";a="702348077"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 11 Feb 2022 22:38:28 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIm39-0005kj-Lc; Sat, 12 Feb 2022 06:38:27 +0000
Date:   Sat, 12 Feb 2022 14:37:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 9b9f89c60d64d1dd184e904e2757875644f29b6e
Message-ID: <620755a6.qyZviVRk56TgVdyw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 9b9f89c60d64d1dd184e904e2757875644f29b6e  Bluetooth: btusb: add support for LG LGSBWAC02 (MT7663BUN)

possible Warning in current branch (please contact us if interested):

drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c:147:0: warning: syntax error [syntaxError]

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- arc-randconfig-p002-20220211
    `-- drivers-net-ethernet-microchip-lan966x-lan966x_ptp.c:warning:syntax-error-syntaxError

elapsed time: 721m

configs tested: 148
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20220211
powerpc                      chrp32_defconfig
xtensa                    xip_kc705_defconfig
openrisc                            defconfig
mips                          rb532_defconfig
sh                               allmodconfig
m68k                          hp300_defconfig
mips                        bcm47xx_defconfig
xtensa                  cadence_csp_defconfig
sh                           se7722_defconfig
m68k                        m5407c3_defconfig
sh                        dreamcast_defconfig
ia64                        generic_defconfig
xtensa                       common_defconfig
ia64                             alldefconfig
powerpc                    adder875_defconfig
arm                        shmobile_defconfig
sh                          sdk7780_defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                         virt_defconfig
arm                         axm55xx_defconfig
m68k                       m5475evb_defconfig
arm                     eseries_pxa_defconfig
m68k                        m5307c3_defconfig
powerpc64                           defconfig
alpha                               defconfig
mips                           ci20_defconfig
alpha                            allyesconfig
mips                           ip32_defconfig
m68k                        stmark2_defconfig
sh                               alldefconfig
sh                        sh7757lcr_defconfig
powerpc                           allnoconfig
arm                          pxa3xx_defconfig
xtensa                generic_kc705_defconfig
arm                           sama5_defconfig
powerpc                      bamboo_defconfig
arc                     nsimosci_hs_defconfig
arm                           u8500_defconfig
ia64                      gensparse_defconfig
arm                          simpad_defconfig
sh                          landisk_defconfig
sh                              ul2_defconfig
m68k                        mvme16x_defconfig
mips                       bmips_be_defconfig
xtensa                    smp_lx200_defconfig
x86_64                              defconfig
mips                        vocore2_defconfig
arm                        realview_defconfig
m68k                        mvme147_defconfig
riscv                               defconfig
xtensa                           allyesconfig
sh                      rts7751r2d1_defconfig
powerpc                   motionpro_defconfig
sh                        edosk7760_defconfig
arm                       aspeed_g5_defconfig
arm                           viper_defconfig
sh                                  defconfig
arm                          gemini_defconfig
sh                          rsk7203_defconfig
arc                      axs103_smp_defconfig
um                           x86_64_defconfig
arm                  randconfig-c002-20220211
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
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220212
arc                  randconfig-r043-20220211
arc                  randconfig-r043-20220212
s390                 randconfig-r044-20220212
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20220211
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220211
arm                  randconfig-c002-20220211
i386                          randconfig-c001
mips                 randconfig-c004-20220211
arm                       imx_v4_v5_defconfig
mips                          ath79_defconfig
arm                         bcm2835_defconfig
arm                      tct_hammer_defconfig
arm                         s3c2410_defconfig
powerpc                      katmai_defconfig
powerpc                      ppc44x_defconfig
mips                        maltaup_defconfig
arm                          collie_defconfig
arm                         palmz72_defconfig
riscv                             allnoconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220211
hexagon              randconfig-r041-20220211
riscv                randconfig-r042-20220211

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
