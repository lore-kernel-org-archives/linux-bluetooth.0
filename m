Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5559023A6
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 May 2024 01:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715046319; cv=none; b=tiEhkIBEUF+P+hAjDgRNGqMdfS4Entl7pEUPZSOrcEIHhKtFqLDmUbOwYtrU3Kmve3RkoSVu8tgO/cX2Kv4zWKNeR7d5tNKTkDaFkf1FA060DtinY1pFQLB4Zl+Ri6NVPpPkg5GQJmlzerZK7udn1Nn8LJNUE87XWj4X4yFw+1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715046319; c=relaxed/simple;
	bh=Pv1AQtJOYkxC1yQA8no3goFIzvaWgQo7xKQd+D4EqU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKvgnkdzzCbd7MjSfV4FJ1ls6e2n4JmndEph3oGRxfxV9jK19xfku2xBpB8UiQidZDwQe/4NYXls2gZ4CDwYIHSg/D9DYpyUAwdDn95b8PCLzft0R1ahSCjMYGfsSd7t1658C0nLqQzDSwtZZm0JyzGxRfBfpeuOm0GiJ026DVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fmWvGx8k; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fmWvGx8k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715046317; x=1746582317;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pv1AQtJOYkxC1yQA8no3goFIzvaWgQo7xKQd+D4EqU8=;
  b=fmWvGx8k7FVWHRdOuJE63jsJkfR/Nnqu+mo7XHY4u1uzA2/BFB0o1jMf
   ESyNRgxZrb1My0E/+GJt2j4Zm/tkTotGtJtJRguHj9VuZNKsCXF9RTiYp
   ZpbahbDWooej5H3Nobaa9+uzGuW7U5dX5q4DQDRA/P9UfIm9abgZJo4hW
   BfHPg/5xRYTfQGAohqHxXpyjBLbIqkn97kxR0r2yU/ILVTTtRtdW52sIN
   sqggbXrqpoOyIKGUiVXxgcqVuXj6JZbgS/CL3c1aGdF0wFXyyfaMXJVMD
   hgdrq9CC2RMQ/+4tfhkczfprIoj9vbi87cApa1SLMC5e9onvTt2QPXZ/B
   g==;
X-CSE-ConnectionGUID: rWkci3PNQLyb0dpqk6K7pw==
X-CSE-MsgGUID: 1PPCNi6vSxuby3+b+8CcJA==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10692310"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="10692310"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 18:45:15 -0700
X-CSE-ConnectionGUID: mT/Q3UGcSUejYskr7pmnHg==
X-CSE-MsgGUID: X5fdfTvqSXaULbUPjlhPUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="59207567"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 06 May 2024 18:45:13 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s49tG-0001D9-1e;
	Tue, 07 May 2024 01:45:10 +0000
Date: Tue, 7 May 2024 09:44:52 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1] Bluetooth: HCI: Remove HCI_AMP support
Message-ID: <202405070914.iRNrUUQb-lkp@intel.com>
References: <20240506223758.460710-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506223758.460710-1-luiz.dentz@gmail.com>

Hi Luiz,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240506]
[cannot apply to v6.9-rc7 v6.9-rc6 v6.9-rc5 linus/master v6.9-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luiz-Augusto-von-Dentz/Bluetooth-HCI-Remove-HCI_AMP-support/20240507-063936
base:   next-20240506
patch link:    https://lore.kernel.org/r/20240506223758.460710-1-luiz.dentz%40gmail.com
patch subject: [PATCH v1] Bluetooth: HCI: Remove HCI_AMP support
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240507/202405070914.iRNrUUQb-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240507/202405070914.iRNrUUQb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405070914.iRNrUUQb-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/bluetooth/btmrvl_main.c:682:8: error: no member named 'dev_type' in 'struct hci_dev'
           hdev->dev_type = priv->btmrvl_dev.dev_type;
           ~~~~  ^
   1 error generated.


vim +682 drivers/bluetooth/btmrvl_main.c

132ff4e5fa8dfb Bing Zhao              2009-06-02  656  
64061607eab7cb Bing Zhao              2010-03-03  657  int btmrvl_register_hdev(struct btmrvl_private *priv)
132ff4e5fa8dfb Bing Zhao              2009-06-02  658  {
132ff4e5fa8dfb Bing Zhao              2009-06-02  659  	struct hci_dev *hdev = NULL;
70a7808b50b119 Abhishek Pandit-Subedi 2020-06-10  660  	struct btmrvl_sdio_card *card = priv->btmrvl_dev.card;
132ff4e5fa8dfb Bing Zhao              2009-06-02  661  	int ret;
132ff4e5fa8dfb Bing Zhao              2009-06-02  662  
132ff4e5fa8dfb Bing Zhao              2009-06-02  663  	hdev = hci_alloc_dev();
132ff4e5fa8dfb Bing Zhao              2009-06-02  664  	if (!hdev) {
132ff4e5fa8dfb Bing Zhao              2009-06-02  665  		BT_ERR("Can not allocate HCI device");
132ff4e5fa8dfb Bing Zhao              2009-06-02  666  		goto err_hdev;
132ff4e5fa8dfb Bing Zhao              2009-06-02  667  	}
132ff4e5fa8dfb Bing Zhao              2009-06-02  668  
132ff4e5fa8dfb Bing Zhao              2009-06-02  669  	priv->btmrvl_dev.hcidev = hdev;
155961e8001719 David Rheinsberg       2012-02-09  670  	hci_set_drvdata(hdev, priv);
132ff4e5fa8dfb Bing Zhao              2009-06-02  671  
c13854cef47510 Marcel Holtmann        2010-02-08  672  	hdev->bus   = HCI_SDIO;
132ff4e5fa8dfb Bing Zhao              2009-06-02  673  	hdev->open  = btmrvl_open;
132ff4e5fa8dfb Bing Zhao              2009-06-02  674  	hdev->close = btmrvl_close;
132ff4e5fa8dfb Bing Zhao              2009-06-02  675  	hdev->flush = btmrvl_flush;
132ff4e5fa8dfb Bing Zhao              2009-06-02  676  	hdev->send  = btmrvl_send_frame;
4b245722cabc6e Amitkumar Karwar       2013-10-01  677  	hdev->setup = btmrvl_setup;
27b869f59d5d98 Amitkumar Karwar       2014-07-18  678  	hdev->set_bdaddr = btmrvl_set_bdaddr;
4539ca67fe8ede Luiz Augusto von Dentz 2021-10-01  679  	hdev->wakeup = btmrvl_wakeup;
70a7808b50b119 Abhishek Pandit-Subedi 2020-06-10  680  	SET_HCIDEV_DEV(hdev, &card->func->dev);
64061607eab7cb Bing Zhao              2010-03-03  681  
f120c6b635a62d Bing Zhao              2010-03-03 @682  	hdev->dev_type = priv->btmrvl_dev.dev_type;
f120c6b635a62d Bing Zhao              2010-03-03  683  
132ff4e5fa8dfb Bing Zhao              2009-06-02  684  	ret = hci_register_dev(hdev);
132ff4e5fa8dfb Bing Zhao              2009-06-02  685  	if (ret < 0) {
132ff4e5fa8dfb Bing Zhao              2009-06-02  686  		BT_ERR("Can not register HCI device");
132ff4e5fa8dfb Bing Zhao              2009-06-02  687  		goto err_hci_register_dev;
132ff4e5fa8dfb Bing Zhao              2009-06-02  688  	}
132ff4e5fa8dfb Bing Zhao              2009-06-02  689  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
