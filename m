Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055F32586C5;
	Thu, 29 May 2025 23:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748562615; cv=none; b=WpFmzqITp3aTCW3QxOit4J1r7067kFLWvlKOzzw7AdPJKloF+3PXOfsop82Wnhzn8jSKiy3mP69p0yV3LZhW7EyiQ+crREiBK3VkKSsOfA2c3mC8F7hi5hdgm8r90uzaZMNxqvSmsVwJjNxBJbDHWs4S3vxDUTI1rFJiR6hCif8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748562615; c=relaxed/simple;
	bh=3fHCqpJzOQ+faj5dcuseeWJ7RAmHY34XO4V4FBCxvYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TutLcZHupsTdBLdjX7Js/HlKP8GwxeZVf8xTwVbICPa8VB3Fn8jkytOrRdDxstObSCly1F6kzhKemofX2ZnCAcyegHiIV1JUmOo90oCaLckzPUUdnBDeUAjYiKe+bZBnweZGzl2PhwW30slQf0uTmPwhWrkzfn2ztNdLPpPS+8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WTqhqfA0; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WTqhqfA0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748562614; x=1780098614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3fHCqpJzOQ+faj5dcuseeWJ7RAmHY34XO4V4FBCxvYg=;
  b=WTqhqfA0U/V08pMrip8bpbX9GJLbEeaN7SU8olAQn+bv9/EtHNhY1MCt
   AwfGvE7TvetwstAaZhwtDDe36b0hyuW0vvdRo2+lF8vhRIjRkQbk/xT0w
   tVoEPVI3yQvPLhjW7H5O4XdCOeXWuRM8dXLInfysW62bJenE6lv4tz72P
   msXG9x2mnG09GXv2VRXGsG4siW1yI8ubQ2ukdtJRzUdKqhTiW12SkaoVq
   7wi2/XPE4qPeqevvDWUM/Uot8S4wWNUL+2A8FUVoFGfwWbypZcBarVp5s
   l0foIJNZjuaN8xaPAarsiDy3JL+hX5xheSva0E2B4SnH91lf3wTySRD1T
   g==;
X-CSE-ConnectionGUID: tZASSIo1STyd9MS8JhSEdw==
X-CSE-MsgGUID: LAaaFLxbSyaVbqU9XtdLZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="54311377"
X-IronPort-AV: E=Sophos;i="6.16,194,1744095600"; 
   d="scan'208";a="54311377"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 16:50:13 -0700
X-CSE-ConnectionGUID: d1o50jMVSfqcz2ZWzD/YTA==
X-CSE-MsgGUID: RJ8nT1nTRmaoGoo97sRlfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,194,1744095600"; 
   d="scan'208";a="143694823"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 29 May 2025 16:50:11 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKn0i-000XC8-30;
	Thu, 29 May 2025 23:50:08 +0000
Date: Fri, 30 May 2025 07:49:40 +0800
From: kernel test robot <lkp@intel.com>
To: Hilda Wu <hildawu@realtek.com>, marcel@holtmann.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, max.chou@realtek.com,
	alex_lu@realsil.com.cn
Subject: Re: [PATCH 1/2] Bluetooth: btrtl: Firmware format v3 support
Message-ID: <202505300705.KsxzVLt6-lkp@intel.com>
References: <20250529124816.4186320-2-hildawu@realtek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529124816.4186320-2-hildawu@realtek.com>

Hi Hilda,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth/master]
[also build test ERROR on bluetooth-next/master linus/master v6.15 next-20250529]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hilda-Wu/Bluetooth-btrtl-Firmware-format-v3-support/20250529-205020
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/20250529124816.4186320-2-hildawu%40realtek.com
patch subject: [PATCH 1/2] Bluetooth: btrtl: Firmware format v3 support
config: arm-randconfig-004-20250530 (https://download.01.org/0day-ci/archive/20250530/202505300705.KsxzVLt6-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250530/202505300705.KsxzVLt6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505300705.KsxzVLt6-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/bluetooth/btusb.c:2707:10: error: call to undeclared function 'btrtl_recv_event'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2707 |                 return btrtl_recv_event(hdev, skb);
         |                        ^
   1 error generated.


vim +/btrtl_recv_event +2707 drivers/bluetooth/btusb.c

  2689	
  2690	static int btusb_recv_event_realtek(struct hci_dev *hdev, struct sk_buff *skb)
  2691	{
  2692		if (skb->data[0] == HCI_VENDOR_PKT && skb->data[2] == RTK_SUB_EVENT_CODE_COREDUMP) {
  2693			struct rtk_dev_coredump_hdr hdr = {
  2694				.code = RTK_DEVCOREDUMP_CODE_MEMDUMP,
  2695			};
  2696	
  2697			bt_dev_dbg(hdev, "RTL: received coredump vendor evt, len %u",
  2698				skb->len);
  2699	
  2700			btusb_rtl_alloc_devcoredump(hdev, &hdr, skb->data, skb->len);
  2701			kfree_skb(skb);
  2702	
  2703			return 0;
  2704		}
  2705	
  2706		if (skb->data[0] == HCI_VENDOR_PKT)
> 2707			return btrtl_recv_event(hdev, skb);
  2708	
  2709		return hci_recv_frame(hdev, skb);
  2710	}
  2711	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
