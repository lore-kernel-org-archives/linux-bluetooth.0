Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3AA238D54;
	Fri, 14 Aug 2026 04:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786681670; cv=none; b=s/kM2HdG+OYBhG/WrbiQvCx91Jfi8+nQtNUm7YVdFT/gQf++FY9r5fftgVGbq2nPkpT6z/Xtavz3G58Adaqzh/Ota2/Zd1imKYPtoro2ZxedEZee6a8JVGzxRXXRCnaWA63yAfPCREtKK4Y4vBdZPJKydlbWE6rHgW7vb4dJNl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786681670; c=relaxed/simple;
	bh=3gLJEiLlSAbmbVaY8h9beUk2rDB9gtNm/aEPaZ0xws8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h76NDcVH51dLpBiKOMrJrLKTwRgWx5GMt4PPyXxCQlTaFYiKd4lXZmgoZpa986xKzMarY0TD/m4CEeTa5fkTB5MfPaMRHLBh+cYXL1E0VViw17miltrtw49D9s2CVH6jDiSAdVzXHr0aDtODc59MJH3RXksGcULVhc6k+ajrKJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G2UwMc9j; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G2UwMc9j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786681667; x=1818217667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3gLJEiLlSAbmbVaY8h9beUk2rDB9gtNm/aEPaZ0xws8=;
  b=G2UwMc9j6X4WWvRPkkxXLSVChdlu3YXtG3hU8mqTx0hmPesPaOG9CXEL
   g9gU+4ibU1r2ZTEtwKmWr7k10s34w+QnH/G010aboX0lpf4VRTnO8713v
   n0wyJyOKB8SslmaRsLqayuXoGB9gkjygLHw+29Nx6PewcbGu9LcVKU6UG
   0Wo0Jzaxb7FypfNsqbwUBOw0kpEXlMgT4SYl/JbDfN+ZxqV9M+3nF8t3h
   RLPMY3jX4EcG2o1QjAK7PRyW/88biXSPcbMhjwclr3fqNdIXcG3DD33D7
   S+yI0rquSyH5AKMWxisIkeOYZETclb7wA9Q1pflQUfYzXfPVqetCr7WsR
   w==;
X-CSE-ConnectionGUID: gZiHaduARKm7NcfEfGx1rQ==
X-CSE-MsgGUID: T+B4fFwCRAGkVh2FNWeDFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87335462"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="87335462"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 21:27:46 -0700
X-CSE-ConnectionGUID: P+SpblFrSkeUGMMCF/UI4Q==
X-CSE-MsgGUID: S6AmETFUT1uoxfYnaNEzvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="294053069"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 13 Aug 2026 21:27:45 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wujWA-00000000XhK-02KV;
	Fri, 14 Aug 2026 04:27:42 +0000
Date: Fri, 14 Aug 2026 12:27:20 +0800
From: kernel test robot <lkp@intel.com>
To: jiale yao <19888972804@163.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Marcel Holtmann <marcel@holtmann.org>,
	Tim Bird <tim.bird@sony.com>, Muhammad Bilal <meatuni001@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re:Re: [PATCH v2] Bluetooth: HIDP: add missing length check for
 incoming frames
Message-ID: <202608141113.WMJnrfnI-lkp@intel.com>
References: <220b6be5.d3f.19f78e165aa.Coremail.19888972804@163.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <220b6be5.d3f.19f78e165aa.Coremail.19888972804@163.com>

Hi jiale,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kees/for-next/pstore]
[also build test WARNING on kees/for-next/kspp]
[cannot apply to bluetooth-next/master bluetooth/master linus/master v7.2-rc7 next-20260812]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/jiale-yao/Re-Re-PATCH-v2-Bluetooth-HIDP-add-missing-length-check-for-incoming-frames/20260814-100503
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
patch link:    https://lore.kernel.org/r/220b6be5.d3f.19f78e165aa.Coremail.19888972804%40163.com
patch subject: Re:Re: [PATCH v2] Bluetooth: HIDP: add missing length check for incoming frames
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260814/202608141113.WMJnrfnI-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260814/202608141113.WMJnrfnI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608141113.WMJnrfnI-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:31,
                    from arch/powerpc/include/asm/bug.h:116,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from arch/powerpc/include/asm/preempt.h:5,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/kref.h:16,
                    from net/bluetooth/hidp/core.c:24:
   net/bluetooth/hidp/core.c: In function 'hidp_recv_intr_frame':
