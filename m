Return-Path: <loic.poulain@intel.com>
Subject: Re: [v11,3/3] Bluetooth: hci_uart: Support firmware download for
 Marvell
To: Amitkumar Karwar <akarwar@marvell.com>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1462548714-7971-3-git-send-email-akarwar@marvell.com>
 <576CCCDE.1050004@rock-chips.com>
 <ea454b25f2334ef9be0451a01cd15e15@SC-EXCH04.marvell.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ganapathi Bhat <gbhat@marvell.com>, Cathy Luo <cluo@marvell.com>,
 Marcel Holtmann <marcel@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
Message-ID: <5774FA48.7080803@intel.com>
Date: Thu, 30 Jun 2016 12:54:00 +0200
MIME-Version: 1.0
In-Reply-To: <ea454b25f2334ef9be0451a01cd15e15@SC-EXCH04.marvell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,


> Hi Marcel,

I suggest you to add Marcel as recipient of your patches.

>
>> From: Jeffy Chen [mailto:jeffy.chen@rock-chips.com]
>> Sent: Friday, June 24, 2016 11:32 AM
>> To: Amitkumar Karwar; linux-bluetooth@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org; Ganapathi Bhat
>> Subject: Re: [v11,3/3] Bluetooth: hci_uart: Support firmware download
>> for Marvell
>>
>> On 2016-5-6 23:31, Amitkumar Karwar wrote:
>>> From: Ganapathi Bhat <gbhat@marvell.com>
>>>
>>> This patch implement firmware download feature for Marvell Bluetooth
>>> devices. If firmware is already downloaded, it will skip downloading.


>>> +static struct sk_buff *mrvl_process_fw_data(struct hci_uart *hu,
>>> +					    struct sk_buff *skb,
>>> +					    u8 *buf, int count)
>>> +{
>>> +	struct mrvl_data *mrvl = hu->priv;
>>> +	struct fw_data *fw_data = mrvl->fwdata;
>>> +	int i = 0, len;
>>> +
>>> +	if (!skb) {
>>> +		while (buf[i] != fw_data->expected_ack && i < count)
>>> +			i++;
>>> +		if (i == count)
>>> +			return ERR_PTR(-EILSEQ);
>>> +
>>> +		skb = bt_skb_alloc(MRVL_FW_HDR_LEN, GFP_KERNEL);

Why you don't test skb here.

>>> +	}
>>> +
>>> +	if (!skb)
>>> +		return ERR_PTR(-ENOMEM);
>>> +
>>> +	len = count - i;
>>> +	memcpy(skb_put(skb, len), &buf[i], len);

You copy all the remaining data from buf into your skb, but what if buf 
contains more than one packet ? out of skb.
Don't assume that buf contains a full packet as well as only one packet.


Regards,
Loic
