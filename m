Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E22C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Nov 2022 13:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiK3NvU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Nov 2022 08:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiK3NvT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Nov 2022 08:51:19 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128A132BAF
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Nov 2022 05:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669816277; x=1701352277;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=e/oJCbmGSVxBUNIXPA9DK/uPPIcV8azTJNne1aHZT2s=;
  b=U6z9Kfk9eaSk1xsL1WAqvyuEO0DlKvsjAc/2O6eBK/FtmAFN4Kgh8eyj
   vEg/XJRulPREORwTwQ73t1+/L5/Cgc3gI/iiZFvoCFVkj/K+KMbHtnQY2
   B/qbpdgHTo4Ug/oIla2bDmJl1vDHp0SGsuomi1ktZdQchHd65+1YVtyPY
   zxslddgsE19cc6ROxvCFwxmdGLnmEMBBwwENooA8V0P96TjdNxQNPbgzv
   8jS7xBpVWmo5y+xuTwsost62J036L9QVPox4MJD3NOVEeTl52KNGgDavZ
   jmOpUm/bey1U6pdspfuoZ6qdRrsTJo8wByDaeW2XehtIFcCiNNA5OAnkK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="295094887"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="295094887"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 05:51:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="676826798"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="676826798"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 30 Nov 2022 05:51:15 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p0NUY-000BDp-1H;
        Wed, 30 Nov 2022 13:51:14 +0000
Date:   Wed, 30 Nov 2022 21:50:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 d2cdc5f0c9be2565d9b7bf0f83c4d4d03d4b3604
Message-ID: <63875fb3.H3q/ROX8Lz/nilU0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: d2cdc5f0c9be2565d9b7bf0f83c4d4d03d4b3604  Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x0cb8:0xc559

elapsed time: 730m

configs tested: 99
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
m68k                             allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
sh                               allmodconfig
x86_64                            allnoconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
sh                        sh7763rdp_defconfig
powerpc                         ps3_defconfig
xtensa                  cadence_csp_defconfig
mips                      maltasmvp_defconfig
ia64                             allmodconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-a001-20221128
i386                 randconfig-a005-20221128
i386                 randconfig-a006-20221128
i386                 randconfig-a004-20221128
i386                 randconfig-a003-20221128
i386                 randconfig-a002-20221128
i386                             allyesconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allmodconfig
i386                          randconfig-c001
x86_64               randconfig-a002-20221128
x86_64               randconfig-a001-20221128
x86_64               randconfig-a004-20221128
x86_64               randconfig-a006-20221128
x86_64               randconfig-a005-20221128
x86_64               randconfig-a003-20221128
arm                       omap2plus_defconfig
sh                               j2_defconfig
mips                           ci20_defconfig
sh                          sdk7786_defconfig
arc                     haps_hs_smp_defconfig
powerpc                      cm5200_defconfig
arm                          lpd270_defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
sh                           se7750_defconfig
sh                             espt_defconfig
sparc64                          alldefconfig
powerpc                   currituck_defconfig
arc                               allnoconfig
csky                                defconfig
nios2                               defconfig
mips                           gcw0_defconfig
xtensa                    xip_kc705_defconfig
arm                        oxnas_v6_defconfig
sh                          lboxre2_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
s390                 randconfig-r044-20221128
hexagon              randconfig-r041-20221128
riscv                randconfig-r042-20221128
hexagon              randconfig-r045-20221128
i386                 randconfig-a014-20221128
i386                 randconfig-a011-20221128
i386                 randconfig-a013-20221128
i386                 randconfig-a016-20221128
i386                 randconfig-a012-20221128
i386                 randconfig-a015-20221128
x86_64               randconfig-k001-20221128
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a011-20221128
x86_64               randconfig-a014-20221128
x86_64               randconfig-a012-20221128
x86_64               randconfig-a013-20221128
x86_64               randconfig-a016-20221128
x86_64               randconfig-a015-20221128
arm                      tct_hammer_defconfig
arm                        vexpress_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
