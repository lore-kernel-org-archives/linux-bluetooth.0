Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473CB1991BD;
	Fri,  8 Nov 2024 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731084918; cv=none; b=GYUr/Te5x0kN4FZHW4bt0l7fB8uK34ypHyHea4Q06TiMr3YvbWVsLAiuNE/wi4C0xKyVi0OQ7hR8zQlgVbwHJttsISUnATflTacjQmhNizhsirPE6UpiWkSmj7BE1jYErBLpfbuqntJdIKHSqpxneSJGr7rgwbmDowIef3qDZSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731084918; c=relaxed/simple;
	bh=yDGibwZd8NUsG9TSW9LVB1DialBc85Qgux+fEkmxHPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rM+f3S8tl7iyPC3bCe/x4LHAalbp0uBLDo3NH67tLXc9fKFu3wESHUW9hBfHLKbyVk5qC962VS2Y6umVrAYh+QWiYRr4IwcJemmd9ijvfLlj3LylHdlY7c158CjVqapSao+El0lhy4Jb63nre26yPeWAOu1i87AZ1W+mkUyPvZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lSczsqL+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lSczsqL+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731084916; x=1762620916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yDGibwZd8NUsG9TSW9LVB1DialBc85Qgux+fEkmxHPI=;
  b=lSczsqL+bLczkPxQ+kZpOTXJh+hUIBVrcsEDwoR5fi+N+MBNvX2uNtTu
   9+W4cxeRrD3nVxpa0vl1eySZt/ELHXucDp4FR1bTVzSe62x/5eSaxjoHB
   8UDVLFkYbElBQ7L/sJlGGakZc/9T/YK6TDa5zpxzj15+MFajs2KlLXD1v
   esp4gvRr75ar59+EqjZ9vMprhKmfxs5BHRR44XQAW1P/SU92orETBuI8p
   8N+QTtNRuyUgPurQd7RoJ0aT7fBpWhUdlaupB9D7vpmnRxX3jJsGW4KLo
   ejKaKeytk3oj7SyqCLRmrqOuBq+vjHOw19wJ7+dt+BdNy04g2Vh+Z0CQO
   Q==;
X-CSE-ConnectionGUID: pB/FBPGOQseVDX5bm4FMNw==
X-CSE-MsgGUID: 1m1+4Nk1T0mehO0xc2nKiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="31076724"
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="31076724"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 08:55:16 -0800
X-CSE-ConnectionGUID: 2s+XMJX6R+i4Eoyc9eeVtw==
X-CSE-MsgGUID: jJ1US8FUTL2U01oOJy8Jww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="90256268"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 08 Nov 2024 08:55:12 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9SGL-000rco-2n;
	Fri, 08 Nov 2024 16:55:09 +0000
Date: Sat, 9 Nov 2024 00:54:46 +0800
From: kernel test robot <lkp@intel.com>
To: WangYuli <wangyuli@uniontech.com>, marcel@holtmann.org,
	luiz.dentz@gmail.com, johan.hedberg@gmail.com,
	matthias.bgg@gmail.com, hello@felixjara.me
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, guanwentao@uniontech.com,
	zhanjun@uniontech.com, aaron.ma@canonical.com
Subject: Re: [PATCH v3] Bluetooth: btusb: Add MT7925 support for ID
 0x13d3:0x3608
Message-ID: <202411090003.bXXzsmNP-lkp@intel.com>
References: <D3E1285F7DBFAB3E+20241108082418.187499-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D3E1285F7DBFAB3E+20241108082418.187499-1-wangyuli@uniontech.com>

Hi WangYuli,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth/master]
[also build test ERROR on bluetooth-next/master linus/master v6.12-rc6 next-20241108]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/WangYuli/Bluetooth-btusb-Add-MT7925-support-for-ID-0x13d3-0x3608/20241108-162754
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/D3E1285F7DBFAB3E%2B20241108082418.187499-1-wangyuli%40uniontech.com
patch subject: [PATCH v3] Bluetooth: btusb: Add MT7925 support for ID 0x13d3:0x3608
config: x86_64-buildonly-randconfig-002-20241108 (https://download.01.org/0day-ci/archive/20241109/202411090003.bXXzsmNP-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241109/202411090003.bXXzsmNP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411090003.bXXzsmNP-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/bluetooth/btusb.c:17:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/bluetooth/btusb.c:651:12: error: use of undeclared identifier 'BTUSB_VALID_LE_STATES'
     651 |                                                      BTUSB_VALID_LE_STATES },
         |                                                      ^
   1 warning and 1 error generated.


