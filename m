Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F016BEB64D7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jun 2023 01:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjF0BTo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Jun 2023 21:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjF0BTn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Jun 2023 21:19:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E09173B
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jun 2023 18:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687828782; x=1719364782;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=US6XbYRtv542B2ht8NoVXWNa5wdS3jod7rBJVSkfi0w=;
  b=n9fODcrFEphHHNy7ba4qJdGZdND0xAyjEYJn5zb2EDGs9QWnmHz5rXed
   dHkv/0VP1Mhv+g6yKoSraeajAEYA+mT3qKHsM/tb+L5f68GO/mLD9kyj4
   29Xk2Rz0W91VSunrd3Rn3B39ZV+UucUdSkvlUJcoIxl09Ok+pZxlZ8lYq
   +266kdKDkIiutMzPGm1w+90IpTig62SuwtTUmWJKWPN3N/+goH9p/+xEh
   LCxngEkGylbWg1d3L2kfMmgMsrWU39YVRxuVDbSDYWTqysrD01nZ6LfAe
   7oRSSRcaAG22uFNpvgE+P7p/F0IUCFW0yPuuXIueRitJmIdpt2oh/YT3e
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="447822529"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="447822529"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 18:19:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="840494090"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="840494090"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2023 18:19:40 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qDxMp-000BL0-1P;
        Tue, 27 Jun 2023 01:19:39 +0000
Date:   Tue, 27 Jun 2023 09:19:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master 18/33] ERROR: modpost: "pidfd_prepare"
 [net/bluetooth/bluetooth.ko] undefined!
Message-ID: <202306270959.9Y2gQBta-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
head:   53c7c193d66ae7a22f137b38d0d374c756892bd4
commit: b4f7565b8844e5b29a9f3d1855655a7b837da19b [18/33] Bluetooth: hci_sock: Forward credentials to monitor
config: x86_64-randconfig-r006-20230626 (https://download.01.org/0day-ci/archive/20230627/202306270959.9Y2gQBta-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230627/202306270959.9Y2gQBta-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306270959.9Y2gQBta-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "pidfd_prepare" [net/bluetooth/bluetooth.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
