Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 1/2] Bluetooth: add public address configuration for Marvell USB devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <477F20668A386D41ADCC57781B1F7043122FCE9980@SC-VEXCH1.marvell.com>
Date: Wed, 16 Jul 2014 23:32:38 +0200
Cc: Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Amitkumar Karwar <akarwar@marvell.com>,
	Avinash Patil <patila@marvell.com>,
	Chin-Ran Lo <crlo@marvell.com>, Xinming Hu <huxm@marvell.com>
Message-Id: <CEC663FA-AAD7-487E-BD1F-3715EC90FC66@holtmann.org>
References: <1405538486-23533-1-git-send-email-bzhao@marvell.com> <968A8F45-B932-4343-A9C4-AA25BC91344A@holtmann.org> <477F20668A386D41ADCC57781B1F7043122FCE9980@SC-VEXCH1.marvell.com>
To: Bing Zhao <bzhao@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

>>> +static int btusb_set_bdaddr_marvell(struct hci_dev *hdev,
>>> +				    const bdaddr_t *bdaddr)
>>> +{
>>> +	struct sk_buff *skb;
>>> +	u8 buf[8];
>>> +	long ret;
>>> +
>>> +	buf[0] = 0xfe;
>>> +	buf[1] = sizeof(bdaddr_t);
>>> +	bacpy((bdaddr_t *)&buf[2], bdaddr);
>> 
>> you could define a packed struct for this or just use memcpy here instead.
> 
> In Amitkumar's original patch, it was like this:
> 
> +	memcpy((u8 *)buf + 2, bdaddr, sizeof(bdaddr_t));

you do not need the cast:

	memcpy(buf + 2, bdaddr, sizeof(bdaddr_t));

> 
> I felt that it'd be better to use bacpy so I changed memcpy to bacpy while applying the patch.
> I can change it back to memcpy if it looks ok to you. Otherwise I can define a packed struct.

I am fine with the memcpy actually.

>>> +
>>> +	skb = __hci_cmd_sync(hdev, 0xfc22, sizeof(buf), buf, HCI_INIT_TIMEOUT);
>> 
>> Is this opcode writing the address into flash and making it permanent or will a reboot restore it to
>> its original address?
> 
> A reboot restores it to its original address. I will add this information in v2.
> 
>> 
>> I am asking because for Ericsson chips this exact command with user_id 0xfe was actually making a
>> permanent change of the BD_ADDR. What we want here is a volatile change of the address.
> 
> For Marvell devices it makes a temporary bdaddr change.

Good.

I just know way too much details of all these vendor specific details of the original Bluetooth chips ;)

Regards

Marcel

