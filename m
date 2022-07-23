Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39534C43334
	for <linux-bluetooth@archiver.kernel.org>; Sat, 23 Jul 2022 13:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbiGWNbc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 23 Jul 2022 09:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGWNba (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 23 Jul 2022 09:31:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6CF63B8
        for <linux-bluetooth@vger.kernel.org>; Sat, 23 Jul 2022 06:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658583089; x=1690119089;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=W/RibUQfeWyict+S8i2n5qwEASmFoss65sVyhxpIE0E=;
  b=Yj4Ga1lrvjRg2vFu64e9+SW80ppQtF7S3GdX6uzcqb6h6GOKEzeur6s+
   Ckms0pOBDOIS7ItNGrBHIjpWeXZoqxSjJMAjtkAd0kT+iRxerNEqffxzE
   lOy2RIFysLQfdIYgCCk9Kz1yqSh2oMHPkj5GJKZEb9GfAb1bwJiRxo4wq
   WEEru3XXaoY4T06Sa3En68khz+kV1NV9tiIVhp96qZxkn3K5RAq0Xov+v
   4gdXff5x6jq7vVQWrLNOVaRfhH3zboHV8H926tX+Ol4zmZrsVCG76+QzL
   C28t0YNYrHaGOoP8jAIK5nBMQWOW80B/IyXH/oi8pfDKsr1SQopHP1kOt
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="274326714"
X-IronPort-AV: E=Sophos;i="5.93,188,1654585200"; 
   d="scan'208";a="274326714"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 06:31:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,188,1654585200"; 
   d="scan'208";a="549464485"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 Jul 2022 06:31:26 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFFE5-0002dZ-1v;
        Sat, 23 Jul 2022 13:31:25 +0000
Date:   Sat, 23 Jul 2022 21:30:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 14202eff214e1e941fefa0366d4c3bc4b1a0d500
Message-ID: <62dbf80e.VHpQsauSMxWvjS9O%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 14202eff214e1e941fefa0366d4c3bc4b1a0d500  Bluetooth: btusb: Detect if an ACL packet is in fact an ISO packet

elapsed time: 722m

configs tested: 97
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20220722
m68k                          atari_defconfig
sparc                       sparc64_defconfig
sh                          r7785rp_defconfig
m68k                                defconfig
powerpc                 mpc834x_itx_defconfig
arm                       imx_v6_v7_defconfig
powerpc                      tqm8xx_defconfig
arc                      axs103_smp_defconfig
m68k                        m5407c3_defconfig
mips                           jazz_defconfig
powerpc                 mpc8540_ads_defconfig
openrisc                 simple_smp_defconfig
nios2                         3c120_defconfig
sh                        apsh4ad0a_defconfig
powerpc                     pq2fads_defconfig
alpha                            alldefconfig
openrisc                            defconfig
sh                             sh03_defconfig
xtensa                           alldefconfig
arm                       omap2plus_defconfig
xtensa                              defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                     asp8347_defconfig
powerpc                       ppc64_defconfig
csky                                defconfig
arm                          gemini_defconfig
powerpc                      mgcoge_defconfig
sh                           se7751_defconfig
arc                    vdk_hs38_smp_defconfig
alpha                               defconfig
parisc64                         alldefconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                              debian-10.3
loongarch                           defconfig
loongarch                         allnoconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
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
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220721
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                      pxa255-idp_defconfig
mips                      maltaaprp_defconfig
arm                       mainstone_defconfig
mips                        bcm63xx_defconfig
powerpc                     ksi8560_defconfig
arm                       spear13xx_defconfig
mips                     loongson1c_defconfig
mips                         tb0287_defconfig
arm                         hackkit_defconfig
arm                  colibri_pxa300_defconfig
x86_64                        randconfig-k001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220721
hexagon              randconfig-r045-20220721
riscv                randconfig-r042-20220721
s390                 randconfig-r044-20220721

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
