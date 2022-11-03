Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E20C43219
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Nov 2022 09:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiKCJZQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Nov 2022 05:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiKCJY3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Nov 2022 05:24:29 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C10DF67
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Nov 2022 02:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667467460; x=1699003460;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=6OrlH+5pQQEIKWZcYi72GyxSrikE3il+CruugNOEQRs=;
  b=IHaEyIth7JQmoBPNKRO8dzlB+14A8yXP9Qvm/X4wBW0J82J1RHdC+ZfM
   BxD+FH6zDgEekR2BlmU3l86xpRpmxK1J6oSre1Mcy4AP+CYISt1XDzYfO
   fefZYZf0C4wDtkb5+C1FJPl4RZHQKwjfQwgNDP6ZpZisHgJhi4PC1Rk6O
   3pvPOoYe6UC68IByWE4pJ73W9l8kPZtiYjVA4uJmwmYapyursP0iRT50/
   h2OKawY8hXxalni/XJzlMgU9R0E5GZogWBD/IeKbZzGG921/z5OVGtGP5
   uACbrBYM8pq7KzW2XvMz7H7mfO1psWtqZwaCFaBUHQon7TUPtm22a1bph
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="307248161"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="307248161"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 02:24:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="667901469"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="667901469"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 03 Nov 2022 02:24:18 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oqWSP-000FlE-2g;
        Thu, 03 Nov 2022 09:24:17 +0000
Date:   Thu, 03 Nov 2022 17:23:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 ce52c2f041776966f6f053c5c591cd0fc2a93869
Message-ID: <636388ad.sQlrLfbySZjrLOsg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: ce52c2f041776966f6f053c5c591cd0fc2a93869  Bluetooth: hci_bcm: Add CYW4373A0 support

elapsed time: 724m

configs tested: 95
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
x86_64                        randconfig-a002
i386                          randconfig-a001
m68k                             allmodconfig
i386                          randconfig-a003
arc                              allyesconfig
alpha                            allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                              defconfig
mips                             allyesconfig
arc                                 defconfig
s390                             allmodconfig
x86_64                          rhel-8.3-func
alpha                               defconfig
x86_64                           rhel-8.3-syz
ia64                             allmodconfig
m68k                             allyesconfig
s390                                defconfig
x86_64                         rhel-8.3-kunit
arm                                 defconfig
x86_64                        randconfig-a006
x86_64                    rhel-8.3-kselftests
powerpc                           allnoconfig
x86_64                               rhel-8.3
i386                             allyesconfig
i386                          randconfig-a014
powerpc                          allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arc                  randconfig-r043-20221102
sh                               allmodconfig
x86_64                        randconfig-a004
arm                              allyesconfig
x86_64                        randconfig-a015
i386                          randconfig-a005
i386                          randconfig-a012
x86_64                           allyesconfig
i386                          randconfig-a016
s390                 randconfig-r044-20221102
s390                             allyesconfig
arm64                            allyesconfig
riscv                randconfig-r042-20221102
i386                          randconfig-c001
arm                            pleb_defconfig
sh                        edosk7760_defconfig
arm                       aspeed_g5_defconfig
um                                  defconfig
riscv                               defconfig
arm                        keystone_defconfig
openrisc                    or1ksim_defconfig
powerpc                      mgcoge_defconfig
m68k                          sun3x_defconfig
arc                            hsdk_defconfig
powerpc                     mpc83xx_defconfig
riscv                            allmodconfig
sh                             sh03_defconfig
powerpc                   currituck_defconfig
sh                           se7712_defconfig
mips                     decstation_defconfig
powerpc                   motionpro_defconfig
parisc                generic-32bit_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                               alldefconfig
arm                        clps711x_defconfig
csky                                defconfig
powerpc                     stx_gp3_defconfig
sh                      rts7751r2d1_defconfig
mips                       bmips_be_defconfig
m68k                       m5208evb_defconfig
powerpc                         wii_defconfig
m68k                       m5275evb_defconfig
m68k                           sun3_defconfig
arm                         nhk8815_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig

clang tested configs:
x86_64                        randconfig-a005
i386                          randconfig-a002
x86_64                        randconfig-a001
i386                          randconfig-a013
hexagon              randconfig-r041-20221102
i386                          randconfig-a015
x86_64                        randconfig-a003
x86_64                        randconfig-a014
i386                          randconfig-a004
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a011
i386                          randconfig-a006
hexagon              randconfig-r045-20221102
mips                     loongson1c_defconfig
mips                           mtx1_defconfig
powerpc               mpc834x_itxgp_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
