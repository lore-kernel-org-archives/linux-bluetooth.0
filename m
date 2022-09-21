Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8C9C6FA90
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Sep 2022 11:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiIULkZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Sep 2022 07:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiIULkX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Sep 2022 07:40:23 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C67E48CA9
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 04:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663760422; x=1695296422;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=46I649uAwLdPY0xQkNEEKho15BLBocer2cEgIw5tSXU=;
  b=fbI785DcFP2dzvuANw5rtepu9pMouwDy55T4awQoiLxqiEb3ewa2K949
   XiMP/seI0h4VMgovKNSZWhG4v8wOqjTi/ogjikt+ilqOS/Tio0IYAQGs7
   7Gu9b78QqgaqmKxDmI+PTMikHPmh8sugjv0Oj6PTg422HdsB5sz9e0wNE
   Z3AD1lowBie0WxLm4tGFbws8edj7M0S1r90yXEzKG0ITWs7HneGRwIGEj
   PZmSJOA8p7PXJEv5SW49TM8cSt1i4aTor7KYjAVMsCvxSJlnVI0XRXzeu
   RucDpsarW9IwtRBbLJm17NuLW0YJkemH6MQD1sphlzHy+LuNBq/IpbZSV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="300814598"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="300814598"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 04:40:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="570501823"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Sep 2022 04:40:20 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oay5T-0003Zl-26;
        Wed, 21 Sep 2022 11:40:19 +0000
Date:   Wed, 21 Sep 2022 19:40:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 bb20da18ce936adda6b48aea79a8797c8eee479f
Message-ID: <632af815.DrI/vjf3/P8HAb++%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: bb20da18ce936adda6b48aea79a8797c8eee479f  Bluetooth: MGMT: fix zalloc-simple.cocci warnings

elapsed time: 726m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
s390                             allmodconfig
alpha                               defconfig
arc                                 defconfig
s390                                defconfig
s390                             allyesconfig
i386                                defconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
arc                  randconfig-r043-20220921
riscv                randconfig-r042-20220921
mips                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
s390                 randconfig-r044-20220921
alpha                            allyesconfig
i386                             allyesconfig
sh                               allmodconfig
m68k                             allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                              defconfig
i386                          randconfig-a005
x86_64                               rhel-8.3
arm                                 defconfig
x86_64                           allyesconfig
i386                          randconfig-a014
arm                              allyesconfig
x86_64                          rhel-8.3-func
arm64                            allyesconfig
i386                          randconfig-a012
x86_64                         rhel-8.3-kunit
i386                          randconfig-a016
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20220921
hexagon              randconfig-r045-20220921
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
