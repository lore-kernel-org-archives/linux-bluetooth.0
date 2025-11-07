Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05862E2DEF
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 01:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762477513; cv=none; b=UgNxZpU5zr06QIKeMTRNNuExc6vyX2aGcMeD2isGBqebPOtkLsGzYLi/QS1eXTJObU3WxNvnQ0aUwYu6UlNXPpCS4O07DqIBhZTrED5XuKUDqB4TkUaYOZGp50fbLGKPbDg/GCVQHRS9DODmpJGKPYF4GNZKukNXxUtTBrlRRk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762477513; c=relaxed/simple;
	bh=jGYT6u7rfNJrUnzzJ6XMzJTPuT4pQluLa+Krtx32sbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlosms33LYSRuj5R9Pr6hK+YUVtKiHb5pgpYgMHLhPpyzX8vbufDxvp8tFkO50UzFvPE6BHlXPMqcYmOujsJSoA4tWIDUBNYtiytc+A2W42IxkTZjxzIYZglH1UcXCqz8WV2138Dkd3JE+c7ZwrMyput1A3/yH4p2oDVmqkWLqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DkigzHi+; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DkigzHi+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762477512; x=1794013512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jGYT6u7rfNJrUnzzJ6XMzJTPuT4pQluLa+Krtx32sbI=;
  b=DkigzHi+q2NX03y/0CKM7WWq/fkg5MkBFiIhP6J4ILtX7DLULgX7NbLe
   tX8ATtboiI7M/EV5ClSTw2NNPsGtbIa4vO0lehmN4ZbG6OfU1PzA/iplA
   1pEl6yT+fWDTdAq2uyYPQ8yK67/MDev9FHFbErPLjjVdE3q7FquLRA8C2
   uqFvRC1ZeDJSIPdhmHwbdv55xHIYJtp+HWmCa/zkT9zpDp20qmk8CQ7ii
   qvM72Q0aRbuojFEa8gAhB4UsHXZy3x7UMAFC8GaUFyaCKmm8HgIkMcK4A
   WDg7DuJ25zXyWTK1L3YD/MGDMp74v80CvD+e/JasgM4YpgeKQb/n2bB0k
   Q==;
X-CSE-ConnectionGUID: kmhfj5fIT6qj+pAlCQoFwg==
X-CSE-MsgGUID: yQDzDshmTHuBgXbTMF/1ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="75742116"
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="75742116"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 17:05:11 -0800
X-CSE-ConnectionGUID: +BQZI5nvRSGzq7eiHB+yzg==
X-CSE-MsgGUID: ABS6YGc5SY+Ij3+y1QopLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="188344432"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 06 Nov 2025 17:05:09 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHAuY-000UXQ-1x;
	Fri, 07 Nov 2025 01:05:06 +0000
Date: Fri, 7 Nov 2025 09:04:12 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1 2/2] Bluetooth: btusb: Add support for Bulk
 Serialization Mode
