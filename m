Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F371FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Feb 2022 22:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbiBPWqI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Feb 2022 17:46:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiBPWqH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Feb 2022 17:46:07 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4212819AB
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 14:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645051554; x=1676587554;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=x0Ks5bvdaNxoxOnq5dck773/yU+T0w7+sRnh/IcdxU4=;
  b=JR8MvQzns1F8O08BzT5naITpnK0gMfk6GeI4nfVjBBvqfofvFuG8ZpdT
   9TWo81IpQhjUerAFzk/H2NdRRlZ+XvMWE9obJ0syyXFjQAR3izvNPqidd
   hnNDZ1RQerQxdZEwHYil3wygsnNAdwAN96vaeEt/RChlAI+3WcGtB2QMw
   UnP0WimtOuEJnCWoMgyH4H4fwd6k8apqzZHbzIgSDy2V3CuwH2lW1dANR
   AIvIEt0Y+tIwSWhN45Ycr+zKY1w8G45b7RZtw9tdPWZk4YRjDh3gS7hL+
   mwwpNwtECh+o6fLXfhP+F825eQL6vHYLw3m7w0DVkzldI81UtChf+8jAM
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="250938662"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="250938662"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 14:45:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="774272875"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 16 Feb 2022 14:45:53 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKT3Y-000BCS-MT; Wed, 16 Feb 2022 22:45:52 +0000
Date:   Thu, 17 Feb 2022 06:45:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 55442fc23d66d33d4f8036e0c6f061c586f4d150
Message-ID: <620d7e6f.69sjRQLMjFqP/iFG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 55442fc23d66d33d4f8036e0c6f061c586f4d150  Bluetooth: make array bt_uuid_any static const

elapsed time: 724m

configs tested: 146
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
arm                          gemini_defconfig
powerpc                       ppc64_defconfig
arm                       multi_v4t_defconfig
sh                           se7751_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                       m5208evb_defconfig
sparc                       sparc32_defconfig
mips                            gpr_defconfig
powerpc                      chrp32_defconfig
arm                            qcom_defconfig
sh                         microdev_defconfig
m68k                        m5307c3_defconfig
h8300                    h8300h-sim_defconfig
m68k                        stmark2_defconfig
sh                        sh7785lcr_defconfig
arm                      jornada720_defconfig
mips                             allyesconfig
powerpc                   motionpro_defconfig
sparc                            allyesconfig
sh                             espt_defconfig
mips                         tb0226_defconfig
mips                  decstation_64_defconfig
powerpc                 mpc834x_mds_defconfig
arm                        keystone_defconfig
sh                      rts7751r2d1_defconfig
sh                           sh2007_defconfig
arm                        oxnas_v6_defconfig
nds32                            alldefconfig
mips                       bmips_be_defconfig
xtensa                          iss_defconfig
mips                           ci20_defconfig
arm                        multi_v7_defconfig
sh                          kfr2r09_defconfig
mips                           jazz_defconfig
powerpc                       holly_defconfig
powerpc                      makalu_defconfig
sh                           se7206_defconfig
mips                           gcw0_defconfig
sh                          sdk7786_defconfig
sh                     sh7710voipgw_defconfig
powerpc                 mpc85xx_cds_defconfig
openrisc                  or1klitex_defconfig
powerpc                        warp_defconfig
powerpc                        cell_defconfig
powerpc                    adder875_defconfig
powerpc                 mpc837x_rdb_defconfig
i386                             alldefconfig
sh                           se7724_defconfig
sh                        edosk7760_defconfig
xtensa                           alldefconfig
openrisc                 simple_smp_defconfig
arm                  randconfig-c002-20220216
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
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
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
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
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220216
s390                 randconfig-r044-20220216
riscv                randconfig-r042-20220216
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20220216
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220216
arm                  randconfig-c002-20220216
i386                          randconfig-c001
mips                 randconfig-c004-20220216
powerpc                          allmodconfig
powerpc                 mpc8315_rdb_defconfig
arm                        multi_v5_defconfig
mips                            e55_defconfig
arm                           sama7_defconfig
powerpc                     tqm8560_defconfig
arm                           omap1_defconfig
powerpc                 mpc836x_mds_defconfig
mips                  cavium_octeon_defconfig
mips                     cu1830-neo_defconfig
arm                          imote2_defconfig
mips                         tb0287_defconfig
powerpc                      walnut_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220216
hexagon              randconfig-r041-20220216

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
