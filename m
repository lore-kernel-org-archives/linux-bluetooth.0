Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D438C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Oct 2022 09:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJKJsX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Oct 2022 05:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJKJsT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Oct 2022 05:48:19 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6796675FEC
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Oct 2022 02:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665481698; x=1697017698;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FEjedHDzHNlyoBvwnuCeBjGDMsAgOJIZxj5uo+malY4=;
  b=SWuv4S7pwt+AlcsGgdrxu8mxlnary8NmLOmCsd8bj999YaHxOh6oEi17
   tvN/KKqNSuXTPckkklfat2oiwlA7TONFggbsnsSLcqmJZU3XTTv3uhuTT
   kL0UPLWFYXDdhLR6IDgXBj2alY7eZ9FVyc841X5/Awkbt7KwoUnCtrWup
   2DpTeS0X7zxzwhhaGSO3DoSwF9bxO/vSVYtFVHsyS2bwbGdU2k/sOgz/8
   meAdivTHCP3Z1nd67KL8z4EogS2cCtciQ4XthT1YPfddewQlFWRSwYRrP
   i2j8iGBSxt0udmT4T0S1JfcMoxuZNR5w1/h6TQ6G4/gB95Fnzywia93AT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="368624587"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="368624587"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 02:48:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="577378880"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="577378880"
Received: from lkp-server01.sh.intel.com (HELO 2af0a69ca4e0) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 Oct 2022 02:48:16 -0700
Received: from kbuild by 2af0a69ca4e0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oiBs0-0002iC-15;
        Tue, 11 Oct 2022 09:48:16 +0000
Date:   Tue, 11 Oct 2022 17:47:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 8549542298e92bbf78f8139779e87a829b00eb02
Message-ID: <63453bca./aNoR1t5Pno2dZzd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 8549542298e92bbf78f8139779e87a829b00eb02  Bluetooth: hci_sync: Fix not able to set force_static_address

elapsed time: 725m

configs tested: 101
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
um                           x86_64_defconfig
um                             i386_defconfig
s390                                defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
arc                  randconfig-r043-20221010
x86_64                           rhel-8.3-kvm
s390                 randconfig-r044-20221010
riscv                randconfig-r042-20221010
s390                             allyesconfig
x86_64                              defconfig
i386                                defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
arm                                 defconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
arc                              allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
i386                             allyesconfig
alpha                            allyesconfig
i386                 randconfig-a012-20221010
i386                 randconfig-a011-20221010
arm64                            allyesconfig
powerpc                           allnoconfig
arm                              allyesconfig
i386                 randconfig-a013-20221010
m68k                             allyesconfig
i386                 randconfig-a015-20221010
m68k                             allmodconfig
i386                 randconfig-a014-20221010
i386                 randconfig-a016-20221010
x86_64               randconfig-a011-20221010
x86_64               randconfig-a012-20221010
x86_64               randconfig-a013-20221010
x86_64               randconfig-a016-20221010
x86_64               randconfig-a014-20221010
x86_64               randconfig-a015-20221010
sh                               allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
sh                           se7206_defconfig
sh                        edosk7760_defconfig
ia64                             allmodconfig
x86_64               randconfig-k001-20221010
i386                 randconfig-c001-20221010
arm                         s3c6400_defconfig
arm                         lubbock_defconfig
m68k                        m5272c3_defconfig
arm                        clps711x_defconfig
m68k                          hp300_defconfig
arm                      footbridge_defconfig
sh                     sh7710voipgw_defconfig
loongarch                        allmodconfig
arm                      integrator_defconfig
sh                           se7750_defconfig
sh                             shx3_defconfig
mips                      maltasmvp_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                         ps3_defconfig
powerpc                      pcm030_defconfig
csky                                defconfig
arc                     nsimosci_hs_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                            lart_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                      fuloong2e_defconfig
mips                           jazz_defconfig
mips                         rt305x_defconfig
openrisc                    or1ksim_defconfig
m68k                        m5407c3_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                     pq2fads_defconfig
powerpc                   currituck_defconfig

clang tested configs:
hexagon              randconfig-r041-20221010
hexagon              randconfig-r045-20221010
i386                 randconfig-a002-20221010
i386                 randconfig-a001-20221010
i386                 randconfig-a006-20221010
i386                 randconfig-a003-20221010
i386                 randconfig-a004-20221010
i386                 randconfig-a005-20221010
x86_64               randconfig-a004-20221010
x86_64               randconfig-a001-20221010
x86_64               randconfig-a002-20221010
x86_64               randconfig-a006-20221010
x86_64               randconfig-a003-20221010
x86_64               randconfig-a005-20221010
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
