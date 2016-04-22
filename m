Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v7] Bluetooth: hci_uart: Support firmware download for Marvell
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <2119fc93636742459899d50f2c1fcb8d@SC-EXCH04.marvell.com>
Date: Fri, 22 Apr 2016 14:49:09 +0200
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ganapathi Bhat <gbhat@marvell.com>,
	Cathy Luo <cluo@marvell.com>
Message-Id: <E16A47DE-611D-4C65-B407-1D78280308B4@holtmann.org>
References: <1459845266-2771-1-git-send-email-akarwar@marvell.com> <2A69CC2B-1FC2-4148-8564-38335A87CCD7@holtmann.org> <2119fc93636742459899d50f2c1fcb8d@SC-EXCH04.marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

>>>> +
>>>> +static int mrvl_setup(struct hci_uart *hu) {
>>>> +	struct mrvl_data *mrvl = hu->priv;
>>>> +
>>>> +	mrvl_init_fw_data(hu);
>>>> +	set_bit(HCI_UART_DNLD_FW, &mrvl->flags);
>>>> +
>>>> +	return hci_uart_dnld_fw(hu);
>>>> +}
>>> 
>>> So this is clearly the wrong spot. When ->setup is called it is
>>> expected that HCI is ready. You are misusing it here.
>>> 
>> 
>> Sure. We will move this to mrvl_open() where HCI is not yet initialized.
> 
> We tried moving firmware download to mrvl_open(), but it's not feasible. "hu->proto" is not yet initialized at that time. So when the data/ack is received during firmware download, we can't have Marvell specific handling. Also, I can see other vendor's (broadcomm, Intel) have done firmware download in setup handler.

firmware download in ->setup() is fine as long as it uses HCI commands. If it does not use HCI commands, then we need to come up with something new.

The problem here is that for all intense and purposes once ->setup() is called, then assumption is that you are in an HCI capable transport and it is ready.

Regards

Marcel
