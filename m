Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85895C19F2A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Aug 2022 12:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbiHDMfW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Aug 2022 08:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiHDMfV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Aug 2022 08:35:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A58C2643
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Aug 2022 05:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659616520; x=1691152520;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=q9kPrQMRg3PZ1x7cni8JbTMboW6UOm54vPQyYOlRXUQ=;
  b=AkiNtTX8g59t+aDDeY1OrIgQUQy6lfvca1A1Lp3f59R0cQGoSyzhhoeM
   sv4OemG83WxJo/Wo3sSoW6LTji9D8MgjcA2POJzDs7u/mJyQay9KwhSFU
   WILSqnGoe9lb6YSFeGaAAjysvJdFa+aGEeNrGtRRnRCWKgcu4d3HILtEU
   oMK1QaNXSuyZFc1yUEI3lCs3InPe48g4suAA5sCzzIZE7KRkD4zcLDSpM
   mIZYe/3DHhEEIHSyyRX2Oow1J0YXHnbFm25BqkAIW4WjZJ7DApTSx+WVY
   qDh2JPGg0O77VUQOTfkN1v0BzZC//8d1Wo0aJZf1WN81RLPzUtcZobaDN
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="289931895"
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="289931895"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 05:35:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="579058437"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 04 Aug 2022 05:35:18 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJa4M-000IQ3-0G;
        Thu, 04 Aug 2022 12:35:18 +0000
Date:   Thu, 04 Aug 2022 20:34:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 8a3fd9bb4fac67ad5d44d6540c7ac20004767076
Message-ID: <62ebbcf2.UjKrrI/MN/YC+n21%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 8a3fd9bb4fac67ad5d44d6540c7ac20004767076  Bluetooth: ISO: Fix iso_sock_getsockopt for BT_DEFER_SETUP

elapsed time: 703m

configs tested: 51
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
arm                                 defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
arm                              allyesconfig
x86_64                        randconfig-a002
i386                          randconfig-a001
alpha                            allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a013
i386                          randconfig-a003
x86_64                        randconfig-a011
arm64                            allyesconfig
i386                          randconfig-a005
sh                               allmodconfig
arc                  randconfig-r043-20220804
x86_64                        randconfig-a006
mips                             allyesconfig
x86_64                        randconfig-a004
powerpc                           allnoconfig
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a012
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a016
ia64                             allmodconfig
x86_64                           allyesconfig

clang tested configs:
hexagon              randconfig-r045-20220804
i386                          randconfig-a002
hexagon              randconfig-r041-20220804
x86_64                        randconfig-a001
riscv                randconfig-r042-20220804
x86_64                        randconfig-a003
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a005
s390                 randconfig-r044-20220804
i386                          randconfig-a006
i386                          randconfig-a004
i386                          randconfig-a015
x86_64                        randconfig-a016
x86_64                        randconfig-a014

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
