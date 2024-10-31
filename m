Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6E719CC2E;
	Thu, 31 Oct 2024 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730379024; cv=none; b=J2rYjTm5kIuhoW1JcsivsPjsvtngPt+yM37MqAVzSEkL6IvpMry5wnXFqZmiLKAeieWyRARRAIAohjziuAdHIKToKIzrEc68OC5/Arlv7Xy+eVdF88jgbDKFNhBkhpGufp0mCsF+GRxpmO2/iub3WMjROUafhjR9TygNfWS2E0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730379024; c=relaxed/simple;
	bh=KgrT9gzJsrw9/tNeAkVtI+KmjUxOi5HWXxXHyw+9wMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMTzrAUA/pepVBfQKAwpAzC3UT8DaprTOugJtjzwaiYcTnNagM+7jil8CaP0t2ZLDkCK0VkRvct0topuzJ1WjQg0iuoZbTasVHeD41ALxtji5YMu6Sj/UaB0B7ZvlrztT8CW810y6GWbSuO2NZJvXO8Ead6WdS4jDvUeQuASSBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EaUCFnxV; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EaUCFnxV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730379021; x=1761915021;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KgrT9gzJsrw9/tNeAkVtI+KmjUxOi5HWXxXHyw+9wMA=;
  b=EaUCFnxV+HJ8CRYtp1fqdg/LyYzvAmzTjDdP8RAf/Ik6qCfkmCX54ajP
   lngyagx3RcAhV/sw2Cw6Pd+0MzxOedA97/fhvIiaNzzkocWZIhHnML41b
   w19WZXn0o7LbzOPJApmkhph7FAhEXpBaFU71XpyzBtX7QQlBIItNMuu2d
   KjNVZKykDWTH8zcxVURu0OgdKWqapHB+FiayMBLeK8iVtkKlkKVczf4A4
   TTQl0Y2pMEAzood+oRDVTSoBul1sa56SJgZabcR+w7TnSbQQdlAJRzlCh
   nGFmDXlR66n4sNEHltbHO6/o3S0oJ2TOOxXYx3W9D8vPRsTCn92qNF6DA
   g==;
X-CSE-ConnectionGUID: LB29erhZTP+Rx8gay+s+4g==
X-CSE-MsgGUID: XFg032BlQwGPEqCMjB2iIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29881011"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29881011"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 05:50:17 -0700
X-CSE-ConnectionGUID: oAS+hGlITdSR4zd7htEH9A==
X-CSE-MsgGUID: EiZWJb+XTKminnwpxAY9wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="87158095"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 31 Oct 2024 05:50:15 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6Ucu-000g6e-2Z;
	Thu, 31 Oct 2024 12:50:12 +0000
Date: Thu, 31 Oct 2024 20:49:13 +0800
From: kernel test robot <lkp@intel.com>
To: Hilda Wu <hildawu@realtek.com>, marcel@holtmann.org
Cc: oe-kbuild-all@lists.linux.dev, luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	max.chou@realtek.com, alex_lu@realsil.com.cn, kidman@realtek.com
Subject: Re: [PATCH] bluetooth: add quirk using packet size 60
Message-ID: <202410312046.r3WbTClD-lkp@intel.com>
References: <20241030100804.2743115-1-hildawu@realtek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030100804.2743115-1-hildawu@realtek.com>

Hi Hilda,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on bluetooth-next/master linus/master v6.12-rc5 next-20241031]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hilda-Wu/bluetooth-add-quirk-using-packet-size-60/20241030-181008
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/20241030100804.2743115-1-hildawu%40realtek.com
patch subject: [PATCH] bluetooth: add quirk using packet size 60
config: x86_64-randconfig-123-20241031 (https://download.01.org/0day-ci/archive/20241031/202410312046.r3WbTClD-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241031/202410312046.r3WbTClD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410312046.r3WbTClD-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/bluetooth/btusb.c:2156:65: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] wMaxPacketSize @@     got int @@
   drivers/bluetooth/btusb.c:2156:65: sparse:     expected restricted __le16 [usertype] wMaxPacketSize
   drivers/bluetooth/btusb.c:2156:65: sparse:     got int
   drivers/bluetooth/btusb.c:2188:65: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] wMaxPacketSize @@     got int @@
   drivers/bluetooth/btusb.c:2188:65: sparse:     expected restricted __le16 [usertype] wMaxPacketSize
   drivers/bluetooth/btusb.c:2188:65: sparse:     got int
