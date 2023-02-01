Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B814DC05027
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Feb 2023 15:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjBAPCp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Feb 2023 10:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbjBAPCa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Feb 2023 10:02:30 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BB36E41E
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Feb 2023 06:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675263586; x=1706799586;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5d6Mr2vO0rxG+cG8mUUZjq57faDNB574DYLOvHaowdU=;
  b=MqEWDFkoBa1G0vEQsdJQD+GrTjlfDLkEAFDWqejH8yTH0K5AlZhGVAxa
   jo+tCvXsEdIsjNVQ+FuzKqo91DillFz7g9EZ12I0zWImC+D/c95ZinOq5
   KbiBDJ/+i/Tvv5XNeo6rxGsfuJYoNYsiFqkv0JWBVV3ZU0+m+ZEvivWaI
   TCwT7bqgs4+7lQsIS8Bgv1ExwxQvOjfSWFGGZ2xOc06MTsPnMEv9whIBO
   mirM17ffMA4oKOajlsCd8psA2gmJnTZnu6AuAneKT2MB9jpqDv98g1eK+
   bdUC1mQIni0mWqV/MO14VohnHlfguVKgqE3pUSu+jv6tO9CxG4a4juF5r
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="414369724"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="414369724"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 06:59:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="788911796"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="788911796"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 01 Feb 2023 06:59:30 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNEa9-0005W2-2c;
        Wed, 01 Feb 2023 14:59:29 +0000
Date:   Wed, 01 Feb 2023 22:59:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 d2e9c401579a6500af2c8d71c8cecd6f4e52f2c4
Message-ID: <63da7e43.AUatGoPx1ChWDDPd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: d2e9c401579a6500af2c8d71c8cecd6f4e52f2c4  Bluetooth: MGMT: add CIS feature bits to controller information

elapsed time: 862m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
arc                                 defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
ia64                             allmodconfig
x86_64               randconfig-a001-20230130
x86_64               randconfig-a003-20230130
x86_64               randconfig-a004-20230130
x86_64               randconfig-a002-20230130
s390                             allyesconfig
x86_64                              defconfig
x86_64               randconfig-a006-20230130
x86_64               randconfig-a005-20230130
m68k                             allmodconfig
x86_64                               rhel-8.3
alpha                            allyesconfig
m68k                             allyesconfig
arc                              allyesconfig
i386                 randconfig-a001-20230130
i386                 randconfig-a004-20230130
i386                 randconfig-a003-20230130
i386                 randconfig-a002-20230130
i386                 randconfig-a005-20230130
i386                 randconfig-a006-20230130
x86_64                           allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
i386                                defconfig
sh                               allmodconfig
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-bpf
i386                             allyesconfig
i386                          randconfig-a014
arm                                 defconfig
i386                          randconfig-a012
arc                  randconfig-r043-20230129
i386                          randconfig-a016
arm                  randconfig-r046-20230129
arm64                            allyesconfig
arm                              allyesconfig
arm                  randconfig-r046-20230130
arc                  randconfig-r043-20230130
powerpc                          allmodconfig

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64               randconfig-a014-20230130
x86_64               randconfig-a012-20230130
x86_64               randconfig-a013-20230130
x86_64               randconfig-a011-20230130
x86_64               randconfig-a015-20230130
x86_64               randconfig-a016-20230130
hexagon              randconfig-r041-20230129
riscv                randconfig-r042-20230129
hexagon              randconfig-r045-20230130
hexagon              randconfig-r041-20230130
hexagon              randconfig-r045-20230129
i386                          randconfig-a013
i386                          randconfig-a015
s390                 randconfig-r044-20230129
riscv                randconfig-r042-20230130
i386                          randconfig-a011
s390                 randconfig-r044-20230130

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