vim +/BTUSB_VALID_LE_STATES +651 drivers/bluetooth/btusb.c

   177	
   178	static const struct usb_device_id quirks_table[] = {
   179		/* CSR BlueCore devices */
   180		{ USB_DEVICE(0x0a12, 0x0001), .driver_info = BTUSB_CSR },
   181	
   182		/* Broadcom BCM2033 without firmware */
   183		{ USB_DEVICE(0x0a5c, 0x2033), .driver_info = BTUSB_IGNORE },
   184	
   185		/* Broadcom BCM2045 devices */
   186		{ USB_DEVICE(0x0a5c, 0x2045), .driver_info = BTUSB_BCM2045 },
   187	
   188		/* Atheros 3011 with sflash firmware */
   189		{ USB_DEVICE(0x0489, 0xe027), .driver_info = BTUSB_IGNORE },
   190		{ USB_DEVICE(0x0489, 0xe03d), .driver_info = BTUSB_IGNORE },
   191		{ USB_DEVICE(0x04f2, 0xaff1), .driver_info = BTUSB_IGNORE },
   192		{ USB_DEVICE(0x0930, 0x0215), .driver_info = BTUSB_IGNORE },
   193		{ USB_DEVICE(0x0cf3, 0x3002), .driver_info = BTUSB_IGNORE },
   194		{ USB_DEVICE(0x0cf3, 0xe019), .driver_info = BTUSB_IGNORE },
   195		{ USB_DEVICE(0x13d3, 0x3304), .driver_info = BTUSB_IGNORE },
   196	
   197		/* Atheros AR9285 Malbec with sflash firmware */
   198		{ USB_DEVICE(0x03f0, 0x311d), .driver_info = BTUSB_IGNORE },
   199	
   200		/* Atheros 3012 with sflash firmware */
   201		{ USB_DEVICE(0x0489, 0xe04d), .driver_info = BTUSB_ATH3012 },
   202		{ USB_DEVICE(0x0489, 0xe04e), .driver_info = BTUSB_ATH3012 },
   203		{ USB_DEVICE(0x0489, 0xe056), .driver_info = BTUSB_ATH3012 },
   204		{ USB_DEVICE(0x0489, 0xe057), .driver_info = BTUSB_ATH3012 },
   205		{ USB_DEVICE(0x0489, 0xe05f), .driver_info = BTUSB_ATH3012 },
   206		{ USB_DEVICE(0x0489, 0xe076), .driver_info = BTUSB_ATH3012 },
   207		{ USB_DEVICE(0x0489, 0xe078), .driver_info = BTUSB_ATH3012 },
   208		{ USB_DEVICE(0x0489, 0xe095), .driver_info = BTUSB_ATH3012 },
   209		{ USB_DEVICE(0x04c5, 0x1330), .driver_info = BTUSB_ATH3012 },
   210		{ USB_DEVICE(0x04ca, 0x3004), .driver_info = BTUSB_ATH3012 },
   211		{ USB_DEVICE(0x04ca, 0x3005), .driver_info = BTUSB_ATH3012 },
   212		{ USB_DEVICE(0x04ca, 0x3006), .driver_info = BTUSB_ATH3012 },
   213		{ USB_DEVICE(0x04ca, 0x3007), .driver_info = BTUSB_ATH3012 },
   214		{ USB_DEVICE(0x04ca, 0x3008), .driver_info = BTUSB_ATH3012 },
   215		{ USB_DEVICE(0x04ca, 0x300b), .driver_info = BTUSB_ATH3012 },
   216		{ USB_DEVICE(0x04ca, 0x300d), .driver_info = BTUSB_ATH3012 },
   217		{ USB_DEVICE(0x04ca, 0x300f), .driver_info = BTUSB_ATH3012 },
   218		{ USB_DEVICE(0x04ca, 0x3010), .driver_info = BTUSB_ATH3012 },
   219		{ USB_DEVICE(0x04ca, 0x3014), .driver_info = BTUSB_ATH3012 },
   220		{ USB_DEVICE(0x04ca, 0x3018), .driver_info = BTUSB_ATH3012 },
   221		{ USB_DEVICE(0x0930, 0x0219), .driver_info = BTUSB_ATH3012 },
   222		{ USB_DEVICE(0x0930, 0x021c), .driver_info = BTUSB_ATH3012 },
   223		{ USB_DEVICE(0x0930, 0x0220), .driver_info = BTUSB_ATH3012 },
   224		{ USB_DEVICE(0x0930, 0x0227), .driver_info = BTUSB_ATH3012 },
   225		{ USB_DEVICE(0x0b05, 0x17d0), .driver_info = BTUSB_ATH3012 },
   226		{ USB_DEVICE(0x0cf3, 0x0036), .driver_info = BTUSB_ATH3012 },
   227		{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
   228		{ USB_DEVICE(0x0cf3, 0x3008), .driver_info = BTUSB_ATH3012 },
   229		{ USB_DEVICE(0x0cf3, 0x311d), .driver_info = BTUSB_ATH3012 },
   230		{ USB_DEVICE(0x0cf3, 0x311e), .driver_info = BTUSB_ATH3012 },
   231		{ USB_DEVICE(0x0cf3, 0x311f), .driver_info = BTUSB_ATH3012 },
   232		{ USB_DEVICE(0x0cf3, 0x3121), .driver_info = BTUSB_ATH3012 },
   233		{ USB_DEVICE(0x0cf3, 0x817a), .driver_info = BTUSB_ATH3012 },
   234		{ USB_DEVICE(0x0cf3, 0x817b), .driver_info = BTUSB_ATH3012 },
   235		{ USB_DEVICE(0x0cf3, 0xe003), .driver_info = BTUSB_ATH3012 },
   236		{ USB_DEVICE(0x0cf3, 0xe004), .driver_info = BTUSB_ATH3012 },
   237		{ USB_DEVICE(0x0cf3, 0xe005), .driver_info = BTUSB_ATH3012 },
   238		{ USB_DEVICE(0x0cf3, 0xe006), .driver_info = BTUSB_ATH3012 },
   239		{ USB_DEVICE(0x13d3, 0x3362), .driver_info = BTUSB_ATH3012 },
   240		{ USB_DEVICE(0x13d3, 0x3375), .driver_info = BTUSB_ATH3012 },
   241		{ USB_DEVICE(0x13d3, 0x3393), .driver_info = BTUSB_ATH3012 },
   242		{ USB_DEVICE(0x13d3, 0x3395), .driver_info = BTUSB_ATH3012 },
   243		{ USB_DEVICE(0x13d3, 0x3402), .driver_info = BTUSB_ATH3012 },
   244		{ USB_DEVICE(0x13d3, 0x3408), .driver_info = BTUSB_ATH3012 },
   245		{ USB_DEVICE(0x13d3, 0x3423), .driver_info = BTUSB_ATH3012 },
   246		{ USB_DEVICE(0x13d3, 0x3432), .driver_info = BTUSB_ATH3012 },
   247		{ USB_DEVICE(0x13d3, 0x3472), .driver_info = BTUSB_ATH3012 },
   248		{ USB_DEVICE(0x13d3, 0x3474), .driver_info = BTUSB_ATH3012 },
   249		{ USB_DEVICE(0x13d3, 0x3487), .driver_info = BTUSB_ATH3012 },
   250		{ USB_DEVICE(0x13d3, 0x3490), .driver_info = BTUSB_ATH3012 },
   251	
   252		/* Atheros AR5BBU12 with sflash firmware */
   253		{ USB_DEVICE(0x0489, 0xe02c), .driver_info = BTUSB_IGNORE },
   254	
   255		/* Atheros AR5BBU12 with sflash firmware */
   256		{ USB_DEVICE(0x0489, 0xe036), .driver_info = BTUSB_ATH3012 },
   257		{ USB_DEVICE(0x0489, 0xe03c), .driver_info = BTUSB_ATH3012 },
   258	
   259		/* QCA ROME chipset */
   260		{ USB_DEVICE(0x0cf3, 0x535b), .driver_info = BTUSB_QCA_ROME |
   261							     BTUSB_WIDEBAND_SPEECH },
   262		{ USB_DEVICE(0x0cf3, 0xe007), .driver_info = BTUSB_QCA_ROME |
   263							     BTUSB_WIDEBAND_SPEECH },
   264		{ USB_DEVICE(0x0cf3, 0xe009), .driver_info = BTUSB_QCA_ROME |
   265							     BTUSB_WIDEBAND_SPEECH },
   266		{ USB_DEVICE(0x0cf3, 0xe010), .driver_info = BTUSB_QCA_ROME |
   267							     BTUSB_WIDEBAND_SPEECH },
   268		{ USB_DEVICE(0x0cf3, 0xe300), .driver_info = BTUSB_QCA_ROME |
   269							     BTUSB_WIDEBAND_SPEECH },
   270		{ USB_DEVICE(0x0cf3, 0xe301), .driver_info = BTUSB_QCA_ROME |
   271							     BTUSB_WIDEBAND_SPEECH },
   272		{ USB_DEVICE(0x0cf3, 0xe360), .driver_info = BTUSB_QCA_ROME |
   273							     BTUSB_WIDEBAND_SPEECH },
   274		{ USB_DEVICE(0x0cf3, 0xe500), .driver_info = BTUSB_QCA_ROME |
   275							     BTUSB_WIDEBAND_SPEECH },
   276		{ USB_DEVICE(0x0489, 0xe092), .driver_info = BTUSB_QCA_ROME |
   277							     BTUSB_WIDEBAND_SPEECH },
   278		{ USB_DEVICE(0x0489, 0xe09f), .driver_info = BTUSB_QCA_ROME |
   279							     BTUSB_WIDEBAND_SPEECH },
   280		{ USB_DEVICE(0x0489, 0xe0a2), .driver_info = BTUSB_QCA_ROME |
   281							     BTUSB_WIDEBAND_SPEECH },
   282		{ USB_DEVICE(0x04ca, 0x3011), .driver_info = BTUSB_QCA_ROME |
   283							     BTUSB_WIDEBAND_SPEECH },
   284		{ USB_DEVICE(0x04ca, 0x3015), .driver_info = BTUSB_QCA_ROME |
   285							     BTUSB_WIDEBAND_SPEECH },
   286		{ USB_DEVICE(0x04ca, 0x3016), .driver_info = BTUSB_QCA_ROME |
   287							     BTUSB_WIDEBAND_SPEECH },
   288		{ USB_DEVICE(0x04ca, 0x301a), .driver_info = BTUSB_QCA_ROME |
   289							     BTUSB_WIDEBAND_SPEECH },
   290		{ USB_DEVICE(0x04ca, 0x3021), .driver_info = BTUSB_QCA_ROME |
   291							     BTUSB_WIDEBAND_SPEECH },
   292		{ USB_DEVICE(0x13d3, 0x3491), .driver_info = BTUSB_QCA_ROME |
   293							     BTUSB_WIDEBAND_SPEECH },
   294		{ USB_DEVICE(0x13d3, 0x3496), .driver_info = BTUSB_QCA_ROME |
   295							     BTUSB_WIDEBAND_SPEECH },
   296		{ USB_DEVICE(0x13d3, 0x3501), .driver_info = BTUSB_QCA_ROME |
   297							     BTUSB_WIDEBAND_SPEECH },
   298	
   299		/* QCA WCN6855 chipset */
   300		{ USB_DEVICE(0x0cf3, 0xe600), .driver_info = BTUSB_QCA_WCN6855 |
   301							     BTUSB_WIDEBAND_SPEECH },
   302		{ USB_DEVICE(0x0489, 0xe0cc), .driver_info = BTUSB_QCA_WCN6855 |
   303							     BTUSB_WIDEBAND_SPEECH },
   304		{ USB_DEVICE(0x0489, 0xe0d6), .driver_info = BTUSB_QCA_WCN6855 |
   305							     BTUSB_WIDEBAND_SPEECH },
   306		{ USB_DEVICE(0x0489, 0xe0e3), .driver_info = BTUSB_QCA_WCN6855 |
   307							     BTUSB_WIDEBAND_SPEECH },
   308		{ USB_DEVICE(0x10ab, 0x9309), .driver_info = BTUSB_QCA_WCN6855 |
   309							     BTUSB_WIDEBAND_SPEECH },
   310		{ USB_DEVICE(0x10ab, 0x9409), .driver_info = BTUSB_QCA_WCN6855 |
   311							     BTUSB_WIDEBAND_SPEECH },
   312		{ USB_DEVICE(0x0489, 0xe0d0), .driver_info = BTUSB_QCA_WCN6855 |
   313							     BTUSB_WIDEBAND_SPEECH },
   314		{ USB_DEVICE(0x10ab, 0x9108), .driver_info = BTUSB_QCA_WCN6855 |
   315							     BTUSB_WIDEBAND_SPEECH },
   316		{ USB_DEVICE(0x10ab, 0x9109), .driver_info = BTUSB_QCA_WCN6855 |
   317							     BTUSB_WIDEBAND_SPEECH },
   318		{ USB_DEVICE(0x10ab, 0x9208), .driver_info = BTUSB_QCA_WCN6855 |
   319							     BTUSB_WIDEBAND_SPEECH },
   320		{ USB_DEVICE(0x10ab, 0x9209), .driver_info = BTUSB_QCA_WCN6855 |
   321							     BTUSB_WIDEBAND_SPEECH },
   322		{ USB_DEVICE(0x10ab, 0x9308), .driver_info = BTUSB_QCA_WCN6855 |
   323							     BTUSB_WIDEBAND_SPEECH },
   324		{ USB_DEVICE(0x10ab, 0x9408), .driver_info = BTUSB_QCA_WCN6855 |
   325							     BTUSB_WIDEBAND_SPEECH },
   326		{ USB_DEVICE(0x10ab, 0x9508), .driver_info = BTUSB_QCA_WCN6855 |
   327							     BTUSB_WIDEBAND_SPEECH },
   328		{ USB_DEVICE(0x10ab, 0x9509), .driver_info = BTUSB_QCA_WCN6855 |
   329							     BTUSB_WIDEBAND_SPEECH },
   330		{ USB_DEVICE(0x10ab, 0x9608), .driver_info = BTUSB_QCA_WCN6855 |
   331							     BTUSB_WIDEBAND_SPEECH },
   332		{ USB_DEVICE(0x10ab, 0x9609), .driver_info = BTUSB_QCA_WCN6855 |
   333							     BTUSB_WIDEBAND_SPEECH },
   334		{ USB_DEVICE(0x10ab, 0x9f09), .driver_info = BTUSB_QCA_WCN6855 |
   335							     BTUSB_WIDEBAND_SPEECH },
   336		{ USB_DEVICE(0x04ca, 0x3022), .driver_info = BTUSB_QCA_WCN6855 |
   337							     BTUSB_WIDEBAND_SPEECH },
   338		{ USB_DEVICE(0x0489, 0xe0c7), .driver_info = BTUSB_QCA_WCN6855 |
   339							     BTUSB_WIDEBAND_SPEECH },
   340		{ USB_DEVICE(0x0489, 0xe0c9), .driver_info = BTUSB_QCA_WCN6855 |
   341							     BTUSB_WIDEBAND_SPEECH },
   342		{ USB_DEVICE(0x0489, 0xe0ca), .driver_info = BTUSB_QCA_WCN6855 |
   343							     BTUSB_WIDEBAND_SPEECH },
   344		{ USB_DEVICE(0x0489, 0xe0cb), .driver_info = BTUSB_QCA_WCN6855 |
   345							     BTUSB_WIDEBAND_SPEECH },
   346		{ USB_DEVICE(0x0489, 0xe0ce), .driver_info = BTUSB_QCA_WCN6855 |
   347							     BTUSB_WIDEBAND_SPEECH },
   348		{ USB_DEVICE(0x0489, 0xe0de), .driver_info = BTUSB_QCA_WCN6855 |
   349							     BTUSB_WIDEBAND_SPEECH },
   350		{ USB_DEVICE(0x0489, 0xe0df), .driver_info = BTUSB_QCA_WCN6855 |
   351							     BTUSB_WIDEBAND_SPEECH },
   352		{ USB_DEVICE(0x0489, 0xe0e1), .driver_info = BTUSB_QCA_WCN6855 |
   353							     BTUSB_WIDEBAND_SPEECH },
   354		{ USB_DEVICE(0x0489, 0xe0ea), .driver_info = BTUSB_QCA_WCN6855 |
   355							     BTUSB_WIDEBAND_SPEECH },
   356		{ USB_DEVICE(0x0489, 0xe0ec), .driver_info = BTUSB_QCA_WCN6855 |
   357							     BTUSB_WIDEBAND_SPEECH },
   358		{ USB_DEVICE(0x04ca, 0x3023), .driver_info = BTUSB_QCA_WCN6855 |
   359							     BTUSB_WIDEBAND_SPEECH },
   360		{ USB_DEVICE(0x04ca, 0x3024), .driver_info = BTUSB_QCA_WCN6855 |
   361							     BTUSB_WIDEBAND_SPEECH },
   362		{ USB_DEVICE(0x04ca, 0x3a22), .driver_info = BTUSB_QCA_WCN6855 |
   363							     BTUSB_WIDEBAND_SPEECH },
   364		{ USB_DEVICE(0x04ca, 0x3a24), .driver_info = BTUSB_QCA_WCN6855 |
   365							     BTUSB_WIDEBAND_SPEECH },
   366		{ USB_DEVICE(0x04ca, 0x3a26), .driver_info = BTUSB_QCA_WCN6855 |
   367							     BTUSB_WIDEBAND_SPEECH },
   368		{ USB_DEVICE(0x04ca, 0x3a27), .driver_info = BTUSB_QCA_WCN6855 |
   369							     BTUSB_WIDEBAND_SPEECH },
   370	
   371		/* QCA WCN785x chipset */
   372		{ USB_DEVICE(0x0cf3, 0xe700), .driver_info = BTUSB_QCA_WCN6855 |
   373							     BTUSB_WIDEBAND_SPEECH },
   374	
   375		/* Broadcom BCM2035 */
   376		{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
   377		{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = BTUSB_WRONG_SCO_MTU },
   378		{ USB_DEVICE(0x0a5c, 0x2035), .driver_info = BTUSB_WRONG_SCO_MTU },
   379	
   380		/* Broadcom BCM2045 */
   381		{ USB_DEVICE(0x0a5c, 0x2039), .driver_info = BTUSB_WRONG_SCO_MTU },
   382		{ USB_DEVICE(0x0a5c, 0x2101), .driver_info = BTUSB_WRONG_SCO_MTU },
   383	
   384		/* IBM/Lenovo ThinkPad with Broadcom chip */
   385		{ USB_DEVICE(0x0a5c, 0x201e), .driver_info = BTUSB_WRONG_SCO_MTU },
   386		{ USB_DEVICE(0x0a5c, 0x2110), .driver_info = BTUSB_WRONG_SCO_MTU },
   387	
   388		/* HP laptop with Broadcom chip */
   389		{ USB_DEVICE(0x03f0, 0x171d), .driver_info = BTUSB_WRONG_SCO_MTU },
   390	
   391		/* Dell laptop with Broadcom chip */
   392		{ USB_DEVICE(0x413c, 0x8126), .driver_info = BTUSB_WRONG_SCO_MTU },
   393	
   394		/* Dell Wireless 370 and 410 devices */
   395		{ USB_DEVICE(0x413c, 0x8152), .driver_info = BTUSB_WRONG_SCO_MTU },
   396		{ USB_DEVICE(0x413c, 0x8156), .driver_info = BTUSB_WRONG_SCO_MTU },
   397	
   398		/* Belkin F8T012 and F8T013 devices */
   399		{ USB_DEVICE(0x050d, 0x0012), .driver_info = BTUSB_WRONG_SCO_MTU },
   400		{ USB_DEVICE(0x050d, 0x0013), .driver_info = BTUSB_WRONG_SCO_MTU },
   401	
   402		/* Asus WL-BTD202 device */
   403		{ USB_DEVICE(0x0b05, 0x1715), .driver_info = BTUSB_WRONG_SCO_MTU },
   404	
   405		/* Kensington Bluetooth USB adapter */
   406		{ USB_DEVICE(0x047d, 0x105e), .driver_info = BTUSB_WRONG_SCO_MTU },
   407	
   408		/* RTX Telecom based adapters with buggy SCO support */
   409		{ USB_DEVICE(0x0400, 0x0807), .driver_info = BTUSB_BROKEN_ISOC },
   410		{ USB_DEVICE(0x0400, 0x080a), .driver_info = BTUSB_BROKEN_ISOC },
   411	
   412		/* CONWISE Technology based adapters with buggy SCO support */
   413		{ USB_DEVICE(0x0e5e, 0x6622),
   414		  .driver_info = BTUSB_BROKEN_ISOC | BTUSB_CW6622},
   415	
   416		/* Roper Class 1 Bluetooth Dongle (Silicon Wave based) */
   417		{ USB_DEVICE(0x1310, 0x0001), .driver_info = BTUSB_SWAVE },
   418	
   419		/* Digianswer devices */
   420		{ USB_DEVICE(0x08fd, 0x0001), .driver_info = BTUSB_DIGIANSWER },
   421		{ USB_DEVICE(0x08fd, 0x0002), .driver_info = BTUSB_IGNORE },
   422	
   423		/* CSR BlueCore Bluetooth Sniffer */
   424		{ USB_DEVICE(0x0a12, 0x0002),
   425		  .driver_info = BTUSB_SNIFFER | BTUSB_BROKEN_ISOC },
   426	
   427		/* Frontline ComProbe Bluetooth Sniffer */
   428		{ USB_DEVICE(0x16d3, 0x0002),
   429		  .driver_info = BTUSB_SNIFFER | BTUSB_BROKEN_ISOC },
   430	
   431		/* Marvell Bluetooth devices */
   432		{ USB_DEVICE(0x1286, 0x2044), .driver_info = BTUSB_MARVELL },
   433		{ USB_DEVICE(0x1286, 0x2046), .driver_info = BTUSB_MARVELL },
   434		{ USB_DEVICE(0x1286, 0x204e), .driver_info = BTUSB_MARVELL },
   435	
   436		/* Intel Bluetooth devices */
   437		{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_COMBINED },
   438		{ USB_DEVICE(0x8087, 0x0026), .driver_info = BTUSB_INTEL_COMBINED },
   439		{ USB_DEVICE(0x8087, 0x0029), .driver_info = BTUSB_INTEL_COMBINED },
   440		{ USB_DEVICE(0x8087, 0x0032), .driver_info = BTUSB_INTEL_COMBINED },
   441		{ USB_DEVICE(0x8087, 0x0033), .driver_info = BTUSB_INTEL_COMBINED },
   442		{ USB_DEVICE(0x8087, 0x0035), .driver_info = BTUSB_INTEL_COMBINED },
   443		{ USB_DEVICE(0x8087, 0x0036), .driver_info = BTUSB_INTEL_COMBINED },
   444		{ USB_DEVICE(0x8087, 0x0037), .driver_info = BTUSB_INTEL_COMBINED },
   445		{ USB_DEVICE(0x8087, 0x0038), .driver_info = BTUSB_INTEL_COMBINED },
   446		{ USB_DEVICE(0x8087, 0x0039), .driver_info = BTUSB_INTEL_COMBINED },
   447		{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
   448		{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED |
   449							     BTUSB_INTEL_NO_WBS_SUPPORT |
   450							     BTUSB_INTEL_BROKEN_INITIAL_NCMD |
   451							     BTUSB_INTEL_BROKEN_SHUTDOWN_LED },
   452		{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED |
   453							     BTUSB_INTEL_NO_WBS_SUPPORT |
   454							     BTUSB_INTEL_BROKEN_SHUTDOWN_LED },
   455		{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_COMBINED },
   456		{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED |
   457							     BTUSB_INTEL_BROKEN_SHUTDOWN_LED },
   458		{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_COMBINED },
   459	
   460		/* Other Intel Bluetooth devices */
   461		{ USB_VENDOR_AND_INTERFACE_INFO(0x8087, 0xe0, 0x01, 0x01),
   462		  .driver_info = BTUSB_IGNORE },
   463	
   464		/* Realtek 8821CE Bluetooth devices */
   465		{ USB_DEVICE(0x13d3, 0x3529), .driver_info = BTUSB_REALTEK |
   466							     BTUSB_WIDEBAND_SPEECH },
   467	
   468		/* Realtek 8822CE Bluetooth devices */
   469		{ USB_DEVICE(0x0bda, 0xb00c), .driver_info = BTUSB_REALTEK |
   470							     BTUSB_WIDEBAND_SPEECH },
   471		{ USB_DEVICE(0x0bda, 0xc822), .driver_info = BTUSB_REALTEK |
   472							     BTUSB_WIDEBAND_SPEECH },
   473	
   474		/* Realtek 8822CU Bluetooth devices */
   475		{ USB_DEVICE(0x13d3, 0x3549), .driver_info = BTUSB_REALTEK |
   476							     BTUSB_WIDEBAND_SPEECH },
   477	
   478		/* Realtek 8852AE Bluetooth devices */
   479		{ USB_DEVICE(0x0bda, 0x2852), .driver_info = BTUSB_REALTEK |
   480							     BTUSB_WIDEBAND_SPEECH },
   481		{ USB_DEVICE(0x0bda, 0xc852), .driver_info = BTUSB_REALTEK |
   482							     BTUSB_WIDEBAND_SPEECH },
   483		{ USB_DEVICE(0x0bda, 0x385a), .driver_info = BTUSB_REALTEK |
   484							     BTUSB_WIDEBAND_SPEECH },
   485		{ USB_DEVICE(0x0bda, 0x4852), .driver_info = BTUSB_REALTEK |
   486							     BTUSB_WIDEBAND_SPEECH },
   487		{ USB_DEVICE(0x04c5, 0x165c), .driver_info = BTUSB_REALTEK |
   488							     BTUSB_WIDEBAND_SPEECH },
   489		{ USB_DEVICE(0x04ca, 0x4006), .driver_info = BTUSB_REALTEK |
   490							     BTUSB_WIDEBAND_SPEECH },
   491		{ USB_DEVICE(0x0cb8, 0xc549), .driver_info = BTUSB_REALTEK |
   492							     BTUSB_WIDEBAND_SPEECH },
   493	
   494		/* Realtek 8852CE Bluetooth devices */
   495		{ USB_DEVICE(0x04ca, 0x4007), .driver_info = BTUSB_REALTEK |
   496							     BTUSB_WIDEBAND_SPEECH },
   497		{ USB_DEVICE(0x04c5, 0x1675), .driver_info = BTUSB_REALTEK |
   498							     BTUSB_WIDEBAND_SPEECH },
   499		{ USB_DEVICE(0x0cb8, 0xc558), .driver_info = BTUSB_REALTEK |
   500							     BTUSB_WIDEBAND_SPEECH },
   501		{ USB_DEVICE(0x13d3, 0x3587), .driver_info = BTUSB_REALTEK |
   502							     BTUSB_WIDEBAND_SPEECH },
   503		{ USB_DEVICE(0x13d3, 0x3586), .driver_info = BTUSB_REALTEK |
   504							     BTUSB_WIDEBAND_SPEECH },
   505		{ USB_DEVICE(0x13d3, 0x3592), .driver_info = BTUSB_REALTEK |
   506							     BTUSB_WIDEBAND_SPEECH },
   507		{ USB_DEVICE(0x0489, 0xe122), .driver_info = BTUSB_REALTEK |
   508							     BTUSB_WIDEBAND_SPEECH },
   509	
   510		/* Realtek 8852BE Bluetooth devices */
   511		{ USB_DEVICE(0x0cb8, 0xc559), .driver_info = BTUSB_REALTEK |
   512							     BTUSB_WIDEBAND_SPEECH },
   513		{ USB_DEVICE(0x0bda, 0x4853), .driver_info = BTUSB_REALTEK |
   514							     BTUSB_WIDEBAND_SPEECH },
   515		{ USB_DEVICE(0x0bda, 0x887b), .driver_info = BTUSB_REALTEK |
   516							     BTUSB_WIDEBAND_SPEECH },
   517		{ USB_DEVICE(0x0bda, 0xb85b), .driver_info = BTUSB_REALTEK |
   518							     BTUSB_WIDEBAND_SPEECH },
   519		{ USB_DEVICE(0x13d3, 0x3570), .driver_info = BTUSB_REALTEK |
   520							     BTUSB_WIDEBAND_SPEECH },
   521		{ USB_DEVICE(0x13d3, 0x3571), .driver_info = BTUSB_REALTEK |
   522							     BTUSB_WIDEBAND_SPEECH },
   523		{ USB_DEVICE(0x13d3, 0x3572), .driver_info = BTUSB_REALTEK |
   524							     BTUSB_WIDEBAND_SPEECH },
   525		{ USB_DEVICE(0x13d3, 0x3591), .driver_info = BTUSB_REALTEK |
   526							     BTUSB_WIDEBAND_SPEECH },
   527		{ USB_DEVICE(0x0489, 0xe125), .driver_info = BTUSB_REALTEK |
   528							     BTUSB_WIDEBAND_SPEECH },
   529	
   530		/* Realtek 8852BT/8852BE-VT Bluetooth devices */
   531		{ USB_DEVICE(0x0bda, 0x8520), .driver_info = BTUSB_REALTEK |
   532							     BTUSB_WIDEBAND_SPEECH },
   533	
   534		/* Realtek 8922AE Bluetooth devices */
   535		{ USB_DEVICE(0x0bda, 0x8922), .driver_info = BTUSB_REALTEK |
   536							     BTUSB_WIDEBAND_SPEECH },
   537		{ USB_DEVICE(0x13d3, 0x3617), .driver_info = BTUSB_REALTEK |
   538							     BTUSB_WIDEBAND_SPEECH },
   539		{ USB_DEVICE(0x13d3, 0x3616), .driver_info = BTUSB_REALTEK |
   540							     BTUSB_WIDEBAND_SPEECH },
   541		{ USB_DEVICE(0x0489, 0xe130), .driver_info = BTUSB_REALTEK |
   542							     BTUSB_WIDEBAND_SPEECH },
   543	
   544		/* Realtek Bluetooth devices */
   545		{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
   546		  .driver_info = BTUSB_REALTEK },
   547	
   548		/* MediaTek Bluetooth devices */
   549		{ USB_VENDOR_AND_INTERFACE_INFO(0x0e8d, 0xe0, 0x01, 0x01),
   550		  .driver_info = BTUSB_MEDIATEK |
   551				 BTUSB_WIDEBAND_SPEECH },
   552	
   553		/* Additional MediaTek MT7615E Bluetooth devices */
   554		{ USB_DEVICE(0x13d3, 0x3560), .driver_info = BTUSB_MEDIATEK},
   555	
   556		/* Additional MediaTek MT7663 Bluetooth devices */
   557		{ USB_DEVICE(0x043e, 0x310c), .driver_info = BTUSB_MEDIATEK |
   558							     BTUSB_WIDEBAND_SPEECH },
   559		{ USB_DEVICE(0x04ca, 0x3801), .driver_info = BTUSB_MEDIATEK |
   560							     BTUSB_WIDEBAND_SPEECH },
   561	
   562		/* Additional MediaTek MT7668 Bluetooth devices */
   563		{ USB_DEVICE(0x043e, 0x3109), .driver_info = BTUSB_MEDIATEK |
   564							     BTUSB_WIDEBAND_SPEECH },
   565	
   566		/* Additional MediaTek MT7921 Bluetooth devices */
   567		{ USB_DEVICE(0x0489, 0xe0c8), .driver_info = BTUSB_MEDIATEK |
   568							     BTUSB_WIDEBAND_SPEECH },
   569		{ USB_DEVICE(0x0489, 0xe0cd), .driver_info = BTUSB_MEDIATEK |
   570							     BTUSB_WIDEBAND_SPEECH },
   571		{ USB_DEVICE(0x0489, 0xe0e0), .driver_info = BTUSB_MEDIATEK |
   572							     BTUSB_WIDEBAND_SPEECH },
   573		{ USB_DEVICE(0x0489, 0xe0f2), .driver_info = BTUSB_MEDIATEK |
   574							     BTUSB_WIDEBAND_SPEECH },
   575		{ USB_DEVICE(0x04ca, 0x3802), .driver_info = BTUSB_MEDIATEK |
   576							     BTUSB_WIDEBAND_SPEECH },
   577		{ USB_DEVICE(0x0e8d, 0x0608), .driver_info = BTUSB_MEDIATEK |
   578							     BTUSB_WIDEBAND_SPEECH },
   579		{ USB_DEVICE(0x13d3, 0x3563), .driver_info = BTUSB_MEDIATEK |
   580							     BTUSB_WIDEBAND_SPEECH },
   581		{ USB_DEVICE(0x13d3, 0x3564), .driver_info = BTUSB_MEDIATEK |
   582							     BTUSB_WIDEBAND_SPEECH },
   583		{ USB_DEVICE(0x13d3, 0x3567), .driver_info = BTUSB_MEDIATEK |
   584							     BTUSB_WIDEBAND_SPEECH },
   585		{ USB_DEVICE(0x13d3, 0x3578), .driver_info = BTUSB_MEDIATEK |
   586							     BTUSB_WIDEBAND_SPEECH },
   587		{ USB_DEVICE(0x13d3, 0x3583), .driver_info = BTUSB_MEDIATEK |
   588							     BTUSB_WIDEBAND_SPEECH },
   589		{ USB_DEVICE(0x13d3, 0x3606), .driver_info = BTUSB_MEDIATEK |
   590							     BTUSB_WIDEBAND_SPEECH },
   591	
   592		/* MediaTek MT7922 Bluetooth devices */
   593		{ USB_DEVICE(0x13d3, 0x3585), .driver_info = BTUSB_MEDIATEK |
   594							     BTUSB_WIDEBAND_SPEECH },
   595	
   596		/* MediaTek MT7922A Bluetooth devices */
   597		{ USB_DEVICE(0x0489, 0xe0d8), .driver_info = BTUSB_MEDIATEK |
   598							     BTUSB_WIDEBAND_SPEECH },
   599		{ USB_DEVICE(0x0489, 0xe0d9), .driver_info = BTUSB_MEDIATEK |
   600							     BTUSB_WIDEBAND_SPEECH },
   601		{ USB_DEVICE(0x0489, 0xe0e2), .driver_info = BTUSB_MEDIATEK |
   602							     BTUSB_WIDEBAND_SPEECH },
   603		{ USB_DEVICE(0x0489, 0xe0e4), .driver_info = BTUSB_MEDIATEK |
   604							     BTUSB_WIDEBAND_SPEECH },
   605		{ USB_DEVICE(0x0489, 0xe0f1), .driver_info = BTUSB_MEDIATEK |
   606							     BTUSB_WIDEBAND_SPEECH },
   607		{ USB_DEVICE(0x0489, 0xe0f2), .driver_info = BTUSB_MEDIATEK |
   608							     BTUSB_WIDEBAND_SPEECH },
   609		{ USB_DEVICE(0x0489, 0xe0f5), .driver_info = BTUSB_MEDIATEK |
   610							     BTUSB_WIDEBAND_SPEECH },
   611		{ USB_DEVICE(0x0489, 0xe0f6), .driver_info = BTUSB_MEDIATEK |
   612							     BTUSB_WIDEBAND_SPEECH },
   613		{ USB_DEVICE(0x0489, 0xe102), .driver_info = BTUSB_MEDIATEK |
   614							     BTUSB_WIDEBAND_SPEECH },
   615		{ USB_DEVICE(0x04ca, 0x3804), .driver_info = BTUSB_MEDIATEK |
   616							     BTUSB_WIDEBAND_SPEECH },
   617		{ USB_DEVICE(0x04ca, 0x38e4), .driver_info = BTUSB_MEDIATEK |
   618							     BTUSB_WIDEBAND_SPEECH },
   619		{ USB_DEVICE(0x13d3, 0x3568), .driver_info = BTUSB_MEDIATEK |
   620							     BTUSB_WIDEBAND_SPEECH },
   621		{ USB_DEVICE(0x13d3, 0x3605), .driver_info = BTUSB_MEDIATEK |
   622							     BTUSB_WIDEBAND_SPEECH },
   623		{ USB_DEVICE(0x13d3, 0x3607), .driver_info = BTUSB_MEDIATEK |
   624							     BTUSB_WIDEBAND_SPEECH },
   625		{ USB_DEVICE(0x13d3, 0x3614), .driver_info = BTUSB_MEDIATEK |
   626							     BTUSB_WIDEBAND_SPEECH },
   627		{ USB_DEVICE(0x13d3, 0x3615), .driver_info = BTUSB_MEDIATEK |
   628							     BTUSB_WIDEBAND_SPEECH },
   629		{ USB_DEVICE(0x35f5, 0x7922), .driver_info = BTUSB_MEDIATEK |
   630							     BTUSB_WIDEBAND_SPEECH },
   631	
   632		/* Additional MediaTek MT7925 Bluetooth devices */
   633		{ USB_DEVICE(0x0489, 0xe113), .driver_info = BTUSB_MEDIATEK |
   634							     BTUSB_WIDEBAND_SPEECH },
   635		{ USB_DEVICE(0x0489, 0xe118), .driver_info = BTUSB_MEDIATEK |
   636							     BTUSB_WIDEBAND_SPEECH },
   637		{ USB_DEVICE(0x0489, 0xe11e), .driver_info = BTUSB_MEDIATEK |
   638							     BTUSB_WIDEBAND_SPEECH },
   639		{ USB_DEVICE(0x13d3, 0x3602), .driver_info = BTUSB_MEDIATEK |
   640							     BTUSB_WIDEBAND_SPEECH },
   641		{ USB_DEVICE(0x13d3, 0x3603), .driver_info = BTUSB_MEDIATEK |
   642							     BTUSB_WIDEBAND_SPEECH },
   643		{ USB_DEVICE(0x13d3, 0x3604), .driver_info = BTUSB_MEDIATEK |
   644							     BTUSB_WIDEBAND_SPEECH },
   645		{ USB_DEVICE(0x13d3, 0x3608), .driver_info = BTUSB_MEDIATEK |
   646							     BTUSB_WIDEBAND_SPEECH },
   647	
   648		/* MediaTek MT7925 Bluetooth devices */
   649		{ USB_DEVICE(0x13d3, 0x3608), .driver_info = BTUSB_MEDIATEK |
   650							     BTUSB_WIDEBAND_SPEECH |
 > 651							     BTUSB_VALID_LE_STATES },
   652	
   653		/* Additional Realtek 8723AE Bluetooth devices */
   654		{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },
   655		{ USB_DEVICE(0x13d3, 0x3394), .driver_info = BTUSB_REALTEK },
   656	
   657		/* Additional Realtek 8723BE Bluetooth devices */
   658		{ USB_DEVICE(0x0489, 0xe085), .driver_info = BTUSB_REALTEK },
   659		{ USB_DEVICE(0x0489, 0xe08b), .driver_info = BTUSB_REALTEK },
   660		{ USB_DEVICE(0x04f2, 0xb49f), .driver_info = BTUSB_REALTEK },
   661		{ USB_DEVICE(0x13d3, 0x3410), .driver_info = BTUSB_REALTEK },
   662		{ USB_DEVICE(0x13d3, 0x3416), .driver_info = BTUSB_REALTEK },
   663		{ USB_DEVICE(0x13d3, 0x3459), .driver_info = BTUSB_REALTEK },
   664		{ USB_DEVICE(0x13d3, 0x3494), .driver_info = BTUSB_REALTEK },
   665	
   666		/* Additional Realtek 8723BU Bluetooth devices */
   667		{ USB_DEVICE(0x7392, 0xa611), .driver_info = BTUSB_REALTEK },
   668	
   669		/* Additional Realtek 8723DE Bluetooth devices */
   670		{ USB_DEVICE(0x0bda, 0xb009), .driver_info = BTUSB_REALTEK },
   671		{ USB_DEVICE(0x2ff8, 0xb011), .driver_info = BTUSB_REALTEK },
   672	
   673		/* Additional Realtek 8761BUV Bluetooth devices */
   674		{ USB_DEVICE(0x2357, 0x0604), .driver_info = BTUSB_REALTEK |
   675							     BTUSB_WIDEBAND_SPEECH },
   676		{ USB_DEVICE(0x0b05, 0x190e), .driver_info = BTUSB_REALTEK |
   677		  					     BTUSB_WIDEBAND_SPEECH },
   678		{ USB_DEVICE(0x2550, 0x8761), .driver_info = BTUSB_REALTEK |
   679							     BTUSB_WIDEBAND_SPEECH },
   680		{ USB_DEVICE(0x0bda, 0x8771), .driver_info = BTUSB_REALTEK |
   681							     BTUSB_WIDEBAND_SPEECH },
   682		{ USB_DEVICE(0x6655, 0x8771), .driver_info = BTUSB_REALTEK |
   683							     BTUSB_WIDEBAND_SPEECH },
   684		{ USB_DEVICE(0x7392, 0xc611), .driver_info = BTUSB_REALTEK |
   685							     BTUSB_WIDEBAND_SPEECH },
   686		{ USB_DEVICE(0x2b89, 0x8761), .driver_info = BTUSB_REALTEK |
   687							     BTUSB_WIDEBAND_SPEECH },
   688	
   689		/* Additional Realtek 8821AE Bluetooth devices */
   690		{ USB_DEVICE(0x0b05, 0x17dc), .driver_info = BTUSB_REALTEK },
   691		{ USB_DEVICE(0x13d3, 0x3414), .driver_info = BTUSB_REALTEK },
   692		{ USB_DEVICE(0x13d3, 0x3458), .driver_info = BTUSB_REALTEK },
   693		{ USB_DEVICE(0x13d3, 0x3461), .driver_info = BTUSB_REALTEK },
   694		{ USB_DEVICE(0x13d3, 0x3462), .driver_info = BTUSB_REALTEK },
   695	
   696		/* Additional Realtek 8822BE Bluetooth devices */
   697		{ USB_DEVICE(0x13d3, 0x3526), .driver_info = BTUSB_REALTEK },
   698		{ USB_DEVICE(0x0b05, 0x185c), .driver_info = BTUSB_REALTEK },
   699	
   700		/* Additional Realtek 8822CE Bluetooth devices */
   701		{ USB_DEVICE(0x04ca, 0x4005), .driver_info = BTUSB_REALTEK |
   702							     BTUSB_WIDEBAND_SPEECH },
   703		{ USB_DEVICE(0x04c5, 0x161f), .driver_info = BTUSB_REALTEK |
   704							     BTUSB_WIDEBAND_SPEECH },
   705		{ USB_DEVICE(0x0b05, 0x18ef), .driver_info = BTUSB_REALTEK |
   706							     BTUSB_WIDEBAND_SPEECH },
   707		{ USB_DEVICE(0x13d3, 0x3548), .driver_info = BTUSB_REALTEK |
   708							     BTUSB_WIDEBAND_SPEECH },
   709		{ USB_DEVICE(0x13d3, 0x3549), .driver_info = BTUSB_REALTEK |
   710							     BTUSB_WIDEBAND_SPEECH },
   711		{ USB_DEVICE(0x13d3, 0x3553), .driver_info = BTUSB_REALTEK |
   712							     BTUSB_WIDEBAND_SPEECH },
   713		{ USB_DEVICE(0x13d3, 0x3555), .driver_info = BTUSB_REALTEK |
   714							     BTUSB_WIDEBAND_SPEECH },
   715		{ USB_DEVICE(0x2ff8, 0x3051), .driver_info = BTUSB_REALTEK |
   716							     BTUSB_WIDEBAND_SPEECH },
   717		{ USB_DEVICE(0x1358, 0xc123), .driver_info = BTUSB_REALTEK |
   718							     BTUSB_WIDEBAND_SPEECH },
   719		{ USB_DEVICE(0x0bda, 0xc123), .driver_info = BTUSB_REALTEK |
   720							     BTUSB_WIDEBAND_SPEECH },
   721		{ USB_DEVICE(0x0cb5, 0xc547), .driver_info = BTUSB_REALTEK |
   722							     BTUSB_WIDEBAND_SPEECH },
   723	
   724		/* Actions Semiconductor ATS2851 based devices */
   725		{ USB_DEVICE(0x10d7, 0xb012), .driver_info = BTUSB_ACTIONS_SEMI },
   726	
   727		/* Silicon Wave based devices */
   728		{ USB_DEVICE(0x0c10, 0x0000), .driver_info = BTUSB_SWAVE },
   729	
   730		{ }	/* Terminating entry */
   731	};
   732	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
