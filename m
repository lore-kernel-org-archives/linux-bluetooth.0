Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D5AC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Oct 2022 09:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiJUJwL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Oct 2022 05:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiJUJwK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Oct 2022 05:52:10 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1203724E39E
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Oct 2022 02:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666345930; x=1697881930;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=kZ0SHU7O08hc8nj4a/OYiEJsfWHuobhJIxOo+ZpZG/U=;
  b=Qx82PFByP8KbYPPct8s7CpnJneAvlfwZIjITSizIIkFHVlCgdlBgiZi+
   3qcprpLhUsgMSULGs3encvT/Dl9q5aHPLBwVqP/YaqAJg5ZpuGz+CnRW4
   aXLWYURxf1c1Jqs9P/tmBUy1VMDdWPcwSgVORdpqDCKR2zIIEan3VAZnA
   svI3q2vWGFpEtvrQkjLvURaOLNT87X7VZkrTRMbk1GwuqtDH5ZH++rJJM
   SGV24FTnNov+rx87x9AWNziQJBCYKvGOZ5Oya3c0KEin29m0UANewc0fS
   km2uh7z1JYVgwVqZ6Ualpw7a9cm0YVEf96N3RtX21XgRcV8K5H4vwXl0C
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="304577560"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="304577560"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 02:52:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="608286017"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="608286017"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2022 02:51:58 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oloh4-0002UD-0x;
        Fri, 21 Oct 2022 09:51:58 +0000
Date:   Fri, 21 Oct 2022 17:50:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 f334dabe7dae4b890926601d743d2ce337883880
Message-ID: <63526b81.21CiC2tnZKdifa2r%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: f334dabe7dae4b890926601d743d2ce337883880  Bluetooth: hci_core: fix error handling in hci_register_dev()

elapsed time: 720m

configs tested: 107
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
powerpc                           allnoconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                                defconfig
x86_64                           rhel-8.3-kvm
s390                                defconfig
s390                             allmodconfig
sh                               allmodconfig
x86_64                              defconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
s390                             allyesconfig
mips                             allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a013
x86_64                           allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a004
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a002
x86_64                        randconfig-a006
arc                  randconfig-r043-20221020
alpha                            allyesconfig
arc                              allyesconfig
i386                             allyesconfig
s390                 randconfig-r044-20221020
arc                  randconfig-r043-20221018
riscv                randconfig-r042-20221020
riscv                randconfig-r042-20221018
s390                 randconfig-r044-20221018
m68k                             allyesconfig
m68k                             allmodconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
m68k                            q40_defconfig
powerpc                     tqm8541_defconfig
arm                           stm32_defconfig
powerpc                      chrp32_defconfig
i386                          randconfig-c001
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
openrisc                         alldefconfig
powerpc                       holly_defconfig
sh                ecovec24-romimage_defconfig
arm                      footbridge_defconfig
sh                     magicpanelr2_defconfig
arm                          gemini_defconfig
mips                  maltasmvp_eva_defconfig
m68k                         apollo_defconfig
arc                        vdk_hs38_defconfig
sh                           se7712_defconfig
mips                      loongson3_defconfig
xtensa                generic_kc705_defconfig
nios2                            alldefconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
i386                          randconfig-a002
x86_64                        randconfig-a014
i386                          randconfig-a004
x86_64                        randconfig-a016
x86_64                        randconfig-a012
hexagon              randconfig-r041-20221020
i386                          randconfig-a006
x86_64                        randconfig-a005
x86_64                        randconfig-a001
hexagon              randconfig-r045-20221020
x86_64                        randconfig-a003
i386                 randconfig-a011-20221017
i386                 randconfig-a013-20221017
i386                 randconfig-a012-20221017
hexagon              randconfig-r041-20221018
i386                 randconfig-a014-20221017
hexagon              randconfig-r045-20221018
i386                 randconfig-a016-20221017
i386                 randconfig-a015-20221017
mips                          ath79_defconfig
arm                         shannon_defconfig
mips                     cu1830-neo_defconfig
arm                       mainstone_defconfig
arm                  colibri_pxa300_defconfig
powerpc                     tqm8560_defconfig
powerpc                     kmeter1_defconfig
mips                       lemote2f_defconfig
powerpc                    socrates_defconfig
arm                         orion5x_defconfig
arm                        magician_defconfig
s390                 randconfig-r044-20221019
hexagon              randconfig-r045-20221019
riscv                randconfig-r042-20221019
hexagon              randconfig-r041-20221019
powerpc                 mpc8560_ads_defconfig
mips                           rs90_defconfig
x86_64                        randconfig-k001
arm                          ep93xx_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                          ath25_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