>> net/bluetooth/hidp/core.c:612:24: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'unsigned char *' [-Wformat=]
     612 |                 BT_DBG("Unsupported protocol header 0x%02x", hdr);
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:401:21: note: in definition of macro 'pr_fmt'
     401 | #define pr_fmt(fmt) fmt
         |                     ^~~
   include/linux/dynamic_debug.h:259:9: note: in expansion of macro '__dynamic_func_call_cls'
     259 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:261:9: note: in expansion of macro '_dynamic_func_call_cls'
     261 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:280:9: note: in expansion of macro '_dynamic_func_call'
     280 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:635:9: note: in expansion of macro 'dynamic_pr_debug'
     635 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   include/net/bluetooth/bluetooth.h:287:33: note: in expansion of macro 'pr_debug'
     287 | #define BT_DBG(fmt, ...)        pr_debug(fmt "\n", ##__VA_ARGS__)
         |                                 ^~~~~~~~
   net/bluetooth/hidp/core.c:612:17: note: in expansion of macro 'BT_DBG'
     612 |                 BT_DBG("Unsupported protocol header 0x%02x", hdr);
         |                 ^~~~~~
   net/bluetooth/hidp/core.c:612:58: note: format string is defined here
     612 |                 BT_DBG("Unsupported protocol header 0x%02x", hdr);
         |                                                       ~~~^
         |                                                          |
         |                                                          unsigned int
         |                                                       %02hhn


vim +612 net/bluetooth/hidp/core.c

^1da177e4c3f415 Linus Torvalds   2005-04-16  588  
91f5cca3d1b4341 Andrew Morton    2008-02-05  589  static void hidp_recv_intr_frame(struct hidp_session *session,
91f5cca3d1b4341 Andrew Morton    2008-02-05  590  				struct sk_buff *skb)
^1da177e4c3f415 Linus Torvalds   2005-04-16  591  {
afd2c613d3369fb jiale yao        2026-07-19  592  	unsigned char *hdr;
^1da177e4c3f415 Linus Torvalds   2005-04-16  593  
093dabb4f1aff98 Kai Ye           2021-06-03  594  	BT_DBG("session %p skb %p len %u", session, skb, skb->len);
^1da177e4c3f415 Linus Torvalds   2005-04-16  595  
afd2c613d3369fb jiale yao        2026-07-19  596  	hdr = skb_pull_data(skb, 1);
afd2c613d3369fb jiale yao        2026-07-19  597  	if (!hdr)
afd2c613d3369fb jiale yao        2026-07-19  598  		return;
^1da177e4c3f415 Linus Torvalds   2005-04-16  599  
afd2c613d3369fb jiale yao        2026-07-19  600  	if (*hdr == (HIDP_TRANS_DATA | HIDP_DATA_RTYPE_INPUT)) {
^1da177e4c3f415 Linus Torvalds   2005-04-16  601  		hidp_set_timer(session);
e1aaadd4d8162a2 Marcel Holtmann  2007-02-17  602  
^1da177e4c3f415 Linus Torvalds   2005-04-16  603  		if (session->input)
^1da177e4c3f415 Linus Torvalds   2005-04-16  604  			hidp_input_report(session, skb);
e1aaadd4d8162a2 Marcel Holtmann  2007-02-17  605  
e1aaadd4d8162a2 Marcel Holtmann  2007-02-17  606  		if (session->hid) {
a4b1b5877b514b2 David Rheinsberg 2013-12-19  607  			hidp_process_report(session, HID_INPUT_REPORT,
a4b1b5877b514b2 David Rheinsberg 2013-12-19  608  					    skb->data, skb->len, 1);
e1aaadd4d8162a2 Marcel Holtmann  2007-02-17  609  			BT_DBG("report len %d", skb->len);
e1aaadd4d8162a2 Marcel Holtmann  2007-02-17  610  		}
^1da177e4c3f415 Linus Torvalds   2005-04-16  611  	} else {
^1da177e4c3f415 Linus Torvalds   2005-04-16 @612  		BT_DBG("Unsupported protocol header 0x%02x", hdr);
^1da177e4c3f415 Linus Torvalds   2005-04-16  613  	}
^1da177e4c3f415 Linus Torvalds   2005-04-16  614  
^1da177e4c3f415 Linus Torvalds   2005-04-16  615  	kfree_skb(skb);
^1da177e4c3f415 Linus Torvalds   2005-04-16  616  }
^1da177e4c3f415 Linus Torvalds   2005-04-16  617  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
