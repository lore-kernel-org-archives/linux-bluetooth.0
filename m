Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C131EC433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Apr 2021 17:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9802061184
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Apr 2021 17:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbhDGRmZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Apr 2021 13:42:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:35116 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229605AbhDGRmZ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Apr 2021 13:42:25 -0400
IronPort-SDR: kpcn3ubxcWuL/WUpQVzBDJoAt0B51iLv2QiUR/7nPpOSS+3YBpJ36+WL2hqRp0qQA9QgDHUTB/
 lxD6ER6vi6ow==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="180907003"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="180907003"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 10:42:08 -0700
IronPort-SDR: 4VozG730Nh0s1+1mWNZsvmHlpl5NMtrLqzZZ/gq3LRTxrmqGt4zsfeL/sxNlAG6CWyf8A37MIg
 uSdmkmWY2+dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="609765542"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 07 Apr 2021 10:42:06 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lUCBp-000DYs-Nz; Wed, 07 Apr 2021 17:42:05 +0000
Date:   Thu, 08 Apr 2021 01:41:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS WITH WARNING
 dc800a9106573bc39d15990ce57f1454d76c79cc
Message-ID: <606deee3.2JvXYdFcyhvpVTLC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: dc800a9106573bc39d15990ce57f1454d76c79cc  Bluetooth: Allow Microsoft extension to indicate curve validation

possible Warning in current branch:

drivers/bluetooth/virtio_bt.c:303:17: sparse:    bad type *
drivers/bluetooth/virtio_bt.c:303:17: sparse:    unsigned short *
drivers/bluetooth/virtio_bt.c:303:17: sparse: sparse: incompatible types in comparison expression (different base types):
drivers/bluetooth/virtio_bt.c:303:17: sparse: sparse: no generic selection for 'unsigned short [addressable] virtio_cread_v'
drivers/bluetooth/virtio_bt.c:303:17: sparse: sparse: no generic selection for 'unsigned short virtio_cread_v'

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- powerpc-randconfig-s032-20210407
    |-- drivers-bluetooth-virtio_bt.c:sparse:bad-type
    |-- drivers-bluetooth-virtio_bt.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-base-types):
    |-- drivers-bluetooth-virtio_bt.c:sparse:sparse:no-generic-selection-for-unsigned-short-addressable-virtio_cread_v
    |-- drivers-bluetooth-virtio_bt.c:sparse:sparse:no-generic-selection-for-unsigned-short-virtio_cread_v
    `-- drivers-bluetooth-virtio_bt.c:sparse:unsigned-short

elapsed time: 729m

configs tested: 142
configs skipped: 3

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
nds32                            alldefconfig
powerpc                   motionpro_defconfig
powerpc                 linkstation_defconfig
mips                       capcella_defconfig
arm                          pxa168_defconfig
nios2                               defconfig
arc                          axs101_defconfig
alpha                            alldefconfig
mips                        nlm_xlp_defconfig
m68k                                defconfig
powerpc                 mpc834x_itx_defconfig
mips                  maltasmvp_eva_defconfig
arm                       netwinder_defconfig
arm                     am200epdkit_defconfig
mips                          rb532_defconfig
powerpc                   currituck_defconfig
mips                         tb0287_defconfig
arm                         lpc18xx_defconfig
powerpc                      ep88xc_defconfig
arm                     eseries_pxa_defconfig
sparc                            alldefconfig
sparc                       sparc32_defconfig
arm                       aspeed_g4_defconfig
arm                             pxa_defconfig
powerpc                      mgcoge_defconfig
arm                        keystone_defconfig
powerpc64                           defconfig
powerpc                    mvme5100_defconfig
m68k                          sun3x_defconfig
arm                         mv78xx0_defconfig
sh                          sdk7780_defconfig
powerpc                      arches_defconfig
csky                             alldefconfig
arc                     nsimosci_hs_defconfig
powerpc                           allnoconfig
powerpc                     pq2fads_defconfig
m68k                        mvme16x_defconfig
mips                           rs90_defconfig
sh                             shx3_defconfig
sh                           sh2007_defconfig
arm                            qcom_defconfig
arm                            hisi_defconfig
ia64                            zx1_defconfig
arm                        neponset_defconfig
mips                           ci20_defconfig
arm                         shannon_defconfig
mips                        jmr3927_defconfig
arm                          ep93xx_defconfig
mips                        nlm_xlr_defconfig
sh                        sh7757lcr_defconfig
powerpc                     powernv_defconfig
powerpc                 mpc8313_rdb_defconfig
ia64                        generic_defconfig
sh                              ul2_defconfig
mips                           ip28_defconfig
powerpc                   lite5200b_defconfig
ia64                          tiger_defconfig
mips                            gpr_defconfig
arc                      axs103_smp_defconfig
powerpc                      katmai_defconfig
arm                        mini2440_defconfig
powerpc                      acadia_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                    adder875_defconfig
arm                       aspeed_g5_defconfig
arm                          ixp4xx_defconfig
sh                          rsk7203_defconfig
powerpc                      pcm030_defconfig
arm                       multi_v4t_defconfig
arm                       spear13xx_defconfig
riscv                          rv32_defconfig
sh                          kfr2r09_defconfig
powerpc                      walnut_defconfig
arm                          simpad_defconfig
arc                                 defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
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
i386                 randconfig-a006-20210407
i386                 randconfig-a003-20210407
i386                 randconfig-a001-20210407
i386                 randconfig-a004-20210407
i386                 randconfig-a002-20210407
i386                 randconfig-a005-20210407
x86_64               randconfig-a014-20210407
x86_64               randconfig-a015-20210407
x86_64               randconfig-a013-20210407
x86_64               randconfig-a011-20210407
x86_64               randconfig-a012-20210407
x86_64               randconfig-a016-20210407
i386                 randconfig-a014-20210407
i386                 randconfig-a011-20210407
i386                 randconfig-a016-20210407
i386                 randconfig-a012-20210407
i386                 randconfig-a015-20210407
i386                 randconfig-a013-20210407
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
