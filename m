Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEC9230BDF
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Aug 2025 20:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756499745; cv=none; b=hi6vMb+PrTuNV/peyvvkyhY8TwqG7FNM402fo3Q6ate6Ul5/VBFaYu8Vldt7UHHFciKCXx2exPG332HRTyvDBcRY5dyYcMXS6Q47mVFov29HjiuUgPgtnSrCIYU6EcnRVm6rSdVZ3xJafv3Xz7qY3ft5wN08Ouy43bzdnS12faQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756499745; c=relaxed/simple;
	bh=80KHaqQ/lXXngNHou4D/Yf7FfEO74zFdYMGEFI1Auok=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ooaDI/SSriY1kPx9qRxKdFh6bd2FU4vhvnQ5h8YH/ovlF+zl+mZvyyjVHFaL9sRMvHuLmOYXv6RQz7yan8/1K0dwcc3yYtrupgUfVILlWoxu8g+5YMRzy9dar6lzfTyW8TS34fvUJMh1qIVAGoXRLIxHj/B1rmWjk9ayRNuO8Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lv7mBn10; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lv7mBn10"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756499744; x=1788035744;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=80KHaqQ/lXXngNHou4D/Yf7FfEO74zFdYMGEFI1Auok=;
  b=lv7mBn108y5zB9UqEKp5MesAeTgZ5xHWOKft5P3KJV8wpuHVRR35fFbt
   qAm/g0ZUhTFRYR09BUvLIOz5bYxJG1kaYyGruSL4vcodrooL8+xVEHefW
   KR6QQVJVNfATzdjAviyKQiAA3+RgTve3yL52Bgd/jJfEW4bnVGMByjN4/
   kHUUUWiuGIcYwQVWjVr1BxJT/+OuAD7g2IxJ2sDFO7uNdpeJjHQHEqWxr
   shFkJS+93cEa/5MJdDmNnOCOnqd/Vu4A/Cpxae/rddE1wpsGgA7ZI5zxn
   mvOIsWoQZIRN75D9UY4LsRHsz6AW8OzgXMff5vmwfwlhDlTAQGPlMdlQe
   w==;
X-CSE-ConnectionGUID: M7b3ieSnREqna23jJOfz8A==
X-CSE-MsgGUID: JnBCKCgiT2mc34fXZsiCYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="58501513"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="58501513"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 13:35:43 -0700
X-CSE-ConnectionGUID: cOtQKbmmRyyNZCJ4sDmItw==
X-CSE-MsgGUID: +sgJSq/4RECfykZD5GFp3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="174820596"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 29 Aug 2025 13:35:41 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1us5oQ-000UxB-3B;
	Fri, 29 Aug 2025 20:35:19 +0000
Date: Sat, 30 Aug 2025 04:34:06 +0800
From: kernel test robot <lkp@intel.com>
To: Calvin Owens <calvin@wbinvd.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [bluetooth-next:master 83/84] drivers/bluetooth/btmtksdio.c:442:33:
 error: array type has incomplete element type 'struct h4_recv_pkt'
