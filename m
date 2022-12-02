Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C3FC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Dec 2022 08:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbiLBIj2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Dec 2022 03:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbiLBIiz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Dec 2022 03:38:55 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090EA5C0DC
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Dec 2022 00:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669970287; x=1701506287;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FIv6EZSkazzztb9d2YCiz4z/Ds+mp8mfss18jEWItas=;
  b=ZF4HN5H4L6Q3CagHH+sheTdlDzqJVD1MVjcMRzWND1DiMrlDH9vToqx/
   mFqSxF2sBaX7/i8b9gCwbQimMFAPiPgSFjA1/1MfwZ1wOv5vTfgAOOYfK
   ZfBiQRw+gSBR3gkFAzMKWFty9jDEvJM5Qr2w7wWt/jD0dSKSJ5Bzkx96n
   7iIBD03PlMoIV/2HO2u9IkNgJW94bes6zeFWsufefNFA2h1+uWN0Xuewu
   tzt3j3Z8jkmOcuaZShEiEI9dfm/r4WJLmm5SCRIUrzYT8vH73xyrhRWcm
   YybUMPXWpzb9BY4bEX3irk0WL9hcA+V9sSV+Q5imkt4V/ZzqkMEfIDV2u
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="378058841"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="378058841"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 00:38:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="890072091"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="890072091"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 02 Dec 2022 00:38:04 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p11YZ-000DRL-21;
        Fri, 02 Dec 2022 08:38:03 +0000
Date:   Fri, 02 Dec 2022 16:37:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 6fe6d1677693fe7e2638bf88fbbf47abbebeab27
Message-ID: <6389b953.Cg2dUDfFjScQH/Rp%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 6fe6d1677693fe7e2638bf88fbbf47abbebeab27  Bluetooth: btusb: Add a new PID/VID 13d3/3549 for RTL8822CU

elapsed time: 725m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allyesconfig
ia64                             allmodconfig
m68k                             allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
arc                  randconfig-r043-20221201
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
riscv                randconfig-r042-20221201
x86_64                         rhel-8.3-kunit
s390                 randconfig-r044-20221201
x86_64                               rhel-8.3
x86_64                              defconfig
x86_64                           allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                             allyesconfig
i386                                defconfig
x86_64                            allnoconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
xtensa                           alldefconfig
microblaze                          defconfig
powerpc                      arches_defconfig
powerpc                      tqm8xx_defconfig
i386                          randconfig-c001

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
hexagon              randconfig-r041-20221201
hexagon              randconfig-r045-20221201
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-k001
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
