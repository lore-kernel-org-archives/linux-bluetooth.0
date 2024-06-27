Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933D7199EA1;
	Thu, 27 Jun 2024 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719507375; cv=none; b=dWRx3VR6F/IUY0i8aeLyoy1sDd/vEIdIc7YbSBxwfYPDWA9kW8xwQhWQZ9JlDuiIEd2ymTTRgXm3bX8pfwGK+a7NFykSIYWwu/GLqC0Iwwok+z5oE6rezvnv50EkTY0NGonW7pnvWooMdjguQKzlWTf1ZVPZgR22alENXbnh76Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719507375; c=relaxed/simple;
	bh=tXnUP+Q4ipMZHMdFaly9rDmGwdmTVd9/H6CA/PJ6e9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsUQAo2t+V+dJ+Q5lPq4QYJ7EEKEDj6mDnvsIGCdN+E4LaRaawj+Dx7J7wKpY/M3K3NnKtVYBG76Dr3K6/b6eXuz4faxXmzwcDowspMzqdlH6TmQY+WJ6qmlT6b/EEzBC0iHlsBWFNvSupS73biczZBy89W94nsoqmTaoEMj6yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mrSchKrs; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mrSchKrs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719507374; x=1751043374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tXnUP+Q4ipMZHMdFaly9rDmGwdmTVd9/H6CA/PJ6e9g=;
  b=mrSchKrshCwg0tvfnXSiLQrW+w0X5whGQDwyswMKSkfp2QD8RmQ7UqbB
   86AHxZyrh9UKFipL/Z3je6Hy7X/XZSz4quKAq13o/iqcPZFg2S6+ORLrP
   fRyURy5VH6IjMyEWR9du06xMb7Shl5bE9mmyLP5MBz4lRam4osMPXFLU2
   L40ZHYvB0INs3mx7WNg2dqtxgb1V9vLtNrwXgOJ9szHSodK1n1TGiztqL
   +fMEs1lDPLtnn/BAdXBdmwHrs4IoPdRb615nA428Lot6ZhR3I4nQc9Cb5
   zJdmMsujT0TYpOW4Iq4azXu5sBN0pLolJWulNU4V0U2OOqDRiKTPls5Pj
   g==;
X-CSE-ConnectionGUID: AIPFVc2LSqSYKSt/uo6WkA==
X-CSE-MsgGUID: YP9FTKJlTruLykeNJ9cgbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="12286788"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="12286788"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 09:56:13 -0700
X-CSE-ConnectionGUID: bsmEuNJtTamAJkDBSbSqeA==
X-CSE-MsgGUID: dLAGV4qcSZK0xnMWNIgGbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="45202273"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 27 Jun 2024 09:56:10 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMsPn-000GMk-1E;
	Thu, 27 Jun 2024 16:56:07 +0000
Date: Fri, 28 Jun 2024 00:55:54 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Lu <chris.lu@mediatek.com>, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Von Dentz <luiz.dentz@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Sean Wang <sean.wang@mediatek.com>,
	Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-mediatek <linux-mediatek@lists.infradead.org>,
	Chris Lu <chris.lu@mediatek.com>
Subject: Re: [PATCH v5 8/8] Bluetooth: btusb: mediatek: add ISO data
 transmission functions
Message-ID: <202406280003.brf5D1qt-lkp@intel.com>
References: <20240626025329.26424-9-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626025329.26424-9-chris.lu@mediatek.com>

Hi Chris,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth-next/master]
[also build test ERROR on next-20240626]
[cannot apply to bluetooth/master linus/master v6.10-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Lu/Bluetooth-btusb-mediatek-remove-the-unnecessary-goto-tag/20240626-114003
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20240626025329.26424-9-chris.lu%40mediatek.com
patch subject: [PATCH v5 8/8] Bluetooth: btusb: mediatek: add ISO data transmission functions
config: i386-buildonly-randconfig-003-20240627 (https://download.01.org/0day-ci/archive/20240628/202406280003.brf5D1qt-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240628/202406280003.brf5D1qt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406280003.brf5D1qt-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/bluetooth/btusb.c:28:
>> drivers/bluetooth/btmtk.h:274:17: error: incompatible integer to pointer conversion passing 'int' to parameter of type 'const void *' [-Wint-conversion]
     274 |         return PTR_ERR(-EOPNOTSUPP);
         |                        ^~~~~~~~~~~
   include/linux/err.h:49:61: note: passing argument to parameter 'ptr' here
      49 | static inline long __must_check PTR_ERR(__force const void *ptr)
         |                                                             ^
   In file included from drivers/bluetooth/btusb.c:28:
>> drivers/bluetooth/btmtk.h:274:9: error: incompatible integer to pointer conversion returning 'long' from a function with result type 'struct urb *' [-Wint-conversion]
     274 |         return PTR_ERR(-EOPNOTSUPP);
         |                ^~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +274 drivers/bluetooth/btmtk.h

   270	
   271	static struct urb *alloc_mtk_intr_urb(struct hci_dev *hdev, struct sk_buff *skb,
   272					      usb_complete_t tx_complete)
   273	{
 > 274		return PTR_ERR(-EOPNOTSUPP);
   275	}
   276	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
