Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <35c90d960903302313y3900c724m285f984ba5eb9ec0@mail.gmail.com>
References: <a172fe730903302245k1bb2209ag371e07d4a0cbbb80@mail.gmail.com>
	 <a172fe730903302253j6f137249g10c51d85488bd608@mail.gmail.com>
	 <35c90d960903302313y3900c724m285f984ba5eb9ec0@mail.gmail.com>
Date: Tue, 31 Mar 2009 14:43:39 +0800
Message-ID: <a172fe730903302343n219bc3e6t2becc00ffdadb947@mail.gmail.com>
Subject: Re: eSCO or SCO link?
From: =?GB2312?B?seXA2g==?= <mykofzone@gmail.com>
To: Nick Pelly <npelly@google.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=GB2312
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

2009/3/31 Nick Pelly <npelly@google.com>:
> 2009/3/30 ±åÀÚ <mykofzone@gmail.com>:
>> Hi All,
>>  I made a mistake when writing the email, I have not complete my question.
>>
>> 2009/3/31 ±åÀÚ <mykofzone@gmail.com>:
>>> Hi All,
>>>  I have a stlc2500c which is a Bluetooth 1.2 chip. When debuging
>>> function 'hci_connect', i found the hci link type of the arguments was
>>> SCO_LINK, because i enabled 'lmp_esco_capable' in my kernel, it call
>>> 'hci_setup_sync' to setup eSCO link.
>>
>> But when i check connection by 'hcitool con', the hcitool show it was
>> a SCO link. So, is it a SCO link or eSCO link? Thanks.
>
> hcitool con will report eSCO if it is eSCO, so you have a SCO link.
>
> hci_setup_sync can be used for both SCO and eSCO, and the chipset
> and/or the host stack will fall back to SCO if eSCO parameters can not
> be negotiated. An LMP log will show why.


Maybe the function 'hci_sync_conn_complete_evt' matches what you said.

static inline void hci_sync_conn_complete_evt(struct hci_dev *hdev,
struct sk_buff *skb)
{
       ...
	printk("hci_sync_conn_complete_evt, ev->link_type=%d\n",
ev->link_type); ------> ev->link_type=0
	
	conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);

	printk("hci_sync_conn_complete_evt, conn=%p\n",
conn);-------------------------------> conn=00000000
	
	if (!conn) {
		if (ev->link_type == ESCO_LINK)
			goto unlock;

		conn = hci_conn_hash_lookup_ba(hdev, ESCO_LINK, &ev->bdaddr);
		if (!conn)
			goto unlock;

		conn->type = SCO_LINK;----------------------------------------------------------------------->
fall back to SCO?
	}
        ...
}
>
> Nick
>

LeiBian
BR
