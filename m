Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39D4C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Dec 2022 09:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiLPJzO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Dec 2022 04:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiLPJzM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Dec 2022 04:55:12 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A001349B41
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Dec 2022 01:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671184511; x=1702720511;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ol/URUyo4y2qsiaQDarSU8upGw97e7hWFzxoU2UmZS0=;
  b=Yl43r38ddIdQWH/Ch3XicBZ4gTAoPWbq9LXlfdYhak3RPJojc6JftrSd
   Nfm/2PimaUF5gDfyxT0pSQ2XccLt0ek3BjsamFPKOUylcP4hvENvJSeXb
   SfixBOh2aLYQNUFN7929tupxmCvk/Krp0TVYspQ/nsVCEIbtgUWG+jS20
   mTDZb5i2ygwG/F4JEuqGvjKOtXq1rJBYuG1ZH1+Wjb2qyzEpeiaTIMcCO
   lIlnV3w4lNH2VakaVKcKyyRjHniV6ixlUlc2+hmYNXoZOT5A8LlwZkya3
   r375SeY3uV0WUU/14Vrd5yFCHwUIIQlgQK8q20DdhblMFmiGkcAOjXxU0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="316571949"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="316571949"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 01:54:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="627516388"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="627516388"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 16 Dec 2022 01:54:27 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p67QA-00074y-2D;
        Fri, 16 Dec 2022 09:54:26 +0000
Date:   Fri, 16 Dec 2022 17:53:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 becee9f3220c20289163cdc0bc8583bd30965f62
Message-ID: <639c4022.P0X9k6pgPES3G1y9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: becee9f3220c20289163cdc0bc8583bd30965f62  Bluetooth: Fix a buffer overflow in mgmt_mesh_add()

elapsed time: 726m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
powerpc                           allnoconfig
s390                                defconfig
s390                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
ia64                             allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arc                  randconfig-r043-20221215
arm                  randconfig-r046-20221215
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a001
i386                          randconfig-a016
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
sh                               allmodconfig
x86_64                           allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                                defconfig
i386                             allyesconfig
x86_64                            allnoconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
hexagon              randconfig-r041-20221215
hexagon              randconfig-r045-20221215
riscv                randconfig-r042-20221215
s390                 randconfig-r044-20221215
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
