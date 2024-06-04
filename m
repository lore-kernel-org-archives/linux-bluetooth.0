Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF8C79C0;
	Tue,  4 Jun 2024 00:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717462050; cv=none; b=lU3TfCQx65IXcErXFqTmpoitLqeynROmUX0J6vCU8tSv7Unyv0sxLItWMQW07v5m+VEJKYrz577qy1PoT8AGJsFjbBjoYyCphv/pHCbsb9p/Ta+BhhehVnqkPr4X2LlbJz7ewcFixc9OI9Ngd5w+1bOWLxyukQojpemdkxNoZ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717462050; c=relaxed/simple;
	bh=FWnAe1hhrfgO1luWWJOhc9cfPlz2YWEEETdh0J87RiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCjwJhgYB8PSrVcEwTsTx2J+nd9YaU9kXBv57wGKVIkuX6Gz9PGk/qe1D2clPdCZwK9Ze4eCPL79TSV6KW02Y/TKzw5v/guMlbWo3mX+V+k6/XuFGTSSogUK8UM+AIXVhjWBLy0O+FPCojGXNGlkVZmuEqAjmk4rP17Mz1IK6l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/HpZiwX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/HpZiwX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717462049; x=1748998049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FWnAe1hhrfgO1luWWJOhc9cfPlz2YWEEETdh0J87RiQ=;
  b=f/HpZiwXr687EFmMHBRaA+HUw94bD51QOruNlZD57HdJ/K54pKIPcidd
   wyb8h1CXB8vz2mZUgp3fS8eRy1jMlYBDrIdfzv8oU2oU6nXECv5L/RwJU
   yXwSFBlHikqXWcXO/bq3Aftt05rk2k0VkjI/bCVMy3mLKSnjMLbWqAaR9
   zpF9Zz9CRn531d1xUuSgfDfl+F8DHABVSaPgonsBk53ozGTGogt1TMr63
   4XALtszXe/+3udIdGcHNuL0FkYFmIHhSE64Lvd5pkw09PICxshcOLMEm3
   ELigZTh4dypg/oCFQOPEsqMbFcDyDRT0AXlF4nJGKtA4uLdlWVRfAoXAj
   Q==;
X-CSE-ConnectionGUID: zdswjwRbQmGfsVdJdTDSxQ==
X-CSE-MsgGUID: BFvvDnLlS8adDt0GBK9x2w==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="39389046"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="39389046"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 17:47:28 -0700
X-CSE-ConnectionGUID: lN988g0sSxKPvO+weZBQFA==
X-CSE-MsgGUID: xbYcz/MLSr+cyyYI1Bq7nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="36937510"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 03 Jun 2024 17:47:24 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEIKf-000MMl-2m;
	Tue, 04 Jun 2024 00:47:21 +0000
Date: Tue, 4 Jun 2024 08:46:28 +0800
From: kernel test robot <lkp@intel.com>
To: Andreas Kemnade <andreas@kemnade.info>, marcel@holtmann.org,
	luiz.dentz@gmail.com, johan@kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, pmenzel@molgen.mpg.de,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Adam Ford <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>,
	tomi.valkeinen@ideasonboard.com,
	=?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@gmail.com>,
	robh@kernel.org, hns@goldelico.com
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 3/4] gnss: Add driver for AI2 protocol
Message-ID: <202406040854.fSEvlFam-lkp@intel.com>
References: <20240603144400.2195564-4-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603144400.2195564-4-andreas@kemnade.info>

Hi Andreas,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth/master]
[also build test ERROR on bluetooth-next/master char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.10-rc2 next-20240603]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andreas-Kemnade/gnss-Add-AI2-protocol-used-by-some-TI-combo-chips/20240603-224753
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/20240603144400.2195564-4-andreas%40kemnade.info
patch subject: [PATCH v3 3/4] gnss: Add driver for AI2 protocol
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240604/202406040854.fSEvlFam-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240604/202406040854.fSEvlFam-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406040854.fSEvlFam-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gnss/ai2.c: In function 'process_ai2_frame':
>> drivers/gnss/ai2.c:340:13: error: implicit declaration of function 'get_unaligned_le16' [-Werror=implicit-function-declaration]
     340 |         if (get_unaligned_le16(data + i) != sum) {
         |             ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/get_unaligned_le16 +340 drivers/gnss/ai2.c

   324	
   325	/* do some sanity checks and split frame into packets */
   326	static void process_ai2_frame(struct ai2_device *ai2dev)
   327	{
   328		u16 sum;
   329		int i;
   330		u8 *head;
   331		u8 *data;
   332	
   333		sum = 0;
   334		data = ai2dev->recv_skb->data;
   335		for (i = 0; i < ai2dev->recv_skb->len - 2; i++)
   336			sum += data[i];
   337	
   338		print_hex_dump_bytes("ai2 frame: ", DUMP_PREFIX_OFFSET, data, ai2dev->recv_skb->len);
   339	
 > 340		if (get_unaligned_le16(data + i) != sum) {
   341			dev_dbg(ai2dev->dev,
   342				"checksum error in reception, dropping frame\n");
   343			return;
   344		}
   345	
   346		/* reached if byte 1 in the command packet is set to 1 */
   347		if (data[1] == AI2_ACK)
   348			return;
   349	
   350		head = skb_pull(ai2dev->recv_skb, 2); /* drop frame start marker */
   351		while (head && (ai2dev->recv_skb->len >= 3)) {
   352			u8 cmd;
   353			u16 pktlen;
   354	
   355			cmd = head[0];
   356			pktlen = get_unaligned_le16(head + 1);
   357			data = skb_pull(ai2dev->recv_skb, 3);
   358			if (!data)
   359				break;
   360	
   361			if (pktlen > ai2dev->recv_skb->len)
   362				break;
   363	
   364			head = skb_pull(ai2dev->recv_skb, pktlen);
   365	
   366			process_ai2_packet(ai2dev, cmd, data, pktlen);
   367		}
   368	}
   369	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
