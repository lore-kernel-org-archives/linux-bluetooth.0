Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2445C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Nov 2022 09:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiKBJo7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Nov 2022 05:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKBJo6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Nov 2022 05:44:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789881F9EC
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Nov 2022 02:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667382297; x=1698918297;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=lKBnfr66pzHgVrtVjQy2OLyNQaTJzq/LeVE49SxCfwQ=;
  b=IQq42RiXnp9awGK2v+Z85KXkc+0hUfYaawvec17sE3M5Fc3kSjATxVnF
   Ng2jZY2qrDCMhbwcutZVxWql9/JmEx4YmqbamkQR0JOA2WG6EIOha+mae
   FttOBTzCJZNtaw/QfkoANaUNKozoQZN62UUZeJ+vrUd/ikBSPhYQxjzed
   NrLm27hTAJbjr2hyN8gn3sogwpPAMlSWMJHPhGoDaqsWdZh8a19KIOqqG
   yzQg4VJCFs8CJI9soY8DXBSc/3VrynHAtQ4jtKgaWtlKKmvjmy46Rfjwq
   d8of2orYJncSKVbJb1poi221FRhlmMyreQhLoD8181UvklVO3153/ve62
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="395670922"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="395670922"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 02:44:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="697742797"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="697742797"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 02 Nov 2022 02:44:51 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oqAIk-000Eej-35;
        Wed, 02 Nov 2022 09:44:50 +0000
Date:   Wed, 02 Nov 2022 17:44:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 34f07dd531a4cf92afb3dbd7057c35702d0870e3
Message-ID: <63623bee.3lgOEsnZ0NP1wM8B%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 34f07dd531a4cf92afb3dbd7057c35702d0870e3  Bluetooth: L2CAP: Fix attempting to access uninitialized memory

elapsed time: 722m

configs tested: 103
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
alpha                               defconfig
x86_64                               rhel-8.3
x86_64                              defconfig
s390                             allmodconfig
s390                                defconfig
powerpc                           allnoconfig
m68k                             allmodconfig
powerpc                          allmodconfig
arc                              allyesconfig
mips                             allyesconfig
alpha                            allyesconfig
x86_64                           rhel-8.3-syz
sh                               allmodconfig
m68k                             allyesconfig
x86_64                         rhel-8.3-kunit
s390                             allyesconfig
x86_64                           rhel-8.3-kvm
arc                  randconfig-r043-20221101
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
ia64                             allmodconfig
x86_64                        randconfig-a013
i386                          randconfig-a001
x86_64                        randconfig-a011
i386                          randconfig-a003
i386                                defconfig
i386                          randconfig-a014
x86_64                        randconfig-a015
i386                          randconfig-a005
i386                          randconfig-a012
i386                          randconfig-a016
arm                                 defconfig
i386                             allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
arm                       omap2plus_defconfig
arm                          iop32x_defconfig
riscv                    nommu_k210_defconfig
sh                        sh7757lcr_defconfig
openrisc                    or1ksim_defconfig
x86_64               randconfig-k001-20221031
arm                      footbridge_defconfig
powerpc                     taishan_defconfig
sh                  sh7785lcr_32bit_defconfig
alpha                             allnoconfig
arm64                            alldefconfig
powerpc                 linkstation_defconfig
m68k                        stmark2_defconfig
arm                            mps2_defconfig
sparc                             allnoconfig
xtensa                    smp_lx200_defconfig
arm                          gemini_defconfig
sh                 kfr2r09-romimage_defconfig
xtensa                       common_defconfig
powerpc                     stx_gp3_defconfig
ia64                        generic_defconfig
sh                          rsk7203_defconfig
sh                      rts7751r2d1_defconfig
i386                          randconfig-c001
i386                 randconfig-a016-20221031
i386                 randconfig-a012-20221031
i386                 randconfig-a015-20221031
i386                 randconfig-a013-20221031
i386                 randconfig-a014-20221031
i386                 randconfig-a011-20221031
sparc                       sparc64_defconfig
sh                          lboxre2_defconfig
arm                        keystone_defconfig
arm                         cm_x300_defconfig
mips                           xway_defconfig
i386                 randconfig-c001-20221031
powerpc                      arches_defconfig
powerpc                    klondike_defconfig

clang tested configs:
hexagon              randconfig-r041-20221101
hexagon              randconfig-r045-20221101
riscv                randconfig-r042-20221101
s390                 randconfig-r044-20221101
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a016
i386                          randconfig-a002
x86_64                        randconfig-a012
i386                          randconfig-a011
i386                          randconfig-a006
x86_64                        randconfig-a014
i386                          randconfig-a004
arm                        vexpress_defconfig
powerpc                       ebony_defconfig
powerpc                      obs600_defconfig
hexagon              randconfig-r041-20221102
hexagon              randconfig-r045-20221102
arm                      pxa255-idp_defconfig
mips                      bmips_stb_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
