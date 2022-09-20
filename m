Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D4BECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Sep 2022 06:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiITGII (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Sep 2022 02:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiITGIH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Sep 2022 02:08:07 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15B5BD6
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Sep 2022 23:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663654086; x=1695190086;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2iBjYK07zt7A9PdJ2mE/PYIaFQgHlcssX2/yI4ZErnQ=;
  b=YrRPDdO3uTb/4EPNs6cwSXk9iNI5rqQ09s2jt+LJsqAZqmUbAzeC66JA
   FsDsY4Jq+dlNmeoC5xV/S6RS6XjnvFvi7Ep8NPne2FuXsUvWzI6Grx3oc
   wtGMNsMVMCA0GfqgNo66j7zEPARQG7U6BSABMGLq0B/sYseJQp6InTQ8u
   iwjzaTrK756e6S6uDmygjmhDJ1rUck0z4A6rFrj8bO4fmvJ2vU/Go+5I+
   tG3AaDCGeMk6iOgW7Ikhyd52qwNRdiFVmA2u5hmRxeriHFDFO038Y3i+R
   SdzuKhl66l8yc/C0bhg3/IcNFoQBTeEhyaTu20g8biDXhTRWg2Nb1P9Kk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="385894518"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="385894518"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 23:08:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="596386254"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 19 Sep 2022 23:08:05 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaWQO-0002Wz-1l;
        Tue, 20 Sep 2022 06:08:04 +0000
Date:   Tue, 20 Sep 2022 14:07:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 3124d320c22f3f4388d9ac5c8f37eaad0cefd6b1
Message-ID: <632958aa.sQC6OWw8pOeQxpGI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 3124d320c22f3f4388d9ac5c8f37eaad0cefd6b1  Bluetooth: hci_{ldisc,serdev}: check percpu_init_rwsem() failure

elapsed time: 720m

configs tested: 34
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
riscv                randconfig-r042-20220919
arc                  randconfig-r043-20220919
s390                 randconfig-r044-20220919
i386                                defconfig
x86_64                              defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                               rhel-8.3
arc                                 defconfig
arm                                 defconfig
s390                             allmodconfig
powerpc                          allmodconfig
alpha                               defconfig
mips                             allyesconfig
x86_64                           rhel-8.3-kvm
m68k                             allmodconfig
s390                                defconfig
powerpc                           allnoconfig
x86_64                           allyesconfig
arc                              allyesconfig
x86_64                          rhel-8.3-func
s390                             allyesconfig
alpha                            allyesconfig
i386                             allyesconfig
sh                               allmodconfig
arm64                            allyesconfig
m68k                             allyesconfig
x86_64                         rhel-8.3-kunit
arm                              allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20220919
hexagon              randconfig-r045-20220919

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