Message-ID: <202511070808.Qvyqjzoc-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on bluetooth/master linus/master v6.18-rc4 next-20251106]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luiz-Augusto-von-Dentz/Bluetooth-btusb-Add-support-for-Bulk-Serialization-Mode/20251106-024830
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20251105170445.518320-2-luiz.dentz%40gmail.com
patch subject: [PATCH v1 2/2] Bluetooth: btusb: Add support for Bulk Serialization Mode
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20251107/202511070808.Qvyqjzoc-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251107/202511070808.Qvyqjzoc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511070808.Qvyqjzoc-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/bluetooth/btusb.c:4101:6: warning: variable 'hdev' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    4101 |         if ((data->proto == BTUSB_PROTO_LEGACY && !data->intr_ep) ||
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    4102 |             !data->bulk_tx_ep || !data->bulk_rx_ep) {
         |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/bluetooth/btusb.c:4436:15: note: uninitialized use occurs here
    4436 |         hci_free_dev(hdev);
         |                      ^~~~
   drivers/bluetooth/btusb.c:4101:2: note: remove the 'if' if its condition is always false
    4101 |         if ((data->proto == BTUSB_PROTO_LEGACY && !data->intr_ep) ||
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    4102 |             !data->bulk_tx_ep || !data->bulk_rx_ep) {
         |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    4103 |                 BT_ERR("failed to enumerate endpoints");
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    4104 |                 err = -ENODEV;
         |                 ~~~~~~~~~~~~~~
    4105 |                 goto out_free_dev;
         |                 ~~~~~~~~~~~~~~~~~~
    4106 |         }
         |         ~
>> drivers/bluetooth/btusb.c:4101:6: warning: variable 'hdev' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
    4101 |         if ((data->proto == BTUSB_PROTO_LEGACY && !data->intr_ep) ||
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    4102 |             !data->bulk_tx_ep || !data->bulk_rx_ep) {
         |             ~~~~~~~~~~~~~~~~~
   drivers/bluetooth/btusb.c:4436:15: note: uninitialized use occurs here
    4436 |         hci_free_dev(hdev);
         |                      ^~~~
   drivers/bluetooth/btusb.c:4101:6: note: remove the '||' if its condition is always false
    4101 |         if ((data->proto == BTUSB_PROTO_LEGACY && !data->intr_ep) ||
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    4102 |             !data->bulk_tx_ep || !data->bulk_rx_ep) {
         |             ~~~~~~~~~~~~~~~~~~~~
>> drivers/bluetooth/btusb.c:4101:6: warning: variable 'hdev' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
    4101 |         if ((data->proto == BTUSB_PROTO_LEGACY && !data->intr_ep) ||
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/bluetooth/btusb.c:4436:15: note: uninitialized use occurs here
    4436 |         hci_free_dev(hdev);
         |                      ^~~~
   drivers/bluetooth/btusb.c:4101:6: note: remove the '||' if its condition is always false
    4101 |         if ((data->proto == BTUSB_PROTO_LEGACY && !data->intr_ep) ||
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/bluetooth/btusb.c:4030:22: note: initialize the variable 'hdev' to silence this warning
    4030 |         struct hci_dev *hdev;
         |                             ^
         |                              = NULL
   3 warnings generated.


vim +4101 drivers/bluetooth/btusb.c

  4023	
  4024	static int btusb_probe(struct usb_interface *intf,
  4025			       const struct usb_device_id *id)
  4026	{
  4027		struct usb_endpoint_descriptor *ep_desc;
  4028		struct gpio_desc *reset_gpio;
  4029		struct btusb_data *data;
  4030		struct hci_dev *hdev;
  4031		unsigned ifnum_base;
  4032		int i, err, priv_size;
  4033	
  4034		BT_DBG("intf %p id %p", intf, id);
  4035	
  4036		if ((id->driver_info & BTUSB_IFNUM_2) &&
  4037		    (intf->cur_altsetting->desc.bInterfaceNumber != 0) &&
  4038		    (intf->cur_altsetting->desc.bInterfaceNumber != 2))
  4039			return -ENODEV;
  4040	
  4041		ifnum_base = intf->cur_altsetting->desc.bInterfaceNumber;
  4042	
  4043		if (!id->driver_info) {
  4044			const struct usb_device_id *match;
  4045	
  4046			match = usb_match_id(intf, quirks_table);
  4047			if (match)
  4048				id = match;
  4049		}
  4050	
  4051		if (id->driver_info == BTUSB_IGNORE)
  4052			return -ENODEV;
  4053	
  4054		if (id->driver_info & BTUSB_ATH3012) {
  4055			struct usb_device *udev = interface_to_usbdev(intf);
  4056	
  4057			/* Old firmware would otherwise let ath3k driver load
  4058			 * patch and sysconfig files
  4059			 */
  4060			if (le16_to_cpu(udev->descriptor.bcdDevice) <= 0x0001 &&
  4061			    !btusb_qca_need_patch(udev))
  4062				return -ENODEV;
  4063		}
  4064	
  4065		data = devm_kzalloc(&intf->dev, sizeof(*data), GFP_KERNEL);
  4066		if (!data)
  4067			return -ENOMEM;
  4068	
  4069		/* If alternate setting 1 is found, it means H4 mode is supported */
  4070		if (btusb_find_altsetting(intf, 1)) {
  4071			struct usb_device *udev = interface_to_usbdev(intf);
  4072	
  4073			err = usb_set_interface(udev, ifnum_base, 1);
  4074			if (!err)
  4075				data->proto = BTUSB_PROTO_H4;
  4076		}
  4077	
  4078		for (i = 0; i < intf->cur_altsetting->desc.bNumEndpoints; i++) {
  4079			ep_desc = &intf->cur_altsetting->endpoint[i].desc;
  4080	
  4081			if (!data->intr_ep && usb_endpoint_is_int_in(ep_desc)) {
  4082				data->intr_ep = ep_desc;
  4083				continue;
  4084			}
  4085	
  4086			if (!data->bulk_tx_ep && usb_endpoint_is_bulk_out(ep_desc)) {
  4087				data->bulk_tx_ep = ep_desc;
  4088				continue;
  4089			}
  4090	
  4091			if (!data->bulk_rx_ep && usb_endpoint_is_bulk_in(ep_desc)) {
  4092				data->bulk_rx_ep = ep_desc;
  4093				continue;
  4094			}
  4095		}
  4096	
  4097		/* Check if all endpoints could be enumerated, legacy mode requires
  4098		 * interrupt and bulk endpoint while H4 mode only requires bulk
  4099		 * endpoints.
  4100		 */
> 4101		if ((data->proto == BTUSB_PROTO_LEGACY && !data->intr_ep) ||
  4102		    !data->bulk_tx_ep || !data->bulk_rx_ep) {
  4103			BT_ERR("failed to enumerate endpoints");
  4104			err = -ENODEV;
  4105			goto out_free_dev;
  4106		}
  4107	
  4108		if (id->driver_info & BTUSB_AMP) {
  4109			data->cmdreq_type = USB_TYPE_CLASS | 0x01;
  4110			data->cmdreq = 0x2b;
  4111		} else {
  4112			data->cmdreq_type = USB_TYPE_CLASS;
  4113			data->cmdreq = 0x00;
  4114		}
  4115	
  4116		data->udev = interface_to_usbdev(intf);
  4117		data->intf = intf;
  4118	
  4119		INIT_WORK(&data->work, btusb_work);
  4120		INIT_WORK(&data->waker, btusb_waker);
  4121		INIT_DELAYED_WORK(&data->rx_work, btusb_rx_work);
  4122	
  4123		skb_queue_head_init(&data->acl_q);
  4124	
  4125		init_usb_anchor(&data->deferred);
  4126		init_usb_anchor(&data->tx_anchor);
  4127		spin_lock_init(&data->txlock);
  4128	
  4129		init_usb_anchor(&data->intr_anchor);
  4130		init_usb_anchor(&data->bulk_anchor);
  4131		init_usb_anchor(&data->isoc_anchor);
  4132		init_usb_anchor(&data->diag_anchor);
  4133		init_usb_anchor(&data->ctrl_anchor);
  4134		spin_lock_init(&data->rxlock);
  4135	
  4136		priv_size = 0;
  4137	
  4138		data->recv_event = hci_recv_frame;
  4139		data->recv_bulk = btusb_recv_bulk;
  4140	
  4141		if (id->driver_info & BTUSB_INTEL_COMBINED) {
  4142			/* Allocate extra space for Intel device */
  4143			priv_size += sizeof(struct btintel_data);
  4144	
  4145			/* Override the rx handlers */
  4146			data->recv_event = btintel_recv_event;
  4147			data->recv_bulk = btusb_recv_bulk_intel;
  4148		} else if (id->driver_info & BTUSB_REALTEK) {
  4149			/* Allocate extra space for Realtek device */
  4150			priv_size += sizeof(struct btrealtek_data);
  4151	
  4152			data->recv_event = btusb_recv_event_realtek;
  4153		} else if (id->driver_info & BTUSB_MEDIATEK) {
  4154			/* Allocate extra space for Mediatek device */
  4155			priv_size += sizeof(struct btmtk_data);
  4156		}
  4157	
  4158		data->recv_acl = hci_recv_frame;
  4159	
  4160		hdev = hci_alloc_dev_priv(priv_size);
  4161		if (!hdev)
  4162			return -ENOMEM;
  4163	
  4164		hdev->bus = HCI_USB;
  4165		hci_set_drvdata(hdev, data);
  4166	
  4167		data->hdev = hdev;
  4168	
  4169		SET_HCIDEV_DEV(hdev, &intf->dev);
  4170	
  4171		reset_gpio = gpiod_get_optional(&data->udev->dev, "reset",
  4172						GPIOD_OUT_LOW);
  4173		if (IS_ERR(reset_gpio)) {
  4174			err = PTR_ERR(reset_gpio);
  4175			goto out_free_dev;
  4176		} else if (reset_gpio) {
  4177			data->reset_gpio = reset_gpio;
  4178		}
  4179	
  4180		hdev->open    = btusb_open;
  4181		hdev->close   = btusb_close;
  4182		hdev->flush   = btusb_flush;
  4183		hdev->send    = btusb_send_frame;
  4184		hdev->notify  = btusb_notify;
  4185		hdev->wakeup  = btusb_wakeup;
  4186		hdev->hci_drv = &btusb_hci_drv;
  4187	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
