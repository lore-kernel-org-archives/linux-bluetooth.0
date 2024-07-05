Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0DF145B25;
	Fri,  5 Jul 2024 09:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720170717; cv=none; b=o2Sr9Zuq2h5C3SSZhlPdl4xA3TsRRFFWwXSTxex3nlnrOrkdQ7dYrqdxMFa84jxZp46XRt6h9iBq5llBSoXTHCRdaW0oxatcIANJ3wwCKILDnDUmF5NmIIBDk4mhXU+TuHGBl/nus4c6PlSPDimCeXNeqHy25ZQlxDI06g8mpdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720170717; c=relaxed/simple;
	bh=CnlF5E4a5lr4vVeUZDKo/2jjL1AfhYBBcKFIy4jthv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcF39dIFQsl6P1W1uZiQOq5VFQLxSttPR8284YDRwyhc6uwQjVablyCiFEZaaIXXKi+vwbho1iAnQTlFRLor+pS1VjR/ZZpvthRkf1jQuFmmYCVR5pmHEIHZ7bBau+5Y+p6Gks2wu5Lg7VaakcVViwA60+kJYKPivrvqtXE3PhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FQ7yZt1H; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FQ7yZt1H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720170715; x=1751706715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CnlF5E4a5lr4vVeUZDKo/2jjL1AfhYBBcKFIy4jthv8=;
  b=FQ7yZt1HR+5M32ayVk3wxrVUmnDuHYEtNmY8UFXu569GBPZhMvCu2hxM
   9CMep/oDPCjKrz1fCSH/FMMXf+euOGV3q5+q+tZfwbYioGxnpeLv+mmpQ
   WYS+2yZvNyMAkMNz9y0nJoky2z2oRArkcOCJTcekc66S1oFGpLS6UbWCQ
   VAclCg2OLe3a6dgda7DbZJ4UGGEzjSeus3cLAekBWkGEbf2w1tYgRYnDR
   ilLzJrRRwObQRtWidNWJ56Wn6b9K5hpPDu20Q8jic/gFZ3x5qcMh2OdM0
   wo6wNigi8Lvb4fAjTmsgNyyxvw6u1/F+QQ+GPQwfRTdQiy7AnROvwfc6e
   A==;
X-CSE-ConnectionGUID: yV7RRI7OSnqn+G9xcW+s5Q==
X-CSE-MsgGUID: J+eBi3/sRYS/Tsn16i6F/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="20362103"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="20362103"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 02:11:55 -0700
X-CSE-ConnectionGUID: MUT4jryPTyesu5F/VdEC4A==
X-CSE-MsgGUID: JQ705aqCRrSj5eeLcxr05g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="46937506"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 05 Jul 2024 02:11:52 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPeyr-000SAm-1J;
	Fri, 05 Jul 2024 09:11:49 +0000
Date: Fri, 5 Jul 2024 17:11:11 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Lu <chris.lu@mediatek.com>, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Von Dentz <luiz.dentz@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Sean Wang <sean.wang@mediatek.com>,
	Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-mediatek <linux-mediatek@lists.infradead.org>,
	Chris Lu <chris.lu@mediatek.com>
Subject: Re: [PATCH v7 8/8] Bluetooth: btusb: mediatek: add ISO data
 transmission functions
Message-ID: <202407051652.C743BIjp-lkp@intel.com>
References: <20240704060116.16600-9-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704060116.16600-9-chris.lu@mediatek.com>

Hi Chris,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth-next/master]
[also build test ERROR on next-20240703]
[cannot apply to bluetooth/master linus/master v6.10-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Lu/Bluetooth-btusb-mediatek-remove-the-unnecessary-goto-tag/20240705-043833
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20240704060116.16600-9-chris.lu%40mediatek.com
patch subject: [PATCH v7 8/8] Bluetooth: btusb: mediatek: add ISO data transmission functions
config: i386-buildonly-randconfig-001-20240705 (https://download.01.org/0day-ci/archive/20240705/202407051652.C743BIjp-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240705/202407051652.C743BIjp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407051652.C743BIjp-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_recv_acl':
   btmtk.c:(.text+0x749): undefined reference to `usb_disable_autosuspend'
   ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_submit_wmt_recv_urb':
   btmtk.c:(.text+0x789): undefined reference to `usb_alloc_urb'
   ld: btmtk.c:(.text+0x81d): undefined reference to `usb_anchor_urb'
   ld: btmtk.c:(.text+0x829): undefined reference to `usb_submit_urb'
   ld: btmtk.c:(.text+0x836): undefined reference to `usb_free_urb'
   ld: btmtk.c:(.text+0x880): undefined reference to `usb_unanchor_urb'
   ld: btmtk.c:(.text+0x889): undefined reference to `usb_free_urb'
   ld: btmtk.c:(.text+0x89e): undefined reference to `usb_free_urb'
   ld: drivers/bluetooth/btmtk.o: in function `btmtk_submit_intr_urb':
   btmtk.c:(.text+0x8db): undefined reference to `usb_alloc_urb'
   ld: btmtk.c:(.text+0x991): undefined reference to `usb_anchor_urb'
   ld: btmtk.c:(.text+0x99a): undefined reference to `usb_submit_urb'
   ld: btmtk.c:(.text+0x9a7): undefined reference to `usb_free_urb'
   ld: btmtk.c:(.text+0xa18): undefined reference to `usb_unanchor_urb'
   ld: btmtk.c:(.text+0xa28): undefined reference to `usb_free_urb'
   ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_suspend':
   btmtk.c:(.text+0xa92): undefined reference to `usb_kill_anchored_urbs'
   ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_hci_wmt_sync':
   btmtk.c:(.text+0xb15): undefined reference to `usb_autopm_get_interface'
   ld: btmtk.c:(.text+0xb51): undefined reference to `usb_autopm_put_interface'
   ld: btmtk.c:(.text+0xc0f): undefined reference to `usb_autopm_put_interface'
   ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_isointf_init.constprop.0':
   btmtk.c:(.text+0xefc): undefined reference to `usb_set_interface'
>> ld: btmtk.c:(.text+0x1063): undefined reference to `usb_kill_anchored_urbs'
   ld: drivers/bluetooth/btmtk.o: in function `alloc_mtk_intr_urb':
   btmtk.c:(.text+0x113c): undefined reference to `usb_alloc_urb'
   ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_wmt_recv':
   btmtk.c:(.text+0x12bb): undefined reference to `usb_anchor_urb'
   ld: btmtk.c:(.text+0x12c7): undefined reference to `usb_submit_urb'
   ld: btmtk.c:(.text+0x13e6): undefined reference to `usb_unanchor_urb'
   ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_reg_read':
   btmtk.c:(.text+0x14cb): undefined reference to `usb_control_msg'
   ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_uhw_reg_write':
   btmtk.c:(.text+0x1559): undefined reference to `usb_control_msg'
   ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_uhw_reg_read':
   btmtk.c:(.text+0x1609): undefined reference to `usb_control_msg'
   ld: drivers/bluetooth/btmtk.o: in function `btmtk_intr_complete':
   btmtk.c:(.text+0x170f): undefined reference to `usb_anchor_urb'
   ld: btmtk.c:(.text+0x171b): undefined reference to `usb_submit_urb'
   ld: btmtk.c:(.text+0x1779): undefined reference to `usb_unanchor_urb'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
