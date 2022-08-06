Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C0DC19F2D
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Aug 2022 12:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiHFMbf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 6 Aug 2022 08:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbiHFMa6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 6 Aug 2022 08:30:58 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFBDD5E
        for <linux-bluetooth@vger.kernel.org>; Sat,  6 Aug 2022 05:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659789057; x=1691325057;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=OR9fAU++Tt6lmq12HPRZ/49dGPpGWuC7m9PK+//Z378=;
  b=BeeddgZ+xDxtVUKT8w/B9he/mZJsvBLkO1N1lxGBc2QSLmIQUzQ4Mp7o
   VKcRT8er8kBjNFDyChk1/IRuXU44ANAq/mLYye1oyOzJm+lb5DnYI0hkU
   HptPNsSAX7oYY2C3Ti6vUY1C4o+kxj+ZK1eMF6fot4tM0tlHKZnX6Uh3B
   5ollLgVSmIN6wefhW3LBBRDlOtYr7qSbJmobIpnX7ZippOjtncb8ibkEB
   zetzBRsordTECebhEWn5Zu7KFoJm/mb6mvXLUXg3rVpxe9a3FpAsQdqEQ
   +r8xrE004zLJLYLtZHwzH8JouQEHVktQXhq9yt/9sW6IIWZKm23kIzICv
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="273412572"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="273412572"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 05:30:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="554406761"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 Aug 2022 05:30:55 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKIxD-000KMF-0v;
        Sat, 06 Aug 2022 12:30:55 +0000
Date:   Sat, 06 Aug 2022 20:30:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 aac59090a068139550f9b73d46d1116e31cdd2d1
Message-ID: <62ee5edd.yYcf5e5wOrkrSsob%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: aac59090a068139550f9b73d46d1116e31cdd2d1  Bluetooth: ISO: Fix not using the correct QoS

elapsed time: 718m

configs tested: 74
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
i386                                defconfig
arm                                 defconfig
i386                             allyesconfig
x86_64                              defconfig
x86_64                          rhel-8.3-func
i386                          randconfig-a001
x86_64                         rhel-8.3-kunit
arm                              allyesconfig
x86_64                               rhel-8.3
i386                          randconfig-a003
powerpc                           allnoconfig
s390                 randconfig-r044-20220805
x86_64                        randconfig-a004
alpha                            allyesconfig
i386                          randconfig-a005
i386                          randconfig-a014
powerpc                          allmodconfig
x86_64                        randconfig-a015
m68k                             allyesconfig
arm64                            allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a002
x86_64                        randconfig-a011
sh                               allmodconfig
arc                  randconfig-r043-20220805
i386                          randconfig-a012
m68k                             allmodconfig
riscv                randconfig-r042-20220805
i386                          randconfig-a016
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a006
mips                             allyesconfig
arc                              allyesconfig
ia64                             allmodconfig
arc                               allnoconfig
alpha                             allnoconfig
csky                              allnoconfig
riscv                             allnoconfig
arm                          pxa3xx_defconfig
arm                      footbridge_defconfig
arm                        realview_defconfig
powerpc                   currituck_defconfig
mips                    maltaup_xpa_defconfig
powerpc                     taishan_defconfig
sh                               j2_defconfig
nios2                               defconfig
arm                     eseries_pxa_defconfig
csky                                defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                        warp_defconfig

clang tested configs:
hexagon              randconfig-r045-20220805
hexagon              randconfig-r041-20220805
i386                          randconfig-a013
i386                          randconfig-a002
i386                          randconfig-a015
i386                          randconfig-a006
i386                          randconfig-a004
i386                          randconfig-a011
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a003
x86_64                        randconfig-a016
powerpc                 xes_mpc85xx_defconfig
mips                      maltaaprp_defconfig
powerpc                 mpc832x_mds_defconfig
arm                       mainstone_defconfig
mips                     cu1830-neo_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
