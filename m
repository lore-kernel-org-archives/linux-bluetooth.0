Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC57C19F2A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jul 2022 23:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiG1XqA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Jul 2022 19:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiG1Xp7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Jul 2022 19:45:59 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94B83B94A
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Jul 2022 16:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659051958; x=1690587958;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=AYza/zZ4j/VeW2yt0uhecbwRqt0+82wHKlHVTkb/BWc=;
  b=KH09+sSWt+JGvmhiBn7CvhkVDOKb8HusXVSE2XUiI/PGcSy5wDseQQLT
   EPYrxB1VWK4FTP0JmIbGlgbzU0F9bNTYGF/YseW2PC4N6eh+w4fLnZqGE
   cQtvY1WdvKnZKh43+beDYl27KFhVLQ3iRXao9FfhALj9UbPGioffA6EEv
   qbGl6rwjov/CC1rHYeVBQYd9DqHDlxEsXCBgzNoPVeq88XshMdh34xIp7
   yRWe+jrFcyEPR38Vk27XbBVLKPdZGXvByg9SKGo7sJy21fUZdJqnk2m10
   o86ySni4Lt2BqjvbzavDMEoHASr6nU7ah+UA8cr/zvW+XWcLPb7Me09T7
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="268416654"
X-IronPort-AV: E=Sophos;i="5.93,199,1654585200"; 
   d="scan'208";a="268416654"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 16:45:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,199,1654585200"; 
   d="scan'208";a="669079328"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jul 2022 16:45:56 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHDCW-000Aiv-0v;
        Thu, 28 Jul 2022 23:45:56 +0000
Date:   Fri, 29 Jul 2022 07:45:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 13474ba176c9649479db7cd2cef2210a4c9f3bbc
Message-ID: <62e31f7e.eTneXAdrFc++cqQ3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 13474ba176c9649479db7cd2cef2210a4c9f3bbc  Bluetooth: ISO: unlock on error path in iso_sock_setsockopt()

elapsed time: 1619m

configs tested: 100
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                                defconfig
i386                             allyesconfig
arc                  randconfig-r043-20220727
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
sh                               allmodconfig
powerpc                          allmodconfig
mips                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
loongarch                           defconfig
loongarch                         allnoconfig
arc                           tb10x_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                       m5475evb_defconfig
powerpc                      pasemi_defconfig
i386                          randconfig-c001
s390                       zfcpdump_defconfig
openrisc                         alldefconfig
ia64                        generic_defconfig
sh                           se7343_defconfig
arm                            mps2_defconfig
openrisc                    or1ksim_defconfig
xtensa                  cadence_csp_defconfig
mips                           ip32_defconfig
arc                            hsdk_defconfig
sh                 kfr2r09-romimage_defconfig
sh                     sh7710voipgw_defconfig
m68k                        m5407c3_defconfig
powerpc                     taishan_defconfig
sh                         ap325rxa_defconfig
powerpc                      tqm8xx_defconfig
arm                          lpd270_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
hexagon              randconfig-r045-20220727
hexagon              randconfig-r041-20220727
s390                 randconfig-r044-20220727
riscv                randconfig-r042-20220727
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
mips                malta_qemu_32r6_defconfig
powerpc                    gamecube_defconfig
arm                          collie_defconfig
arm                       imx_v4_v5_defconfig
arm                       versatile_defconfig
powerpc                      obs600_defconfig
x86_64                        randconfig-k001
arm                     davinci_all_defconfig
powerpc                 mpc836x_mds_defconfig
riscv                             allnoconfig
hexagon              randconfig-r041-20220728
hexagon              randconfig-r045-20220728
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
powerpc                     tqm5200_defconfig
powerpc                        fsp2_defconfig
powerpc                      katmai_defconfig
powerpc                   microwatt_defconfig
powerpc                      ppc64e_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
