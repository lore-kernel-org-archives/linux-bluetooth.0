Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4FCC54EE9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Sep 2022 09:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiIPJvu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Sep 2022 05:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiIPJvt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Sep 2022 05:51:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B79BCAD
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Sep 2022 02:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663321908; x=1694857908;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dkAV4CLaMwHSZvjMABZIi3qBIKWwff4CD2ir2FwebsE=;
  b=RsxYyVo5+cSZ3X9aCFisZPmELP+Nd6GntNDcwAC0uZNuN1hIOrTdHwDz
   pZBqt/1RPtAvNMA3PPj2YQHYIjRQPsI+fzvF4+ZSt7ls2/QEzcpfLTnsR
   ZXp5Bjnmj5zom6JVUAxyFViOB4i+ri13qBPMziz3EulGEHW5JO8VGEdmz
   x/lnEa5ZLuTG1HXhlHoSs1AkVhArp96fakt3wtr3dOFYl/7jGm2HTziun
   hocEHAnzyIphE9WoVaSa3HeelcYVnzOpZEEYq1Wszhzg+J6/iK7STukBa
   d6IV4KNdXP+zcL2rYOlrk5nwi3o6Qx+rjF0AQ6+RI92DRyMYGVGwdn045
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="279337444"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="279337444"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 02:51:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="568776410"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 16 Sep 2022 02:51:46 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZ80g-0001fO-0T;
        Fri, 16 Sep 2022 09:51:46 +0000
Date:   Fri, 16 Sep 2022 17:51:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 812e92b824c1db16c9519f8624d48a9901a0d38f
Message-ID: <6324470a.dRETZVm2dA2Vr76r%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 812e92b824c1db16c9519f8624d48a9901a0d38f  Bluetooth: RFCOMM: Fix possible deadlock on socket shutdown/release

elapsed time: 720m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
arc                  randconfig-r043-20220915
alpha                               defconfig
m68k                             allyesconfig
x86_64                              defconfig
m68k                             allmodconfig
riscv                randconfig-r042-20220915
arc                              allyesconfig
s390                 randconfig-r044-20220915
alpha                            allyesconfig
i386                                defconfig
x86_64                               rhel-8.3
s390                             allmodconfig
x86_64                        randconfig-a002
x86_64                           allyesconfig
s390                                defconfig
powerpc                           allnoconfig
i386                          randconfig-a001
x86_64                        randconfig-a013
i386                          randconfig-a003
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a011
i386                          randconfig-a005
i386                          randconfig-a014
x86_64                          rhel-8.3-func
x86_64                        randconfig-a015
x86_64                        randconfig-a004
x86_64                         rhel-8.3-kunit
arm                                 defconfig
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a012
x86_64                           rhel-8.3-syz
mips                             allyesconfig
x86_64                           rhel-8.3-kvm
i386                          randconfig-a016
s390                             allyesconfig
sh                               allmodconfig
i386                             allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20220915
hexagon              randconfig-r041-20220915
x86_64                        randconfig-a001
i386                          randconfig-a013
i386                          randconfig-a002
x86_64                        randconfig-a016
x86_64                        randconfig-a003
i386                          randconfig-a004
x86_64                        randconfig-a012
i386                          randconfig-a011
i386                          randconfig-a006
x86_64                        randconfig-a014
x86_64                        randconfig-a005
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
