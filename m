Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF77C00140
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Aug 2022 10:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiHJKrt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Aug 2022 06:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiHJKrs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Aug 2022 06:47:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CE585FAF
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Aug 2022 03:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660128467; x=1691664467;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FrkMl6dxfBOhsf5p2h+/+gctv1+/AjhzSvl0nM+74iQ=;
  b=k+mQurqrahZeBtHQCkBim6qlzYrDeSc+XMR+pLltPIFyfGmOsIafa+rX
   cbCtW8q6J/Zk97qU1oQy2n7d9E0Wj6ghu/ZDxD8B6/nNgDwJwPKnBwzBn
   v9RxYUgACCNLybu+8/2zE3H3WR5VfIzLqIpTO/p+3mxKqBBaqW/cotj35
   YfgeiA7T0kfNw+VM94rX6r3fgcXqQwZNZcfvFikEaa46kOdBpllujUUut
   ZGbr5LeHpCsBYY4eILbyYWSGpu3W6RvO4mlHkItVYKy5eFiCWidEMmNcl
   O5dzHv9bi083cGAcb6UJWmqQz+qPupxZpGbUgDV/h9aHnXurSNGECIpV5
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="355054384"
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="355054384"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 03:47:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="555691270"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 10 Aug 2022 03:47:46 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLjFZ-00009X-2H;
        Wed, 10 Aug 2022 10:47:45 +0000
Date:   Wed, 10 Aug 2022 18:47:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 9ec46ac996f59425f950051df6e2e30ef963190b
Message-ID: <62f38cc9.YrRJlv9ef5KF8I8L%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 9ec46ac996f59425f950051df6e2e30ef963190b  Bluetooth: convert hci_update_adv_data to hci_sync

elapsed time: 694m

configs tested: 90
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a013
m68k                             allmodconfig
arc                              allyesconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a015
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                        randconfig-a002
arc                  randconfig-r043-20220810
s390                 randconfig-r044-20220810
x86_64                        randconfig-a006
i386                          randconfig-a014
riscv                randconfig-r042-20220810
powerpc                          allmodconfig
x86_64                        randconfig-a004
i386                          randconfig-a012
x86_64                          rhel-8.3-func
mips                             allyesconfig
i386                          randconfig-a016
powerpc                           allnoconfig
x86_64                         rhel-8.3-kunit
sh                               allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
ia64                             allmodconfig
arm                                 defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
loongarch                           defconfig
loongarch                         allnoconfig
m68k                        m5407c3_defconfig
sh                ecovec24-romimage_defconfig
sh                          polaris_defconfig
arm                          badge4_defconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                          randconfig-c001
sparc                             allnoconfig
arm                          pxa3xx_defconfig
sh                        sh7785lcr_defconfig
sh                          r7780mp_defconfig
sh                                  defconfig
powerpc                 mpc8540_ads_defconfig
mips                  maltasmvp_eva_defconfig
sparc                       sparc32_defconfig
sh                           se7722_defconfig
arc                     haps_hs_smp_defconfig
openrisc                       virt_defconfig
xtensa                generic_kc705_defconfig
sh                             sh03_defconfig
powerpc                     tqm8541_defconfig
arm                        mvebu_v7_defconfig
arm                        spear6xx_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
m68k                            q40_defconfig
mips                      loongson3_defconfig
mips                     decstation_defconfig
sparc64                             defconfig
sh                              ul2_defconfig
sparc                       sparc64_defconfig
arm64                            alldefconfig
m68k                        stmark2_defconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
hexagon              randconfig-r041-20220810
i386                          randconfig-a015
x86_64                        randconfig-a001
hexagon              randconfig-r045-20220810
x86_64                        randconfig-a003
i386                          randconfig-a011
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-k001
hexagon                          alldefconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
