Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A22C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Jul 2022 06:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiGUGQw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jul 2022 02:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbiGUGQu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jul 2022 02:16:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E784F4504F
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jul 2022 23:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658384209; x=1689920209;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=OcO8HWcgyKbasdmGUqGTQO70V1gmkfmU/cUGYmdsiQo=;
  b=ZL0kq0mD7zri++eLgkcvEEQNVdGOVkNzzENGgAIIY9Q8SDdANsLWowrE
   JHEn+SJQG633qizFuXIZ89axhEOUpyTkQSitHgUvBsxN5AsHuG3++h+TU
   9Y9O43uuNej+SBcEwhGy8P9OSoXb4hicyWH4HuLgy43PwxzZPCLJrkDFV
   G62ZS2GnvTUCu1oRIIAfAQwbvCatiLDc6fYGNFy84+xsjDGbPYZtTE4dy
   Ef3/GCByG5vzonVTfTTAmvoKQJgGsr6z4tG/E7ncutb8krIU6qIRvI1zx
   1yg/7kWXYITv2sU+xDBJHtenvq+QOSHiQx7oFHfgz3AFXqbkEWbnWxkGQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="286971619"
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="286971619"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 23:16:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="548651338"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 20 Jul 2022 23:16:38 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oEPUE-0001Xo-7P;
        Thu, 21 Jul 2022 06:16:38 +0000
Date:   Thu, 21 Jul 2022 14:16:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 f7913b8db3c4fe3ff39f541703d1354a2f0b276a
Message-ID: <62d8ef29.zTeyvPl0Y2EezuFP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: f7913b8db3c4fe3ff39f541703d1354a2f0b276a  Bluetooth: hci_sync: Correct hci_set_event_mask_page_2_sync() event mask

elapsed time: 739m

configs tested: 109
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
xtensa                  audio_kc705_defconfig
powerpc                    adder875_defconfig
m68k                        m5272c3_defconfig
mips                         bigsur_defconfig
csky                              allnoconfig
um                             i386_defconfig
mips                           ci20_defconfig
arm                          lpd270_defconfig
arm                      integrator_defconfig
arm                        mvebu_v7_defconfig
m68k                           virt_defconfig
sh                           se7206_defconfig
sh                             shx3_defconfig
sh                                  defconfig
powerpc                        cell_defconfig
nios2                               defconfig
openrisc                 simple_smp_defconfig
arm                            hisi_defconfig
sh                           se7724_defconfig
arm                       aspeed_g5_defconfig
arm                            zeus_defconfig
powerpc                     tqm8548_defconfig
sh                   secureedge5410_defconfig
m68k                        mvme147_defconfig
nios2                         10m50_defconfig
xtensa                              defconfig
m68k                            mac_defconfig
arm                           viper_defconfig
powerpc                      ep88xc_defconfig
powerpc                      pcm030_defconfig
ia64                         bigsur_defconfig
arm                          exynos_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
loongarch                           defconfig
loongarch                         allnoconfig
arm                  randconfig-c002-20220718
i386                 randconfig-c001-20220718
x86_64               randconfig-c001-20220718
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
x86_64               randconfig-a012-20220718
x86_64               randconfig-a011-20220718
x86_64               randconfig-a014-20220718
x86_64               randconfig-a016-20220718
x86_64               randconfig-a013-20220718
x86_64               randconfig-a015-20220718
i386                 randconfig-a015-20220718
i386                 randconfig-a011-20220718
i386                 randconfig-a012-20220718
i386                 randconfig-a014-20220718
i386                 randconfig-a016-20220718
i386                 randconfig-a013-20220718
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
s390                 randconfig-r044-20220718
riscv                randconfig-r042-20220718
arc                  randconfig-r043-20220718
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                      tct_hammer_defconfig
mips                           ip28_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                 mpc832x_mds_defconfig
mips                          ath25_defconfig
powerpc                      acadia_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a001-20220718
i386                 randconfig-a006-20220718
i386                 randconfig-a002-20220718
i386                 randconfig-a004-20220718
i386                 randconfig-a005-20220718
i386                 randconfig-a003-20220718
x86_64               randconfig-a005-20220718
x86_64               randconfig-a003-20220718
x86_64               randconfig-a006-20220718
hexagon              randconfig-r041-20220718
hexagon              randconfig-r045-20220718

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
