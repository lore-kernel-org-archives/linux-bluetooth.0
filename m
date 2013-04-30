Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH 04/13] Bluetooth: Fix LE vs BR/EDR selection when connecting
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20130430173619.GA19710@samus>
Date: Tue, 30 Apr 2013 10:51:53 -0700
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <B2B99ED5-AE78-480F-B8C5-871D1E1F3CD6@holtmann.org>
References: <1367253345-12482-1-git-send-email-johan.hedberg@gmail.com> <1367253345-12482-5-git-send-email-johan.hedberg@gmail.com> <20130430173619.GA19710@samus>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

>> The choice between LE and BR/EDR should be made on the destination
>> address type instead of the destination CID. This is particularly
>> important when in the future more than one CID will be allowed for LE.
>> 
>> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
>> ---
>> net/bluetooth/l2cap_core.c |    2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index d5e4404..95d46cd 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -1792,7 +1792,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
>> 
>> 	auth_type = l2cap_get_auth_type(chan);
>> 
>> -	if (chan->dcid == L2CAP_CID_ATT)
>> +	if (bdaddr_type_is_le(dst_type))
> 
> Wouldn't this break applications that rely on the CID for making a LE 
> connection?

which application are these. They are all from the time where enable_le=0 was the default. We introduced the BD_ADDR address type before we enabled LE by default.

Regards

Marcel

