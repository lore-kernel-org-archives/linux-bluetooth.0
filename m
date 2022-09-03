Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C176ECAAD4
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Sep 2022 11:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiICLG0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 3 Sep 2022 07:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiICLGZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 3 Sep 2022 07:06:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA66F21E22
        for <linux-bluetooth@vger.kernel.org>; Sat,  3 Sep 2022 04:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662203183; x=1693739183;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=SkGN3ahJhzjmYQYDLecU5cFHG9/OpOe53+1yV0ZMxvU=;
  b=NCuHowjHkCs53cMyCSrDyXlb2reBVaPx6DeRmDAvk+OzlHiGrYo6z6Ai
   XsElhr6AUugXvjA7hF1OpBZYd+bZwoodUWxsPXM09zGnKfygMZba5CY6K
   tDIBQwoy9Fxp6ggpBEkb13jYocPdN+EbcJ+lkyMM4S/fcvpZBUYeWek7s
   bKLQH8bz+ouFQ0lorofRBXC4mmG6N9hnKJ6Y1rgje60imxVF9Moi4YBqR
   y8RN9fSSzF5KmPuTtiS393hb+u3qA+carnGtygTqrJX6AnlZprf6/x82m
   Up3w9UQ+0rMwLOvV4jThBa3ROkG6qvpjNdzr4GkVZWqz7gg7rRQkL0NhW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="279165494"
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="279165494"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 04:06:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="590370061"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 03 Sep 2022 04:06:22 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUQyj-0001X7-1J;
        Sat, 03 Sep 2022 11:06:21 +0000
Date:   Sat, 03 Sep 2022 19:05:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 b1c013419bdecc7257a4a997c75db0332598e048
Message-ID: <63133500.eLGJYdi0rYbbVuWy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: b1c013419bdecc7257a4a997c75db0332598e048  Bluetooth: hci_sync: Fix hci_read_buffer_size_sync

elapsed time: 894m

configs tested: 24
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                              defconfig
sh                               allmodconfig
x86_64                               rhel-8.3
i386                                defconfig
x86_64                           allyesconfig
i386                             allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