Message-ID: <202508300413.OnIedvRh-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
head:   02925b3b935e2203077ec974b93bf2d5f84ab754
commit: 0e272fc7e17d429b018d4f2d9c5cacab10f5fab5 [83/84] Bluetooth: remove duplicate h4_recv_buf() in header
config: nios2-randconfig-002-20250830 (https://download.01.org/0day-ci/archive/20250830/202508300413.OnIedvRh-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250830/202508300413.OnIedvRh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508300413.OnIedvRh-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/bluetooth/btmtksdio.c:442:33: error: array type has incomplete element type 'struct h4_recv_pkt'
    static const struct h4_recv_pkt mtk_recv_pkts[] = {
                                    ^~~~~~~~~~~~~
>> drivers/bluetooth/btmtksdio.c:443:4: error: 'H4_RECV_ACL' undeclared here (not in a function); did you mean 'IP_RECVTTL'?
     { H4_RECV_ACL,      .recv = btmtksdio_recv_acl },
       ^~~~~~~~~~~
       IP_RECVTTL
>> drivers/bluetooth/btmtksdio.c:443:22: error: field name not in record or union initializer
     { H4_RECV_ACL,      .recv = btmtksdio_recv_acl },
                         ^
   drivers/bluetooth/btmtksdio.c:443:22: note: (near initialization for 'mtk_recv_pkts')
>> drivers/bluetooth/btmtksdio.c:444:4: error: 'H4_RECV_SCO' undeclared here (not in a function)
     { H4_RECV_SCO,      .recv = hci_recv_frame },
       ^~~~~~~~~~~
   drivers/bluetooth/btmtksdio.c:444:22: error: field name not in record or union initializer
     { H4_RECV_SCO,      .recv = hci_recv_frame },
                         ^
   drivers/bluetooth/btmtksdio.c:444:22: note: (near initialization for 'mtk_recv_pkts')
>> drivers/bluetooth/btmtksdio.c:445:4: error: 'H4_RECV_EVENT' undeclared here (not in a function); did you mean 'BPF_PERF_EVENT'?
     { H4_RECV_EVENT,    .recv = btmtksdio_recv_event },
       ^~~~~~~~~~~~~
       BPF_PERF_EVENT
   drivers/bluetooth/btmtksdio.c:445:22: error: field name not in record or union initializer
     { H4_RECV_EVENT,    .recv = btmtksdio_recv_event },
                         ^
   drivers/bluetooth/btmtksdio.c:445:22: note: (near initialization for 'mtk_recv_pkts')
   In file included from include/linux/cleanup.h:5,
                    from include/linux/irqflags.h:17,
                    from include/asm-generic/cmpxchg.h:15,
                    from ./arch/nios2/include/generated/asm/cmpxchg.h:1,
                    from include/asm-generic/atomic.h:12,
                    from ./arch/nios2/include/generated/asm/atomic.h:1,
                    from include/linux/atomic.h:7,
                    from drivers/bluetooth/btmtksdio.c:14:
   drivers/bluetooth/btmtksdio.c: In function 'btmtksdio_rx_packet':
   include/linux/compiler.h:197:82: error: expression in static assertion is not an integer
    #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
                                                                                     ^
   include/linux/compiler.h:202:28: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
    #define __must_be_array(a) __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
                               ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                                              ^~~~~~~~~~~~~~~
   drivers/bluetooth/btmtksdio.c:451:19: note: in expansion of macro 'ARRAY_SIZE'
     int pkts_count = ARRAY_SIZE(mtk_recv_pkts);
                      ^~~~~~~~~~
>> drivers/bluetooth/btmtksdio.c:493:34: error: invalid use of undefined type 'struct h4_recv_pkt'
      if (sdio_hdr->bt_type == (&pkts[i])->type)
                                     ^
>> drivers/bluetooth/btmtksdio.c:493:34: error: dereferencing pointer to incomplete type 'const struct h4_recv_pkt'
   drivers/bluetooth/btmtksdio.c:504:23: error: invalid use of undefined type 'struct h4_recv_pkt'
     if (skb->len < (&pkts[i])->hlen) {
                          ^
   drivers/bluetooth/btmtksdio.c:509:16: error: invalid use of undefined type 'struct h4_recv_pkt'
     switch ((&pkts[i])->lsize) {
                   ^
   drivers/bluetooth/btmtksdio.c:511:26: error: invalid use of undefined type 'struct h4_recv_pkt'
      dlen = skb->data[(&pkts[i])->loff];
                             ^
   drivers/bluetooth/btmtksdio.c:515:15: error: invalid use of undefined type 'struct h4_recv_pkt'
            (&pkts[i])->loff);
                  ^
   drivers/bluetooth/btmtksdio.c:521:30: error: invalid use of undefined type 'struct h4_recv_pkt'
     pad_size = skb->len - (&pkts[i])->hlen -  dlen;
                                 ^
   drivers/bluetooth/btmtksdio.c:533:8: error: invalid use of undefined type 'struct h4_recv_pkt'
     (&pkts[i])->recv(bdev->hdev, skb);
           ^
   At top level:
>> drivers/bluetooth/btmtksdio.c:442:33: warning: 'mtk_recv_pkts' defined but not used [-Wunused-variable]
    static const struct h4_recv_pkt mtk_recv_pkts[] = {
                                    ^~~~~~~~~~~~~


vim +442 drivers/bluetooth/btmtksdio.c

db57b625912abc Sean Wang 2021-11-20  441  
9aebfd4a2200ab Sean Wang 2019-03-08 @442  static const struct h4_recv_pkt mtk_recv_pkts[] = {
db57b625912abc Sean Wang 2021-11-20 @443  	{ H4_RECV_ACL,      .recv = btmtksdio_recv_acl },
9aebfd4a2200ab Sean Wang 2019-03-08 @444  	{ H4_RECV_SCO,      .recv = hci_recv_frame },
9aebfd4a2200ab Sean Wang 2019-03-08 @445  	{ H4_RECV_EVENT,    .recv = btmtksdio_recv_event },
9aebfd4a2200ab Sean Wang 2019-03-08  446  };
9aebfd4a2200ab Sean Wang 2019-03-08  447  
9aebfd4a2200ab Sean Wang 2019-03-08  448  static int btmtksdio_rx_packet(struct btmtksdio_dev *bdev, u16 rx_size)
9aebfd4a2200ab Sean Wang 2019-03-08  449  {
9aebfd4a2200ab Sean Wang 2019-03-08  450  	const struct h4_recv_pkt *pkts = mtk_recv_pkts;
9aebfd4a2200ab Sean Wang 2019-03-08  451  	int pkts_count = ARRAY_SIZE(mtk_recv_pkts);
9aebfd4a2200ab Sean Wang 2019-03-08  452  	struct mtkbtsdio_hdr *sdio_hdr;
9aebfd4a2200ab Sean Wang 2019-03-08  453  	int err, i, pad_size;
9aebfd4a2200ab Sean Wang 2019-03-08  454  	struct sk_buff *skb;
9aebfd4a2200ab Sean Wang 2019-03-08  455  	u16 dlen;
9aebfd4a2200ab Sean Wang 2019-03-08  456  
9aebfd4a2200ab Sean Wang 2019-03-08  457  	if (rx_size < sizeof(*sdio_hdr))
9aebfd4a2200ab Sean Wang 2019-03-08  458  		return -EILSEQ;
9aebfd4a2200ab Sean Wang 2019-03-08  459  
9aebfd4a2200ab Sean Wang 2019-03-08  460  	/* A SDIO packet is exactly containing a Bluetooth packet */
9aebfd4a2200ab Sean Wang 2019-03-08  461  	skb = bt_skb_alloc(rx_size, GFP_KERNEL);
9aebfd4a2200ab Sean Wang 2019-03-08  462  	if (!skb)
9aebfd4a2200ab Sean Wang 2019-03-08  463  		return -ENOMEM;
9aebfd4a2200ab Sean Wang 2019-03-08  464  
9aebfd4a2200ab Sean Wang 2019-03-08  465  	skb_put(skb, rx_size);
9aebfd4a2200ab Sean Wang 2019-03-08  466  
9aebfd4a2200ab Sean Wang 2019-03-08  467  	err = sdio_readsb(bdev->func, skb->data, MTK_REG_CRDR, rx_size);
9aebfd4a2200ab Sean Wang 2019-03-08  468  	if (err < 0)
9aebfd4a2200ab Sean Wang 2019-03-08  469  		goto err_kfree_skb;
9aebfd4a2200ab Sean Wang 2019-03-08  470  
9aebfd4a2200ab Sean Wang 2019-03-08  471  	sdio_hdr = (void *)skb->data;
9aebfd4a2200ab Sean Wang 2019-03-08  472  
9aebfd4a2200ab Sean Wang 2019-03-08  473  	/* We assume the default error as -EILSEQ simply to make the error path
9aebfd4a2200ab Sean Wang 2019-03-08  474  	 * be cleaner.
9aebfd4a2200ab Sean Wang 2019-03-08  475  	 */
9aebfd4a2200ab Sean Wang 2019-03-08  476  	err = -EILSEQ;
9aebfd4a2200ab Sean Wang 2019-03-08  477  
9aebfd4a2200ab Sean Wang 2019-03-08  478  	if (rx_size != le16_to_cpu(sdio_hdr->len)) {
9aebfd4a2200ab Sean Wang 2019-03-08  479  		bt_dev_err(bdev->hdev, "Rx size in sdio header is mismatched ");
9aebfd4a2200ab Sean Wang 2019-03-08  480  		goto err_kfree_skb;
9aebfd4a2200ab Sean Wang 2019-03-08  481  	}
9aebfd4a2200ab Sean Wang 2019-03-08  482  
9aebfd4a2200ab Sean Wang 2019-03-08  483  	hci_skb_pkt_type(skb) = sdio_hdr->bt_type;
9aebfd4a2200ab Sean Wang 2019-03-08  484  
9aebfd4a2200ab Sean Wang 2019-03-08  485  	/* Remove MediaTek SDIO header */
9aebfd4a2200ab Sean Wang 2019-03-08  486  	skb_pull(skb, sizeof(*sdio_hdr));
9aebfd4a2200ab Sean Wang 2019-03-08  487  
9aebfd4a2200ab Sean Wang 2019-03-08  488  	/* We have to dig into the packet to get payload size and then know how
9aebfd4a2200ab Sean Wang 2019-03-08  489  	 * many padding bytes at the tail, these padding bytes should be removed
9aebfd4a2200ab Sean Wang 2019-03-08  490  	 * before the packet is indicated to the core layer.
9aebfd4a2200ab Sean Wang 2019-03-08  491  	 */
9aebfd4a2200ab Sean Wang 2019-03-08  492  	for (i = 0; i < pkts_count; i++) {
9aebfd4a2200ab Sean Wang 2019-03-08 @493  		if (sdio_hdr->bt_type == (&pkts[i])->type)
9aebfd4a2200ab Sean Wang 2019-03-08  494  			break;
9aebfd4a2200ab Sean Wang 2019-03-08  495  	}
9aebfd4a2200ab Sean Wang 2019-03-08  496  
9aebfd4a2200ab Sean Wang 2019-03-08  497  	if (i >= pkts_count) {
9aebfd4a2200ab Sean Wang 2019-03-08  498  		bt_dev_err(bdev->hdev, "Invalid bt type 0x%02x",
9aebfd4a2200ab Sean Wang 2019-03-08  499  			   sdio_hdr->bt_type);
9aebfd4a2200ab Sean Wang 2019-03-08  500  		goto err_kfree_skb;
9aebfd4a2200ab Sean Wang 2019-03-08  501  	}
9aebfd4a2200ab Sean Wang 2019-03-08  502  
9aebfd4a2200ab Sean Wang 2019-03-08  503  	/* Remaining bytes cannot hold a header*/
9aebfd4a2200ab Sean Wang 2019-03-08  504  	if (skb->len < (&pkts[i])->hlen) {
9aebfd4a2200ab Sean Wang 2019-03-08  505  		bt_dev_err(bdev->hdev, "The size of bt header is mismatched");
9aebfd4a2200ab Sean Wang 2019-03-08  506  		goto err_kfree_skb;
9aebfd4a2200ab Sean Wang 2019-03-08  507  	}
9aebfd4a2200ab Sean Wang 2019-03-08  508  
9aebfd4a2200ab Sean Wang 2019-03-08  509  	switch ((&pkts[i])->lsize) {
9aebfd4a2200ab Sean Wang 2019-03-08  510  	case 1:
9aebfd4a2200ab Sean Wang 2019-03-08  511  		dlen = skb->data[(&pkts[i])->loff];
9aebfd4a2200ab Sean Wang 2019-03-08  512  		break;
9aebfd4a2200ab Sean Wang 2019-03-08  513  	case 2:
9aebfd4a2200ab Sean Wang 2019-03-08  514  		dlen = get_unaligned_le16(skb->data +
9aebfd4a2200ab Sean Wang 2019-03-08  515  						  (&pkts[i])->loff);
9aebfd4a2200ab Sean Wang 2019-03-08  516  		break;
9aebfd4a2200ab Sean Wang 2019-03-08  517  	default:
9aebfd4a2200ab Sean Wang 2019-03-08  518  		goto err_kfree_skb;
9aebfd4a2200ab Sean Wang 2019-03-08  519  	}
9aebfd4a2200ab Sean Wang 2019-03-08  520  
9aebfd4a2200ab Sean Wang 2019-03-08  521  	pad_size = skb->len - (&pkts[i])->hlen -  dlen;
9aebfd4a2200ab Sean Wang 2019-03-08  522  
9aebfd4a2200ab Sean Wang 2019-03-08  523  	/* Remaining bytes cannot hold a payload */
9aebfd4a2200ab Sean Wang 2019-03-08  524  	if (pad_size < 0) {
9aebfd4a2200ab Sean Wang 2019-03-08  525  		bt_dev_err(bdev->hdev, "The size of bt payload is mismatched");
9aebfd4a2200ab Sean Wang 2019-03-08  526  		goto err_kfree_skb;
9aebfd4a2200ab Sean Wang 2019-03-08  527  	}
9aebfd4a2200ab Sean Wang 2019-03-08  528  
9aebfd4a2200ab Sean Wang 2019-03-08  529  	/* Remove padding bytes */
9aebfd4a2200ab Sean Wang 2019-03-08  530  	skb_trim(skb, skb->len - pad_size);
9aebfd4a2200ab Sean Wang 2019-03-08  531  
9aebfd4a2200ab Sean Wang 2019-03-08  532  	/* Complete frame */
9aebfd4a2200ab Sean Wang 2019-03-08  533  	(&pkts[i])->recv(bdev->hdev, skb);
9aebfd4a2200ab Sean Wang 2019-03-08  534  
bcaa7d72dffddf Sean Wang 2019-04-18  535  	bdev->hdev->stat.byte_rx += rx_size;
bcaa7d72dffddf Sean Wang 2019-04-18  536  
9aebfd4a2200ab Sean Wang 2019-03-08  537  	return 0;
9aebfd4a2200ab Sean Wang 2019-03-08  538  
9aebfd4a2200ab Sean Wang 2019-03-08  539  err_kfree_skb:
9aebfd4a2200ab Sean Wang 2019-03-08  540  	kfree_skb(skb);
9aebfd4a2200ab Sean Wang 2019-03-08  541  
9aebfd4a2200ab Sean Wang 2019-03-08  542  	return err;
9aebfd4a2200ab Sean Wang 2019-03-08  543  }
9aebfd4a2200ab Sean Wang 2019-03-08  544  

:::::: The code at line 442 was first introduced by commit
:::::: 9aebfd4a2200ab8075e44379c758bccefdc589bb Bluetooth: mediatek: add support for MediaTek MT7663S and MT7668S SDIO devices

:::::: TO: Sean Wang <sean.wang@mediatek.com>
:::::: CC: Marcel Holtmann <marcel@holtmann.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
