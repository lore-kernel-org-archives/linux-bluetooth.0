Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0FF1DCB24;
	Sun, 16 Aug 2026 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786846829; cv=none; b=jzjdDRFj4mBs2n5bKfT71p0PeKQgVpBdPoWMxVIwGf+QiDRz3QqCh0yyJsLHUAYoQ0khFyyjPOU+AHe2wqmHkGDRVNwb6QsuaeUbM4E3QLXb7aS0jwnxU2nyHrEuLWYMd57/FpE+Y8OgEIBSMI8nzjqLuueoilfUWbznv/tRsM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786846829; c=relaxed/simple;
	bh=KJTG9L+tk857BpYI7xBnnnkPB2xo4z0xes4+gjxkJQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZADrnVuSLE3fGATTpnEDq1hslgDrxIB5YAeQzZRWRns+Ab9I/DfhLztl2M6B439HsR4p5qOLMWCDIrTu7lB5C0VEHC+phj/be5zogRHIJjtTyh2ydY28MqYEeHXhxb67BNHcjPviYV09JXPSDe/BTVeTgRAo7AnzIiTZlAOkORo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OqBtbPG2; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OqBtbPG2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786846827; x=1818382827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KJTG9L+tk857BpYI7xBnnnkPB2xo4z0xes4+gjxkJQs=;
  b=OqBtbPG2rDlefOjZxtjq5g82o9RDhI9ilA5lBDnaBrEk8f8KY/GMBdrJ
   bJszSBUAr7auHf4V0P2Tn5RwsvmFNz3HQr9uqWqKZ24vIws7Qey/RfFNE
   cSGnWPB/Ubkf9mObxUk9OfX0Q97I+ppTrAif+QACT4IbDwKgmkEbASe4v
   wMl03A4ueNRQt5I2CjN/iWPc4hK9r/wbYSFSqeD18PIbSgU2VkcgPRmQP
   zdURHf4AshhbZGZc+xihwAHFwNeoFHFxNGJq8ljZnDKXjoKu58Lt4eX8F
   nVZ348hr616DLzkktAm8qyjCJ5QI9uLhEQ9RajhTYj+GeijtqfbMs+8XS
   w==;
X-CSE-ConnectionGUID: JuzK325tT3+AIU6ToNSmpQ==
X-CSE-MsgGUID: hTdwBJmwQjWyWXitZ2rCDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11876"; a="98884985"
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; 
   d="scan'208";a="98884985"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 19:20:27 -0700
X-CSE-ConnectionGUID: Iq57Tr41ROCieqfncajFHA==
X-CSE-MsgGUID: sXEnOhsGSsalsajF1PEG0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; 
   d="scan'208";a="262800964"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 15 Aug 2026 19:20:24 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wvQU1-00000000cfq-34EJ;
	Sun, 16 Aug 2026 02:20:21 +0000
Date: Sun, 16 Aug 2026 10:19:52 +0800
From: kernel test robot <lkp@intel.com>
To: jiale yao <19888972804@163.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Marcel Holtmann <marcel@holtmann.org>, Tim Bird <tim.bird@sony.com>,
	Muhammad Bilal <meatuni001@gmail.com>, Kees Cook <kees@kernel.org>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re:Re: [PATCH v2] Bluetooth: HIDP: add missing length check for
 incoming frames
