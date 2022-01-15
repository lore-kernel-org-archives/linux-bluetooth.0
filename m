Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A01C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Jan 2022 10:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiAOKTx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 15 Jan 2022 05:19:53 -0500
Received: from mga01.intel.com ([192.55.52.88]:18788 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbiAOKTw (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 15 Jan 2022 05:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642241992; x=1673777992;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=xYOhJDndCNQZi0urKoWTO7mbjGmB+v3eEDSoWzIzLvo=;
  b=KCMNPxf0ZdmgLcvgR6s9TdF5iBOmDK4eDxP3gapZuSFsXdrUbBLUijUz
   HmgXvbP9HF8m++d2gA/htWUX+DTCybriXzpvFj6sndG1Y4RVDwZS2HWfK
   7DrJiYnFqRvTHOopcNKiChUgUkAGRHlp8gT3mUWiCulFbX5BZNW3Ga1Ec
   ieyQp/2AmsnBkj8nrq+PxR2VliKEQ/wi8S13ZNu6CjneJdfrBgoOh4mQ9
   9MMxgNwdqQQ0XggRinT3a5MUZ/vdxOokcz1cKDPi3xzUL+eXiPOV7DY7k
   GDi6INXpZ/uq9PlPfTNFY+CbgU03jmZNjULCKcBZykChRYWo6q6vOfgtz
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="268771109"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="268771109"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2022 02:19:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="530648537"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 15 Jan 2022 02:19:51 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8gA2-0009dx-GO; Sat, 15 Jan 2022 10:19:50 +0000
Date:   Sat, 15 Jan 2022 18:19:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 3afee2118132e93e5f6fa636dfde86201a860ab3
Message-ID: <61e29f95.5pr5MyyFY42b/Q27%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 3afee2118132e93e5f6fa636dfde86201a860ab3  Bluetooth: fix null ptr deref on hci_sync_conn_complete_evt

elapsed time: 724m

configs tested: 135
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
h8300                            allyesconfig
arc                                 defconfig
mips                           jazz_defconfig
h8300                               defconfig
powerpc                        cell_defconfig
arm                           sama5_defconfig
x86_64                           alldefconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                      tqm8xx_defconfig
powerpc                      arches_defconfig
powerpc                     tqm8555_defconfig
powerpc                      pcm030_defconfig
sparc                               defconfig
mips                           ip32_defconfig
arm                           viper_defconfig
xtensa                generic_kc705_defconfig
xtensa                    xip_kc705_defconfig
sh                   secureedge5410_defconfig
ia64                                defconfig
powerpc                 linkstation_defconfig
ia64                         bigsur_defconfig
ia64                            zx1_defconfig
arm                      integrator_defconfig
sh                          r7785rp_defconfig
sh                            shmin_defconfig
powerpc                     tqm8541_defconfig
sh                          sdk7780_defconfig
powerpc                     sequoia_defconfig
mips                            ar7_defconfig
arm                           h3600_defconfig
sh                        sh7785lcr_defconfig
arm                            zeus_defconfig
arm                        spear6xx_defconfig
sh                              ul2_defconfig
ia64                             allmodconfig
arm                      footbridge_defconfig
sh                     magicpanelr2_defconfig
arm                  randconfig-c002-20220113
arm                  randconfig-c002-20220114
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
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220113
arc                  randconfig-r043-20220113
s390                 randconfig-r044-20220113
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220113
x86_64                        randconfig-c007
riscv                randconfig-c006-20220113
powerpc              randconfig-c003-20220113
i386                          randconfig-c001
mips                 randconfig-c004-20220113
mips                           ip27_defconfig
mips                      pic32mzda_defconfig
mips                          ath79_defconfig
arm                     davinci_all_defconfig
powerpc                     pseries_defconfig
arm                       spear13xx_defconfig
mips                         tb0219_defconfig
powerpc                    socrates_defconfig
powerpc                        icon_defconfig
powerpc                   lite5200b_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
hexagon              randconfig-r045-20220113
hexagon              randconfig-r045-20220114
riscv                randconfig-r042-20220114
hexagon              randconfig-r041-20220114
hexagon              randconfig-r041-20220113

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
