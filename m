Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F675C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jun 2022 07:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351776AbiFVHvq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jun 2022 03:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350126AbiFVHvl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jun 2022 03:51:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36761150
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 00:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655884300; x=1687420300;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=e2syKXDtdhHzZq0jk82oQln9zKq/BcWeQDZ5bs7oYcw=;
  b=Ssc63UG5jD/riPJ92sRxklflEi5hMf19Xgi04KtEICG7u2gealICpKfq
   CouJtdKFldyBQ9KW8hp3Cyun5zlTSQ35y8jAlAjTy2xUD6O9R8uHvucKg
   NTtslao0Y07tBKOpcQTvgdkIItwgWSHkg1F5zNACEHxkjYcfCt/5vAFib
   ksn72Ci2Z9Kmzcv7UTMe0hM37tyCHN4qJycDwwlvIVUMvSo9+5Z8oJXzM
   iTqEnwI2WSYo9BB6bvkX9vsFvQiEhBhp/x2iMuba5kvnCLqKqbe5lJdWo
   CV5YYi0oxH8miBMwOMOVYzAL5RmuyOGAtZ/3iEIrc4cKK5amuccYN+40N
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="344336626"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="344336626"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 00:51:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="538362319"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 22 Jun 2022 00:51:39 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3v9G-000114-0j;
        Wed, 22 Jun 2022 07:51:38 +0000
Date:   Wed, 22 Jun 2022 15:51:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 d9cc9d78ca85210132c7a7cbe75975db16464390
Message-ID: <62b2c9ff.hcWou28kl7qhjZWo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: d9cc9d78ca85210132c7a7cbe75975db16464390  Bluetooth: mgmt: Fix refresh cached connection info

elapsed time: 724m

configs tested: 98
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
sh                           se7780_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                     mpc83xx_defconfig
sh                          urquell_defconfig
sparc                       sparc64_defconfig
m68k                          multi_defconfig
alpha                            alldefconfig
mips                       bmips_be_defconfig
powerpc                      mgcoge_defconfig
arm                        shmobile_defconfig
arc                          axs103_defconfig
arm                           stm32_defconfig
ia64                             alldefconfig
sh                                  defconfig
ia64                      gensparse_defconfig
mips                           ci20_defconfig
xtensa                  nommu_kc705_defconfig
sh                           se7724_defconfig
arm                        realview_defconfig
powerpc                     redwood_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                         wii_defconfig
sh                          sdk7786_defconfig
arm                         axm55xx_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                   sh7770_generic_defconfig
powerpc                      ppc6xx_defconfig
mips                            ar7_defconfig
arm                      integrator_defconfig
um                             i386_defconfig
arm                         vf610m4_defconfig
powerpc                      pasemi_defconfig
m68k                            q40_defconfig
sh                          kfr2r09_defconfig
riscv                               defconfig
arm                         lubbock_defconfig
m68k                        mvme147_defconfig
sh                          rsk7201_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220622
riscv                             allnoconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220622
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
s390                             alldefconfig
mips                        qi_lb60_defconfig
mips                      maltaaprp_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r041-20220622
s390                 randconfig-r044-20220622
hexagon              randconfig-r045-20220622
riscv                randconfig-r042-20220622

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
