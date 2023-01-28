Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3844BC61DB3
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 Jan 2023 01:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbjA1BVG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Jan 2023 20:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbjA1BVF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Jan 2023 20:21:05 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB63C12F09
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jan 2023 17:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674868864; x=1706404864;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=GvVbQwkccpmRQlW8t8mZS2RAKjfYhl8SeDfx5uemU6g=;
  b=GdTh4hzOdiZZkrftMyU9/68LVIyfDKSdc5GlRwDK/9FJB0/Wf/mhWPpd
   nX0iw8oLQOz9WxR6otXkY3j2vC2oPRiHp7YsFQeGbnwvlU1gZY0nG4+6I
   cUWralYdis4Pq8+8MKyU72Ec2G+XjX5VoF6AOq2r/zGAFGaXFsDHx3jvP
   Yh+6IF0J9uxi/xiyF8Y/H1793bTPJ9bBi/I9z2hEjkDl4oaXlvIZrc8+7
   zvr6fyJQbZbTEfpt6tPIZZSN/G4Ffl+D1ZWBI287bLYcPW/kYLY/NtuwR
   zWnsLXuzOO8C9Mw9ScCmTeRQdgi2VRic+M1lHmw2N3/TRPa1qW1BPY3ut
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="307587326"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="307587326"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 17:21:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="695722647"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="695722647"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 Jan 2023 17:21:02 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLZtu-0000CA-11;
        Sat, 28 Jan 2023 01:21:02 +0000
Date:   Sat, 28 Jan 2023 09:20:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 ef017002b93b8c5213c3a3e31fdc463bb6358cba
Message-ID: <63d47853.6xRvXmNrg6YMPsDV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: ef017002b93b8c5213c3a3e31fdc463bb6358cba  dt-bindings: leds: Document Bluetooth and WLAN triggers

elapsed time: 4373m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
um                             i386_defconfig
s390                                defconfig
um                           x86_64_defconfig
s390                             allyesconfig
powerpc                           allnoconfig
i386                                defconfig
x86_64                              defconfig
arc                  randconfig-r043-20230123
arm                  randconfig-r046-20230123
x86_64                               rhel-8.3
sh                               allmodconfig
x86_64                           allyesconfig
ia64                             allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                           rhel-8.3-syz
x86_64               randconfig-a002-20230123
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a001-20230123
x86_64               randconfig-a004-20230123
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a003-20230123
x86_64                           rhel-8.3-bpf
x86_64               randconfig-a006-20230123
x86_64               randconfig-a005-20230123
i386                             allyesconfig
arm                                 defconfig
i386                 randconfig-a003-20230123
i386                 randconfig-a002-20230123
i386                 randconfig-a001-20230123
i386                 randconfig-a004-20230123
i386                 randconfig-a005-20230123
i386                 randconfig-a006-20230123
arm64                            allyesconfig
arm                              allyesconfig
x86_64                          rhel-8.3-func
m68k                             allyesconfig
alpha                            allyesconfig
arc                              allyesconfig
x86_64                    rhel-8.3-kselftests
m68k                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20230123
hexagon              randconfig-r045-20230123
s390                 randconfig-r044-20230123
riscv                randconfig-r042-20230123
x86_64               randconfig-a013-20230123
x86_64               randconfig-a011-20230123
x86_64               randconfig-a012-20230123
x86_64               randconfig-a014-20230123
x86_64               randconfig-a015-20230123
x86_64               randconfig-a016-20230123
x86_64                          rhel-8.3-rust
i386                 randconfig-a012-20230123
i386                 randconfig-a013-20230123
i386                 randconfig-a011-20230123
i386                 randconfig-a014-20230123
i386                 randconfig-a016-20230123
i386                 randconfig-a015-20230123

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
