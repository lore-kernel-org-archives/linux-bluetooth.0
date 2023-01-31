Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1972C636CC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Jan 2023 10:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjAaKs7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Jan 2023 05:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjAaKs5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Jan 2023 05:48:57 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A1322DEF
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Jan 2023 02:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675162131; x=1706698131;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=X29vnypsxMMsZg3gs4wW2/GQ2lMoKKWQMIfn7QUbWv0=;
  b=X+6xPKh3XZ4Hbt9HHY7uRnj38WLbqXFLLmqIO1o+De5Qt24+JfGG4xw9
   wYiECfgtox16pQ6vRGL3Kg+6dsLO9p3WWVy2wAyeSilae/pGWbvvgFi7O
   NsRJ0ZcwauP0QF6Zyz3CtlC3nauRv/UqZo5ysMqhfr8sqvQ3zlzEcJNTI
   RXLoJAUz9fIx6xX2BLA0fPkNSHJOrlX/QSwI8hpGxjvGS8Os4yNb6c3Ka
   LSEct77OCsjgQOTQ/HqIahibynyJ2fcf39RAPThq2pSRHadocjbE4Ugwq
   BIMAA8H/eKEqgIu+7xtVa72+YdQKJdgFEZbI4txGW85/ha2FSXVSXuGDB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="329917152"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="329917152"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 02:48:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="696771840"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="696771840"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 31 Jan 2023 02:48:49 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pMoC0-0004NO-37;
        Tue, 31 Jan 2023 10:48:48 +0000
Date:   Tue, 31 Jan 2023 18:48:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 d57d873e68517300ca7d32623e77b7f333534c44
Message-ID: <63d8f20f.gKao5AbV43SFTRQY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: d57d873e68517300ca7d32623e77b7f333534c44  Bluetooth: hci_conn: Refactor hci_bind_bis() since it always succeeds

elapsed time: 724m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
x86_64                              defconfig
s390                                defconfig
x86_64                               rhel-8.3
sh                               allmodconfig
s390                             allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
ia64                             allmodconfig
x86_64                    rhel-8.3-kselftests
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                                defconfig
i386                          randconfig-a005
x86_64               randconfig-a001-20230130
arc                  randconfig-r043-20230129
x86_64               randconfig-a003-20230130
x86_64               randconfig-a002-20230130
x86_64               randconfig-a004-20230130
arm                  randconfig-r046-20230129
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a006-20230130
x86_64               randconfig-a005-20230130
arm                  randconfig-r046-20230130
arc                  randconfig-r043-20230130
i386                             allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r041-20230129
riscv                randconfig-r042-20230129
hexagon              randconfig-r045-20230130
i386                 randconfig-a013-20230130
hexagon              randconfig-r041-20230130
i386                 randconfig-a012-20230130
hexagon              randconfig-r045-20230129
i386                 randconfig-a014-20230130
i386                 randconfig-a011-20230130
i386                 randconfig-a015-20230130
s390                 randconfig-r044-20230129
i386                 randconfig-a016-20230130
riscv                randconfig-r042-20230130
s390                 randconfig-r044-20230130
x86_64               randconfig-a014-20230130
x86_64               randconfig-a013-20230130
x86_64               randconfig-a011-20230130
x86_64               randconfig-a015-20230130
x86_64               randconfig-a012-20230130
x86_64               randconfig-a016-20230130

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
