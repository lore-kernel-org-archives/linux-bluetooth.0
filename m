Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01924C433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Apr 2021 20:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0C29613F0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Apr 2021 20:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbhD2UVo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Apr 2021 16:21:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:5624 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229674AbhD2UVn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Apr 2021 16:21:43 -0400
IronPort-SDR: 457FKsHAEe4Neka8o2CVqkR0konurgdLWxUf/4IjOqvLOku9u+FAW8r+Z9oCdgcTC6Yd8CruSw
 kz+SI354OxMg==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="176591818"
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="176591818"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 13:20:56 -0700
IronPort-SDR: aH8SwzhqL0Cnu/eXW9EMKFc+VHtREz2YpejUhiFail+8wj+UVyyGsuy+0DGQfVEZ4ByvZysWiW
 SzWO0MUibT6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="527121090"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 29 Apr 2021 13:20:55 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lcD9a-0007mi-GJ; Thu, 29 Apr 2021 20:20:54 +0000
Date:   Fri, 30 Apr 2021 04:20:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 8faca89c34eb1af9dba5069bddd144e95d6b96d3
Message-ID: <608b14f4.hJEy7J7NVghr1d11%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 8faca89c34eb1af9dba5069bddd144e95d6b96d3  Bluetooth: Fix the HCI to MGMT status conversion table

elapsed time: 720m

configs tested: 118
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
riscv                            allyesconfig
arm                        clps711x_defconfig
openrisc                  or1klitex_defconfig
sh                   sh7770_generic_defconfig
powerpc                        warp_defconfig
sh                         ecovec24_defconfig
powerpc                     kilauea_defconfig
xtensa                         virt_defconfig
arm                           corgi_defconfig
nios2                            allyesconfig
m68k                          sun3x_defconfig
arm                          moxart_defconfig
arm                     eseries_pxa_defconfig
arm                       aspeed_g5_defconfig
mips                       capcella_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                           xway_defconfig
powerpc                     sbc8548_defconfig
arm                     am200epdkit_defconfig
sh                           se7721_defconfig
parisc                              defconfig
powerpc                   lite5200b_defconfig
powerpc                      ppc64e_defconfig
arm                     davinci_all_defconfig
xtensa                       common_defconfig
m68k                        m5272c3_defconfig
mips                      maltasmvp_defconfig
powerpc                     tqm5200_defconfig
x86_64                              defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                 linkstation_defconfig
arm                        spear6xx_defconfig
sh                          sdk7780_defconfig
powerpc                      ppc40x_defconfig
arm                        trizeps4_defconfig
mips                         db1xxx_defconfig
arm                             rpc_defconfig
riscv                    nommu_virt_defconfig
xtensa                  audio_kc705_defconfig
xtensa                          iss_defconfig
riscv                             allnoconfig
s390                       zfcpdump_defconfig
sh                          landisk_defconfig
powerpc                 mpc8560_ads_defconfig
mips                      bmips_stb_defconfig
sparc64                             defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210429
x86_64               randconfig-a002-20210429
x86_64               randconfig-a005-20210429
x86_64               randconfig-a006-20210429
x86_64               randconfig-a001-20210429
x86_64               randconfig-a003-20210429
i386                 randconfig-a005-20210429
i386                 randconfig-a002-20210429
i386                 randconfig-a001-20210429
i386                 randconfig-a006-20210429
i386                 randconfig-a003-20210429
i386                 randconfig-a004-20210429
i386                 randconfig-a012-20210429
i386                 randconfig-a014-20210429
i386                 randconfig-a013-20210429
i386                 randconfig-a011-20210429
i386                 randconfig-a015-20210429
i386                 randconfig-a016-20210429
riscv                    nommu_k210_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210429
x86_64               randconfig-a016-20210429
x86_64               randconfig-a011-20210429
x86_64               randconfig-a014-20210429
x86_64               randconfig-a013-20210429
x86_64               randconfig-a012-20210429

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
