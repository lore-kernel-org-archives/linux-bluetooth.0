Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A590AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Mar 2022 01:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345224AbiCKBFQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Mar 2022 20:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237426AbiCKBFM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Mar 2022 20:05:12 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF32C7D72
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Mar 2022 17:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646960650; x=1678496650;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=MZsfe0WgwaNSrI+f5fWxgUqa/TRG5TqERkdMdTAvYM4=;
  b=a+ogPL2q0TG5WZqeW7gYaPd+cx7YyuYCvayMRDrEpkuRe9TJ600nJUD7
   tDcnGZ5hCjEjvVGUl2r+gnSaDwzE4NquMv6Nc3d3NW1Qim0OIYaPRx4OR
   RNBnlV4EijOTNxAetiQ5cPc25ebYLBC4BGFMSLJOMbWZywyPaXZzEmw2w
   wT1HKm+Yh8UalvUg0zdPVb0pjNTcgo4Yr3bNgmB7qzh/F/XFUwfwZIBnM
   3jjyPnvhgEawuvWnrF41dms4hjfdp2JJt3inXt4LW2adq30Fjh25oWS2Y
   kA0qJDXOisVnEl4UnVLmze5RZAjRUMt3yb3eKi+X2APfojYF4/WO0RtMC
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="341887158"
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="341887158"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 17:02:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="548277954"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 10 Mar 2022 17:02:10 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSTfW-0005bF-4k; Fri, 11 Mar 2022 01:02:10 +0000
Date:   Fri, 11 Mar 2022 09:01:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 4afc6c7435575398b4a3d045ccc8a8b1eab02fe9
Message-ID: <622a9f75.MREjiHEKyL+vYdaC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 4afc6c7435575398b4a3d045ccc8a8b1eab02fe9  Bluetooth: btusb: Use quirk to skip HCI_FLT_CLEAR_ALL on fake CSR controllers

elapsed time: 721m

configs tested: 113
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
powerpc                 mpc8540_ads_defconfig
arm                            pleb_defconfig
microblaze                          defconfig
arm                           stm32_defconfig
powerpc                        cell_defconfig
sh                           se7750_defconfig
sh                         ap325rxa_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                 canyonlands_defconfig
arc                        nsim_700_defconfig
sh                        edosk7705_defconfig
openrisc                    or1ksim_defconfig
arc                        vdk_hs38_defconfig
sh                  sh7785lcr_32bit_defconfig
arm64                            alldefconfig
arm                         s3c6400_defconfig
ia64                                defconfig
arm                        keystone_defconfig
sh                            shmin_defconfig
h8300                    h8300h-sim_defconfig
powerpc                     tqm8548_defconfig
arm                  randconfig-c002-20220310
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
nios2                            allyesconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220310
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
powerpc                 mpc836x_rdk_defconfig
powerpc                  mpc866_ads_defconfig
arm                       cns3420vb_defconfig
riscv                          rv32_defconfig
powerpc                     ppa8548_defconfig
arm                         orion5x_defconfig
powerpc                     ksi8560_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r041-20220310
hexagon              randconfig-r045-20220310
s390                 randconfig-r044-20220310
riscv                randconfig-r042-20220310

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
