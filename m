Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9B9C6FA82
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Sep 2022 10:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiIVK4Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Sep 2022 06:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiIVK4Y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Sep 2022 06:56:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99422D432B
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Sep 2022 03:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663844183; x=1695380183;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=xWY2DufTPb5i7by/WcSrPMGqpZzf6tRkKQZT0Ew5by4=;
  b=BgkEmoKCnfEn5yoq8y7Pc7xdttEnuaWaIcCTOoTOmWRbOmZEVLRcfJmP
   ZhS0mEEkOHuXFvlAfOCmnSt/8NLR232HO6m526EMMly9HAt+A7E4dOcQ/
   30B+BJE2vJBwKYbZ4lygb6f3b4yN0U0CDdF171blysjvtXnkdvoyAThDD
   GrkIGXqtGnU/6XTY+ELmW1PdkfPt9QvINVs50+4TpCDUazjnTiZ5plhmV
   qwlFFaVCB9747nVcbcuO7m6H8CHOaM/ifJG97ocanisO0FrQLpfhJ853H
   Eh2fXHS5NjXIzbmgWmp4oHoSnB04qiogtkAfH443aLLptUlziY6zPyC89
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="300249573"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="300249573"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 03:56:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="570917515"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Sep 2022 03:56:21 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obJsS-0004cu-2N;
        Thu, 22 Sep 2022 10:56:20 +0000
Date:   Thu, 22 Sep 2022 18:55:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 ed680f925aea76ac666f34d9923cb40558f4e97b
Message-ID: <632c3f37.06l+NbKAoZkIvFEl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: ed680f925aea76ac666f34d9923cb40558f4e97b  Bluetooth: hci_event: Make sure ISO events don't affect non-ISO connections

elapsed time: 721m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20220921
powerpc                           allnoconfig
powerpc                          allmodconfig
riscv                randconfig-r042-20220921
mips                             allyesconfig
arc                              allyesconfig
sh                               allmodconfig
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
s390                 randconfig-r044-20220921
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
s390                                defconfig
x86_64                        randconfig-a006
i386                                defconfig
s390                             allyesconfig
arm                                 defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                              defconfig
i386                          randconfig-a016
arm64                            allyesconfig
arm                              allyesconfig
x86_64                               rhel-8.3
i386                             allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
x86_64                           allyesconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20220921
hexagon              randconfig-r045-20220921
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a013
i386                          randconfig-a006
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
