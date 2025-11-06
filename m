Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0C826ACB
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Nov 2025 03:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762399558; cv=none; b=lqVb/QaQom1jn96xL0zdHFfGpbiaAc7AvPumaClRSOxQpIHdVw5iP5+iDnYX8aP/R/hWrpVucHamascFQbbANMq7to9sBfaeP4EFx2xnHxFVMfoFHiPcoCIdWMVb/d1GSOJkIDgitRWbXM3ZCQyY/kigroTX7SYafvWx/MFKZMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762399558; c=relaxed/simple;
	bh=TVPL5Y8wTO7zDSVKPKd2ZKD08gTy26YTPkgy4WgfZfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gs0f//OQt39JsTL3PUUGzQxkWZkoiSNrPQEJGRQ3/dkBRw9Tfh8FKjXB+Z9Klya/AhJkH6zd5J9BtxeOq4DVsuZyqwLp1cVlSYztqLjyphTO3IB9jGbjKVVpQuMWxcKu0HzQTBm0Em+O+AFBj6rdVlr6lhTTxps5gRd2V2fM9CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nfh8Zvc8; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nfh8Zvc8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762399556; x=1793935556;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TVPL5Y8wTO7zDSVKPKd2ZKD08gTy26YTPkgy4WgfZfk=;
  b=nfh8Zvc8N5+svQ2lZ61j4m4HXtYkDohwWc0cM28QHDsp+/7mrXzqnOuC
   5imIjVOlS5KrlnPcpKb8fUXDtv03B9NSo2VaKlPc9gzZHweLFFXoQJh6D
   5YmqQhyS0PJJUO+Ddnmq4C5R7YQbXJPnr+0LxEXifjttfXQiHydBP+Slc
   2GK2rO8uS3kOsYUbDvTiYAGVsQ7xjAwpW/5DUStd0MZyrwyrJ/5V+7NqQ
   0c0kJNAQerABbZX9+kVlyn8ilO4eFPKGkHdoA4S5FZyv8ofPP3Fq/wvEC
   30AlnLIVCPlmhgBXiDTDpznzUP0x7/QGyunYJaE/mijTE5ePGjQZ20eqY
   g==;
X-CSE-ConnectionGUID: Kb0TD03jTz6Jeuzg7FwUPg==
X-CSE-MsgGUID: bLoebm/4S4KTvS0Eg3HxRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="68388307"
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="68388307"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 19:25:56 -0800
X-CSE-ConnectionGUID: D/9mhqmSRAqy7SZ2++hTjQ==
X-CSE-MsgGUID: BYQg6bwbTWaIai9smGwbvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="192812795"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 05 Nov 2025 19:25:54 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGqd9-000TRQ-2J;
	Thu, 06 Nov 2025 03:25:49 +0000
Date: Thu, 6 Nov 2025 11:24:44 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1 2/2] Bluetooth: btusb: Add support for Bulk
 Serialization Mode
Message-ID: <202511061054.iucfnuVO-lkp@intel.com>
References: <20251105170445.518320-2-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105170445.518320-2-luiz.dentz@gmail.com>

Hi Luiz,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth-next/master]
[also build test ERROR on bluetooth/master linus/master v6.18-rc4 next-20251105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luiz-Augusto-von-Dentz/Bluetooth-btusb-Add-support-for-Bulk-Serialization-Mode/20251106-024830
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20251105170445.518320-2-luiz.dentz%40gmail.com
patch subject: [PATCH v1 2/2] Bluetooth: btusb: Add support for Bulk Serialization Mode
config: nios2-randconfig-002-20251106 (https://download.01.org/0day-ci/archive/20251106/202511061054.iucfnuVO-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251106/202511061054.iucfnuVO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511061054.iucfnuVO-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/bluetooth/btusb.c: In function 'btusb_recv_h4':
>> drivers/bluetooth/btusb.c:1286:17: error: implicit declaration of function 'h4_recv_skb'; did you mean 'sk_eat_skb'? [-Werror=implicit-function-declaration]
     data->rx_skb = h4_recv_skb(data->hdev, NULL, NULL, data->rx_skb, buffer,
                    ^~~~~~~~~~~
                    sk_eat_skb
>> drivers/bluetooth/btusb.c:1286:15: warning: assignment to 'struct sk_buff *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     data->rx_skb = h4_recv_skb(data->hdev, NULL, NULL, data->rx_skb, buffer,
                  ^
   cc1: some warnings being treated as errors


vim +1286 drivers/bluetooth/btusb.c

  1280	
  1281	static int btusb_recv_h4(struct btusb_data *data, void *buffer, int count)
  1282	{
  1283		unsigned long flags;
  1284	
  1285		spin_lock_irqsave(&data->rxlock, flags);
> 1286		data->rx_skb = h4_recv_skb(data->hdev, NULL, NULL, data->rx_skb, buffer,
  1287					   count, btusb_recv_pkts,
  1288					   ARRAY_SIZE(btusb_recv_pkts));
  1289		spin_unlock_irqrestore(&data->rxlock, flags);
  1290	
  1291		return 0;
  1292	}
  1293	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
