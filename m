Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747F3C636CD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Feb 2023 18:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjBJSXq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Feb 2023 13:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjBJSXp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Feb 2023 13:23:45 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB3961D2B
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Feb 2023 10:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676053425; x=1707589425;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=PmJf4ktT6JKpOpJAkPG9BR7v6xb32BeuHHObCz8nx/o=;
  b=ia3XKGczVscbYOvd1ToPC22phx8oSUOQXv3wfpnkj3rzZznyjRiK5t7P
   8izDX93ok010IJYDlmXwBH5B4b1TqdCWwYzKB1wGcSSa2P1xNCwM6YEHA
   iggz7XYCtTPAlC/2HjEaHDFXbl0BqYh9x9TdbyX9tx9sFo5c9fC1xOz/P
   0CQvGODxiMNXY/pQ5Y7hDIqQZ6CIr2CMy8sgHxnVwUfJOzTPsVaxrb4ut
   IAVFXozh5ZRap3qglwZ3Q62Ygu7xTa7KdxNhmUJYOkfyJvVGbYhonaawA
   m+e1M+yiYfHFd+4EoYw3aexcIQNkeYrnKBSeUrIv//S9pghxCAUlGzilM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="392896115"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="392896115"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 10:23:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="913621305"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="913621305"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 10 Feb 2023 10:23:43 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQY3j-0005yV-01;
        Fri, 10 Feb 2023 18:23:43 +0000
Date:   Sat, 11 Feb 2023 02:23:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 c585a92b2f9c624b0b62b2af1eb0ea6d11cb5cac
Message-ID: <63e68b8b.hvEeVs9JMup6J9Rv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: c585a92b2f9c624b0b62b2af1eb0ea6d11cb5cac  Bluetooth: btintel: Set Per Platform Antenna Gain(PPAG)

elapsed time: 1087m

configs tested: 43
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                            allyesconfig
alpha                               defconfig
arc                              allyesconfig
arc                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
csky                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                                defconfig
ia64                             allmodconfig
ia64                                defconfig
loongarch                        allmodconfig
loongarch                         allnoconfig
loongarch                           defconfig
m68k                             allmodconfig
m68k                                defconfig
mips                             allmodconfig
mips                             allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
s390                             allmodconfig
s390                             allyesconfig
s390                                defconfig
sh                               allmodconfig
sparc                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
