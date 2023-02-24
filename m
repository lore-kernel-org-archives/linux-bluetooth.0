Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E681FC64ED8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Feb 2023 08:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjBXIky (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Feb 2023 03:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBXIkw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Feb 2023 03:40:52 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDC763DF0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Feb 2023 00:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677228051; x=1708764051;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Da+2eeJT7SYtlD5TZUkqV2dfnOZB+m/HVBZ9p/CnuAQ=;
  b=n7vf7TDs4Dnbx4BLcDJayc9Q7u8qWFMaB7dIw+E4JlmWCLlCDfXm1NsQ
   2NzLM/KxZQKoSf9Cs7hUuL9BSml6RXTZn6onsnNzDjXsQC1AnoClNMuIW
   9BK5NSr86qm47CQdw+HgjanrAucXL4V8hNLaHk10MKeIQHUIw6wqli9jZ
   WlwkMOs5BQZRiRP5ldXS1bFM7CIzFryuITaJTMy8OaY622Cs10LK846s/
   hAEGFvj5Lyzbj71fdGgixVxgVmkVC+bZCaonY50paPkhDQHJwfwUQ5QtT
   dg6jQRu7PgUj1B0BAHRSrswVRXcMYvO1O5mpKVsGfPHMPOactORKKFtyj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="395939517"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="395939517"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 00:40:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="918362188"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="918362188"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 24 Feb 2023 00:40:43 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pVTdC-0002G9-34;
        Fri, 24 Feb 2023 08:40:42 +0000
Date:   Fri, 24 Feb 2023 16:40:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 1fb7281c62c944405960a52a70b20a3bdb1a024a
Message-ID: <63f877f7.7UDHIFLwx4BQKK5n%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 1fb7281c62c944405960a52a70b20a3bdb1a024a  Bluetooth: btrtl: Add support for RTL8852BS

elapsed time: 725m

configs tested: 19
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
clang                                   alpha   defconfig
gcc                                       arc   defconfig
gcc                                       arm   defconfig
gcc                                     arm64   defconfig
gcc                                      csky   defconfig
gcc                                      i386   defconfig
gcc                                      ia64   defconfig
gcc                                 loongarch   defconfig
gcc                                      m68k   defconfig
gcc                                     nios2   defconfig
gcc                                    parisc   defconfig
gcc                                  parisc64   defconfig
gcc                                     riscv   defconfig
gcc                                     riscv   rv32_defconfig
gcc                                      s390   defconfig
gcc                                     sparc   defconfig
gcc                                        um   i386_defconfig
gcc                                        um   x86_64_defconfig
gcc                                    x86_64   defconfig
gcc                                                  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
