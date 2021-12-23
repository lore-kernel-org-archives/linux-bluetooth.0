Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EA2C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Dec 2021 13:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348632AbhLWNWp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Dec 2021 08:22:45 -0500
Received: from mga17.intel.com ([192.55.52.151]:11048 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236931AbhLWNWo (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Dec 2021 08:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640265764; x=1671801764;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=g6V1Q1K21nuR0YJQ6VHiDm7gofoYOiFcAq0lXgYbHfI=;
  b=RMAsLu0XqrL9DRo3sH5klZ438VQRJdmH67icKVKh3WcdYxEiEBUq9roQ
   KyK1fYbfi6hRj2x4YcvWGdJ+/byRoAt8WsVVRu92K9oyK9ZDTBblgLpk/
   b6Q3GYa4fj34lUXp1DlVbskF2fZwCeqrCCyILg+ldp4V+brNcSY4fBv36
   Mh9s2xX/WkOV/E436Rf+4EytrYzITwrXIMfUT8fREy8crY447RdBY1PAR
   uKr31wptK930xBfq0Nuhkj1iIUjQGdFIx2LYI7KMeqNrJeuaa6e8BIzua
   IvkPGjXN3KsimAAzwOgHF6Rm1hHMS3xodFezujrw9GMkx8W3QUl15sj4t
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="221499077"
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="221499077"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 05:22:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="759127515"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 23 Dec 2021 05:22:43 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n0O3O-0001tt-SR; Thu, 23 Dec 2021 13:22:42 +0000
Date:   Thu, 23 Dec 2021 21:21:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 cfb4c313be670fd4bd09650216620fa4514cdb93
Message-ID: <61c477ee.Hefev4fhD5HB7grR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: cfb4c313be670fd4bd09650216620fa4514cdb93  Bluetooth: vhci: Set HCI_QUIRK_VALID_LE_STATES

elapsed time: 913m

configs tested: 141
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211223
arm                          moxart_defconfig
powerpc               mpc834x_itxgp_defconfig
sparc                       sparc64_defconfig
powerpc                         wii_defconfig
powerpc64                        alldefconfig
powerpc                      ppc44x_defconfig
arm                          pxa3xx_defconfig
sh                          r7780mp_defconfig
sh                            titan_defconfig
arm                          pcm027_defconfig
parisc                generic-32bit_defconfig
riscv                               defconfig
powerpc                   motionpro_defconfig
arm                        clps711x_defconfig
sh                           se7343_defconfig
ia64                      gensparse_defconfig
h8300                     edosk2674_defconfig
arc                        vdk_hs38_defconfig
m68k                       m5208evb_defconfig
powerpc                     tqm8555_defconfig
arm                         lpc32xx_defconfig
mips                   sb1250_swarm_defconfig
arm                       aspeed_g4_defconfig
arm                             pxa_defconfig
sh                          kfr2r09_defconfig
powerpc                 mpc832x_mds_defconfig
ia64                             allyesconfig
powerpc                     skiroot_defconfig
sh                          rsk7264_defconfig
powerpc64                           defconfig
sh                        edosk7760_defconfig
powerpc                     kilauea_defconfig
parisc                           alldefconfig
mips                       bmips_be_defconfig
mips                            gpr_defconfig
sh                             shx3_defconfig
mips                  cavium_octeon_defconfig
arm                         lpc18xx_defconfig
m68k                          atari_defconfig
powerpc                 canyonlands_defconfig
arm                        neponset_defconfig
sh                            migor_defconfig
powerpc                      walnut_defconfig
arm                           h3600_defconfig
m68k                          amiga_defconfig
arm                       aspeed_g5_defconfig
riscv                             allnoconfig
powerpc                 mpc8313_rdb_defconfig
h8300                            alldefconfig
sh                          lboxre2_defconfig
arm                  randconfig-c002-20211223
ia64                             allmodconfig
ia64                                defconfig
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
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
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
i386                 randconfig-a006-20211222
i386                 randconfig-a004-20211222
i386                 randconfig-a002-20211222
i386                 randconfig-a003-20211222
i386                 randconfig-a005-20211222
i386                 randconfig-a001-20211222
x86_64               randconfig-a013-20211223
x86_64               randconfig-a015-20211223
x86_64               randconfig-a014-20211223
x86_64               randconfig-a011-20211223
x86_64               randconfig-a012-20211223
x86_64               randconfig-a016-20211223
i386                 randconfig-a012-20211223
i386                 randconfig-a011-20211223
i386                 randconfig-a014-20211223
i386                 randconfig-a016-20211223
i386                 randconfig-a015-20211223
i386                 randconfig-a013-20211223
arc                  randconfig-r043-20211223
riscv                randconfig-r042-20211223
s390                 randconfig-r044-20211223
arc                  randconfig-r043-20211222
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
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
x86_64               randconfig-a001-20211223
x86_64               randconfig-a003-20211223
x86_64               randconfig-a005-20211223
x86_64               randconfig-a006-20211223
x86_64               randconfig-a004-20211223
x86_64               randconfig-a002-20211223
i386                 randconfig-a006-20211223
i386                 randconfig-a004-20211223
i386                 randconfig-a002-20211223
i386                 randconfig-a003-20211223
i386                 randconfig-a005-20211223
i386                 randconfig-a001-20211223
hexagon              randconfig-r045-20211222
s390                 randconfig-r044-20211222
hexagon              randconfig-r041-20211222
riscv                randconfig-r042-20211222

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
