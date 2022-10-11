Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8B2C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Oct 2022 11:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiJKLR3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Oct 2022 07:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJKLR2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Oct 2022 07:17:28 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D1C6052E
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Oct 2022 04:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665487047; x=1697023047;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=o6tu3VDFcdon/xUVE1+IsPu6gc6lZm2kvJ8nbaVF5lU=;
  b=FxOs6kZI50oRsVxxHpiByTcBLlQDqzyObbmfe1FaoN27x1ZKWc3YwOfb
   lKOr9907cS+Otb5pNpQECnfRFyUUkIcSqMwCGwGgQuJS04hXzhzsp0MeD
   6lhQrYCaeByJgUwkAdqgB6NlASDaFFfR5Tv+E1ZjXL04u5LNcsKJMWK/O
   ounEAZdwAf79sez1jNV7D3eb/etSdN7l/1trwYcdii2m0S/Ft2jf2ZAF0
   7gFtPkthxockzeGJoRdMpdQKX+oNpqJ6G1IAg+GOTzGvS8yXgRwtNIDag
   HrtcuupyS6DJu0OE+0ZISi4Ey5pAMzUzMQq62kx4XSEIRF377EmluAquF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="305530785"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="305530785"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 04:17:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="577403399"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="577403399"
Received: from lkp-server01.sh.intel.com (HELO 2af0a69ca4e0) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 Oct 2022 04:17:25 -0700
Received: from kbuild by 2af0a69ca4e0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oiDGG-0002np-1S;
        Tue, 11 Oct 2022 11:17:24 +0000
Date:   Tue, 11 Oct 2022 19:16:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:bluetooth-next] BUILD SUCCESS
 64b5c4c8e79c131fe8f135bab5e5dfaa245c5776
Message-ID: <634550a5.V44ddeQdfcMxueNH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git bluetooth-next
branch HEAD: 64b5c4c8e79c131fe8f135bab5e5dfaa245c5776  Bluetooth: hci_sync: cancel cmd_timer if hci_open failed

elapsed time: 724m

configs tested: 116
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
arc                                 defconfig
x86_64                           allyesconfig
s390                             allmodconfig
x86_64                               rhel-8.3
arc                  randconfig-r043-20221010
x86_64                           rhel-8.3-kvm
m68k                             allyesconfig
alpha                               defconfig
x86_64                           rhel-8.3-syz
powerpc                           allnoconfig
m68k                             allmodconfig
s390                             allyesconfig
powerpc                          allmodconfig
arm                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
x86_64                         rhel-8.3-kunit
riscv                randconfig-r042-20221010
i386                 randconfig-a015-20221010
s390                                defconfig
s390                 randconfig-r044-20221010
alpha                            allyesconfig
mips                             allyesconfig
i386                 randconfig-a014-20221010
x86_64                          rhel-8.3-func
i386                 randconfig-a016-20221010
i386                                defconfig
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a012-20221010
i386                 randconfig-a011-20221010
i386                 randconfig-a013-20221010
arm64                            allyesconfig
arm                              allyesconfig
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
x86_64               randconfig-a011-20221010
x86_64               randconfig-a014-20221010
x86_64               randconfig-a012-20221010
i386                             allyesconfig
x86_64               randconfig-a013-20221010
x86_64               randconfig-a016-20221010
x86_64               randconfig-a015-20221010
sh                           se7206_defconfig
sh                        edosk7760_defconfig
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
arm                           h5000_defconfig
powerpc                    sam440ep_defconfig
mips                          rb532_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
ia64                          tiger_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                     asp8347_defconfig
m68k                        stmark2_defconfig
arm                        trizeps4_defconfig
arm                           stm32_defconfig
arm                            pleb_defconfig

clang tested configs:
hexagon              randconfig-r045-20221010
hexagon              randconfig-r041-20221010
i386                 randconfig-a003-20221010
i386                 randconfig-a004-20221010
i386                 randconfig-a002-20221010
i386                 randconfig-a005-20221010
i386                 randconfig-a001-20221010
i386                 randconfig-a006-20221010
x86_64               randconfig-a004-20221010
x86_64               randconfig-a002-20221010
x86_64               randconfig-a001-20221010
x86_64               randconfig-a003-20221010
x86_64               randconfig-a006-20221010
x86_64               randconfig-a005-20221010
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
