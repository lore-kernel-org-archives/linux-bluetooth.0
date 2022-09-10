Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D030CC6FA82
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Sep 2022 08:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiIJIXu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 10 Sep 2022 04:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiIJIXt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 10 Sep 2022 04:23:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC07089820
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Sep 2022 01:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662798228; x=1694334228;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=MSSyQK4WwFfQQJ2ncGOlWZ9SWiCgMDhOGEJ3TItINuw=;
  b=OszadBrLocwI5iWYBIMTkO56OiDgmffgqvZrnncvfOOLdLaj7vNdbc3Y
   3lacmtKWO3o+XeJXnwkbZ+6eO9+5uoCcmJHrZvQhnTtlW/mUJAS4hC7/c
   d/cL6MGn6kZCPHd9oInr2barRQGi4b6AsY1KG/ObGLuofHLeJ+AmP3RLh
   FWgoHcoQ09NnAQ+b6mSRXsfnAyvpACtOr256TVCjFca+ZyOTc5HGJsRSJ
   1D3jrOUXUaqYnKxsusIzwDzT74XTGfuWduBeejC8TjSuiu/ipBmIVcugy
   6ODiPS/IF0dWYCoRqfctDKbRXJ0dbCC9oS9BlH7wiNTFYrgutCeFqAzVE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="284642305"
X-IronPort-AV: E=Sophos;i="5.93,305,1654585200"; 
   d="scan'208";a="284642305"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2022 01:23:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,305,1654585200"; 
   d="scan'208";a="944045985"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 10 Sep 2022 01:23:47 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWvmE-0002J9-1K;
        Sat, 10 Sep 2022 08:23:46 +0000
Date:   Sat, 10 Sep 2022 16:22:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 dd0a1794f4334ddbf9b7c5e7d642aaffff38c69b
Message-ID: <631c4961.uKb5x4uLMTZzF2qu%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: dd0a1794f4334ddbf9b7c5e7d642aaffff38c69b  Bluetooth: btintel: Mark Intel controller to support LE_STATES quirk

elapsed time: 728m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
powerpc                           allnoconfig
i386                                defconfig
x86_64                           allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
sh                               allmodconfig
m68k                             allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arc                  randconfig-r043-20220908
i386                             allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
arc                  randconfig-r043-20220907
x86_64                          rhel-8.3-func
s390                 randconfig-r044-20220908
x86_64                         rhel-8.3-kunit
i386                          randconfig-a005
riscv                randconfig-r042-20220908
x86_64                    rhel-8.3-kselftests
arm                                 defconfig
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a002
arm64                            allyesconfig
arm                              allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
ia64                             allmodconfig

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
hexagon              randconfig-r041-20220907
hexagon              randconfig-r041-20220908
riscv                randconfig-r042-20220907
hexagon              randconfig-r045-20220908
i386                          randconfig-a002
hexagon              randconfig-r045-20220907
s390                 randconfig-r044-20220907
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
