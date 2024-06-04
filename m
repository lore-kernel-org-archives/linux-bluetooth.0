Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355153236;
	Tue,  4 Jun 2024 11:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717500616; cv=none; b=WGiLTnQHZQokUbWjcurFwV9OYL0kiYLIurtsgaeiPn+j3zrgvd5k1A90BUHCZHpG9BHRh6tP+cMqTphO5tziPZuQysupldxKSd1TGXoJf5EHa66Fsv6l5kTZkKsaIGKFflSsRCKpgG3HW186kHT/JbzCCk8u/Jz781FbNoXd214=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717500616; c=relaxed/simple;
	bh=TSTA2G2LQUoLI818l9IzE6WcYMZFTkdSN3J60PlP/OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUK6K1LtbYSCJ0YdbuSatG5du47SttAExr+uHpWPjePti8Th4cBiGjkhXHpJQ525u9wYF6bmUj5gLKOX1hemBxzmozqIPIwuHooxEWPRCwFeDl8Yc2tQyyfUmFQmpJoxm6yc7SEYe7Qoe3EAbR6dm+B3u1rVkl0XMmQ/Lc2j1tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OdRrewFP; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OdRrewFP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717500614; x=1749036614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TSTA2G2LQUoLI818l9IzE6WcYMZFTkdSN3J60PlP/OM=;
  b=OdRrewFP5MUVENDRqkkcuHEBPp/VmaAIOHBfvDoyeVA4sPjbgEcgCn+S
   mxS1mSQ8fZGnK1y1AclN/EBBmcyRA4VeNzfzYc7xIXy8mzC92z0Z9OQo6
   8T90/gbKrZdzLAdL51tZ4FSlZ+7DHBP+h779lyRKiylWQwPL7EQ2KTNfQ
   SclejSY99WDVb806Iqa+nbC+Eucb5tpLuztueF/LV5BnzorMWgL/VCKDR
   vIVEASKy38b2JvYomtHUuGQp55sQa4iO/DYQ14gvZm8llWbPP3IJdXPTE
   cri0RB0+ANh7CRRBNsvbq8HGCgQAu+FW9GUnj4c8YD1/WjRmRxRwYZfyW
   A==;
X-CSE-ConnectionGUID: yoedKoM6S3+44ld1Z20dUw==
X-CSE-MsgGUID: WKEPKTdaRlmfMrXI8MXxvA==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="14263076"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="14263076"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 04:30:13 -0700
X-CSE-ConnectionGUID: SpeJQ3pTRt+lLlyUgBliTg==
X-CSE-MsgGUID: PDxX2zhER16Ox+JxrCjxVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="41670248"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 04 Jun 2024 04:30:09 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sESMh-000N8x-06;
	Tue, 04 Jun 2024 11:30:07 +0000
Date: Tue, 4 Jun 2024 19:29:28 +0800
From: kernel test robot <lkp@intel.com>
To: Andreas Kemnade <andreas@kemnade.info>, marcel@holtmann.org,
	luiz.dentz@gmail.com, johan@kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, pmenzel@molgen.mpg.de,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Adam Ford <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>,
	tomi.valkeinen@ideasonboard.com,
	=?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@gmail.com>,
	robh@kernel.org, hns@goldelico.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 3/4] gnss: Add driver for AI2 protocol
Message-ID: <202406041854.1Ad8rnRn-lkp@intel.com>
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
[also build test ERROR on bluetooth-next/master char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.10-rc2 next-20240604]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andreas-Kemnade/gnss-Add-AI2-protocol-used-by-some-TI-combo-chips/20240603-224753
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/20240603144400.2195564-4-andreas%40kemnade.info
patch subject: [PATCH v3 3/4] gnss: Add driver for AI2 protocol
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20240604/202406041854.1Ad8rnRn-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240604/202406041854.1Ad8rnRn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406041854.1Ad8rnRn-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gnss/ai2.c:9:
   In file included from include/linux/gnss.h:13:
   In file included from include/linux/kfifo.h:42:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2210:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/gnss/ai2.c:9:
   In file included from include/linux/gnss.h:13:
   In file included from include/linux/kfifo.h:42:
   In file included from include/linux/scatterlist.h:9:
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
   In file included from drivers/gnss/ai2.c:9:
   In file included from include/linux/gnss.h:13:
   In file included from include/linux/kfifo.h:42:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/gnss/ai2.c:9:
   In file included from include/linux/gnss.h:13:
   In file included from include/linux/kfifo.h:42:
   In file included from include/linux/scatterlist.h:9:
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
>> drivers/gnss/ai2.c:340:6: error: call to undeclared function 'get_unaligned_le16'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     340 |         if (get_unaligned_le16(data + i) != sum) {
         |             ^
   7 warnings and 1 error generated.


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
