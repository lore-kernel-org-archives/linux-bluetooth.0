Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B486C46467
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Jan 2023 08:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjAGIt2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 Jan 2023 03:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjAGIt0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 Jan 2023 03:49:26 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538A861457
        for <linux-bluetooth@vger.kernel.org>; Sat,  7 Jan 2023 00:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673081365; x=1704617365;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ZomSABJESjT32Q7Iimj2sUF5BP4HL5mTKL4LigcdD94=;
  b=NdjEDB59r3v0YWY7ZigneunDEEmViBWHJwKcClkRXDsbMSU4CfYoc6r0
   H4MLjRjuspbW3BhSel9KG52CxRQYrrVIj+mzYpeTsVo3jtm+8QPF9F1ua
   T3BvXs3vzRpfLs77nQrTQ8hJf1zmEy9YqcG69qWQVHaMg6CJGyw33f0JU
   rLbefVTnXQtn2alz3tJ6o/yYLQiFgmPMHBbDMXrpxIft5P/G/JfGPXMAs
   MJFwd9HTCqf8EmmtcjYCWlvQr3xNvB6olnc+GGHXXJ3F8M5aJiArfporc
   9e6hf4x6/y1AU6NslAOf3nR5gVz5ZrEFD9Nq5e9WWHQqmRIzaqIVmtcAQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="306142065"
X-IronPort-AV: E=Sophos;i="5.96,308,1665471600"; 
   d="scan'208";a="306142065"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2023 00:49:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="798505012"
X-IronPort-AV: E=Sophos;i="5.96,308,1665471600"; 
   d="scan'208";a="798505012"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jan 2023 00:49:23 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pE4tG-0004R0-22;
        Sat, 07 Jan 2023 08:49:22 +0000
Date:   Sat, 07 Jan 2023 16:49:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 a288d38b19962efac5689dfa3eb9e7e111e39870
Message-ID: <63b93211.wLGVew8FdwWr/qHY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: a288d38b19962efac5689dfa3eb9e7e111e39870  Bluetooth: qca: Fix sparse warnings

elapsed time: 724m

configs tested: 93
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
s390                             allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                            allnoconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
ia64                             allmodconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                             allyesconfig
i386                                defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
sparc64                             defconfig
powerpc                       ppc64_defconfig
sh                            titan_defconfig
ia64                             alldefconfig
powerpc                     mpc83xx_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
powerpc                      ppc40x_defconfig
arc                              alldefconfig
mips                           ci20_defconfig
arm                        cerfcube_defconfig
m68k                        mvme147_defconfig
powerpc                 linkstation_defconfig
arm                        clps711x_defconfig
arm                       imx_v6_v7_defconfig
mips                           xway_defconfig
sh                          rsk7264_defconfig
x86_64                           alldefconfig
i386                          randconfig-c001
sparc                             allnoconfig
arc                     haps_hs_smp_defconfig
sh                           sh2007_defconfig
ia64                      gensparse_defconfig
powerpc                      pasemi_defconfig
arm                            lart_defconfig
mips                         db1xxx_defconfig
powerpc                      ppc6xx_defconfig
mips                         cobalt_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
s390                 randconfig-r044-20230106
hexagon              randconfig-r041-20230106
hexagon              randconfig-r045-20230106
riscv                randconfig-r042-20230106
hexagon              randconfig-r041-20230107
hexagon              randconfig-r045-20230107
arm                  randconfig-r046-20230107
powerpc                 xes_mpc85xx_defconfig
powerpc                          g5_defconfig
arm                          ixp4xx_defconfig
x86_64                        randconfig-k001
x86_64                          rhel-8.3-rust
arm                         palmz72_defconfig
arm                         orion5x_defconfig
arm                           spitz_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
