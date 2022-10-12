Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BB6C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Oct 2022 09:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJLJlQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiJLJlN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Oct 2022 05:41:13 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D237A8CC2
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Oct 2022 02:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665567671; x=1697103671;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=51kGHtZJ4tAHz3R1Tv1qrwkjN1Itj+NZvGhHu+GSxfE=;
  b=ZfKY6x1jHNeNGve4ZPMlMaZJXc+xVfSPhrjLAiDfixiJN7dHfsqLZJjQ
   XxyrVefxVm2LzARqAkAqcn2uUZ4jO5SWALkcpc5CTU1QIQp/IvOMZfPIO
   TdwWvDvdtnreJiF4skyMu2xjtjd/K4At/8+mHDdEUxMzyE9WS06Vw2o60
   aD3IRQDn0E80XThou/y/yj+JFOvVs+5weN7mojDxYvbha5ALV+oZNyhrQ
   en9qvHuHlLQzr+jiNtWaYtuXdKo2fBAlB2MUz5uV9Rij4I/E1debpb3VF
   J6un5c1CaMbX8R/tG6D9duX3RVDFwSd4pLG5j4DcgqYuh6zq2gJ5LsFjt
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="305808029"
X-IronPort-AV: E=Sophos;i="5.95,178,1661842800"; 
   d="scan'208";a="305808029"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 02:41:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="604490930"
X-IronPort-AV: E=Sophos;i="5.95,178,1661842800"; 
   d="scan'208";a="604490930"
Received: from lkp-server01.sh.intel.com (HELO 2af0a69ca4e0) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 12 Oct 2022 02:41:09 -0700
Received: from kbuild by 2af0a69ca4e0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oiYEf-0003gG-0z;
        Wed, 12 Oct 2022 09:41:09 +0000
Date:   Wed, 12 Oct 2022 17:40:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 4d12cd187c821f7cb0bccc7cdf84570004d528a8
Message-ID: <63468b83.eoXO70zMOdeHA0vS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 4d12cd187c821f7cb0bccc7cdf84570004d528a8  Bluetooth: hci_conn: use HCI dst_type values also for BIS

elapsed time: 724m

configs tested: 73
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
s390                             allyesconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
um                           x86_64_defconfig
um                             i386_defconfig
powerpc                          allmodconfig
arc                  randconfig-r043-20221010
mips                             allyesconfig
s390                 randconfig-r044-20221010
powerpc                           allnoconfig
x86_64                              defconfig
riscv                randconfig-r042-20221010
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
sh                               allmodconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20221012
s390                 randconfig-r044-20221012
riscv                randconfig-r042-20221012
x86_64                        randconfig-a015
i386                          randconfig-a001
alpha                            allyesconfig
i386                          randconfig-a003
i386                          randconfig-a005
m68k                             allmodconfig
arc                              allyesconfig
x86_64                        randconfig-a002
m68k                             allyesconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a006
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
arm                                 defconfig
sparc64                             defconfig
powerpc                     stx_gp3_defconfig
arc                            hsdk_defconfig
ia64                            zx1_defconfig
m68k                       m5208evb_defconfig
powerpc                     taishan_defconfig
powerpc                     sequoia_defconfig
sh                   rts7751r2dplus_defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                        keystone_defconfig
powerpc                     tqm8548_defconfig
powerpc                 mpc834x_mds_defconfig
mips                       bmips_be_defconfig

clang tested configs:
hexagon              randconfig-r045-20221010
hexagon              randconfig-r041-20221010
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a015
x86_64                        randconfig-a014
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
