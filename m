Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FD8C43334
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Jun 2022 18:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346862AbiFESs5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Jun 2022 14:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbiFESs4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Jun 2022 14:48:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D562366A4
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Jun 2022 11:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654454935; x=1685990935;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=iGJvqdAgiDEvNJivjfS7y8VoRI4idlzUcTnYAjhc7/8=;
  b=UguB14GxCaOJm/4tGPgO1nz49aX0Puy4fdz7JeQjra0c1GkTM+i4SfVj
   ai8Svrp5Yux3+LFESsB4tTbu+Lb68WF3WzYHxJffL3N4/hFNr6hRL37NL
   hePp1hihK2fY2MlkKhrhGqsj7/kNWx1Qg/bkT2milrrB2VXniFgPgP5AS
   9IaThD2J9Ak00eErFjDUUcxHJ8fo1XUQ5jhQUZoV+yuMhHMInSC8iop2w
   JQeCvZ2X4VoO9KlViTYZd+ycyF3eE2MTwMnOV/eLgjUbdO8TUWM4TLGPz
   uH9Jg4QXvuzzgUMiBCaR3tFg+tzHddsPWN4MHhkLVBBKmR/fIu6j+57cc
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="276381950"
X-IronPort-AV: E=Sophos;i="5.91,279,1647327600"; 
   d="scan'208";a="276381950"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 11:48:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,279,1647327600"; 
   d="scan'208";a="583269470"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 05 Jun 2022 11:48:53 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxvIz-000C9l-8y;
        Sun, 05 Jun 2022 18:48:53 +0000
Date:   Mon, 06 Jun 2022 02:48:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 a589ee43644c0269a066fa06e1ad4b3599ae6b1d
Message-ID: <629cfa8b.fCtEbefJLPuY43Wr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: a589ee43644c0269a066fa06e1ad4b3599ae6b1d  Bluetooth: hci_bcm: Add BCM4349B1 variant

elapsed time: 839m

configs tested: 112
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
m68k                         apollo_defconfig
arm64                               defconfig
m68k                       m5275evb_defconfig
ia64                      gensparse_defconfig
openrisc                 simple_smp_defconfig
powerpc                 mpc834x_itx_defconfig
arm                          pxa910_defconfig
openrisc                  or1klitex_defconfig
arm                      jornada720_defconfig
powerpc                           allnoconfig
parisc                              defconfig
alpha                               defconfig
arc                        nsimosci_defconfig
nios2                            allyesconfig
openrisc                    or1ksim_defconfig
mips                     decstation_defconfig
powerpc                      arches_defconfig
ia64                             allyesconfig
mips                       bmips_be_defconfig
sh                ecovec24-romimage_defconfig
arc                            hsdk_defconfig
sh                        dreamcast_defconfig
mips                         cobalt_defconfig
sparc64                             defconfig
sh                         apsh4a3a_defconfig
powerpc                         ps3_defconfig
sh                             shx3_defconfig
powerpc                     asp8347_defconfig
powerpc                        warp_defconfig
parisc                generic-64bit_defconfig
s390                                defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                             allyesconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
parisc64                            defconfig
riscv                               defconfig
h8300                            allyesconfig
m68k                             allyesconfig
xtensa                           allyesconfig
m68k                             allmodconfig
csky                                defconfig
arc                                 defconfig
mips                             allyesconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
alpha                            allyesconfig
mips                             allmodconfig
sh                               allmodconfig
powerpc                          allmodconfig
sparc                            allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
powerpc                          allyesconfig
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
ia64                             allmodconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
ia64                                defconfig
i386                          randconfig-a001
x86_64                        randconfig-a004
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a008
i386                          randconfig-a009
i386                          randconfig-a010
i386                          randconfig-a007
x86_64                        randconfig-a006
i386                          randconfig-a012
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                                  kexec
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz

clang tested configs:
powerpc                   microwatt_defconfig
mips                        maltaup_defconfig
arm                         bcm2835_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                     mpc5200_defconfig
powerpc                      ppc64e_defconfig
arm                          ep93xx_defconfig
arm                        vexpress_defconfig
mips                          ath79_defconfig
i386                          randconfig-a002
x86_64                        randconfig-a009
x86_64                        randconfig-a007
i386                          randconfig-a006
x86_64                        randconfig-a010
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a008
i386                          randconfig-a004
x86_64                        randconfig-a012
i386                          randconfig-a011

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