Message-ID: <202608161044.9x6CmhDO-lkp@intel.com>
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
[cannot apply to bluetooth-next/master bluetooth/master linus/master v7.2-rc7 next-20260814]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/jiale-yao/Re-Re-PATCH-v2-Bluetooth-HIDP-add-missing-length-check-for-incoming-frames/20260814-100503
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
patch link:    https://lore.kernel.org/r/220b6be5.d3f.19f78e165aa.Coremail.19888972804%40163.com
patch subject: Re:Re: [PATCH v2] Bluetooth: HIDP: add missing length check for incoming frames
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20260816/202608161044.9x6CmhDO-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 844a18e753e822736c9805ab779144b647a2c186)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260816/202608161044.9x6CmhDO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608161044.9x6CmhDO-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/bluetooth/hidp/core.c:612:48: warning: format specifies type 'unsigned int' but the argument has type 'unsigned char *' [-Wformat]
     612 |                 BT_DBG("Unsupported protocol header 0x%02x", hdr);
         |                                                       ~~~~   ^~~
         |                                                       %2s
   include/net/bluetooth/bluetooth.h:287:47: note: expanded from macro 'BT_DBG'
     287 | #define BT_DBG(fmt, ...)        pr_debug(fmt "\n", ##__VA_ARGS__)
         |                                          ~~~         ^~~~~~~~~~~
   include/linux/printk.h:641:38: note: expanded from macro 'pr_debug'
     641 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |                                     ~~~     ^~~~~~~~~~~
   include/linux/printk.h:134:18: note: expanded from macro 'no_printk'
     134 |                 _printk(fmt, ##__VA_ARGS__);            \
         |                         ~~~    ^~~~~~~~~~~
   1 warning generated.


vim +612 net/bluetooth/hidp/core.c

^1da177e4c3f41 Linus Torvalds   2005-04-16  588  
91f5cca3d1b434 Andrew Morton    2008-02-05  589  static void hidp_recv_intr_frame(struct hidp_session *session,
91f5cca3d1b434 Andrew Morton    2008-02-05  590  				struct sk_buff *skb)
^1da177e4c3f41 Linus Torvalds   2005-04-16  591  {
afd2c613d3369f jiale yao        2026-07-19  592  	unsigned char *hdr;
^1da177e4c3f41 Linus Torvalds   2005-04-16  593  
093dabb4f1aff9 Kai Ye           2021-06-03  594  	BT_DBG("session %p skb %p len %u", session, skb, skb->len);
^1da177e4c3f41 Linus Torvalds   2005-04-16  595  
afd2c613d3369f jiale yao        2026-07-19  596  	hdr = skb_pull_data(skb, 1);
afd2c613d3369f jiale yao        2026-07-19  597  	if (!hdr)
afd2c613d3369f jiale yao        2026-07-19  598  		return;
^1da177e4c3f41 Linus Torvalds   2005-04-16  599  
afd2c613d3369f jiale yao        2026-07-19  600  	if (*hdr == (HIDP_TRANS_DATA | HIDP_DATA_RTYPE_INPUT)) {
^1da177e4c3f41 Linus Torvalds   2005-04-16  601  		hidp_set_timer(session);
e1aaadd4d8162a Marcel Holtmann  2007-02-17  602  
^1da177e4c3f41 Linus Torvalds   2005-04-16  603  		if (session->input)
^1da177e4c3f41 Linus Torvalds   2005-04-16  604  			hidp_input_report(session, skb);
e1aaadd4d8162a Marcel Holtmann  2007-02-17  605  
e1aaadd4d8162a Marcel Holtmann  2007-02-17  606  		if (session->hid) {
a4b1b5877b514b David Rheinsberg 2013-12-19  607  			hidp_process_report(session, HID_INPUT_REPORT,
a4b1b5877b514b David Rheinsberg 2013-12-19  608  					    skb->data, skb->len, 1);
e1aaadd4d8162a Marcel Holtmann  2007-02-17  609  			BT_DBG("report len %d", skb->len);
e1aaadd4d8162a Marcel Holtmann  2007-02-17  610  		}
^1da177e4c3f41 Linus Torvalds   2005-04-16  611  	} else {
^1da177e4c3f41 Linus Torvalds   2005-04-16 @612  		BT_DBG("Unsupported protocol header 0x%02x", hdr);
^1da177e4c3f41 Linus Torvalds   2005-04-16  613  	}
^1da177e4c3f41 Linus Torvalds   2005-04-16  614  
^1da177e4c3f41 Linus Torvalds   2005-04-16  615  	kfree_skb(skb);
^1da177e4c3f41 Linus Torvalds   2005-04-16  616  }
^1da177e4c3f41 Linus Torvalds   2005-04-16  617  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
