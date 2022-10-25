Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97410C04A95
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Oct 2022 08:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiJYIDL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Oct 2022 04:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiJYIDJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Oct 2022 04:03:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBEEEE089
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Oct 2022 01:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666684988; x=1698220988;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=6v8arPWF+O6uUeuX5B5GfxpV0jzeoJ7Bco2RusdJxbc=;
  b=YAxXcHJNQqDEYgW/K8d7ZmofBYb9UsXPMaeIjnOfpw//Iuz67LFrd513
   rEIF/pIxKm1i3sOZN+jMLWDd82gzWl+ISnl4aFuqXCnCJfd3wbKdxes16
   DAbL6rn/rRDP6r3F3xKb1JGN8d8UjspsA0ipt5s/l7E9aAUkR/wu4CU9Z
   MwuIomEhcfHAQafwN4cODvPRGAH5JuubHXlwQbycM8SO4VnQQDf8UOr59
   Or+bHWUNZsGb4hZ2ukHWDbeD7ECh0ZpG/ARX2BiByKKWikJTB7lSpS0z4
   jdVG64agf145ZEwXKkUUJYL80d3SIr4W4qVMdgPFZrSCxucIzx6BYiGu4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="295019144"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="295019144"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 01:03:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="609486555"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="609486555"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 25 Oct 2022 01:03:03 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1onEtr-00063t-0c;
        Tue, 25 Oct 2022 08:03:03 +0000
Date:   Tue, 25 Oct 2022 16:02:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 28fd83db215ebc49ebfe4f87b55b40b859b45bfe
Message-ID: <6357981b.a+wfrSfkb/+/vFw2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 28fd83db215ebc49ebfe4f87b55b40b859b45bfe  Bluetooth: MGMT: Fix error report for ADD_EXT_ADV_PARAMS

elapsed time: 721m

configs tested: 91
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
sh                               allmodconfig
alpha                            allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                              allyesconfig
mips                             allyesconfig
m68k                             allmodconfig
powerpc                          allmodconfig
arc                                 defconfig
m68k                             allyesconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
x86_64                              defconfig
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
i386                                defconfig
s390                             allyesconfig
ia64                             allmodconfig
x86_64                               rhel-8.3
arc                  randconfig-r043-20221024
riscv                randconfig-r042-20221024
arc                  randconfig-r043-20221023
s390                 randconfig-r044-20221024
x86_64                           allyesconfig
i386                             allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                 randconfig-a014-20221024
i386                 randconfig-a013-20221024
i386                 randconfig-a012-20221024
i386                 randconfig-a011-20221024
i386                 randconfig-a015-20221024
i386                 randconfig-a016-20221024
x86_64                        randconfig-a015
arm                        mini2440_defconfig
powerpc                      chrp32_defconfig
sh                          lboxre2_defconfig
mips                     decstation_defconfig
arm                           h5000_defconfig
arm                       multi_v4t_defconfig
sh                           se7712_defconfig
x86_64               randconfig-a014-20221024
x86_64               randconfig-a015-20221024
x86_64               randconfig-a016-20221024
x86_64               randconfig-a013-20221024
x86_64               randconfig-a012-20221024
x86_64               randconfig-a011-20221024
m68k                           sun3_defconfig
sh                        dreamcast_defconfig
sh                          urquell_defconfig
arm                       omap2plus_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                        spear6xx_defconfig
powerpc                      tqm8xx_defconfig
powerpc                 mpc834x_mds_defconfig
mips                            gpr_defconfig
x86_64               randconfig-k001-20221024
arc                  randconfig-r043-20221025

clang tested configs:
hexagon              randconfig-r045-20221023
hexagon              randconfig-r041-20221024
riscv                randconfig-r042-20221023
hexagon              randconfig-r045-20221024
s390                 randconfig-r044-20221023
hexagon              randconfig-r041-20221023
x86_64               randconfig-a001-20221024
x86_64               randconfig-a003-20221024
x86_64               randconfig-a006-20221024
x86_64               randconfig-a004-20221024
x86_64               randconfig-a002-20221024
x86_64               randconfig-a005-20221024
i386                 randconfig-a004-20221024
i386                 randconfig-a001-20221024
i386                 randconfig-a002-20221024
i386                 randconfig-a005-20221024
i386                 randconfig-a003-20221024
i386                 randconfig-a006-20221024
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
