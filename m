Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C4626E171
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2025 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739901370; cv=none; b=UzuIHU+/Yp7erM0LssDB+60uRpWmU3u2KvGr3BG/t6c2ln3jtWzyPaOJ5ThhYgHe3JNIfDd5k7PNm8Oiud4mMDk1C+rHdu5Hm8OXWkIYg8S5iPGttT1F86yS8PdWCq3lhsDYoSig0oNRlrtU5/TU/3nsegxsGyv3VvvqXv4K9aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739901370; c=relaxed/simple;
	bh=LwOEgBwElLETGa5mmjKgJSCNdp1qJQxEEmJHrtuGThM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PST1bF8HAofRNOAqWkokmM4u9HHXX3b90+evSNJH1cNvjfjh8YwvUer0YHT7Py8L5BwE5UfSH2eP0PPA/u0P9yPGmHnrmef/4A/kKdb2NXiqYkfYjJplE8Ebxa26w6taJcMFrtmqVFPSiVIwobQgGQqqotfPVIyVpR4mOCCPyDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=khuqMXkA; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="khuqMXkA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739901368; x=1771437368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LwOEgBwElLETGa5mmjKgJSCNdp1qJQxEEmJHrtuGThM=;
  b=khuqMXkABFgTSLpR0MwLBV17D41dcxY1Eb/sB5jNSQEPk6slplOt+uj/
   itObDThmJqkLnPqcjhp+Y214WIQ2xN81v/Um+JJ+sWTgvQ/cmqVurUWd9
   mKD9zuz5FUdUnvGdpQSAqjV4Bp+dxnOLGaAuUKQ4JmNRopd70D7RA6Uq1
   Jtnjv/wGOHWShB0KdnjfwalVAyYrIpWvWYfX5uhIswUwgTQxGq65kH9JD
   ORpZQRvQLwXcYVVmA6shkHmDPMNTzd0LPo5W0SOJ7Cepdd10Aj47qNpQ9
   lhkOIs5aYQRbo1Ykam92Yl9rbJNnqGBymFNInBVoO0mWTen9/7m2fVCXQ
   A==;
X-CSE-ConnectionGUID: rXl//Co/TwO8zOKlamcOqA==
X-CSE-MsgGUID: eUYc6Ix/SIi/mVPwBaHAvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="58012154"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="58012154"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 09:55:58 -0800
X-CSE-ConnectionGUID: OO3K8ZGpRjSAeTb+Q7LBCQ==
X-CSE-MsgGUID: XKwAzA7ZTdKy0g2dP0hNLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="119554986"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 18 Feb 2025 09:55:56 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tkRp4-0000m3-0y;
	Tue, 18 Feb 2025 17:55:54 +0000
Date: Wed, 19 Feb 2025 01:54:56 +0800
From: kernel test robot <lkp@intel.com>
To: Kiran K <kiran.k@intel.com>, linux-bluetooth@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com, Kiran K <kiran.k@intel.com>
Subject: Re: [PATCH v1 1/4] Bluetooth: btintel_pcie: Setup buffers for
 firmware traces
Message-ID: <202502190143.0LmI162j-lkp@intel.com>
References: <20250218122620.762523-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218122620.762523-1-kiran.k@intel.com>

Hi Kiran,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on bluetooth/master linus/master v6.14-rc3 next-20250218]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kiran-K/Bluetooth-btintel_pcie-Read-hardware-exception-data/20250218-202903
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20250218122620.762523-1-kiran.k%40intel.com
patch subject: [PATCH v1 1/4] Bluetooth: btintel_pcie: Setup buffers for firmware traces
config: sparc-randconfig-002-20250218 (https://download.01.org/0day-ci/archive/20250219/202502190143.0LmI162j-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250219/202502190143.0LmI162j-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502190143.0LmI162j-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/bluetooth/btintel_pcie.c: In function 'btintel_pcie_setup_dbgc':
>> drivers/bluetooth/btintel_pcie.c:134:72: warning: right shift count >= width of type [-Wshift-count-overflow]
     134 |                 db_frag.bufs[i].buf_addr_msb = (u32)((buf->data_p_addr >> 32) & 0xffffffff);
         |                                                                        ^~


vim +134 drivers/bluetooth/btintel_pcie.c

    90	
    91	/* This function initializes the memory for DBGC buffers and formats the
    92	 * DBGC fragment which consists header info and DBGC buffer's LSB, MSB and
    93	 * size as the payload
    94	 */
    95	static int btintel_pcie_setup_dbgc(struct btintel_pcie_data *data)
    96	{
    97		struct btintel_pcie_dbgc_ctxt db_frag;
    98		struct data_buf *buf;
    99		int i;
   100	
   101		data->dbgc.count = BTINTEL_PCIE_DBGC_BUFFER_COUNT;
   102		data->dbgc.bufs = devm_kcalloc(&data->pdev->dev, data->dbgc.count,
   103					       sizeof(*buf), GFP_KERNEL);
   104		if (!data->dbgc.bufs)
   105			return -ENOMEM;
   106	
   107		data->dbgc.buf_v_addr = dmam_alloc_coherent(&data->pdev->dev,
   108							    data->dbgc.count *
   109							    BTINTEL_PCIE_DBGC_BUFFER_SIZE,
   110							    &data->dbgc.buf_p_addr,
   111							    GFP_KERNEL | __GFP_NOWARN);
   112		if (!data->dbgc.buf_v_addr)
   113			return -ENOMEM;
   114	
   115		data->dbgc.frag_v_addr = dmam_alloc_coherent(&data->pdev->dev,
   116							     sizeof(struct btintel_pcie_dbgc_ctxt),
   117							     &data->dbgc.frag_p_addr,
   118							     GFP_KERNEL | __GFP_NOWARN);
   119		if (!data->dbgc.frag_v_addr)
   120			return -ENOMEM;
   121	
   122		data->dbgc.frag_size = sizeof(struct btintel_pcie_dbgc_ctxt);
   123	
   124		db_frag.magic_num = BTINTEL_PCIE_MAGIC_NUM;
   125		db_frag.ver = BTINTEL_PCIE_DBGC_FRAG_VERSION;
   126		db_frag.total_size = BTINTEL_PCIE_DBGC_FRAG_PAYLOAD_SIZE;
   127		db_frag.num_buf = BTINTEL_PCIE_DBGC_FRAG_BUFFER_COUNT;
   128	
   129		for (i = 0; i < data->dbgc.count; i++) {
   130			buf = &data->dbgc.bufs[i];
   131			buf->data_p_addr = data->dbgc.buf_p_addr + i * BTINTEL_PCIE_DBGC_BUFFER_SIZE;
   132			buf->data = data->dbgc.buf_v_addr + i * BTINTEL_PCIE_DBGC_BUFFER_SIZE;
   133			db_frag.bufs[i].buf_addr_lsb = (u32)(buf->data_p_addr & 0xffffffff);
 > 134			db_frag.bufs[i].buf_addr_msb = (u32)((buf->data_p_addr >> 32) & 0xffffffff);
   135			db_frag.bufs[i].buf_size = BTINTEL_PCIE_DBGC_BUFFER_SIZE;
   136		}
   137	
   138		memcpy(data->dbgc.frag_v_addr, &db_frag, sizeof(db_frag));
   139		return 0;
   140	}
   141	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
