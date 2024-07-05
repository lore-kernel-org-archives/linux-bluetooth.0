Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC311474B2;
	Fri,  5 Jul 2024 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172049; cv=none; b=OQMzQE6Wyt26+PxpCFWIvV0ddPxkIJvhXZ8jEKKf26sPskQnCe0v/hyScFI1CmQWjO7cZu9Aaz/fbdmCN85426SevH5X1Dpgara6N/Y4IDrr758k4bS+I00yn25DqGjrSKvo5ejsGnHfVTRUtzYWVRC0pXfhk/pAthgEQnJ+6bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172049; c=relaxed/simple;
	bh=c+/9TaMyp6MyuX8Wr7bK7QL2QMpx1isbVHGUwpIW0ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCziqOSY40qsJcvjdN0ckU+wVjFeNtLc8pb+L5A9bV2Wv6U2gSCzBt1mGdxwZoFp8KkV2+dCNGCoAWgtQdCCsaKjrxXuC/bLgETDHBegVqnpB5f8LP7aW5nPrWi6EKdl7ZXJ0FfTwPkZ77DNIPVdtl0Rg7TV7nCR0HKdFGNMn3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VxtQMEtk; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VxtQMEtk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720172046; x=1751708046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c+/9TaMyp6MyuX8Wr7bK7QL2QMpx1isbVHGUwpIW0ic=;
  b=VxtQMEtkC82Po8DukXrO4OkJ63iMJi7ilsF+ZSPYUADtvq+EOt2u28hW
   AF6/k1DDooZVt9TopNmj9XI4iAaa4xfz7pvDSejewPyD6D65bsFvQNeGd
   aB/yXyF/U+XcWS3d0+LiCIUe9x9xQeu8BuQnVqYSP6sMy/DT45gg1Pgn+
   +v27HPGVncl60ZDI0vhBy2ZKKawPsgjlTnP1I1e6N3P/IzV21rrjDGmel
   XOBpsXTJSBopsHyJvWaQ0VizCOiVYnLcv7ELafuyg4+BZ7i+JfsAwNeQ/
   o+a+mT/7KLrHEGE8Y8rYfynHvdUuXx1UPmqGQ7DAsn+FFHT3UYH6EMJKK
   g==;
X-CSE-ConnectionGUID: k7SQzChfSleiHnDn8lxqxg==
X-CSE-MsgGUID: xF6TcstPRc6PmIA7tzf6cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="21224691"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="21224691"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 02:34:05 -0700
X-CSE-ConnectionGUID: GhJ2rfenSPCXvTq4mxu6Ag==
X-CSE-MsgGUID: zGEf5IsMTg20uHLTYraSSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="47475112"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 05 Jul 2024 02:34:02 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPfKJ-000SC0-2g;
	Fri, 05 Jul 2024 09:33:59 +0000
Date: Fri, 5 Jul 2024 17:33:34 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Lu <chris.lu@mediatek.com>, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Von Dentz <luiz.dentz@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Sean Wang <sean.wang@mediatek.com>,
	Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-mediatek <linux-mediatek@lists.infradead.org>,
	Chris Lu <chris.lu@mediatek.com>
Subject: Re: [PATCH v7 5/8] Bluetooth: btmtk: move btusb_mtk_hci_wmt_sync to
 btmtk.c
Message-ID: <202407051720.d1FTJg6H-lkp@intel.com>
References: <20240704060116.16600-6-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704060116.16600-6-chris.lu@mediatek.com>

