Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B32C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 17:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbiI2RxS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 13:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbiI2RxN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 13:53:13 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72D114D30D
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 10:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664473992; x=1696009992;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Xve6c7VFy+HRCHvnCOF5ZDeQ1vKzYUlGgXYhdz/S+b0=;
  b=KVSFy2T0E1ts9I5eBo8rZqX9BkzivcZPckxmPJxUAjm7QSjtDPrQTyen
   wt4gifKUzAkpOQwMXuzO0/8fnyzIeE2FXtyw/kklgKn5K16pCPcLmOQ2v
   jQkvca20cOvcnR5g5PpwfcTnZWUpt7GwLqHkgoOjAV7K6kEf8VPynEYJZ
   4PKjxgc9Ig6FvjK4Cs+GPr1pzV5AhDIF33S3A7GOXlS67tE40+HbEYwu9
   fozu2TxiaFocdAVRv7P0PE5QCqQCEk/3sMriLHDdD/P/G9RJWj/GA7kd2
   Ft3es/g1tSUHRyOAkDhCvkSkP6KMKeUOKIYmnU327okNpzHie591fVYP6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="302894509"
X-IronPort-AV: E=Sophos;i="5.93,355,1654585200"; 
   d="scan'208";a="302894509"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 10:53:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="653219161"
X-IronPort-AV: E=Sophos;i="5.93,355,1654585200"; 
   d="scan'208";a="653219161"
Received: from lkp-server01.sh.intel.com (HELO 6126f2790925) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 29 Sep 2022 10:53:09 -0700
Received: from kbuild by 6126f2790925 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1odxie-0001SQ-1s;
        Thu, 29 Sep 2022 17:53:08 +0000
Date:   Fri, 30 Sep 2022 01:52:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 8dbc3e75a0a56fb0ab70781338a2283d28a09164
Message-ID: <6335db6c.SscGfFMKX0xw9R8b%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 8dbc3e75a0a56fb0ab70781338a2283d28a09164  Bluetooth: Call shutdown for HCI_USER_CHANNEL

elapsed time: 1150m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
powerpc                           allnoconfig
s390                             allmodconfig
x86_64                          rhel-8.3-func
s390                                defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                           rhel-8.3-kvm
sh                               allmodconfig
x86_64                               rhel-8.3
i386                                defconfig
powerpc                          allmodconfig
x86_64                           rhel-8.3-syz
mips                             allyesconfig
x86_64                         rhel-8.3-kunit
s390                             allyesconfig
x86_64                           allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
arm                                 defconfig
arc                  randconfig-r043-20220926
m68k                             allyesconfig
i386                 randconfig-a001-20220926
i386                 randconfig-a004-20220926
i386                 randconfig-a002-20220926
i386                 randconfig-a003-20220926
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                             allyesconfig
x86_64                        randconfig-a002
i386                 randconfig-a006-20220926
i386                 randconfig-a005-20220926
x86_64                        randconfig-a015
arm64                            allyesconfig
arm                              allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a006
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20220926
riscv                randconfig-r042-20220926
hexagon              randconfig-r041-20220926
s390                 randconfig-r044-20220926
x86_64                        randconfig-a012
x86_64                        randconfig-a001
x86_64                        randconfig-a016
i386                 randconfig-a011-20220926
x86_64                        randconfig-a014
x86_64                        randconfig-a003
i386                 randconfig-a013-20220926
i386                 randconfig-a012-20220926
x86_64                        randconfig-a005
i386                 randconfig-a016-20220926
i386                 randconfig-a015-20220926
i386                 randconfig-a014-20220926

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
