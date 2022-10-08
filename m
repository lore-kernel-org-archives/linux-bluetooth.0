Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E05FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  8 Oct 2022 08:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJHIBh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 8 Oct 2022 04:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiJHIBg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 8 Oct 2022 04:01:36 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B0C252AC
        for <linux-bluetooth@vger.kernel.org>; Sat,  8 Oct 2022 01:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665216095; x=1696752095;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=wRzwEPEtLCVqc/W1e95WSvmgTWLlM7HeDSk1TvjETGU=;
  b=jtNT7FP5JfooRnqC4WKP0cylRAW/fMLTQphaG6Jv+7xiie+HdNbmJ1fA
   lrel53tXuLIoI5KiuMKdtZKx9KIuGvpT6zT+7GIJyQ28wjZU6MeSa7R3m
   RTupTb4zVnIf99ry8m32AQvjoYzLa7QCUt4YxuzibVd5SpeOzurYono45
   bQyIkknFwWB6xQ5olxs3Huz3L1sPMr/eZmq7mxeC+7PsL0zSkii1Raj5d
   PIZo5T/sKmqjJlw+Z9hxrt0lve5ftmE1ldzng8IOxuc/5OhEjZ/ZL8VUN
   ZEW99YwHahzgdjUefJR0GfrEfLX4VjanHvwblsE5lRNFGE1EqqpK0Dogd
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="301513711"
X-IronPort-AV: E=Sophos;i="5.95,169,1661842800"; 
   d="scan'208";a="301513711"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2022 01:01:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="620509352"
X-IronPort-AV: E=Sophos;i="5.95,169,1661842800"; 
   d="scan'208";a="620509352"
Received: from lkp-server01.sh.intel.com (HELO 3c15167049b7) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 08 Oct 2022 01:01:33 -0700
Received: from kbuild by 3c15167049b7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oh4m5-0001xD-0m;
        Sat, 08 Oct 2022 08:01:33 +0000
Date:   Sat, 08 Oct 2022 16:01:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 7df90b55ae9a37c919494e5a3da87a73d5842a04
Message-ID: <63412e57.Y7uZOdM4D7WOCDIT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 7df90b55ae9a37c919494e5a3da87a73d5842a04  Bluetooth: Work around SCO over USB HCI design defect

elapsed time: 726m

configs tested: 130
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
arc                                 defconfig
sh                               allmodconfig
alpha                               defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
s390                                defconfig
s390                             allmodconfig
x86_64                          rhel-8.3-func
arm                                 defconfig
x86_64                    rhel-8.3-kselftests
s390                             allyesconfig
i386                             allyesconfig
i386                                defconfig
m68k                             allmodconfig
i386                 randconfig-a011-20221003
i386                 randconfig-a016-20221003
i386                 randconfig-a012-20221003
i386                 randconfig-a014-20221003
i386                 randconfig-a015-20221003
i386                 randconfig-a013-20221003
arc                              allyesconfig
alpha                            allyesconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
m68k                             allyesconfig
x86_64               randconfig-a011-20221003
x86_64               randconfig-a016-20221003
x86_64               randconfig-a014-20221003
x86_64               randconfig-a013-20221003
x86_64               randconfig-a012-20221003
x86_64               randconfig-a015-20221003
arm64                            allyesconfig
arm                              allyesconfig
riscv                randconfig-r042-20221007
arc                  randconfig-r043-20221007
s390                 randconfig-r044-20221007
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arm                           imxrt_defconfig
arm                            zeus_defconfig
nios2                            alldefconfig
arm                           viper_defconfig
i386                          randconfig-c001
arm                           sunxi_defconfig
sparc                       sparc64_defconfig
parisc                generic-64bit_defconfig
arm                             ezx_defconfig
powerpc                     ep8248e_defconfig
sh                  sh7785lcr_32bit_defconfig
sparc64                          alldefconfig
arc                        nsim_700_defconfig
mips                         db1xxx_defconfig
powerpc                    sam440ep_defconfig
sh                          rsk7269_defconfig
parisc                           alldefconfig
sh                        sh7757lcr_defconfig
arm                        realview_defconfig
sh                          polaris_defconfig
sh                     magicpanelr2_defconfig
powerpc                       maple_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sh                        dreamcast_defconfig
s390                          debug_defconfig
powerpc                     asp8347_defconfig
mips                 randconfig-c004-20221002
powerpc                     sequoia_defconfig
m68k                          multi_defconfig
riscv                randconfig-r042-20221003
arc                  randconfig-r043-20221003
arc                  randconfig-r043-20221002
s390                 randconfig-r044-20221003
um                               alldefconfig
sh                          kfr2r09_defconfig
powerpc                        warp_defconfig
m68k                        stmark2_defconfig
powerpc                    klondike_defconfig
arm                        oxnas_v6_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
ia64                             allmodconfig
arm                       imx_v6_v7_defconfig
powerpc                         wii_defconfig
powerpc                     taishan_defconfig
sh                          landisk_defconfig
arm                             pxa_defconfig
sh                             sh03_defconfig
arm                         lubbock_defconfig
sparc                            alldefconfig
sh                           se7705_defconfig
arm                  randconfig-c002-20221002
x86_64                        randconfig-c001
sh                          r7780mp_defconfig
ia64                                defconfig
arm                          badge4_defconfig
arc                        vdk_hs38_defconfig
powerpc                     redwood_defconfig
nios2                               defconfig
ia64                      gensparse_defconfig
arm                          lpd270_defconfig

clang tested configs:
i386                 randconfig-a001-20221003
i386                 randconfig-a006-20221003
i386                 randconfig-a002-20221003
i386                 randconfig-a003-20221003
i386                 randconfig-a005-20221003
i386                 randconfig-a004-20221003
x86_64               randconfig-a003-20221003
x86_64               randconfig-a005-20221003
x86_64               randconfig-a001-20221003
x86_64               randconfig-a004-20221003
x86_64               randconfig-a002-20221003
x86_64               randconfig-a006-20221003
arm                        mvebu_v5_defconfig
s390                             alldefconfig
powerpc                 mpc832x_mds_defconfig
mips                          ath25_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
