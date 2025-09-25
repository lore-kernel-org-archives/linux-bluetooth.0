Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA312E8E08;
	Thu, 25 Sep 2025 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758840913; cv=none; b=KZ6VOLFzqWjjFLTbt4YauI4HnDl9MCOOOtEmAHiSzZtrqdbVNBo/C1gdFBwBQx5xtavrp814gpKVMBf0c9Dc3jbsYGigS6G+zjtZh4f9+DXqSUwaL0kkAw++pBkW1x5avmXTQWBiVvA+LPgqFmxhCvcowYJfKlQYLYXr7xJCkkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758840913; c=relaxed/simple;
	bh=Wcm+0+MGr0QhGbbKqE9by5FkhaqCe/1wQYUpEehdWbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUbdsKY8wnHgz/4uSZAohqAX6Pbhj0SvP02J8r6ECKMJWC7zXdXPsE13NruTu28b80P6GIh8Jk6XrOdgeWRKzTrJBPn5jH2DK19AYyCdqMNpqyatceDUYd7/5OfmaUGZPiaocllViXEnOQ4X0fq4eQh8W7BpveE8GT71hoQhTpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzzZ21HT; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzzZ21HT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758840910; x=1790376910;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wcm+0+MGr0QhGbbKqE9by5FkhaqCe/1wQYUpEehdWbc=;
  b=lzzZ21HTRGBJUdf5vB71H/iSq09A9L6XizR843EXIsbc5Kllk0F4OAd/
   C0lkBXxGs2KR13OnaLiP+FYx2eifo85Ig8qB8vK1qef/tGhsARmTOmeDC
   6V0V4M18044F9nTS9m8vjtuLSNRz3H36VlCF3Jdw87RDWuJOjQU9E2A5J
   eTvVBocmcoQFpL9aUimtv/+axjeQKVzhurbGxnafNdOQjtV84oBKBpVjA
   TI8nxmRvHeiuPVqF5jKEYX8XW9cfaZ30jhO2XxOjOMQGv/lH5Amp36y2z
   3ZR0gXrUVRYN9kaZzR4KG/5DO5PqYCwc/JK7AJtCLnXnuDCrKxNlp+3d2
   A==;
X-CSE-ConnectionGUID: fkGM2C/OS9m0EJ79jm1yBg==
X-CSE-MsgGUID: w2UL1p/9Q6aJLYaD9/2FkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64985621"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64985621"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 15:55:10 -0700
X-CSE-ConnectionGUID: 3ZgUONWAQ9KZXqtUzThLIQ==
X-CSE-MsgGUID: m4VRglUzTn60fiyCen3W5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="176586918"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 25 Sep 2025 15:55:06 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1ure-0005gz-38;
	Thu, 25 Sep 2025 22:55:02 +0000
Date: Fri, 26 Sep 2025 06:55:01 +0800
From: kernel test robot <lkp@intel.com>
To: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Luiz Von Dentz <luiz.dentz@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: oe-kbuild-all@lists.linux.dev, Krzysztof Kozlowski <krzk@kernel.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Deren Wu <deren.Wu@mediatek.com>, Chris Lu <chris.lu@mediatek.com>,
	Hao Qin <Hao.qin@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-mediatek <linux-mediatek@lists.infradead.org>,
	Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
Subject: Re: [PATCH v8] Bluetooth: mediatek: add gpio pin to reset bt
Message-ID: <202509260623.nZX7ipvc-lkp@intel.com>
References: <20250925092058.16648-1-ot_zhangchao.zhang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925092058.16648-1-ot_zhangchao.zhang@mediatek.com>

Hi Zhangchao,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth/master]
[also build test ERROR on bluetooth-next/master linus/master v6.17-rc7 next-20250925]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhangchao-Zhang/Bluetooth-mediatek-add-gpio-pin-to-reset-bt/20250925-172508
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/20250925092058.16648-1-ot_zhangchao.zhang%40mediatek.com
patch subject: [PATCH v8] Bluetooth: mediatek: add gpio pin to reset bt
config: sh-randconfig-001-20250926 (https://download.01.org/0day-ci/archive/20250926/202509260623.nZX7ipvc-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250926/202509260623.nZX7ipvc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509260623.nZX7ipvc-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/bluetooth/btusb.c: In function 'btusb_mtk_reset':
>> drivers/bluetooth/btusb.c:2769:19: error: 'struct btusb_data' has no member named 'rest_gpio'; did you mean 'reset_gpio'?
    2769 |         if (data->rest_gpio) {
         |                   ^~~~~~~~~
         |                   reset_gpio


vim +2769 drivers/bluetooth/btusb.c

  2740	
  2741	static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
  2742	{
  2743		struct btusb_data *data = hci_get_drvdata(hdev);
  2744		struct btmtk_data *btmtk_data = hci_get_priv(hdev);
  2745		int err;
  2746	
  2747		/* It's MediaTek specific bluetooth reset mechanism via USB */
  2748		if (test_and_set_bit(BTMTK_HW_RESET_ACTIVE, &btmtk_data->flags)) {
  2749			bt_dev_err(hdev, "last reset failed? Not resetting again");
  2750			return -EBUSY;
  2751		}
  2752	
  2753		err = usb_autopm_get_interface(data->intf);
  2754		if (err < 0)
  2755			return err;
  2756	
  2757		/* Release MediaTek ISO data interface */
  2758		btusb_mtk_release_iso_intf(hdev);
  2759	
  2760		btusb_stop_traffic(data);
  2761		usb_kill_anchored_urbs(&data->tx_anchor);
  2762	
  2763		/* Toggle the hard reset line. The MediaTek device is going to
  2764		 * yank itself off the USB and then replug. The cleanup is handled
  2765		 * correctly on the way out (standard USB disconnect), and the new
  2766		 * device is detected cleanly and bound to the driver again like
  2767		 * it should be.
  2768		 */
> 2769		if (data->rest_gpio) {
  2770			gpiod_set_value_cansleep(data->reset_gpio, 1);
  2771			msleep(200);
  2772			gpiod_set_value_cansleep(data->reset_gpio, 0);
  2773			return 0;
  2774		}
  2775	
  2776		err = btmtk_usb_subsys_reset(hdev, btmtk_data->dev_id);
  2777	
  2778		usb_queue_reset_device(data->intf);
  2779		clear_bit(BTMTK_HW_RESET_ACTIVE, &btmtk_data->flags);
  2780	
  2781		return err;
  2782	}
  2783	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