Hi Chris,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth-next/master]
[also build test ERROR on next-20240703]
[cannot apply to bluetooth/master linus/master v6.10-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Lu/Bluetooth-btusb-mediatek-remove-the-unnecessary-goto-tag/20240705-043833
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20240704060116.16600-6-chris.lu%40mediatek.com
patch subject: [PATCH v7 5/8] Bluetooth: btmtk: move btusb_mtk_hci_wmt_sync to btmtk.c
config: x86_64-randconfig-161-20240705 (https://download.01.org/0day-ci/archive/20240705/202407051720.d1FTJg6H-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240705/202407051720.d1FTJg6H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407051720.d1FTJg6H-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_wmt_recv':
   drivers/bluetooth/btmtk.c:503:(.text+0xacf): undefined reference to `usb_anchor_urb'
   ld: drivers/bluetooth/btmtk.c:504:(.text+0xadc): undefined reference to `usb_submit_urb'
   ld: drivers/bluetooth/btmtk.c:513:(.text+0xc61): undefined reference to `usb_unanchor_urb'
   ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_hci_wmt_sync':
   drivers/bluetooth/btmtk.c:605:(.text+0xda5): undefined reference to `usb_autopm_get_interface'
   ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_submit_wmt_recv_urb':
   drivers/bluetooth/btmtk.c:526:(.text+0xe04): undefined reference to `usb_alloc_urb'
   ld: drivers/bluetooth/btmtk.c:556:(.text+0xefe): undefined reference to `usb_anchor_urb'
   ld: drivers/bluetooth/btmtk.c:557:(.text+0xf0b): undefined reference to `usb_submit_urb'
   ld: drivers/bluetooth/btmtk.c:565:(.text+0xf23): undefined reference to `usb_free_urb'
   ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_hci_wmt_sync':
>> drivers/bluetooth/btmtk.c:620:(.text+0xf2f): undefined reference to `usb_autopm_put_interface'
   ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_submit_wmt_recv_urb':
>> drivers/bluetooth/btmtk.c:562:(.text+0x1030): undefined reference to `usb_unanchor_urb'
   ld: drivers/bluetooth/btmtk.c:565:(.text+0x1038): undefined reference to `usb_free_urb'
   ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_hci_wmt_sync':
   drivers/bluetooth/btmtk.c:620:(.text+0x1044): undefined reference to `usb_autopm_put_interface'
   ld: drivers/bluetooth/btmtk.c:613:(.text+0x1062): undefined reference to `usb_autopm_put_interface'
   ld: drivers/bluetooth/btmtk.c:620:(.text+0x11c6): undefined reference to `usb_autopm_put_interface'
   ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_submit_wmt_recv_urb':
>> drivers/bluetooth/btmtk.c:545:(.text+0x1288): undefined reference to `usb_free_urb'
   ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_hci_wmt_sync':
   drivers/bluetooth/btmtk.c:620:(.text+0x1294): undefined reference to `usb_autopm_put_interface'


vim +620 drivers/bluetooth/btmtk.c

   516	
   517	static int btmtk_usb_submit_wmt_recv_urb(struct hci_dev *hdev)
   518	{
   519		struct btmtk_data *data = hci_get_priv(hdev);
   520		struct usb_ctrlrequest *dr;
   521		unsigned char *buf;
   522		int err, size = 64;
   523		unsigned int pipe;
   524		struct urb *urb;
   525	
   526		urb = usb_alloc_urb(0, GFP_KERNEL);
   527		if (!urb)
   528			return -ENOMEM;
   529	
   530		dr = kmalloc(sizeof(*dr), GFP_KERNEL);
   531		if (!dr) {
   532			usb_free_urb(urb);
   533			return -ENOMEM;
   534		}
   535	
   536		dr->bRequestType = USB_TYPE_VENDOR | USB_DIR_IN;
   537		dr->bRequest     = 1;
   538		dr->wIndex       = cpu_to_le16(0);
   539		dr->wValue       = cpu_to_le16(48);
   540		dr->wLength      = cpu_to_le16(size);
   541	
   542		buf = kmalloc(size, GFP_KERNEL);
   543		if (!buf) {
   544			kfree(dr);
 > 545			usb_free_urb(urb);
   546			return -ENOMEM;
   547		}
   548	
   549		pipe = usb_rcvctrlpipe(data->udev, 0);
   550	
   551		usb_fill_control_urb(urb, data->udev, pipe, (void *)dr,
   552				     buf, size, btmtk_usb_wmt_recv, hdev);
   553	
   554		urb->transfer_flags |= URB_FREE_BUFFER;
   555	
   556		usb_anchor_urb(urb, data->ctrl_anchor);
   557		err = usb_submit_urb(urb, GFP_KERNEL);
   558		if (err < 0) {
   559			if (err != -EPERM && err != -ENODEV)
   560				bt_dev_err(hdev, "urb %p submission failed (%d)",
   561					   urb, -err);
 > 562			usb_unanchor_urb(urb);
   563		}
   564	
   565		usb_free_urb(urb);
   566	
   567		return err;
   568	}
   569	
   570	int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
   571				   struct btmtk_hci_wmt_params *wmt_params)
   572	{
   573		struct btmtk_data *data = hci_get_priv(hdev);
   574		struct btmtk_hci_wmt_evt_funcc *wmt_evt_funcc;
   575		u32 hlen, status = BTMTK_WMT_INVALID;
   576		struct btmtk_hci_wmt_evt *wmt_evt;
   577		struct btmtk_hci_wmt_cmd *wc;
   578		struct btmtk_wmt_hdr *hdr;
   579		int err;
   580	
   581		/* Send the WMT command and wait until the WMT event returns */
   582		hlen = sizeof(*hdr) + wmt_params->dlen;
   583		if (hlen > 255)
   584			return -EINVAL;
   585	
   586		wc = kzalloc(hlen, GFP_KERNEL);
   587		if (!wc)
   588			return -ENOMEM;
   589	
   590		hdr = &wc->hdr;
   591		hdr->dir = 1;
   592		hdr->op = wmt_params->op;
   593		hdr->dlen = cpu_to_le16(wmt_params->dlen + 1);
   594		hdr->flag = wmt_params->flag;
   595		memcpy(wc->data, wmt_params->data, wmt_params->dlen);
   596	
   597		set_bit(BTMTK_TX_WAIT_VND_EVT, &data->flags);
   598	
   599		/* WMT cmd/event doesn't follow up the generic HCI cmd/event handling,
   600		 * it needs constantly polling control pipe until the host received the
   601		 * WMT event, thus, we should require to specifically acquire PM counter
   602		 * on the USB to prevent the interface from entering auto suspended
   603		 * while WMT cmd/event in progress.
   604		 */
   605		err = usb_autopm_get_interface(data->intf);
   606		if (err < 0)
   607			goto err_free_wc;
   608	
   609		err = __hci_cmd_send(hdev, 0xfc6f, hlen, wc);
   610	
   611		if (err < 0) {
   612			clear_bit(BTMTK_TX_WAIT_VND_EVT, &data->flags);
   613			usb_autopm_put_interface(data->intf);
   614			goto err_free_wc;
   615		}
   616	
   617		/* Submit control IN URB on demand to process the WMT event */
   618		err = btmtk_usb_submit_wmt_recv_urb(hdev);
   619	
 > 620		usb_autopm_put_interface(data->intf);
   621	
   622		if (err < 0)
   623			goto err_free_wc;
   624	
   625		/* The vendor specific WMT commands are all answered by a vendor
   626		 * specific event and will have the Command Status or Command
   627		 * Complete as with usual HCI command flow control.
   628		 *
   629		 * After sending the command, wait for BTUSB_TX_WAIT_VND_EVT
   630		 * state to be cleared. The driver specific event receive routine
   631		 * will clear that state and with that indicate completion of the
   632		 * WMT command.
   633		 */
   634		err = wait_on_bit_timeout(&data->flags, BTMTK_TX_WAIT_VND_EVT,
   635					  TASK_INTERRUPTIBLE, HCI_INIT_TIMEOUT);
   636		if (err == -EINTR) {
   637			bt_dev_err(hdev, "Execution of wmt command interrupted");
   638			clear_bit(BTMTK_TX_WAIT_VND_EVT, &data->flags);
   639			goto err_free_wc;
   640		}
   641	
   642		if (err) {
   643			bt_dev_err(hdev, "Execution of wmt command timed out");
   644			clear_bit(BTMTK_TX_WAIT_VND_EVT, &data->flags);
   645			err = -ETIMEDOUT;
   646			goto err_free_wc;
   647		}
   648	
   649		if (data->evt_skb == NULL)
   650			goto err_free_wc;
   651	
   652		/* Parse and handle the return WMT event */
   653		wmt_evt = (struct btmtk_hci_wmt_evt *)data->evt_skb->data;
   654		if (wmt_evt->whdr.op != hdr->op) {
   655			bt_dev_err(hdev, "Wrong op received %d expected %d",
   656				   wmt_evt->whdr.op, hdr->op);
   657			err = -EIO;
   658			goto err_free_skb;
   659		}
   660	
   661		switch (wmt_evt->whdr.op) {
   662		case BTMTK_WMT_SEMAPHORE:
   663			if (wmt_evt->whdr.flag == 2)
   664				status = BTMTK_WMT_PATCH_UNDONE;
   665			else
   666				status = BTMTK_WMT_PATCH_DONE;
   667			break;
   668		case BTMTK_WMT_FUNC_CTRL:
   669			wmt_evt_funcc = (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;
   670			if (be16_to_cpu(wmt_evt_funcc->status) == 0x404)
   671				status = BTMTK_WMT_ON_DONE;
   672			else if (be16_to_cpu(wmt_evt_funcc->status) == 0x420)
   673				status = BTMTK_WMT_ON_PROGRESS;
   674			else
   675				status = BTMTK_WMT_ON_UNDONE;
   676			break;
   677		case BTMTK_WMT_PATCH_DWNLD:
   678			if (wmt_evt->whdr.flag == 2)
   679				status = BTMTK_WMT_PATCH_DONE;
   680			else if (wmt_evt->whdr.flag == 1)
   681				status = BTMTK_WMT_PATCH_PROGRESS;
   682			else
   683				status = BTMTK_WMT_PATCH_UNDONE;
   684			break;
   685		}
   686	
   687		if (wmt_params->status)
   688			*wmt_params->status = status;
   689	
   690	err_free_skb:
   691		kfree_skb(data->evt_skb);
   692		data->evt_skb = NULL;
   693	err_free_wc:
   694		kfree(wc);
   695		return err;
   696	}
   697	EXPORT_SYMBOL_GPL(btmtk_usb_hci_wmt_sync);
   698	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
