Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A02C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jul 2022 11:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbiGVLBp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jul 2022 07:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiGVLBo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jul 2022 07:01:44 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AC3B555F
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 04:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658487703; x=1690023703;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=m1KnB0Oni7wcHEhI9HZoabXOR5tWQ5smzHIpHyiGgr0=;
  b=H970d/A4g67VLlq4j7id3AYcWTBB2YzCSid4EE7RqA6XGkCoJj2bUr25
   XNb+SkwDmxgzMjVhA+z1uZ8TgaKrH17WRliNTyM63w73a+Nyjkv9kusgU
   PGrJu9aZ6vYH7BtSpZvx/bReUMpMaBQdfQ113K+dLTObaiUaHTbTlrABH
   houalwxR0L2hmnX3tD8HU48rTjYWg3bxVCFHRxIvCiQUZEnv4iLNNsxov
   nH6hPilbjBNVAoXImkPOxaH/Jsx/Z/BhKMnKyGB61i/o3fpTqDKy1Ffdt
   H7axAqvswgaG89Jjm8M36XxBL31WHejILnJwFlEtFZjUdcJQlMaDcONSL
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="270324034"
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="270324034"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 04:01:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="574131919"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Jul 2022 04:01:40 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEqPb-0001Mk-3D;
        Fri, 22 Jul 2022 11:01:39 +0000
Date:   Fri, 22 Jul 2022 19:01:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 4e0b765cefea51e6f5198644a3aa3c7d1dbc5240
Message-ID: <62da8388.INyyJB7odWEYsNhR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 4e0b765cefea51e6f5198644a3aa3c7d1dbc5240  Bluetooth: mgmt: Fix using hci_conn_abort

elapsed time: 726m

configs tested: 131
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20220722
sh                   sh7724_generic_defconfig
csky                                defconfig
powerpc                 mpc85xx_cds_defconfig
mips                     loongson1b_defconfig
sh                               j2_defconfig
arc                          axs101_defconfig
alpha                               defconfig
mips                         cobalt_defconfig
arm                      jornada720_defconfig
microblaze                          defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                 mpc834x_mds_defconfig
sh                              ul2_defconfig
powerpc                        cell_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                           xway_defconfig
mips                          rb532_defconfig
mips                         db1xxx_defconfig
powerpc                     sequoia_defconfig
powerpc                    sam440ep_defconfig
nios2                               defconfig
powerpc                     tqm8548_defconfig
xtensa                           allyesconfig
arc                        vdk_hs38_defconfig
powerpc                       maple_defconfig
powerpc                      makalu_defconfig
m68k                          atari_defconfig
parisc                              defconfig
arc                      axs103_smp_defconfig
m68k                        mvme147_defconfig
arm                         at91_dt_defconfig
sh                        apsh4ad0a_defconfig
csky                             alldefconfig
mips                           ip32_defconfig
arm                            xcep_defconfig
arm                           h5000_defconfig
mips                            ar7_defconfig
loongarch                           defconfig
m68k                            mac_defconfig
nios2                         10m50_defconfig
sh                               alldefconfig
powerpc                     tqm8555_defconfig
powerpc                    amigaone_defconfig
arm                     eseries_pxa_defconfig
sh                        edosk7760_defconfig
sh                          rsk7203_defconfig
powerpc                   currituck_defconfig
mips                      maltasmvp_defconfig
nios2                            allyesconfig
parisc64                            defconfig
parisc                           allyesconfig
riscv                             allnoconfig
riscv                    nommu_virt_defconfig
i386                              debian-10.3
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
riscv                          rv32_defconfig
loongarch                         allnoconfig
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220721
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
hexagon                             defconfig
arm                          collie_defconfig
arm                         s3c2410_defconfig
arm                          ixp4xx_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                          allyesconfig
powerpc                     akebono_defconfig
powerpc                    mvme5100_defconfig
mips                      malta_kvm_defconfig
arm                                 defconfig
arm                           spitz_defconfig
arm                      tct_hammer_defconfig
mips                        qi_lb60_defconfig
mips                           mtx1_defconfig
x86_64                           allyesconfig
mips                            e55_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20220721
hexagon              randconfig-r045-20220721
riscv                randconfig-r042-20220721
s390                 randconfig-r044-20220721
hexagon              randconfig-r041-20220722
hexagon              randconfig-r045-20220722

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
