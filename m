Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C516AECAAD2
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Aug 2022 12:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiH0M2v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 27 Aug 2022 08:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiH0M2u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 27 Aug 2022 08:28:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC15F40BEF
        for <linux-bluetooth@vger.kernel.org>; Sat, 27 Aug 2022 05:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661603329; x=1693139329;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=xsfaCVPfv//6/B3Mh9Bp2SnbwGvSqHyu8bx8Fvw1PSk=;
  b=ZJs9ICb1Cn7+jvjXKMWo5Uc0D+DmLYVocR6MCVTC+RC3OXamt38ixULl
   RlXfGmMAg5Ar+1w2NBh/cdgGwtTeLE1KD8a3XlYTuFMggfSO8iJivTJIw
   SInk6UC4BT8//0cwblYwsG2M2y46oR9UeQ5b/sgp400JIgfusg5o2EbR/
   PMjdxZBaTK540fDgN6C5M1eQC2qGorVotmokMbezC7ABRXVcZn2RKjkRC
   cHgkrvcEC97IrKcP9Pv+jUUqUqntnDBbWOFpBfzC1CXc4z4fy+WQfZ/hm
   I30/7+q6Ih17iJMfHQKDnuZ5KmhRk7QHaxPuTF84l0vp2dXzaHkehwrCg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="320773227"
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="320773227"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 05:28:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="640382947"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 27 Aug 2022 05:28:48 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRuvf-0000AA-20;
        Sat, 27 Aug 2022 12:28:47 +0000
Date:   Sat, 27 Aug 2022 20:28:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 b828854871f6851c75a5b19f1cd967bf4e7c85dd
Message-ID: <630a0de4.P90mVOZvIQqORlrY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: b828854871f6851c75a5b19f1cd967bf4e7c85dd  Bluetooth: hci_sync: hold hdev->lock when cleanup hci_conn

elapsed time: 725m

configs tested: 77
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
arc                                 defconfig
um                             i386_defconfig
alpha                               defconfig
powerpc                           allnoconfig
loongarch                         allnoconfig
loongarch                           defconfig
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
powerpc                          allmodconfig
alpha                            allyesconfig
s390                                defconfig
i386                                defconfig
arc                  randconfig-r043-20220827
s390                             allmodconfig
x86_64                        randconfig-a004
mips                             allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a006
s390                             allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arm                                 defconfig
x86_64                        randconfig-a015
i386                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
parisc                           allyesconfig
parisc64                            defconfig
parisc                              defconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
arm                              allyesconfig
arm64                            allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
riscv                             allnoconfig
riscv                    nommu_virt_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
i386                         debian-10.3-func
i386                        debian-10.3-kunit
i386                          debian-10.3-kvm
x86_64                           allyesconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20220827
hexagon              randconfig-r045-20220827
s390                 randconfig-r044-20220827
x86_64                        randconfig-a005
riscv                randconfig-r042-20220827
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
