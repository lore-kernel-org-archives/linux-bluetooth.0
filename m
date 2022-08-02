Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C20C00140
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Aug 2022 10:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235926AbiHBKiR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Aug 2022 06:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiHBKiQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Aug 2022 06:38:16 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8E8193D4
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 Aug 2022 03:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659436695; x=1690972695;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=CVN+EFcjXnJH0CeWa+i0zI0HCv8HN0pDwznrAO/7aJk=;
  b=QiyErqef2OiSY/YhDdAgR85rxVTJcWLxvMLYkvfXjF+yOikS6vpSSwfS
   HMYb3cR3f0M5lQldecW1t40zs5U/kLHYy1iD6bXLeaPwhIPxwnhzmnwVk
   7TW3gBZqNbDbROp1Hhw27BZ5wOa66CbErrFukVLXKLNa4NaAEZxZ0TVDF
   9aqNESKlrMdoGIFXiwAxIGHjs3xu67GrBoYXd1XLt15YtRlA0ZG9Wmmwr
   e5QcJbrcTWNm9VvHiwjhlADk8M0kpIJeLbhFQRNgKs+IQLp1G+WX6V4OS
   fJFJ5MztdMs2bDC+C2anmaACI+xXQOhcQAnPRauzw/LyGySD3goYJUCtL
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="286937433"
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="286937433"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 03:38:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="630656344"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 02 Aug 2022 03:38:14 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIpHx-000Fx7-2N;
        Tue, 02 Aug 2022 10:38:13 +0000
Date:   Tue, 02 Aug 2022 18:37:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 c5d36b8a7dbdcf41da7316252b717c60c409992b
Message-ID: <62e8fe66.Zjc2tJ78y6aVH3SO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: c5d36b8a7dbdcf41da7316252b717c60c409992b  Bluetooth: ISO: Fix memory corruption

elapsed time: 759m

configs tested: 65
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                  randconfig-r043-20220801
s390                 randconfig-r044-20220801
riscv                randconfig-r042-20220801
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
arm                                 defconfig
x86_64               randconfig-a011-20220801
x86_64               randconfig-a012-20220801
x86_64               randconfig-a013-20220801
x86_64               randconfig-a014-20220801
x86_64               randconfig-a015-20220801
x86_64               randconfig-a016-20220801
i386                 randconfig-a012-20220801
x86_64                           rhel-8.3-kvm
arm64                            allyesconfig
x86_64                          rhel-8.3-func
i386                 randconfig-a013-20220801
x86_64                         rhel-8.3-kunit
i386                 randconfig-a014-20220801
arm                              allyesconfig
i386                 randconfig-a011-20220801
i386                 randconfig-a016-20220801
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a015-20220801
x86_64                           rhel-8.3-syz
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
loongarch                        alldefconfig
loongarch                 loongson3_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
sh                           se7722_defconfig
nios2                            allyesconfig
x86_64               randconfig-k001-20220801
i386                 randconfig-c001-20220801

clang tested configs:
hexagon              randconfig-r045-20220801
hexagon              randconfig-r041-20220801
x86_64               randconfig-a006-20220801
x86_64               randconfig-a005-20220801
i386                 randconfig-a001-20220801
i386                 randconfig-a002-20220801
i386                 randconfig-a003-20220801
i386                 randconfig-a004-20220801
hexagon              randconfig-r045-20220802
s390                 randconfig-r044-20220802
hexagon              randconfig-r041-20220802
riscv                randconfig-r042-20220802
i386                 randconfig-a006-20220801
i386                 randconfig-a005-20220801
x86_64               randconfig-a002-20220801
x86_64               randconfig-a001-20220801
x86_64               randconfig-a003-20220801
x86_64               randconfig-a004-20220801
powerpc                      obs600_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
