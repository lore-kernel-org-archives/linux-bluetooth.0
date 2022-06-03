Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142D3CCA473
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jun 2022 04:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239253AbiFCE5x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Jun 2022 00:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbiFCE5w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Jun 2022 00:57:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB8521E15
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jun 2022 21:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654232270; x=1685768270;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=1CsIcSD9PzsqbKxikFCVopzkLvCSg+fQ/wfoQVtUOXE=;
  b=QvG2o/mkJvENyFqLOK5n19dxciVI1LOLO1aRELLj6sDht1ILdDywSbuB
   xwJvgS/PvgQI7zWrGAeGzq7zCL3idntZTTkA6nQMNCBlElsDVekTMi1r2
   4H5uS8D5WDfydTzPPldu79LJB7ZrQm8Ffb3e2OTIYlwOZ84CUdb38suD5
   q9mtuTlH2LWnS/p0V0uSW3UaZeylr9uzrzC1pXmDH+GpE2x4f6oNpU7Ao
   dl0tlAxSoCID7gQQsQwLFvaR3J4xmmOSJqh060PMu2DQSeA/nm67bANPr
   cafskJQKt0E9xM62a9HrRk6pqYChXVYUoHD79sv6QPTLYFSnNWscahjsm
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="336822737"
X-IronPort-AV: E=Sophos;i="5.91,273,1647327600"; 
   d="scan'208";a="336822737"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 21:57:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,273,1647327600"; 
   d="scan'208";a="607215997"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 02 Jun 2022 21:57:46 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwzNZ-0006JN-Ps;
        Fri, 03 Jun 2022 04:57:45 +0000
Date:   Fri, 03 Jun 2022 12:56:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 5a4e1528d8405e207bdc2c9db0b9952b70ca1e4c
Message-ID: <6299949b.vb7GP3uhn+qV3/0L%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 5a4e1528d8405e207bdc2c9db0b9952b70ca1e4c  Bluetooth: clear the temporary linkkey in hci_conn_cleanup

elapsed time: 724m

configs tested: 117
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
arc                          axs101_defconfig
nios2                               defconfig
arm                          gemini_defconfig
arm                         vf610m4_defconfig
arm                           viper_defconfig
sh                   secureedge5410_defconfig
arm64                            alldefconfig
sh                         microdev_defconfig
xtensa                generic_kc705_defconfig
powerpc                      cm5200_defconfig
m68k                         apollo_defconfig
powerpc                     ep8248e_defconfig
sh                           se7780_defconfig
sh                          kfr2r09_defconfig
sh                ecovec24-romimage_defconfig
arm                       aspeed_g5_defconfig
arm                           sama5_defconfig
mips                         mpc30x_defconfig
openrisc                 simple_smp_defconfig
x86_64                        randconfig-c001
i386                          randconfig-c001
arm                  randconfig-c002-20220531
ia64                                defconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
arc                              allyesconfig
alpha                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220531
riscv                randconfig-r042-20220531
s390                 randconfig-r044-20220531
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
mips                 randconfig-c004-20220531
x86_64                        randconfig-c007
i386                          randconfig-c001
s390                 randconfig-c005-20220531
arm                  randconfig-c002-20220531
powerpc              randconfig-c003-20220531
riscv                randconfig-c006-20220531
mips                malta_qemu_32r6_defconfig
mips                        workpad_defconfig
arm                             mxs_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                     tqm8540_defconfig
arm                       cns3420vb_defconfig
arm                       netwinder_defconfig
arm                         lpc32xx_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r041-20220531
hexagon              randconfig-r045-20220531

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
