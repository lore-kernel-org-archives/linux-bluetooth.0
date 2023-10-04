Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE59E936EC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Oct 2023 23:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbjJDXR3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Oct 2023 19:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjJDXR2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Oct 2023 19:17:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED1DC0
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Oct 2023 16:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696461443; x=1727997443;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eRLOOD3IBkoDaoIvNdoryIpNSgz0fN9f44CtaFUY23Y=;
  b=UZPVpPRLy9BZXWli40VayVpLglAHhCByPKxZ0cKRzWzmDtYmZkU22SMy
   ztGvdZJmrK0xbJuHQFw5WNYN6rZ9y85gbjl3C8S+yOT8RVCSsEbtT8gm5
   C32v+nmZW8bp908vZET9JsDkg/pND9EFw5DiJJ9tbgY0Fe0awl3zwXFOP
   0KaJhZGOlL9c2Yu2HbbpytXpJaNrXV0tPNqHz4LkhskfZgKae81umm1sG
   8d2bXJX9+2yFZIl/pBrvktoY8nRhww0LLCMuIj9u0GRUv0/puvWdiUiL6
   r902EzgKdR8PcyuXFOAnNLX6Sk5fXY+5H+nwC7dvILaGojI68Koh6xi9e
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="449824005"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="449824005"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 16:17:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="998703425"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="998703425"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 04 Oct 2023 16:17:20 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qoB7E-000Kji-2V;
        Wed, 04 Oct 2023 23:17:17 +0000
Date:   Thu, 5 Oct 2023 07:16:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Lee, Chun-Yi" <jlee@suse.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [bluetooth-next:master 19/23] include/linux/fortify-string.h:63:33:
 warning: '__builtin_memcmp' specified bound 6 exceeds source size 0
Message-ID: <202310050755.e0kabNON-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
head:   6be21d9878685e926d8e21fbfd8be7d0b6b105e4
commit: d70e44fef8621aeae895e1cbc62059df9e31836b [19/23] Bluetooth: Reject connection with the device which has same BD_ADDR
config: arm-randconfig-001-20231005 (https://download.01.org/0day-ci/archive/20231005/202310050755.e0kabNON-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231005/202310050755.e0kabNON-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310050755.e0kabNON-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/string.h:254,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/wait.h:9,
                    from include/linux/poll.h:8,
                    from include/net/bluetooth/bluetooth.h:29,
                    from net/bluetooth/hci_event.c:30:
   net/bluetooth/hci_event.c: In function 'hci_cc_read_class_of_dev':
   include/linux/fortify-string.h:57:33: warning: '__builtin_memcpy' writing 3 bytes into a region of size 0 overflows the destination [-Wstringop-overflow=]
      57 | #define __underlying_memcpy     __builtin_memcpy
         |                                 ^
   include/linux/fortify-string.h:648:9: note: in expansion of macro '__underlying_memcpy'
     648 |         __underlying_##op(p, q, __fortify_size);                        \
         |         ^~~~~~~~~~~~~
   include/linux/fortify-string.h:693:26: note: in expansion of macro '__fortify_memcpy_chk'
     693 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
         |                          ^~~~~~~~~~~~~~~~~~~~
   net/bluetooth/hci_event.c:522:9: note: in expansion of macro 'memcpy'
     522 |         memcpy(hdev->dev_class, rp->dev_class, 3);
         |         ^~~~~~
   cc1: note: destination object is likely at address zero
   In function 'memcmp',
       inlined from 'bacmp' at include/net/bluetooth/bluetooth.h:364:9,
       inlined from 'hci_conn_request_evt' at net/bluetooth/hci_event.c:3274:7:
>> include/linux/fortify-string.h:63:33: warning: '__builtin_memcmp' specified bound 6 exceeds source size 0 [-Wstringop-overread]
      63 | #define __underlying_memcmp     __builtin_memcmp
         |                                 ^
   include/linux/fortify-string.h:728:16: note: in expansion of macro '__underlying_memcmp'
     728 |         return __underlying_memcmp(p, q, size);
         |                ^~~~~~~~~~~~~~~~~~~


vim +/__builtin_memcmp +63 include/linux/fortify-string.h

78a498c3a227f2 Alexander Potapenko 2022-10-24  61  
78a498c3a227f2 Alexander Potapenko 2022-10-24  62  #define __underlying_memchr	__builtin_memchr
78a498c3a227f2 Alexander Potapenko 2022-10-24 @63  #define __underlying_memcmp	__builtin_memcmp
a28a6e860c6cf2 Francis Laniel      2021-02-25  64  #define __underlying_strcat	__builtin_strcat
a28a6e860c6cf2 Francis Laniel      2021-02-25  65  #define __underlying_strcpy	__builtin_strcpy
a28a6e860c6cf2 Francis Laniel      2021-02-25  66  #define __underlying_strlen	__builtin_strlen
a28a6e860c6cf2 Francis Laniel      2021-02-25  67  #define __underlying_strncat	__builtin_strncat
a28a6e860c6cf2 Francis Laniel      2021-02-25  68  #define __underlying_strncpy	__builtin_strncpy
a28a6e860c6cf2 Francis Laniel      2021-02-25  69  #endif
a28a6e860c6cf2 Francis Laniel      2021-02-25  70  

:::::: The code at line 63 was first introduced by commit
:::::: 78a498c3a227f2ac773a8234b2ce092a4403f2c3 x86: fortify: kmsan: fix KMSAN fortify builds

:::::: TO: Alexander Potapenko <glider@google.com>
:::::: CC: Andrew Morton <akpm@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
