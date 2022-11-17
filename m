Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC731C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Nov 2022 18:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbiKQS5N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 13:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiKQS5M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 13:57:12 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5754886A55
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 10:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668711431; x=1700247431;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=hFRjZ+2862KaoR1qR7H9b1CZFMNDvUqx5u8Vs/sZ5eM=;
  b=W8J11G1/Xw/lu0jsAUqEXCX+U+CxG4MoPodIWooLIYfbhStNzyIYogjI
   whKAWBKwwuJSOzLTvZFHS3e8U3vIj9LscuEp93S/icTsl8ak8wEduzNTX
   xFMeRlWHLm+ZDfpKR/a8R2N8tPK9jL7Nlic4rWI8hPt3X664y8Zg6JYdX
   R6K8CU7Kf36ZI947WgLTt+Gz70modsqAvFibaUHcbYy5Kyn7de/cYO+4I
   fRn0+WLVeE/5mCCB8mnzzIGZqZ3n3ydeMxhHH9h8qEca8qaXy5FjMi9gy
   /siVprR7KUU+ptXQ2sECd6y1P2Ts2GnUIMZ8V+ufV3af+DuGnIneYsi4I
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="296306789"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="296306789"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 10:57:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="764877682"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="764877682"
Received: from lkp-server01.sh.intel.com (HELO 55744f5052f8) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 17 Nov 2022 10:57:09 -0800
Received: from kbuild by 55744f5052f8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ovk4S-0000Yx-30;
        Thu, 17 Nov 2022 18:57:08 +0000
Date:   Fri, 18 Nov 2022 02:56:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 c3fd63f7fe5afd98b7d9f5d8d45be08825ec1065
Message-ID: <637683d6.px5HJDEGpwjka11t%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: c3fd63f7fe5afd98b7d9f5d8d45be08825ec1065  Bluetooth: silence a dmesg error message in hci_request.c

elapsed time: 1269m

configs tested: 85
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
i386                          randconfig-a001
um                             i386_defconfig
powerpc                           allnoconfig
i386                          randconfig-a003
i386                          randconfig-a005
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
sh                               allmodconfig
s390                                defconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
mips                             allyesconfig
x86_64                               rhel-8.3
powerpc                          allmodconfig
s390                             allyesconfig
x86_64                              defconfig
ia64                             allmodconfig
x86_64                           allyesconfig
x86_64                        randconfig-a006
arc                  randconfig-r043-20221117
riscv                randconfig-r042-20221117
s390                 randconfig-r044-20221117
x86_64                        randconfig-a015
i386                          randconfig-a016
i386                                defconfig
m68k                             allyesconfig
x86_64                            allnoconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
sh                          sdk7786_defconfig
arm                            zeus_defconfig
openrisc                            defconfig
i386                             allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
um                               alldefconfig
sh                           se7722_defconfig
sh                         ap325rxa_defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-c001
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                       omap2plus_defconfig
arm                           stm32_defconfig
sh                           se7705_defconfig
powerpc                       maple_defconfig
sh                        edosk7705_defconfig
m68k                       m5249evb_defconfig
sparc64                             defconfig
x86_64                           alldefconfig
arc                     nsimosci_hs_defconfig
arm                        trizeps4_defconfig
sh                          rsk7264_defconfig
s390                          debug_defconfig
m68k                        stmark2_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                        shmobile_defconfig
powerpc                 linkstation_defconfig
sh                          sdk7780_defconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a005
hexagon              randconfig-r041-20221117
hexagon              randconfig-r045-20221117
x86_64                        randconfig-a016
powerpc                          g5_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
