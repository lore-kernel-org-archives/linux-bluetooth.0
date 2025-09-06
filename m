Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC9820F079;
	Sat,  6 Sep 2025 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757156743; cv=none; b=raflhqdEm1/HtihCALtyYO8rRUcXUxHAuFNPMzQN8M1nPwJlki8aLDsU9TlEm5IcghRMI6jOV34nUSiC/dEuO0Q8kj8KGWnDcV8Iuf73kSO/JNPeJ+GmKyPgrpmB5zRuspFBgHLKVL8zj9LrbIQbzOUzL/oOXf+z8Ayl+yAwUFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757156743; c=relaxed/simple;
	bh=qMYBvVdJ1HSlHVvYz/hS01oKPmqpmnjHlzwp0s/H3Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKQWIalOkuTLuXPTlNgPruTrCVMDe5GNzgNf7pp+A2Bwgg21SLxmBUtGHnoM9bu3/5WcRVhzqQnYDn2N8+UnZtpz4pdjyTwvcmsVYDA62xr9touZZpue61gHnBaocxBZ0C8orDLCeHrO8gl9o/pZ2s5oZZEnvTqddvkijXJVIYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aSL7H53b; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aSL7H53b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757156742; x=1788692742;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qMYBvVdJ1HSlHVvYz/hS01oKPmqpmnjHlzwp0s/H3Mk=;
  b=aSL7H53bhm7/uuZTm8A6I2ZrU2D3bsaVpzhPuE+tfxW0aBrFNRt3ory1
   Xou5EkhJHFMLmt9wWofH+1FfNMAoB0NYsSh3l3mPCLt3xGNwTDnJflzIN
   P1eg1I/NOeDMyzinX10odD1dXe0tCSo/amyLjD1qEWMCCkuv//cVAd3a/
   lO9OomlLLuGxKvT7xVdx1N+WrvsmPTfiHGCyIZrH3MrPXzsoWNRuOLsZl
   RV/aoowlsflZU34FbIcgHm+IzQeEu5xih4Lyhj8VprUoErRzQlnI40wt2
   B296Pdy2rtnI3HHl22o6r4goz3+4dNbL0dWEjoUOLQ2ploYADB6SwO7oa
   A==;
X-CSE-ConnectionGUID: HR06TIhmTB6x/JE2RlpV1A==
X-CSE-MsgGUID: NA6UrYlUQWuZlPFnTEBc2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="47058313"
X-IronPort-AV: E=Sophos;i="6.18,244,1751266800"; 
   d="scan'208";a="47058313"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 04:05:31 -0700
X-CSE-ConnectionGUID: nGcxIybSS1qxAhsECIbVLQ==
X-CSE-MsgGUID: /xIRjD2aS3+C7ekmIsiaOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,244,1751266800"; 
   d="scan'208";a="196028943"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 06 Sep 2025 04:05:27 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uuqjV-0001NR-1N;
	Sat, 06 Sep 2025 11:05:25 +0000
Date: Sat, 6 Sep 2025 19:04:58 +0800
From: kernel test robot <lkp@intel.com>
To: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Luiz Von Dentz <luiz.dentz@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Sean Wang <sean.wang@mediatek.com>,
	Jiande Lu <jiande.lu@mediatek.com>,
	Deren Wu <deren.Wu@mediatek.com>, Chris Lu <chris.lu@mediatek.com>,
	Hao Qin <Hao.qin@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-mediatek <linux-mediatek@lists.infradead.org>,
	Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
Subject: Re: [PATCH v7 1/1] Bluetooth: mediatek: add gpio pin to reset bt
Message-ID: <202509061837.tyzBvcs9-lkp@intel.com>
References: <20250905084059.26959-2-ot_zhangchao.zhang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905084059.26959-2-ot_zhangchao.zhang@mediatek.com>

Hi Zhangchao,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth/master]
[also build test ERROR on bluetooth-next/master linus/master v6.17-rc4 next-20250905]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhangchao-Zhang/Bluetooth-mediatek-add-gpio-pin-to-reset-bt/20250905-164341
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/20250905084059.26959-2-ot_zhangchao.zhang%40mediatek.com
patch subject: [PATCH v7 1/1] Bluetooth: mediatek: add gpio pin to reset bt
config: x86_64-buildonly-randconfig-001-20250906 (https://download.01.org/0day-ci/archive/20250906/202509061837.tyzBvcs9-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250906/202509061837.tyzBvcs9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509061837.tyzBvcs9-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/bluetooth/btmtk.c:370:34: error: incompatible pointer types passing 'struct device_node *' to parameter of type 'struct device *' [-Werror,-Wincompatible-pointer-types]
     370 |         reset_gpio = gpiod_get_optional(hdev->dev.of_node, "reset", GPIOD_OUT_HIGH);
         |                                         ^~~~~~~~~~~~~~~~~
   include/linux/gpio/consumer.h:72:66: note: passing argument to parameter 'dev' here
      72 | struct gpio_desc *__must_check gpiod_get_optional(struct device *dev,
         |                                                                  ^
   1 error generated.


vim +370 drivers/bluetooth/btmtk.c

   363	
   364	static int btmtk_hw_gpio_reset(struct hci_dev *hdev, struct btmtk_data *reset_work)
   365	{
   366		struct gpio_desc *reset_gpio;
   367	
   368		/* Find device node*/
   369		hdev->dev.of_node = of_find_compatible_node(NULL, NULL, "mediatek,mt7925-bluetooth");
 > 370		reset_gpio = gpiod_get_optional(hdev->dev.of_node, "reset", GPIOD_OUT_HIGH);
   371		if (IS_ERR(reset_gpio))
   372			return PTR_ERR(reset_gpio);
   373	
   374		if (!reset_gpio)
   375			return -ENODEV;
   376	
   377		if (test_and_set_bit(BTMTK_HW_RESET_ACTIVE, &reset_work->flags)) {
   378			bt_dev_err(hdev, "last reset failed? Not resetting again");
   379			gpiod_put(reset_gpio);
   380			return -EBUSY;
   381		}
   382		gpiod_set_value_cansleep(reset_gpio, 0);
   383		msleep(100);
   384		gpiod_set_value_cansleep(reset_gpio, 1);
   385		gpiod_put(reset_gpio);
   386		return 0;
   387	}
   388	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
