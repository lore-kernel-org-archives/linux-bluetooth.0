Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989F1C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Oct 2022 08:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiJSIFz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Oct 2022 04:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiJSIFy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Oct 2022 04:05:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939E56D85F
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Oct 2022 01:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666166753; x=1697702753;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=CZkJWoLazHIOklSZ2NrD855M9eVsvETY0QAw4Gu+6SU=;
  b=lbNqVofEAcxOCfBKFPt7+i8r9wq4LCaTBRoOkv/DrgM22OpRdciCPaQe
   N0MHXjbWgyMrWn6X+9nzZ8smi1iCJN9u7oPhFr90PoB/6fio2SXV3V0CP
   PZh7bqX19ANAylFaFeK1g2bwBliia7w73BwF9Z5+jxl39TeyUyL17Ljup
   lO6SkMjae02FmJvkbrL0/nCqB6/zzy/F7iO8xTDTd9vmy5aM4FNs4VlN4
   bPqcUctg4Ap+9mk5p5nSoXjVET36nE4LYJ7nGc3omMG9NiaIFczl/poch
   YdEzZznN2cJvJ//gM+U5CCljEq1CV10u2+gaXj/4r/WDD1Gpcembap9bu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="293734711"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="293734711"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 01:05:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="606969106"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="606969106"
Received: from lkp-server01.sh.intel.com (HELO 8381f64adc98) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 19 Oct 2022 01:05:46 -0700
Received: from kbuild by 8381f64adc98 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ol45B-0002dk-2b;
        Wed, 19 Oct 2022 08:05:45 +0000
Date:   Wed, 19 Oct 2022 16:04:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 97097c85c088e11651146da32a4e1cdb9dfa6193
Message-ID: <634fafa0.5pvbN0ywrr9bd1bD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 97097c85c088e11651146da32a4e1cdb9dfa6193  Bluetooth: L2CAP: Fix memory leak in vhci_write

elapsed time: 723m

configs tested: 126
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                          rhel-8.3-func
arc                                 defconfig
s390                             allmodconfig
x86_64                    rhel-8.3-kselftests
alpha                               defconfig
m68k                             allmodconfig
s390                                defconfig
m68k                             allyesconfig
x86_64                        randconfig-a002
s390                             allyesconfig
x86_64                        randconfig-a004
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a006
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                              defconfig
mips                             allyesconfig
x86_64                               rhel-8.3
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a013
x86_64                        randconfig-a011
sh                               allmodconfig
arc                  randconfig-r043-20221018
x86_64                        randconfig-a015
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-a005
ia64                             allmodconfig
i386                          randconfig-c001
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                           allyesconfig
i386                                defconfig
i386                             allyesconfig
s390                       zfcpdump_defconfig
openrisc                            defconfig
powerpc                     tqm8548_defconfig
openrisc                  or1klitex_defconfig
riscv                randconfig-r042-20221018
s390                 randconfig-r044-20221018
xtensa                  audio_kc705_defconfig
arc                           tb10x_defconfig
openrisc                 simple_smp_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
arm                        trizeps4_defconfig
m68k                                defconfig
mips                 decstation_r4k_defconfig
sh                 kfr2r09-romimage_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64                        randconfig-c001
arm                  randconfig-c002-20221018
sh                            shmin_defconfig
sh                         apsh4a3a_defconfig
arm                        cerfcube_defconfig
sh                        sh7763rdp_defconfig
sh                          sdk7780_defconfig
powerpc                    klondike_defconfig
sh                             sh03_defconfig
sh                          r7785rp_defconfig
sh                             espt_defconfig
arm                          iop32x_defconfig
sh                            hp6xx_defconfig
sh                             shx3_defconfig
sh                          polaris_defconfig
mips                         cobalt_defconfig
sparc                             allnoconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
hexagon              randconfig-r041-20221018
x86_64                        randconfig-a012
hexagon              randconfig-r045-20221018
i386                          randconfig-a004
x86_64                        randconfig-a016
i386                          randconfig-a006
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
mips                        maltaup_defconfig
arm                                 defconfig
mips                           rs90_defconfig
x86_64                        randconfig-c007
mips                 randconfig-c004-20221018
i386                          randconfig-c001
s390                 randconfig-c005-20221018
arm                  randconfig-c002-20221018
riscv                randconfig-c006-20221018
powerpc              randconfig-c003-20221018
i386                 randconfig-a013-20221017
i386                 randconfig-a015-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a011-20221017
i386                 randconfig-a014-20221017
i386                 randconfig-a012-20221017
mips                 randconfig-c004-20221019
s390                 randconfig-c005-20221019
arm                  randconfig-c002-20221019
riscv                randconfig-c006-20221019
powerpc              randconfig-c003-20221019
powerpc                          g5_defconfig
powerpc                   lite5200b_defconfig
arm                         socfpga_defconfig
x86_64                        randconfig-k001
hexagon                             defconfig
s390                 randconfig-r044-20221019
hexagon              randconfig-r045-20221019
riscv                randconfig-r042-20221019
hexagon              randconfig-r041-20221019

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
