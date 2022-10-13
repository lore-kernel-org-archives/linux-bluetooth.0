Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BAFC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Oct 2022 08:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiJMIXw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Oct 2022 04:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiJMIXt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Oct 2022 04:23:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670D0150486
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Oct 2022 01:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665649427; x=1697185427;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ieTvjGoZ+bgI8vmet7lO4Nv7IeXtZNos36QDNHol/yk=;
  b=X1Vm59Hrp/KHH2vt6G2OUErZrPS9b/ZekBMD0/L1KCNbEbvP7KzkQeJQ
   RIeab00pQii6iMqnbnNa+bWo5+3vOg6g/hWI6ATnA8L78R7D2T+9UPbpZ
   xe1U52h6rrdCN4DTKpF7rrZsboOJMhIJEq2MzAW4GS4HyQuurV1v0OBCY
   EOBcgfIL4a4iaoNDQoIyTgGzgOWiE6YZv9c0GR5Z7XMNJhOI1+q6z2GSB
   pNTWAmfMAezsvXs6oUjW+v4aH5OX1uXEZW+TrsN5uH2UKjnn7O82SIV4M
   yPIhSWV2sv3qQZKMaW6oJVQNEcYLYf6j/qRQslyzZH6U0+BoQZVhcZtBH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="302633598"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="302633598"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 01:23:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="956078282"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="956078282"
Received: from lkp-server01.sh.intel.com (HELO 2af0a69ca4e0) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 13 Oct 2022 01:23:45 -0700
Received: from kbuild by 2af0a69ca4e0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oitVI-0004tD-1q;
        Thu, 13 Oct 2022 08:23:44 +0000
Date:   Thu, 13 Oct 2022 16:22:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 6ab8872f1976e3b00ec5280f19355a462298503a
Message-ID: <6347cade.QF2VKpm91DNgowjm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 6ab8872f1976e3b00ec5280f19355a462298503a  Bluetooth: virtio_bt: Use skb_put to set length

elapsed time: 724m

configs tested: 81
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                                defconfig
x86_64                           rhel-8.3-syz
x86_64                              defconfig
x86_64                               rhel-8.3
arc                                 defconfig
alpha                               defconfig
i386                          randconfig-a001
i386                          randconfig-a003
s390                             allmodconfig
x86_64                        randconfig-a002
arm                                 defconfig
x86_64                           allyesconfig
i386                          randconfig-a005
x86_64                          rhel-8.3-func
x86_64                        randconfig-a006
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a004
s390                                defconfig
i386                          randconfig-a014
riscv                randconfig-r042-20221012
i386                          randconfig-a012
s390                 randconfig-r044-20221012
i386                             allyesconfig
i386                          randconfig-a016
powerpc                           allnoconfig
s390                             allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
arc                  randconfig-r043-20221012
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arm                              allyesconfig
arm64                            allyesconfig
sh                               allmodconfig
x86_64                        randconfig-a015
ia64                             allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
mips                         bigsur_defconfig
sh                           se7780_defconfig
arm                             ezx_defconfig
ia64                        generic_defconfig
powerpc                 mpc837x_mds_defconfig
arm                        multi_v7_defconfig
arc                     haps_hs_smp_defconfig
sh                          kfr2r09_defconfig
nios2                               defconfig
loongarch                 loongson3_defconfig
arm                        mini2440_defconfig
powerpc                     stx_gp3_defconfig
arm                         lpc18xx_defconfig
powerpc                  storcenter_defconfig
powerpc                 linkstation_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arm                       omap2plus_defconfig
sparc                               defconfig
powerpc                     tqm8541_defconfig
arm                        spear6xx_defconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a013
x86_64                        randconfig-a001
i386                          randconfig-a006
x86_64                        randconfig-a003
i386                          randconfig-a015
i386                          randconfig-a004
x86_64                        randconfig-a005
i386                          randconfig-a011
hexagon              randconfig-r041-20221012
hexagon              randconfig-r045-20221012
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
