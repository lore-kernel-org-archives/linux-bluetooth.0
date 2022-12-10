Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B177C4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Dec 2022 14:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiLJONx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 10 Dec 2022 09:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJONw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 10 Dec 2022 09:13:52 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E264AC742
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Dec 2022 06:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670681631; x=1702217631;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=L1OzKgb37Em1z0GaHbVN/qb8r+zZIJa3KN+Ln/qiSE0=;
  b=CCQ2OzsH6fnQ1s2lnDYupp/SyOZy8ZjQ4stE5IoUsLOLgCr7WR5hApNz
   klbCAbgGF7cFC9bxhr8Goe43oWSDejwVrP1JnvibVmVb/uSwqD6jQVMG7
   a9mYeqgkE10nldXdmS9UebLXaGmXh4Ey5OWZ6DCUrh2oGUddc6XPsY5Yr
   u08MonucW8JYqFBUFIutPRl6isZsaCVYRmZU3uzhxllTz1eZ35Nlq9MPT
   TrFNGCfSd7S0dUMbg/pM106MgHhzbW4dcOli/Xt1tnIgx6z+foiXo2qes
   XTF+0IHsyu8z0Sl0dft71nwGfpOa50qUo/UaWPQQtbqO8GePri686D+6q
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="297973121"
X-IronPort-AV: E=Sophos;i="5.96,234,1665471600"; 
   d="scan'208";a="297973121"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2022 06:13:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="647688847"
X-IronPort-AV: E=Sophos;i="5.96,234,1665471600"; 
   d="scan'208";a="647688847"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 10 Dec 2022 06:13:50 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p40bt-0002VR-1g;
        Sat, 10 Dec 2022 14:13:49 +0000
Date:   Sat, 10 Dec 2022 22:13:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 7a637ef7e0c3308754d7ccf0edb0eec69f77bb81
Message-ID: <63949417.9yrSb7tmJ4nSXjXM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 7a637ef7e0c3308754d7ccf0edb0eec69f77bb81  Bluetooth: Wait for HCI_OP_WRITE_AUTH_PAYLOAD_TO to complete

elapsed time: 721m

configs tested: 34
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                               rhel-8.3
x86_64                              defconfig
x86_64                          rhel-8.3-func
x86_64                          rhel-8.3-rust
x86_64                    rhel-8.3-kselftests
arc                                 defconfig
alpha                               defconfig
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
s390                             allmodconfig
arc                  randconfig-r043-20221209
s390                                defconfig
s390                 randconfig-r044-20221209
riscv                randconfig-r042-20221209
m68k                             allyesconfig
alpha                            allyesconfig
s390                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
i386                                defconfig
arm64                            allyesconfig
i386                             allyesconfig
i386                          randconfig-c001

clang tested configs:
arm                  randconfig-r046-20221209
hexagon              randconfig-r041-20221209
hexagon              randconfig-r045-20221209
powerpc                     mpc512x_defconfig
powerpc                     skiroot_defconfig
x86_64                        randconfig-k001
mips                        omega2p_defconfig
powerpc                   lite5200b_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
