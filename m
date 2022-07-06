Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA9FC43334
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jul 2022 06:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiGFG7e (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Jul 2022 02:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiGFG7d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Jul 2022 02:59:33 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140A31EAFC
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Jul 2022 23:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657090773; x=1688626773;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=3K0r0mU6t/0Ee7qTvIWZqIkqXrgPB7eWeQO7XkTocJI=;
  b=H6LAGupBnD9Ez5xJRwgNv8rl+m8qggIOzaOLOboMGwYOaCrGEWPqe/kN
   XEEf0fXZgKR8TVfqorx7gXRbTr2ubOnXsGqJKLcgE6X2IL86LelhS/SAC
   f++3yVZCr2HKcj2NXjvkf6pvJYql5XftOU0U9rIRWXU57gqLN45haUWKq
   U3NiuQZjWDYclIBSuqdOM/hOITELfr2hF9h9bcrjbP9qMbZZRlr8Zw5qX
   RRszDAm6q9jBO96e25pT8Jl31UZW9+rAftjarnvNZU9vKbcE+DXequUH1
   q0zWTUyGDAkCF6LbvOCIgb22OQPZ7vZAUTlhMQRVt4l+kI9c7IkSDIOXQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="347648536"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="347648536"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 23:59:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="660850022"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jul 2022 23:59:30 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8z0T-000KAf-Lk;
        Wed, 06 Jul 2022 06:59:29 +0000
Date:   Wed, 06 Jul 2022 14:59:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 bf909caec3902d174aea2ef3f4326e4715a56499
Message-ID: <62c532bd.KSM22OngLvRMGk5G%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: bf909caec3902d174aea2ef3f4326e4715a56499  Bluetooth: core: Fix deadlock on hci_power_on_sync.

elapsed time: 723m

configs tested: 98
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
xtensa                  audio_kc705_defconfig
sh                            shmin_defconfig
sh                            migor_defconfig
arc                         haps_hs_defconfig
sh                               j2_defconfig
arm                         lubbock_defconfig
m68k                          multi_defconfig
arc                     haps_hs_smp_defconfig
sh                           se7206_defconfig
x86_64                           alldefconfig
openrisc                            defconfig
sh                        sh7785lcr_defconfig
arm                           h3600_defconfig
alpha                            allyesconfig
m68k                        stmark2_defconfig
mips                       bmips_be_defconfig
m68k                        m5407c3_defconfig
sparc                       sparc64_defconfig
m68k                        mvme147_defconfig
sh                          polaris_defconfig
arm                         assabet_defconfig
arm                       multi_v4t_defconfig
xtensa                         virt_defconfig
sh                              ul2_defconfig
sh                          r7785rp_defconfig
m68k                       m5475evb_defconfig
m68k                          amiga_defconfig
sh                        sh7757lcr_defconfig
riscv                               defconfig
arc                          axs101_defconfig
arm                          gemini_defconfig
powerpc                     pq2fads_defconfig
openrisc                    or1ksim_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
ia64                             allmodconfig
arc                              allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220703
riscv                randconfig-r042-20220703
s390                 randconfig-r044-20220703
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3

clang tested configs:
mips                          ath79_defconfig
powerpc                     ksi8560_defconfig
powerpc                     kilauea_defconfig
mips                          ath25_defconfig
powerpc                     powernv_defconfig
mips                     cu1000-neo_defconfig
x86_64                        randconfig-k001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r045-20220703
hexagon              randconfig-r041-20220703

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
