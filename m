Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EF2C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Feb 2023 16:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjBCQKN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Feb 2023 11:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjBCQKM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Feb 2023 11:10:12 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED8A7A91
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Feb 2023 08:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675440612; x=1706976612;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=GcQtf5LoWnWuuAgyAnZSpqdhRFAVp/4vuMtDHLoHo1Q=;
  b=hDsoSvHVe1Qmc0NTGIcebLxOZCMDVMSAR1c/Ydz/pbIxdwhVE1+Np+PJ
   N+1nCGz1QtMN2Fp0HqbNfMNJVj5grcx6Ny8mnvkXm+sZ33ieuUYushDrl
   qGo+mqjPBqF9urFAWD1vuDhtjsRbHjN1L/+/ybyd2Kx/yh3Pm1M6Dp8DB
   Xk8y1MQc16qWO8hcyS+Qn2Q8cNlDw4Vr2bRk8025VYpQuBtAOzS0d8sTK
   hCoN//LFxyaHsxL6ohWzxTFX/+VYHf3hb/Sf+jAGao4WNcJ0MpUpQFayY
   GjnJQq88W8cekjlxQl2tfmbx35xmHO6qfjz6O59QymND/dNtoD3uZzke/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="393372273"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="393372273"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 08:10:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="994562977"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="994562977"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 03 Feb 2023 08:10:08 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNydb-0000cW-2F;
        Fri, 03 Feb 2023 16:10:07 +0000
Date:   Sat, 04 Feb 2023 00:09:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 3d29daf4b155dbb4c834186f46c0877a1ebb3607
Message-ID: <63dd31a7.SDaG3h6Ug1NCDcUF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 3d29daf4b155dbb4c834186f46c0877a1ebb3607  Bluetooth: hci_qca: get wakeup status from serdev device handle

elapsed time: 1086m

configs tested: 64
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
um                             i386_defconfig
arc                              allyesconfig
um                           x86_64_defconfig
alpha                            allyesconfig
powerpc                           allnoconfig
ia64                             allmodconfig
s390                             allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
sh                               allmodconfig
mips                             allyesconfig
x86_64                        randconfig-a006
powerpc                          allmodconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
riscv                randconfig-r042-20230202
s390                 randconfig-r044-20230202
arc                  randconfig-r043-20230202
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
i386                                defconfig
powerpc                     stx_gp3_defconfig
xtensa                  cadence_csp_defconfig
powerpc                      mgcoge_defconfig
sh                            migor_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
arm                  randconfig-r046-20230202
hexagon              randconfig-r045-20230202
hexagon              randconfig-r041-20230202
x86_64                          rhel-8.3-rust
x86_64                        randconfig-k001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
