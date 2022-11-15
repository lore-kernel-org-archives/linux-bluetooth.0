Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CF2C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Nov 2022 13:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiKONxv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Nov 2022 08:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238558AbiKONxY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Nov 2022 08:53:24 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE25B2C124
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Nov 2022 05:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668520389; x=1700056389;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=A4VgQnvph0DHbzOmVYbPqu6YF9s9HGfqLKDClF4460M=;
  b=TwqdZm8cQ67FH1/Zd+TGVsbfLzL5vd69qxu+pQTidM2FCMGamEn5DNhM
   pn66PYV5SxQT9zUdtWGcW6Rpvv7pBj378XHDBtHxU+WqdMU2mIjkG+4aq
   H9+8/pfHXM6r7+nfBoIDwPdKoEI0QKFfitvF1Sg4IR1N5c/KOGm4vRoij
   +PSOk0HnRqDOY6nz/z9DKNnVrASa+b2yUInP6RO8lMtQFCV43E+wbrUAz
   17GR8Zsz1i6gFbTHBJPQKLq8Opm5YP5Vmh/CQSwxrg9AIwKmuyF37Szlf
   /LnZc5io8c3xrh/ZEkCpnfv4Q2DXxj15OBkAS6mZjHKoaenJz+tceYkjJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="314064705"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="314064705"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 05:53:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="638949899"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="638949899"
Received: from lkp-server01.sh.intel.com (HELO ebd99836cbe0) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 15 Nov 2022 05:53:08 -0800
Received: from kbuild by ebd99836cbe0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ouwN9-0001P9-1d;
        Tue, 15 Nov 2022 13:53:07 +0000
Date:   Tue, 15 Nov 2022 21:52:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 e32c8d8c6f2918b45fa146e6ab63af9b7b56aba6
Message-ID: <63739994.6xF4vtTeSbPgiWA9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: e32c8d8c6f2918b45fa146e6ab63af9b7b56aba6  Bluetooth: hci_conn: add missing hci_dev_put() in iso_listen_bis()

elapsed time: 943m

configs tested: 107
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
um                             i386_defconfig
s390                             allmodconfig
um                           x86_64_defconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
sh                               allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arc                  randconfig-r043-20221114
x86_64                            allnoconfig
m68k                             allyesconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
i386                             allyesconfig
i386                                defconfig
parisc                generic-32bit_defconfig
sh                     magicpanelr2_defconfig
mips                           gcw0_defconfig
ia64                             allmodconfig
i386                 randconfig-a002-20221114
i386                 randconfig-a004-20221114
i386                 randconfig-a003-20221114
i386                 randconfig-a005-20221114
i386                 randconfig-a006-20221114
i386                 randconfig-a001-20221114
arm                           sunxi_defconfig
arm                               allnoconfig
loongarch                 loongson3_defconfig
arc                         haps_hs_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
powerpc                     stx_gp3_defconfig
sh                           sh2007_defconfig
loongarch                        allmodconfig
sh                               j2_defconfig
arm                           stm32_defconfig
parisc                           alldefconfig
arm                         assabet_defconfig
arc                               allnoconfig
m68k                             allmodconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
x86_64               randconfig-a003-20221114
x86_64               randconfig-a005-20221114
x86_64               randconfig-a004-20221114
x86_64               randconfig-a002-20221114
x86_64               randconfig-a001-20221114
x86_64               randconfig-a006-20221114
xtensa                         virt_defconfig
sh                            shmin_defconfig
xtensa                              defconfig
mips                        vocore2_defconfig
i386                 randconfig-c001-20221114
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
x86_64                        randconfig-c001
i386                          randconfig-c001
arm                  randconfig-c002-20221115
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arm                          pxa3xx_defconfig
m68k                       m5475evb_defconfig
sh                            hp6xx_defconfig
mips                  decstation_64_defconfig
powerpc                    sam440ep_defconfig
sparc64                          alldefconfig
sparc64                             defconfig
ia64                         bigsur_defconfig
ia64                             allyesconfig
m68k                          atari_defconfig
powerpc                      ppc6xx_defconfig
powerpc                        cell_defconfig

clang tested configs:
hexagon              randconfig-r045-20221114
hexagon              randconfig-r041-20221114
s390                 randconfig-r044-20221114
riscv                randconfig-r042-20221114
x86_64               randconfig-a012-20221114
x86_64               randconfig-a013-20221114
x86_64               randconfig-a016-20221114
x86_64               randconfig-a014-20221114
x86_64               randconfig-a015-20221114
x86_64               randconfig-a011-20221114
hexagon              randconfig-r041-20221115
hexagon              randconfig-r045-20221115
i386                 randconfig-a015-20221114
i386                 randconfig-a013-20221114
i386                 randconfig-a011-20221114
i386                 randconfig-a016-20221114
i386                 randconfig-a012-20221114
i386                 randconfig-a014-20221114
x86_64               randconfig-k001-20221114
arm                        magician_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
