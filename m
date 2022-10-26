Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E71C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Oct 2022 11:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbiJZLtz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Oct 2022 07:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbiJZLtx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Oct 2022 07:49:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838594C033
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Oct 2022 04:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666784991; x=1698320991;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=VglMMkNAidq8/3Z7Sov+gsaTQtiIoOSE1ELayfk0qz0=;
  b=Bx6wmzmCfOr85gb8IxXBJBvIhDNUYM9d3gi7HxHiaFEq8NUoQr3/a0Oz
   CYMacgV1XC54FpOVR/jTtcXt8Ek776pzwiVgk6CiaMyyyNAstE8fYrsoG
   mQgc6cBCJzIksTp4hYfoAgwYAEJQNwyXoEX+F4fIPmw7iQ1hMir9KjHm6
   oMCCiicdLpadev6IeFi0UxmGLkJ1pIpGq0B0I7wFj2lvEMS+IxCxFnG7g
   eV/2ecIrHSELBdVOHxG3BXeRmMREyqXJdV5c60lQespk0e89x6QVwl8yd
   PbsKBQfRI+IXBW7r5LI3/FBKd5mVDwV60LmB0lXsKN0D21moPUZW7SSQk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="306653435"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="306653435"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 04:49:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="961180841"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="961180841"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 26 Oct 2022 04:49:50 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oneur-0007Mu-1s;
        Wed, 26 Oct 2022 11:49:49 +0000
Date:   Wed, 26 Oct 2022 19:49:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 57dc0d471d2765c4b2952da97a90120a9d689a7e
Message-ID: <63591edc.OiStsThCBHLOE9Bu%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 57dc0d471d2765c4b2952da97a90120a9d689a7e  virtio_bt: Fix alignment in configuration struct

elapsed time: 724m

configs tested: 76
configs skipped: 2

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
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
m68k                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                              defconfig
x86_64                    rhel-8.3-kselftests
i386                                defconfig
x86_64                               rhel-8.3
ia64                             allmodconfig
i386                          randconfig-a014
i386                             allyesconfig
arc                  randconfig-r043-20221024
riscv                randconfig-r042-20221024
x86_64                        randconfig-a013
arc                  randconfig-r043-20221023
x86_64                        randconfig-a011
s390                 randconfig-r044-20221024
x86_64                        randconfig-a015
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
arm                                 defconfig
x86_64                           allyesconfig
arc                  randconfig-r043-20221025
arm                              allyesconfig
arm64                            allyesconfig
i386                 randconfig-a011-20221024
i386                 randconfig-a014-20221024
i386                 randconfig-a015-20221024
i386                 randconfig-a016-20221024
i386                 randconfig-a012-20221024
i386                 randconfig-a013-20221024
ia64                          tiger_defconfig
powerpc                   motionpro_defconfig
sh                         ecovec24_defconfig
sh                        sh7785lcr_defconfig
mips                     decstation_defconfig
arm                         axm55xx_defconfig
powerpc                       holly_defconfig
arm                           viper_defconfig
i386                          randconfig-c001

clang tested configs:
i386                          randconfig-a013
hexagon              randconfig-r045-20221023
hexagon              randconfig-r041-20221024
i386                          randconfig-a011
hexagon              randconfig-r045-20221024
s390                 randconfig-r044-20221023
hexagon              randconfig-r041-20221023
x86_64                        randconfig-a012
riscv                randconfig-r042-20221023
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                 randconfig-a003-20221024
i386                 randconfig-a002-20221024
i386                 randconfig-a004-20221024
i386                 randconfig-a005-20221024
i386                 randconfig-a001-20221024
i386                 randconfig-a006-20221024

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
