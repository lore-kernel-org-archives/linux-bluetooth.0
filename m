Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22F8C4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Dec 2022 09:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiLCJiu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 3 Dec 2022 04:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiLCJis (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 3 Dec 2022 04:38:48 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1F413E1C
        for <linux-bluetooth@vger.kernel.org>; Sat,  3 Dec 2022 01:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670060327; x=1701596327;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+WgtYDT2s61gpP9CAcBW9u5bzpAvSA+IZRFpervOKU0=;
  b=mwL7CXLhEHY/Nuf73exjePCfRICvujX302CV37/NGvq5S0KyG/z5D/s1
   1J/lqXk2QfY4DWMUFgMguG7dZxwe6I6Vd4JnxD0CuP7V8e63y1mEu9r2u
   oimTcB+UxkzrZiKl0lZf3Szrbvbu0M/s/d2W36y3ALMkyIHYmOoIHN/wE
   Pyi06Sw/GGklXKbmBfKKC1w2eO3g2nbZLb8sxiB4d7mvdpHggD80+Z8HO
   +OICn5907gR1lAxl6x0H0lX9ZgLPd3eORwThyURe8XSiEEU9cBiTBFNgH
   xPM3uc4+kpV7GbPKBCA8c5RmZo0E/yrYvF/zrq2H3wGn72qxVhfebJdnp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="303721742"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="303721742"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2022 01:38:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="751574295"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="751574295"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 03 Dec 2022 01:38:45 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p1Oyr-000ES5-0p;
        Sat, 03 Dec 2022 09:38:45 +0000
Date:   Sat, 03 Dec 2022 17:37:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 dbd24be484227fe64615fc6c01fa9cf6de0455ac
Message-ID: <638b18ef.wVVtbKfIQeAfxYE2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: dbd24be484227fe64615fc6c01fa9cf6de0455ac  Bluetooth: Fix crash when replugging CSR fake controllers

elapsed time: 721m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
powerpc                           allnoconfig
alpha                               defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                               rhel-8.3
x86_64                              defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
s390                             allmodconfig
s390                                defconfig
ia64                             allmodconfig
x86_64                           allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
sh                               allmodconfig
alpha                            allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
s390                             allyesconfig
x86_64                        randconfig-a006
mips                             allyesconfig
powerpc                          allmodconfig
arc                  randconfig-r043-20221201
riscv                randconfig-r042-20221201
s390                 randconfig-r044-20221201
i386                                defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a005
i386                             allyesconfig
arm                                 defconfig
x86_64                            allnoconfig
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r045-20221201
hexagon              randconfig-r041-20221201
i386                          randconfig-a013
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a006
x86_64                        randconfig-k001
arm                       spear13xx_defconfig
arm                          ep93xx_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
