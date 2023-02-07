Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E797C636CC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Feb 2023 10:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjBGKfS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Feb 2023 05:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjBGKfR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Feb 2023 05:35:17 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35915586
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Feb 2023 02:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675766087; x=1707302087;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4sAYvLBQ/5crjpS1eLzeN0VJTFAITtRGHrQG1yCXpjU=;
  b=VZOBxeUTpphjmTebyi5+OgGj8HwZe3ryI0ReQ7WuDZkVLVTgwDqbRYTr
   cBv++14K/1UOQo6tVoZE/eM+8hKGuHo6A87O7/xnYadLt0t8/sT65FmaA
   nFYjIkZ5Ljo0yZu8CcIbPrPXLszi0htPq8D46jmb/neF2DYoQ0W7tJlEU
   Vg2DCXE4XvPWtYt5D97M2Afc7RyfLcLu+NubUdaU93PqAoZy7tSlibxPk
   Nv++z2MrT0oIw2LQFsHCSjm9kswsqBQwpEuHjDYqKa5RXhBFqDGlC/EY6
   eGQT7JhkEI8AKnnrIzrlbsHbVm4+CPkNsqie0QUxnGR3IGnHMS4YSYxAA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="329491067"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="329491067"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 02:32:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="644407324"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="644407324"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 Feb 2023 02:32:56 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPLHT-0003SI-2Q;
        Tue, 07 Feb 2023 10:32:55 +0000
Date:   Tue, 07 Feb 2023 18:32:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 b8ad6dcdc6515a0fbd78bae07a8288de1b09e90f
Message-ID: <63e228ac.H/aQDUfWMdHYf6jU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: b8ad6dcdc6515a0fbd78bae07a8288de1b09e90f  Bluetooth: btintel: Set Per Platform Antenna Gain(PPAG)

elapsed time: 723m

configs tested: 79
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
riscv                randconfig-r042-20230204
x86_64                              defconfig
s390                 randconfig-r044-20230206
arc                  randconfig-r043-20230204
arc                  randconfig-r043-20230206
s390                 randconfig-r044-20230204
riscv                randconfig-r042-20230206
x86_64                               rhel-8.3
ia64                             allmodconfig
x86_64               randconfig-a013-20230206
x86_64               randconfig-a011-20230206
x86_64               randconfig-a012-20230206
x86_64               randconfig-a014-20230206
x86_64                           allyesconfig
arm                                 defconfig
x86_64               randconfig-a015-20230206
x86_64               randconfig-a016-20230206
arm64                            allyesconfig
arm                              allyesconfig
i386                                defconfig
i386                             allyesconfig
arm                     eseries_pxa_defconfig
sh                          rsk7203_defconfig
m68k                          amiga_defconfig
xtensa                           alldefconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
s390                             allyesconfig
mips                           jazz_defconfig
sh                          r7780mp_defconfig
um                               alldefconfig
xtensa                  nommu_kc705_defconfig
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20230206
hexagon              randconfig-r041-20230206
hexagon              randconfig-r041-20230204
arm                  randconfig-r046-20230204
arm                  randconfig-r046-20230206
hexagon              randconfig-r045-20230204
x86_64               randconfig-a002-20230206
x86_64               randconfig-a004-20230206
x86_64               randconfig-a003-20230206
x86_64               randconfig-a001-20230206
i386                 randconfig-a002-20230206
i386                 randconfig-a004-20230206
i386                 randconfig-a001-20230206
i386                 randconfig-a003-20230206
x86_64               randconfig-a005-20230206
i386                 randconfig-a005-20230206
x86_64               randconfig-a006-20230206
i386                 randconfig-a006-20230206
arm                         mv78xx0_defconfig
powerpc                      ppc44x_defconfig
hexagon                             defconfig
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
