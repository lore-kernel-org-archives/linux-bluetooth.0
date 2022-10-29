Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BF2C38A02
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Oct 2022 11:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiJ2L4e (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Oct 2022 07:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJ2L4c (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Oct 2022 07:56:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197813ECEE
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Oct 2022 04:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667044592; x=1698580592;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=WhHiPzCtt6tQJMQzGOerSE2lvyY9QFKpLGy1/crLnR8=;
  b=VrPCJnMLhYagjtCWUURj3rb+727NycTWqKw1FJABcU15lrwFtbW//Rdm
   zFbvta+ESSj6bqilT0oZuYM0P87+lDVbScro9LkZfdjw2vVXOA8C957Pm
   uifJAV+Pz+Bsi2CxL+aOlP7vWGtXLry/MG65KowVnq4sUklp4vgkJib1C
   UuaCT0tjnZ7B3iqmoFPWyg6RRROpGlDCw7ZMPVpSwyHeEV7xiHrqZbxhI
   ddIl2Q9gDZ4b5L594pcJE6XstHGj/uKr9twTpBLs5dgFjQ4eo0yu1pa8u
   mCG+rulb4xtuFEOMt72m/BE96VqH9ZNLiEsRqcKvQI+hxvURvr/7JA6AA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="308659529"
X-IronPort-AV: E=Sophos;i="5.95,223,1661842800"; 
   d="scan'208";a="308659529"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 04:56:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="962306693"
X-IronPort-AV: E=Sophos;i="5.95,223,1661842800"; 
   d="scan'208";a="962306693"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 29 Oct 2022 04:56:30 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ookRy-000Azr-0d;
        Sat, 29 Oct 2022 11:56:30 +0000
Date:   Sat, 29 Oct 2022 19:56:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 98f18bb78b7def72f9c4038ba3944cd53f2009c9
Message-ID: <635d14d1.jB10aPUu1UOqwgyH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 98f18bb78b7def72f9c4038ba3944cd53f2009c9  Bluetooth: Add CONFIG_BT_LE_L2CAP_ECRED

elapsed time: 721m

configs tested: 74
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
x86_64                           rhel-8.3-kvm
i386                                defconfig
alpha                               defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
s390                             allmodconfig
alpha                            allyesconfig
s390                                defconfig
i386                          randconfig-a012
arc                              allyesconfig
i386                          randconfig-a016
i386                          randconfig-a001
m68k                             allyesconfig
i386                          randconfig-a003
m68k                             allmodconfig
i386                          randconfig-a014
mips                             allyesconfig
s390                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                              defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
ia64                             allmodconfig
x86_64                    rhel-8.3-kselftests
sh                               allmodconfig
x86_64                        randconfig-a002
i386                          randconfig-a005
x86_64                           allyesconfig
x86_64                        randconfig-a015
arm                                 defconfig
i386                             allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
arc                  randconfig-r043-20221029
arm                              allyesconfig
arm64                            allyesconfig
arc                  randconfig-r043-20221028
s390                 randconfig-r044-20221028
riscv                randconfig-r042-20221028
arm                            hisi_defconfig
xtensa                  cadence_csp_defconfig
m68k                           virt_defconfig
powerpc                       holly_defconfig
arm                          pxa3xx_defconfig
sh                        dreamcast_defconfig
powerpc                      ep88xc_defconfig
powerpc                       ppc64_defconfig
powerpc                      makalu_defconfig
arm                           u8500_defconfig
arm                         lpc18xx_defconfig
arm                      jornada720_defconfig
i386                          randconfig-c001

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a012
i386                          randconfig-a006
x86_64                        randconfig-a005
x86_64                        randconfig-a014
x86_64                        randconfig-a001
x86_64                        randconfig-a016
x86_64                        randconfig-a003
hexagon              randconfig-r041-20221029
riscv                randconfig-r042-20221029
hexagon              randconfig-r045-20221029
s390                 randconfig-r044-20221029

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
