Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B96C433E6
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Dec 2020 20:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE15A21E92
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Dec 2020 20:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgLZUSH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Dec 2020 15:18:07 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:50120 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgLZUSH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Dec 2020 15:18:07 -0500
Received: from marcel-macbook.holtmann.net (p4ff9f924.dip0.t-ipconnect.de [79.249.249.36])
        by mail.holtmann.org (Postfix) with ESMTPSA id 955D2CED2F;
        Sat, 26 Dec 2020 21:24:43 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH 1/1] [Add support Mediatek mt7921U]
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <292c69c1038242d5b0d03fb7b4675555@mtkmbs08n1.mediatek.inc>
Date:   Sat, 26 Dec 2020 21:17:24 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Wang <Sean.Wang@mediatek.com>,
        =?utf-8?B?IlBldGVyIFRzYW8gKOabueePhuW9sCki?= 
        <Peter.Tsao@mediatek.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <5925338F-C8E3-4FDE-9477-256EC2363C49@holtmann.org>
References: <20201222150527.22904-1-Mark-YW.Chen@mediatek.com>
 <06C876AD-8232-418E-B3CB-96B88579BAF7@holtmann.org>
 <292c69c1038242d5b0d03fb7b4675555@mtkmbs08n1.mediatek.inc>
To:     =?utf-8?B?Ik1hcmstWVcgQ2hlbiAo6Zmz5o+a5paHKSI=?= 
        <Mark-YW.Chen@mediatek.com>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mark,

> Thanks for your suggestions, I will remove the duplicate definitions and functions.
> 
> Firstly, we will add the support of enabling MT7921U in btusb.c
> Secondary, we will discuss the driver architecture with you.
> Finally, we update the common part and hif part for MT7921.
> 
> I have a couple questions for driver architecture.
> 1. Global dev.
> 2. Unify common part.
> 3. HIF part (usb/sdio/pcie/uart)
>> 
>>> This patch adds the support of enabling MT7921U, it's USB-based
>>> Bluetooth function.
>>> 
>>> There are some component in the Mediatek driver.
>>> 1. Btmtk_main: it's common code for Mediatek devices,
>>>  such as firmware download, chip initialization,
>>>  state machine handling and etc.
>>> 2. Btmtkusb: it's for usb interface,
>>>  such as usb endpoint enumeration, urb handling and etc.
>>> 
>>> Firstly, we update the common part and usb part for MT7921U.
>>> Secondly, we will add the support MT7921S, it's SDIO-based device.
>>> Finally, we will add the procedure to support uart/pcie interfaces.
>> 
>> create a btmtk.[ch] module like the other vendors did if it makes sense.
>> Otherwise just skip that part for now and get btmtkusb.c driver working. You
>> can later unify between all 3 transports.
>> 
>> I would do the latter since it would first make sense to really see where the
>> common parts are. And I have to be frank, this driver needs massive cleanup. I
>> am not going to accept this tons of copy-and-paste left and right.
>> 
>> Please provide the content of /sys/kernel/debug/usb/devices in the commit
>> message.
>> 
>>> +/* To support dynamic mount of interface can be probed */
>>> +static int btmtk_intf_num = BT_MCU_MINIMUM_INTERFACE_NUM;
>>> +/* To allow g_bdev being sized from btmtk_intf_num setting */
>>> +static struct btmtk_dev **g_bdev;
>> 
>> NO. Period. No global dev instances.
> 
> [Global dev.]
> The global dev is for our state machine that design for error recovery, such as chip reset, memory dump and etc.
> We must to make sure state machine transition that is the same flow for each interfaces (usb/sdio/pcie/uart).
> [Mediatek driver]
> -> Create a dev before interface probe.
> [Linux kernel Bluetooth driver]
> -> Create a dev in interface probe (btusb_probe).
> 
> May we create a global dev before interface probe?

No. Please design things properly. Non of the drivers have global devices.

>>> +
>>> +/**
>>> + * Kernel Module init/exit Functions
>>> + */
>>> +static int __init main_driver_init(void)
>>> +{
>>> +	int ret = 0;
>>> +	int i;
>>> +
>>> +	/* Mediatek Driver Version */
>>> +	BTMTK_INFO("%s: MTK BT Driver Version : %s", __func__, VERSION);
>>> +
>>> +	ret = main_init();
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	for (i = 0; i < btmtk_intf_num; i++)
>>> +		btmtk_set_chip_state(g_bdev[i], BTMTK_STATE_DISCONNECT);
>>> +
>>> +	ret = btmtk_cif_register();
>>> +	if (ret < 0) {
>>> +		BTMTK_ERR("*** USB registration failed(%d)! ***", ret);
>>> +		main_exit();
>>> +		return ret;
>>> +	}
>>> +
>>> +	BTMTK_INFO("%s: Done", __func__);
>>> +	return ret;
>>> +}
>> 
>> NO. Period. Use module_usb_driver() and if you need anything more, you are
>> doing something wrong.
> 
> We would like to unify state machine, dev allocate, hif_hook and hif_register.
> [Unify Common Part]: btmtk_main
> State machine: Mediatek chip error recovery
> Dev allocate: Bluetooth dev.
> Mediatek chip-related behavior: Firmware download.
> HCI device-related: hci register, open, close and send_frame.
> 
> [HIF Part] : btmtkusb/btmtksdio/btmtkuart
> hif_hook (cif interface): read/write register, open/close, chip reset and etc.
> hif_register (cif register): hif registration-related, such as usb_register/sdio_register_driver.
> 
> May we use the driver architecture?

You can do that, but then first start with the existing btmtksdio and btmtkuart drivers to show me how you want to design it. You still have to design it cleanly.

Regards

Marcel