>> drivers/bluetooth/btusb.c:2156:65: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] wMaxPacketSize @@     got int @@
   drivers/bluetooth/btusb.c:2156:65: sparse:     expected restricted __le16 [usertype] wMaxPacketSize
   drivers/bluetooth/btusb.c:2156:65: sparse:     got int
   drivers/bluetooth/btusb.c:2188:65: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] wMaxPacketSize @@     got int @@
   drivers/bluetooth/btusb.c:2188:65: sparse:     expected restricted __le16 [usertype] wMaxPacketSize
   drivers/bluetooth/btusb.c:2188:65: sparse:     got int

vim +2156 drivers/bluetooth/btusb.c

  2126	
  2127	static inline int __set_isoc_interface(struct hci_dev *hdev, int altsetting)
  2128	{
  2129		struct btusb_data *data = hci_get_drvdata(hdev);
  2130		struct usb_interface *intf = data->isoc;
  2131		struct usb_endpoint_descriptor *ep_desc;
  2132		struct usb_host_interface *alt;
  2133		int i, err;
  2134	
  2135		if (!data->isoc)
  2136			return -ENODEV;
  2137	
  2138		/* For some Realtek chips, they actually have the altsetting 6, but its
  2139		 * altsetting descriptor is not exposed. We can activate altsetting 6 by
  2140		 * replacing the altsetting 5.
  2141		 */
  2142		if (altsetting == 6 && !btusb_find_altsetting(data, 6) &&
  2143		    btrealtek_test_flag(hdev, REALTEK_ALT6_FORCE)) {
  2144			alt = NULL;
  2145			for (i = 0; i < intf->num_altsetting; i++) {
  2146				if (intf->altsetting[i].desc.bAlternateSetting == 5) {
  2147					alt = &intf->altsetting[i];
  2148					break;
  2149				}
  2150			}
  2151			if (alt) {
  2152				for (i = 0; i < alt->desc.bNumEndpoints; i++) {
  2153					ep_desc = &alt->endpoint[i].desc;
  2154					if (usb_endpoint_is_isoc_out(ep_desc) ||
  2155					    usb_endpoint_is_isoc_in(ep_desc))
> 2156						ep_desc->wMaxPacketSize = 63;
  2157				}
  2158				alt->desc.bAlternateSetting = 6;
  2159				set_bit(BTUSB_ALT_CHANGED, &data->flags);
  2160			}
  2161		}
  2162	
  2163		err = usb_set_interface(data->udev, data->isoc_ifnum, altsetting);
  2164		if (err < 0) {
  2165			bt_dev_err(hdev, "setting interface failed (%d)", -err);
  2166			return err;
  2167		}
  2168	
  2169		data->isoc_altsetting = altsetting;
  2170	
  2171		data->isoc_tx_ep = NULL;
  2172		data->isoc_rx_ep = NULL;
  2173	
  2174		/* Recover alt 5 desc if alt 0 is set. */
  2175		if (!altsetting && test_bit(BTUSB_ALT_CHANGED, &data->flags)) {
  2176			alt = NULL;
  2177			for (i = 0; i < intf->num_altsetting; i++) {
  2178				if (intf->altsetting[i].desc.bAlternateSetting == 6) {
  2179					alt = &intf->altsetting[i];
  2180					break;
  2181				}
  2182			}
  2183			if (alt) {
  2184				for (i = 0; i < alt->desc.bNumEndpoints; i++) {
  2185					ep_desc = &alt->endpoint[i].desc;
  2186					if (usb_endpoint_is_isoc_out(ep_desc) ||
  2187					    usb_endpoint_is_isoc_in(ep_desc))
  2188						ep_desc->wMaxPacketSize = 49;
  2189				}
  2190				alt->desc.bAlternateSetting = 5;
  2191				clear_bit(BTUSB_ALT_CHANGED, &data->flags);
  2192			}
  2193		}
  2194	
  2195		for (i = 0; i < intf->cur_altsetting->desc.bNumEndpoints; i++) {
  2196			ep_desc = &intf->cur_altsetting->endpoint[i].desc;
  2197	
  2198			if (!data->isoc_tx_ep && usb_endpoint_is_isoc_out(ep_desc)) {
  2199				data->isoc_tx_ep = ep_desc;
  2200				continue;
  2201			}
  2202	
  2203			if (!data->isoc_rx_ep && usb_endpoint_is_isoc_in(ep_desc)) {
  2204				data->isoc_rx_ep = ep_desc;
  2205				continue;
  2206			}
  2207		}
  2208	
  2209		if (!data->isoc_tx_ep || !data->isoc_rx_ep) {
  2210			bt_dev_err(hdev, "invalid SCO descriptors");
  2211			return -ENODEV;
  2212		}
  2213	
  2214		return 0;
  2215	}
  2216	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
