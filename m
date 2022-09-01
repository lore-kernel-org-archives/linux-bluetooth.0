Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6BFECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Sep 2022 18:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbiIASZ7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Sep 2022 14:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbiIASZz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Sep 2022 14:25:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A014CA05
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 11:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662056754; x=1693592754;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=lfsA6EawqzF8wRj+yiDcO0l2mipwQx/TgWlUG9qnpGU=;
  b=hKbMbUrIM6vTYc3t/jLlZAwbNc9InsDsUiCcmupVEWC5cz+CPNeLle5w
   cVwa3dqsO4StXl5quR3Yq8qtkcrTzU5vtgQt1xhhzQqVvlXFGUrwgTH5Q
   Cqn/7nUneZd47HBxaEA3xR+whASjox1cZqmukG946IWzi1McgmxjYbFkm
   gLstQXA1NW7P5AUdtXGmNEUqa7DsMopumPT1mIx5XG2ap4r51cgjMZTFe
   e3RajPIbpIRvOXLo73eDEHJijIwGGbpnq2RF+DkomQv/Dpz3i2EqNvvWX
   q1+HmuFvKmE0kArOILJ18d8LqSCcXYH9XfFyE3byrr3ZOZt1xh/Xfef5L
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="278811841"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="278811841"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 11:25:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="940962461"
Received: from lkp-server02.sh.intel.com (HELO b138c9e8658c) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 01 Sep 2022 11:25:51 -0700
Received: from kbuild by b138c9e8658c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTosw-0000d1-1A;
        Thu, 01 Sep 2022 18:25:50 +0000
Date:   Fri, 02 Sep 2022 02:25:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 177978b2942624bb1dd826a892ab4a6a400f5715
Message-ID: <6310f90d.aUrSOvdmoz50T5T/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 177978b2942624bb1dd826a892ab4a6a400f5715  Bluetooth: btusb: mediatek: fix WMT failure during runtime suspend

elapsed time: 1128m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20220831
s390                 randconfig-r044-20220831
riscv                randconfig-r042-20220831
x86_64                              defconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                               rhel-8.3
mips                             allyesconfig
m68k                             allmodconfig
x86_64                        randconfig-a013
m68k                             allyesconfig
x86_64                        randconfig-a011
x86_64                           allyesconfig
sh                               allmodconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a014
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a012
i386                          randconfig-a016
i386                                defconfig
i386                          randconfig-a005
i386                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20220831
hexagon              randconfig-r041-20220831
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a002
x86_64                        randconfig-a005
i386                          randconfig-a015
i386                          randconfig-a004
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
