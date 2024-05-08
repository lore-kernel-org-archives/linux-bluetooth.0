Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371FE8174F;
	Wed,  8 May 2024 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167412; cv=none; b=gD9e+QM5USsDSREMGIweutA+e2Q6uNMrNAK/VBwCYMoejMwMVcH5osd1Otc1ayEZ3b0lPOF6ejsmwdebK6VDnb3H4oYqK65fIOV/HGaSuJ4OX6Oxel9vJW9HZibvg5raLV/ACJY0LynL1Rq9LJcGC+ye1FtSoBP/tQu/PR8iPWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167412; c=relaxed/simple;
	bh=Cc81Sm9+kFaTqiurwOpfbIBmuCu+bUVjuSjxcgMXyO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saMRYjPZBSkvBparsXsgnQyPplQMvLtMtssrYuEAbejXRjEQZEzIPrlx5+WW4jyDx8/knVddd7Fl2da6gK/dO4plTK4k4s/7teoAjB2pFO69G17KOVSArT9L23k5bwq54xgv4BQoQMuSMVngZu/kTXtRd/E8a4OxJNbVY7stc+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JSSzMdKe; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JSSzMdKe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715167410; x=1746703410;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cc81Sm9+kFaTqiurwOpfbIBmuCu+bUVjuSjxcgMXyO4=;
  b=JSSzMdKebr4EmKplin4OpmBXJnvnVQ8RkQDxdPdzgwf+Cz22OC4UUDAt
   qSHGWb5HrrLEk6Ph389I0h9kNbwfZUJbERgo/Xm6oyhdndoYsmJi+ofHO
   AKDN2QyttHqvSD5OYqd/8wGtk/ARDlpKm/0XkqCNrzoXcP0m4f+BbaJT6
   LJpxqwnxmlUKFbl+aJm+UBly/tWppO2f7TAIXRVsoZvscoe5DMP4Z2XBL
   VH/2IZ6wm7Fk3gdwTAooz0Oba8hEMaz4uz44KEPP4ziu4eMoR/m+7H/Yu
   NRnFHMYaAsBnszqRnqdB5D9+6pNZsri/PuvUQRcJC7WtnzJF87KaMXh1F
   g==;
X-CSE-ConnectionGUID: 6HmUHXaYS0KiRtTCm4ydTQ==
X-CSE-MsgGUID: wJ0+xoKjQQWObwgM/jSLow==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="22412246"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="22412246"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 04:23:30 -0700
X-CSE-ConnectionGUID: HQZM8k96QZOhQgZVyNEMJg==
X-CSE-MsgGUID: dcpymqCtT9uJPwoz8me6EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="59714775"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 08 May 2024 04:23:26 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4fOO-0003LE-0i;
	Wed, 08 May 2024 11:23:24 +0000
Date: Wed, 8 May 2024 19:22:54 +0800
From: kernel test robot <lkp@intel.com>
To: sean.wang@kernel.org, marcel@holtmann.org, johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH v4 1/5] Bluetooth: btmtk: add the function to get the fw
 name
Message-ID: <202405081828.e6IMNKPn-lkp@intel.com>
References: <965cd14922aea67e2750ff2c2ecad773f8ba485a.1715109394.git.sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <965cd14922aea67e2750ff2c2ecad773f8ba485a.1715109394.git.sean.wang@kernel.org>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on bluetooth-next/master linus/master v6.9-rc7 next-20240508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/sean-wang-kernel-org/Bluetooth-btmtk-apply-the-common-btmtk_fw_get_filename/20240508-032333
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/965cd14922aea67e2750ff2c2ecad773f8ba485a.1715109394.git.sean.wang%40kernel.org
patch subject: [PATCH v4 1/5] Bluetooth: btmtk: add the function to get the fw name
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240508/202405081828.e6IMNKPn-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 0ab4458df0688955620b72cc2c72a32dffad3615)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240508/202405081828.e6IMNKPn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405081828.e6IMNKPn-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/bluetooth/btmtk.c:8:
   In file included from include/net/bluetooth/bluetooth.h:30:
   In file included from include/net/sock.h:38:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/bluetooth/btmtk.c:8:
   In file included from include/net/bluetooth/bluetooth.h:30:
   In file included from include/net/sock.h:38:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/bluetooth/btmtk.c:8:
   In file included from include/net/bluetooth/bluetooth.h:30:
   In file included from include/net/sock.h:38:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   In file included from drivers/bluetooth/btmtk.c:8:
   In file included from include/net/bluetooth/bluetooth.h:30:
   In file included from include/net/sock.h:46:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/mm.h:2210:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/bluetooth/btmtk.c:114:3: warning: 'snprintf' will always be truncated; specified size is 4, but format string expands to at least 41 [-Wformat-truncation]
     114 |                 snprintf(buf, sizeof(size),
         |                 ^
   8 warnings generated.


vim +/snprintf +114 drivers/bluetooth/btmtk.c

   105	
   106	void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id, u32 fw_ver,
   107				   u32 fw_flavor)
   108	{
   109		if (dev_id == 0x7925)
   110			snprintf(buf, size,
   111				 "mediatek/mt%04x/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
   112				 dev_id & 0xffff, dev_id & 0xffff, (fw_ver & 0xff) + 1);
   113		else if (dev_id == 0x7961 && fw_flavor)
 > 114			snprintf(buf, sizeof(size),
   115				 "mediatek/BT_RAM_CODE_MT%04x_1a_%x_hdr.bin",
   116				 dev_id & 0xffff, (fw_ver & 0xff) + 1);
   117		else
   118			snprintf(buf, size,
   119				 "mediatek/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
   120				 dev_id & 0xffff, (fw_ver & 0xff) + 1);
   121	}
   122	EXPORT_SYMBOL_GPL(btmtk_fw_get_filename);
   123	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
