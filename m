Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF284C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 May 2022 19:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiEOTbf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 15 May 2022 15:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiEOTbd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 15 May 2022 15:31:33 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83301DE94
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 May 2022 12:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652643092; x=1684179092;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=HztGZrIfh3cpz3JxZF0qkrMfbHu/usinFdRCb3IjCSk=;
  b=PVAg9Sb4yZornJV/e48e/rMm4fPv8+T9Zv7cBgO5gcpRCY1MkE8U05j0
   HIbgmSK8KYwVJ+shz7O7KfpbzFQDYGm1MCFd1rC50Br5AYukmwyb9nRhp
   0NXjBMkngc7ILD6bymBeHppq/8tTaZkRsglj1jIMC956qYnRXwBgC8tOk
   vONDevZefk+/E4Wr4TINNdZyPW7Alv+3v2YR8xdnTmTZOmN3dUWp5vWkw
   3CB3B/ZDSZxY5NGcs5vJ5d+KCbaaXdE7Nmh1stW0/CmtshgphuZ4wvGpN
   npPrCmIOMwAJbkUVZrOBZHYzEr4bVeMjkYB39KrY9rwxwUeI17AaJ52fa
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="251182729"
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="251182729"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2022 12:31:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,228,1647327600"; 
   d="scan'208";a="604581530"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 15 May 2022 12:31:29 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqJxh-0001vu-BF;
        Sun, 15 May 2022 19:31:29 +0000
Date:   Mon, 16 May 2022 03:30:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 3b42055388c30f2761a2d9cd9af2c99611dfe457
Message-ID: <628154ea.cI+qL4p6GweROQlF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 3b42055388c30f2761a2d9cd9af2c99611dfe457  Bluetooth: hci_sync: Fix attempting to suspend with unfiltered passive scan

elapsed time: 3334m

configs tested: 134
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arm                           stm32_defconfig
csky                                defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                     tqm8555_defconfig
arm                          simpad_defconfig
arm                        cerfcube_defconfig
sh                          r7785rp_defconfig
sh                          urquell_defconfig
h8300                     edosk2674_defconfig
arm                            hisi_defconfig
mips                        bcm47xx_defconfig
sh                              ul2_defconfig
sh                      rts7751r2d1_defconfig
sh                           se7712_defconfig
mips                             allyesconfig
mips                         tb0226_defconfig
sh                   secureedge5410_defconfig
ia64                          tiger_defconfig
m68k                           sun3_defconfig
powerpc                       eiger_defconfig
openrisc                            defconfig
i386                             alldefconfig
ia64                         bigsur_defconfig
m68k                        mvme147_defconfig
sh                         ecovec24_defconfig
powerpc                     taishan_defconfig
sparc                       sparc32_defconfig
arm                             ezx_defconfig
sh                          lboxre2_defconfig
sh                        sh7763rdp_defconfig
powerpc                           allnoconfig
powerpc                 mpc837x_mds_defconfig
powerpc                     stx_gp3_defconfig
xtensa                  cadence_csp_defconfig
arm                        oxnas_v6_defconfig
sh                          rsk7264_defconfig
sh                           se7751_defconfig
parisc                generic-32bit_defconfig
sh                            hp6xx_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220512
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nios2                            allyesconfig
alpha                               defconfig
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
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
s390                 randconfig-r044-20220512
riscv                randconfig-r042-20220512
arc                  randconfig-r043-20220512
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
powerpc              randconfig-c003-20220512
x86_64                        randconfig-c007
riscv                randconfig-c006-20220512
mips                 randconfig-c004-20220512
i386                          randconfig-c001
arm                  randconfig-c002-20220512
arm                      pxa255-idp_defconfig
arm                  colibri_pxa270_defconfig
arm                        magician_defconfig
arm                       netwinder_defconfig
riscv                    nommu_virt_defconfig
arm                           spitz_defconfig
mips                  cavium_octeon_defconfig
powerpc                     tqm8540_defconfig
riscv                             allnoconfig
arm                        mvebu_v5_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                          moxart_defconfig
powerpc                   lite5200b_defconfig
mips                   sb1250_swarm_defconfig
powerpc                      ppc44x_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220512
hexagon              randconfig-r041-20220512

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
