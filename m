Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7979DC54EBE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Jan 2023 12:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238112AbjAJMiY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Jan 2023 07:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238438AbjAJMha (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Jan 2023 07:37:30 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9909BDF99
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jan 2023 04:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673354241; x=1704890241;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=a/wrkIMUgdu1vzckIbvpelpLNhr+3HX5TPQLK4CscAg=;
  b=b3JCTN2Hr+vlUKwfJAeuyJEyT5Lm5sIFy08CxMOG05u2EFdaRNCvuUT1
   u8niJNil9V5D5n3q5yn3J8YLXkEXtgLNPXhJfFUenFI9SU+vlg0nMx3R3
   0mO9H+YgGCIxhpOWd4ZAumMwxhnN8Tu2aBkGRua/cFnINp2viXTTO6oDj
   nkuh10wrfJtaGGBFVRoYsCq1wxtcm7/6TbSCvfovU+LmOWGSyANa5rLoA
   w6rp9SFQZpGkkWtU3+8ONJ/Otei5WgAZ6fvRD1rzVOQYm2JVNhKIoBTdZ
   DN5pbCe52rZYiUh2gDGAxFKHNEPjKmp307Mir+HZb3G5q17JR3ZJZLuqv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="321834252"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="321834252"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 04:37:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="745760756"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="745760756"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jan 2023 04:37:10 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pFDsL-0007y1-0z;
        Tue, 10 Jan 2023 12:37:09 +0000
Date:   Tue, 10 Jan 2023 20:37:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 e8b5fd71713bb440fbe0ddac0c1e48c6326fddd4
Message-ID: <63bd5bf2.uLvunQwwnu0zd7rt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: e8b5fd71713bb440fbe0ddac0c1e48c6326fddd4  Bluetooth: hci_sync: fix memory leak in hci_update_adv_data()

elapsed time: 720m

configs tested: 120
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
um                             i386_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                 randconfig-a014-20230109
arm                                 defconfig
x86_64                              defconfig
i386                 randconfig-a011-20230109
ia64                             allmodconfig
i386                 randconfig-a016-20230109
i386                                defconfig
m68k                             allyesconfig
x86_64                               rhel-8.3
i386                 randconfig-a015-20230109
arm                              allyesconfig
i386                 randconfig-a013-20230109
m68k                             allmodconfig
x86_64               randconfig-a011-20230109
x86_64                           allyesconfig
arc                              allyesconfig
x86_64               randconfig-a016-20230109
i386                 randconfig-a012-20230109
x86_64                        randconfig-a004
arm64                            allyesconfig
x86_64               randconfig-a013-20230109
x86_64                    rhel-8.3-kselftests
alpha                            allyesconfig
x86_64               randconfig-a015-20230109
x86_64               randconfig-a012-20230109
x86_64                          rhel-8.3-func
x86_64                        randconfig-a002
x86_64               randconfig-a014-20230109
x86_64                        randconfig-a006
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
i386                             allyesconfig
mips                           jazz_defconfig
sparc64                          alldefconfig
arc                         haps_hs_defconfig
arc                  randconfig-r043-20230108
arm                  randconfig-r046-20230108
arm                             pxa_defconfig
powerpc                         ps3_defconfig
sh                          polaris_defconfig
powerpc                 canyonlands_defconfig
m68k                           sun3_defconfig
powerpc                      ppc6xx_defconfig
x86_64                           alldefconfig
powerpc                 mpc834x_mds_defconfig
m68k                        stmark2_defconfig
arm                             rpc_defconfig
arm                           corgi_defconfig
xtensa                    xip_kc705_defconfig
powerpc                     asp8347_defconfig
parisc                generic-32bit_defconfig
sh                     sh7710voipgw_defconfig
mips                            gpr_defconfig
i386                          randconfig-c001
m68k                        m5407c3_defconfig
xtensa                           allyesconfig
ia64                         bigsur_defconfig
m68k                        mvme147_defconfig
sh                           se7712_defconfig
riscv                randconfig-r042-20230110
s390                 randconfig-r044-20230109
arc                  randconfig-r043-20230109
s390                 randconfig-r044-20230110
riscv                randconfig-r042-20230109
arc                  randconfig-r043-20230110
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
powerpc                    amigaone_defconfig
arm                            hisi_defconfig
arm                            pleb_defconfig
sh                      rts7751r2d1_defconfig
arc                           tb10x_defconfig
arm                       multi_v4t_defconfig
arc                    vdk_hs38_smp_defconfig
arm                        trizeps4_defconfig
arm                         s3c6400_defconfig
sh                               alldefconfig

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a001
i386                 randconfig-a001-20230109
x86_64                        randconfig-a003
i386                 randconfig-a004-20230109
x86_64                        randconfig-a005
i386                 randconfig-a002-20230109
i386                 randconfig-a003-20230109
i386                 randconfig-a006-20230109
i386                 randconfig-a005-20230109
x86_64               randconfig-a001-20230109
x86_64               randconfig-a002-20230109
x86_64               randconfig-a004-20230109
x86_64               randconfig-a003-20230109
x86_64               randconfig-a006-20230109
x86_64               randconfig-a005-20230109
x86_64                        randconfig-k001
arm                        multi_v5_defconfig
arm                          ep93xx_defconfig
powerpc                     ksi8560_defconfig
arm                          pcm027_defconfig
powerpc                       ebony_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
