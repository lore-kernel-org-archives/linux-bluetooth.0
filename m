Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42C6C46467
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Jan 2023 23:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbjADXlg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Jan 2023 18:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjADXlg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Jan 2023 18:41:36 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511BFDE81
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Jan 2023 15:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672875695; x=1704411695;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=OENppEqqMaQ/x+fDQFk/A6z3zZ6G+zlbIyTH+mibt0M=;
  b=RFK9wPql0Nf+GTYIusJkHBtx2QgKj9CnizHEOSNWmNHUyI/8X8PrE8Ae
   IcZ/4amvoztxKLiPwoddHSiy3i81aEUr9ZUpAL3kfV5Pr4lgDYteW/lVa
   QmsBNC7J70HJMbaBt0JHmNejdOmdVZT7NFjzwkIXkX9fY51qzlG1nkxGi
   BDGbrUiqbDMfps3z/hbX6faigd0+WN6vi1nlhT3jNSJkLWJ7SgCUSLCWM
   StfZTcKhVhZBAvNwpe7pxwzxLbfPEH2MbXUikcaKGaUlsr8ovM+x4fcJL
   58t8iepB2irebZQAO7u7ItsJdnn6euM1tUgOKzxxM5eSwLbj86WkqQMyE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="301766005"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="301766005"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 15:41:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="605337154"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="605337154"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 04 Jan 2023 15:41:33 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pDDO0-0000sZ-2M;
        Wed, 04 Jan 2023 23:41:32 +0000
Date:   Thu, 05 Jan 2023 07:40:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 ad230933bec93bc610f0e02f2eccf252d7a65cfe
Message-ID: <63b60e75.S6USjns0rkeSlYZI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: ad230933bec93bc610f0e02f2eccf252d7a65cfe  Bluetooth: btusb: Add new PID/VID 0489:e0f2 for MT7921

elapsed time: 1446m

configs tested: 108
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
powerpc                           allnoconfig
arc                                 defconfig
x86_64                              defconfig
alpha                               defconfig
s390                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                    rhel-8.3-kselftests
s390                                defconfig
i386                                defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                           allyesconfig
x86_64                        randconfig-a015
s390                             allyesconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
arm                                 defconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
ia64                             allmodconfig
sh                               allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64               randconfig-a003-20230102
mips                             allyesconfig
x86_64               randconfig-a001-20230102
m68k                             allyesconfig
x86_64               randconfig-a004-20230102
i386                             allyesconfig
riscv                randconfig-r042-20230101
i386                 randconfig-a004-20230102
x86_64               randconfig-a002-20230102
i386                 randconfig-a003-20230102
x86_64               randconfig-a005-20230102
x86_64               randconfig-a006-20230102
i386                 randconfig-a002-20230102
i386                 randconfig-a001-20230102
arc                  randconfig-r043-20230102
i386                 randconfig-a006-20230102
arm                              allyesconfig
i386                 randconfig-a005-20230102
arm64                            allyesconfig
arm                  randconfig-r046-20230102
arc                  randconfig-r043-20230101
s390                 randconfig-r044-20230101
x86_64                            allnoconfig
powerpc                     redwood_defconfig
powerpc                 mpc8540_ads_defconfig
arm                        shmobile_defconfig
powerpc                    klondike_defconfig
i386                          randconfig-c001
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
powerpc              randconfig-c003-20230101
m68k                       m5249evb_defconfig
xtensa                    smp_lx200_defconfig
arm                         vf610m4_defconfig
sh                         ecovec24_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                 randconfig-r044-20230103
arc                  randconfig-r043-20230103
riscv                randconfig-r042-20230103
powerpc                          allmodconfig

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
hexagon              randconfig-r041-20230102
s390                 randconfig-r044-20230102
i386                 randconfig-a013-20230102
i386                 randconfig-a012-20230102
hexagon              randconfig-r045-20230101
hexagon              randconfig-r045-20230102
i386                 randconfig-a016-20230102
i386                 randconfig-a015-20230102
i386                 randconfig-a011-20230102
arm                  randconfig-r046-20230101
i386                 randconfig-a014-20230102
riscv                randconfig-r042-20230102
hexagon              randconfig-r041-20230101
x86_64                        randconfig-k001
x86_64               randconfig-a014-20230102
x86_64               randconfig-a016-20230102
x86_64               randconfig-a012-20230102
x86_64               randconfig-a011-20230102
x86_64               randconfig-a015-20230102
x86_64               randconfig-a013-20230102
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
