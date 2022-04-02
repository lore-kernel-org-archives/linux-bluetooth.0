Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97668C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Apr 2022 11:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbiDBLNk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 2 Apr 2022 07:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiDBLNj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 2 Apr 2022 07:13:39 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBED015448A
        for <linux-bluetooth@vger.kernel.org>; Sat,  2 Apr 2022 04:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648897908; x=1680433908;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=R5z2W0JYRb/L8G4V6gxS0Fed7H8Htk5TjNg7vhAb+7M=;
  b=kpdL8UMNSIBUa2l5KGGy6WFkCpBxOFpO5N7uV9sWA1MNV1fJ6QhSrXDw
   FjuECEGBB1kdxowb0rOz8ITiEN2eHm0BDM6MBcZ/aUYVvr1YQimiSm+Gp
   hodmCwemFY1pDrvY8xMS/JoxOAyK/X0BcgKuq/pSZ5frU/SwvTElNqi/2
   0a9DRvYfWRLOyXbe2WK3RRYNyhr9z3xqfrnLIL5dQubc6NiZ4x0G5l1WU
   zIMsT45iwTg1QWY9/igPI3fi8WSB22KCowcbmEl5qq3RbYDhp/aebxXsi
   bgJq4tt7XASBHKBd/iiRNvhJVmJQJ/N1UdpsRI4NtLVlitxrxLdvB9ptz
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="242437732"
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="242437732"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 04:11:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="619557268"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 02 Apr 2022 04:11:46 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nabfW-00004f-0h;
        Sat, 02 Apr 2022 11:11:46 +0000
Date:   Sat, 02 Apr 2022 19:10:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 30b0001fcdc1009071ce1facfb9c80a174b0260f
Message-ID: <62482f3e.8gItLZfKiiFwqn0J%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 30b0001fcdc1009071ce1facfb9c80a174b0260f  Bluetooth: btintel: Constify static struct regmap_bus

elapsed time: 1033m

configs tested: 133
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arm                           tegra_defconfig
arm                         lubbock_defconfig
mips                         cobalt_defconfig
arm                        clps711x_defconfig
arm                       aspeed_g5_defconfig
powerpc                     rainier_defconfig
powerpc                      arches_defconfig
arm                          pxa3xx_defconfig
openrisc                  or1klitex_defconfig
sh                           se7751_defconfig
sh                           se7721_defconfig
arm                             pxa_defconfig
arm                          simpad_defconfig
mips                  decstation_64_defconfig
arm                            qcom_defconfig
arc                           tb10x_defconfig
h8300                     edosk2674_defconfig
arm                          gemini_defconfig
sh                          r7785rp_defconfig
m68k                       m5208evb_defconfig
powerpc                      makalu_defconfig
powerpc                           allnoconfig
sh                            hp6xx_defconfig
powerpc                 mpc834x_mds_defconfig
parisc64                         alldefconfig
sparc                       sparc32_defconfig
sh                             sh03_defconfig
mips                      loongson3_defconfig
riscv                            allmodconfig
alpha                               defconfig
arm                         vf610m4_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220402
arm                  randconfig-c002-20220331
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
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
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220401
arc                  randconfig-r043-20220402
s390                 randconfig-r044-20220402
riscv                randconfig-r042-20220402
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220402
riscv                randconfig-c006-20220402
mips                 randconfig-c004-20220402
arm                  randconfig-c002-20220402
powerpc                 mpc8315_rdb_defconfig
mips                      maltaaprp_defconfig
powerpc                     mpc512x_defconfig
arm                           spitz_defconfig
powerpc                      acadia_defconfig
powerpc                     ksi8560_defconfig
arm                         hackkit_defconfig
mips                           mtx1_defconfig
powerpc                     kmeter1_defconfig
mips                          ath79_defconfig
arm                          ep93xx_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220401
hexagon              randconfig-r041-20220401
s390                 randconfig-r044-20220401
riscv                randconfig-r042-20220401

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
