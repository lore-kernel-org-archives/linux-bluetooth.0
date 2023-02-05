Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30726C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Feb 2023 00:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjBEAeF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 4 Feb 2023 19:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjBEAeE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 4 Feb 2023 19:34:04 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD6221A2A
        for <linux-bluetooth@vger.kernel.org>; Sat,  4 Feb 2023 16:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675557243; x=1707093243;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=X9DUrk3Rd1kWGKexIf3F14Yct0gZCX2hdPYWrY4pwU8=;
  b=dW84YhI4PZTfJOqacEtfcagSiAx48zAiHEGGaaKAKe1t95tuoSsHLGOL
   0fhCuNAtwT7zQisDVEX25d9aRr993PP5h9U7nG49iJ9/3ZNKeVln6mlH4
   aZjvwGOvkFl2aLfAuSp3djt1gwc6J6ILw5kdvADLSr6vskRS0HR0TqM8b
   uqdRN1SY+CRZyn41rgV+5LBjaZRt8gK8Kb6osAq3zGy8DxM7ma3A9SCjM
   uHUvx7+ACvYUz3w57ncvbnIKrAkE4Pp4kXiz/0HG3OZs7pTE+r8K11PkT
   BTpNXQqrVj+tzgKqIzoyM1HvO7vBTAViMxt7wqh5TMqGMik0oOYTwhzeG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="326698072"
X-IronPort-AV: E=Sophos;i="5.97,274,1669104000"; 
   d="scan'208";a="326698072"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2023 16:34:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="774756028"
X-IronPort-AV: E=Sophos;i="5.97,274,1669104000"; 
   d="scan'208";a="774756028"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 04 Feb 2023 16:34:01 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pOSyn-0001bc-0o;
        Sun, 05 Feb 2023 00:34:01 +0000
Date:   Sun, 05 Feb 2023 08:33:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 edda34a2348f22bed62e2c2f72cd5e2a3c5a5e8d
Message-ID: <63def967.HOT/w1wbOw7F7vc7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: edda34a2348f22bed62e2c2f72cd5e2a3c5a5e8d  Bluetooth: Make sure LE create conn cancel is sent when timeout

elapsed time: 1680m

configs tested: 60
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
ia64                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
riscv                randconfig-r042-20230204
arc                  randconfig-r043-20230204
s390                 randconfig-r044-20230204
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                                defconfig
i386                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arm                                 defconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r041-20230204
arm                  randconfig-r046-20230204
hexagon              randconfig-r045-20230204
x86_64                          rhel-8.3-rust
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
