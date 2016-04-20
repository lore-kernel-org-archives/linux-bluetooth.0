Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v7] Bluetooth: hci_uart: Support firmware download for Marvell
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <d3b0292dba1f4951ad5aaf8a683b8b7a@SC-EXCH04.marvell.com>
Date: Wed, 20 Apr 2016 16:42:53 +0200
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ganapathi Bhat <gbhat@marvell.com>
Message-Id: <AFF1BDDA-EB1A-4C99-976E-643A093FFD48@holtmann.org>
References: <1459845266-2771-1-git-send-email-akarwar@marvell.com> <2A69CC2B-1FC2-4148-8564-38335A87CCD7@holtmann.org> <d3b0292dba1f4951ad5aaf8a683b8b7a@SC-EXCH04.marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

> Thanks for your review.
> We will address these comments in updated version.
> 
>>> +
>>> +/* Receive data */
>>> +static int mrvl_recv(struct hci_uart *hu, const void *data, int
>>> +count) {
>>> +	struct mrvl_data *mrvl = hu->priv;
>>> +
>>> +	if (test_bit(HCI_UART_DNLD_FW, &mrvl->flags)) {
>>> +		mrvl->fwdata->skb = mrvl_process_fw_data(hu, mrvl->fwdata-
>>> skb,
>>> +							 (u8 *)data, count);
>>> +		if (IS_ERR(mrvl->fwdata->skb)) {
>>> +			int err = PTR_ERR(mrvl->fwdata->skb);
>>> +
>>> +			bt_dev_err(hu->hdev,
>>> +				   "Receive firmware data failed (%d)", err);
>>> +			mrvl->fwdata->skb = NULL;
>>> +			return err;
>>> +		}
>>> +		return 0;
>>> +	}
>> 
>> This part actually worries me a bit. Yes, we can do it this way, but in
>> general it sounds a bit more like we need a generic approach in
>> hci_ldisc.c to handle pre-HCI firmware loading and/or setup.
>> 
>> In the btusb.c driver we added ->setup_on_usb callback. And for it
>> sounds like we need something similar here. So that hci_ldisc.c can
>> handle most of the basic TX/RX.
> 
> Even if we added "->setup_on_usb" in hci_ldisc.c, we will need protocol specific changes in receive path during firmware download.
> With this patch, those changes are smoothly handled in hci_mrvl.c file.
> [hci_uart_tty_receive] -> [proto->recv] -> [mrvl_recv] -> [normal Rx path/FW download Rx handling]

we might need to find a better callback name, but yes, we want to make this generic in hci_ldisc.c. I do not have a perfect solution or quick answer, but I think this needs a bit more generic framework.

Regards

Marcel
