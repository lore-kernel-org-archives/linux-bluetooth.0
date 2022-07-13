Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D71AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jul 2022 21:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237131AbiGMVEQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Jul 2022 17:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236919AbiGMVEN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Jul 2022 17:04:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B2B29CB6
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jul 2022 14:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657746252; x=1689282252;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ZjGs9kFmJxmeMXW1tS2MGN4PA558Q9zPHtdJS3nEbDY=;
  b=ExIiqTc7MNGO3SzNg6uvLzvIlLBjRGNvzJTYhtHc8FBDNxcjBG5MtC/y
   2SA744Ao2zkt7pxHdBP1rFHwRPfj9vlldlogCGX6tHtyUHTyMzvqR1UcE
   G0wfXcuKfgUJ5sCMnpbEtiHMBQ67muVcqtGwwsVoxoKBgRl8mnfJKts+V
   qXmzYJIV0NEQF7HJDyT1b+qPtS3EZhos7fRmunNwUIhK4Ki4WxyD0zg1Q
   OQML7bLuYjwSBv7TjXcmhLkRLi/r3bnU0A44zrX4Wple32ZqtltbOpVug
   R+BhCvGBbBkL61A3+tEYIwXZiyMxNG9gG1AThNDAhTgRUFPmPfVkXvSHI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="347027058"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="347027058"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 14:04:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="922797895"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jul 2022 14:04:10 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBjWj-0003nD-Sg;
        Wed, 13 Jul 2022 21:04:09 +0000
Date:   Thu, 14 Jul 2022 05:04:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 0cc323d985f97d5fd9a4217c536585a65dae4888
Message-ID: <62cf3342.psRibjfVduMKj7jh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 0cc323d985f97d5fd9a4217c536585a65dae4888  Bluetooth: hci_sync: Fix resuming scan after suspend resume

elapsed time: 1456m

configs tested: 57
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
sh                         apsh4a3a_defconfig
sh                           se7751_defconfig
arm                         nhk8815_defconfig
arm64                            alldefconfig
nios2                         3c120_defconfig
ia64                             allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
riscv                randconfig-r042-20220710
arc                  randconfig-r043-20220710
s390                 randconfig-r044-20220710
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20220710
hexagon              randconfig-r045-20220710

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
