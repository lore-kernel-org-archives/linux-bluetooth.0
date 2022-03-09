Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4669C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Mar 2022 03:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbiCID3t (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Mar 2022 22:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiCID3s (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Mar 2022 22:29:48 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8ABA606F8
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Mar 2022 19:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646796530; x=1678332530;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=GpRvZsG9KBpH/hlW4Dv0Z5Aopo1IdbpjFSNXDlLpdqY=;
  b=b2dcBEES0qMJX6DP1Gaz+sNgMH2mmcIifPUp1cjuTKtqpPZzxY1m7X7L
   S6CLL3QnOUb5+cA5UIsvmtVuZqyCDob30r0R54Ht4imeabSs0DE6Kenv5
   xxnzMPXfqP4itcEVWmCPbbbdMd598TZW5KJ0D4E7suvImVOZlCmHZ6UFf
   Viox/DpDZpAvdU39cTJP0NxOwk6C9NX8s1gQvQXqnS3H5mH/GX1ik1uim
   AYgI1CcASDjulJ0Thz20IcxeDLnBbgnzPg9BA4KqdQj/c5cxFHQ1HDkQO
   zdMNrSPwyPPL2P2i+kZKoIroXBeyMgt8W4ZmMZRu/XTLfX/Ri4qFDtRKL
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="253705123"
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="253705123"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 19:28:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="537837781"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 08 Mar 2022 19:28:49 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRn0K-0002Uf-M1; Wed, 09 Mar 2022 03:28:48 +0000
Date:   Wed, 09 Mar 2022 11:27:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 035e54ae7b1d2801b260c4986cd2e612b009f784
Message-ID: <62281eb7.0534vW94MFOnXPKG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 035e54ae7b1d2801b260c4986cd2e612b009f784  Bluetooth: mgmt: remove redundant assignment to variable cur_len

elapsed time: 1826m

configs tested: 123
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
alpha                            alldefconfig
arm                      footbridge_defconfig
m68k                           sun3_defconfig
sh                          landisk_defconfig
sh                          urquell_defconfig
mips                           ip32_defconfig
arm                         lubbock_defconfig
sh                        dreamcast_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                      tqm8xx_defconfig
mips                      fuloong2e_defconfig
m68k                          atari_defconfig
mips                    maltaup_xpa_defconfig
openrisc                 simple_smp_defconfig
sh                        edosk7705_defconfig
arm                        mini2440_defconfig
arc                        vdk_hs38_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                      arches_defconfig
powerpc                 mpc834x_itx_defconfig
m68k                       m5249evb_defconfig
arm                            hisi_defconfig
riscv                               defconfig
arm                          pxa3xx_defconfig
powerpc                      bamboo_defconfig
sh                        apsh4ad0a_defconfig
powerpc                      makalu_defconfig
arm                  randconfig-c002-20220308
arm                  randconfig-c002-20220307
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20220307
x86_64               randconfig-a001-20220307
x86_64               randconfig-a002-20220307
x86_64               randconfig-a006-20220307
x86_64               randconfig-a004-20220307
x86_64               randconfig-a005-20220307
i386                 randconfig-a005-20220307
i386                 randconfig-a004-20220307
i386                 randconfig-a003-20220307
i386                 randconfig-a006-20220307
i386                 randconfig-a002-20220307
i386                 randconfig-a001-20220307
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
riscv                randconfig-r042-20220308
arc                  randconfig-r043-20220307
arc                  randconfig-r043-20220308
s390                 randconfig-r044-20220308
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
riscv                randconfig-c006-20220308
powerpc              randconfig-c003-20220308
i386                          randconfig-c001
arm                  randconfig-c002-20220308
mips                 randconfig-c004-20220308
s390                 randconfig-c005-20220308
mips                           mtx1_defconfig
arm                            dove_defconfig
powerpc                     ksi8560_defconfig
arm                         orion5x_defconfig
powerpc                 mpc8313_rdb_defconfig
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r041-20220307
riscv                randconfig-r042-20220307
s390                 randconfig-r044-20220307
hexagon              randconfig-r045-20220308
hexagon              randconfig-r041-20220308
hexagon              randconfig-r045-20220307

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
