Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6AFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Feb 2022 01:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiBRBo2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Feb 2022 20:44:28 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiBRBo0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Feb 2022 20:44:26 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93976673D7
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 17:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645148650; x=1676684650;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=mNbl7N/LJRH3QjNedp48S1cq4hqDH657ZXTM76UdR3U=;
  b=nK12FNzSpQEgksFP0tB1u2zsZ0vR0XYMithsm4wcaXO1LDfHdL1nEW6o
   t5p3+5L8hlt82zcOa9iIulD0opZ6fU2GiKkn4mbm6pbzYW7KFjVA6STQe
   NrUT7KU7DYRk+iD9bD394akC1s9yOIR9/ScaLwtf4lKAyD+KAaahKTUfY
   xdsugiNypw0yrMsIB5pqW+uGRHTcr9t4duvUwRRFUnXN8NFp6K5p2u9nU
   8KpGsmUbc4YxtOfni2HEOSSHZqpn1OsV4dm0LXzDZApVLkTKXlGd9+EZf
   RNH7jhnuhIOvzDo/GW8RWOEONYatmPYU2Fl+eK0DBAmqZF4s3IB6r77S0
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="337470971"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="337470971"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 17:44:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="572099619"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 17 Feb 2022 17:44:08 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKsJc-0000ns-0K; Fri, 18 Feb 2022 01:44:08 +0000
Date:   Fri, 18 Feb 2022 09:43:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 e8e41e2b99cc4355fdf057fefcaf3db4b1ad6bc6
Message-ID: <620ef9ad.g11/AcOmGfheGP6g%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: e8e41e2b99cc4355fdf057fefcaf3db4b1ad6bc6  Bluetooth: mediatek: fix the conflict between mtk and msft vendor event

elapsed time: 728m

configs tested: 114
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
powerpc                       maple_defconfig
arc                                 defconfig
sh                         microdev_defconfig
mips                  decstation_64_defconfig
riscv                            allyesconfig
xtensa                  nommu_kc705_defconfig
xtensa                    xip_kc705_defconfig
m68k                       m5475evb_defconfig
arm                        spear6xx_defconfig
arm                            lart_defconfig
sh                            titan_defconfig
h8300                            alldefconfig
nios2                         3c120_defconfig
m68k                         apollo_defconfig
sh                           se7343_defconfig
sh                     sh7710voipgw_defconfig
powerpc                      pasemi_defconfig
arc                    vdk_hs38_smp_defconfig
x86_64                           alldefconfig
mips                           ip32_defconfig
mips                            gpr_defconfig
arc                         haps_hs_defconfig
xtensa                           alldefconfig
arm                           h5000_defconfig
ia64                         bigsur_defconfig
powerpc                      tqm8xx_defconfig
um                             i386_defconfig
m68k                         amcore_defconfig
arm                          pxa3xx_defconfig
ia64                          tiger_defconfig
m68k                           sun3_defconfig
powerpc                        cell_defconfig
powerpc                      makalu_defconfig
arm                  randconfig-c002-20220217
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
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20220217
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220217
arm                  randconfig-c002-20220217
i386                          randconfig-c001
mips                 randconfig-c004-20220217
arm                     davinci_all_defconfig
arm                      tct_hammer_defconfig
arm                     am200epdkit_defconfig
powerpc                     tqm5200_defconfig
arm                        magician_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220217
hexagon              randconfig-r041-20220217
riscv                randconfig-r042-20220217

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
