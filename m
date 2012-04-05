Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1333648179.16897.16.camel@aeonflux>
References: <1333646241-12574-1-git-send-email-andre.guedes@openbossa.org>
	<1333646241-12574-2-git-send-email-andre.guedes@openbossa.org>
	<1333648179.16897.16.camel@aeonflux>
Date: Thu, 5 Apr 2012 19:18:04 -0300
Message-ID: <CACJA=fXwkotOD5kUVEDCGEx31XYkyaMXn72hoTqDMFFOrSQ4+Q@mail.gmail.com>
Subject: Re: [RFC v3 1/5] Bluetooth: Add address type to struct sockaddr_l2
From: Andre Guedes <andre.guedes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Apr 5, 2012 at 2:49 PM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
> Hi Andre,
>
>> This patch adds the address type info to struct sockaddr_l2 so
>> user-space can inform the remote device address type required
>> to establish LE connections.
>>
>> Soon, instead of looking the advertising cache up to discover the
>> address type, we'll use this address type info to establish LE
>> connections.
>>
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> =A0include/net/bluetooth/l2cap.h | =A0 =A01 +
>> =A01 file changed, 1 insertion(+)
>>
>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap=
.h
>> index f6f0500..d14967e 100644
>> --- a/include/net/bluetooth/l2cap.h
>> +++ b/include/net/bluetooth/l2cap.h
>> @@ -57,6 +57,7 @@ struct sockaddr_l2 {
>> =A0 =A0 =A0 __le16 =A0 =A0 =A0 =A0 =A0l2_psm;
>> =A0 =A0 =A0 bdaddr_t =A0 =A0 =A0 =A0l2_bdaddr;
>> =A0 =A0 =A0 __le16 =A0 =A0 =A0 =A0 =A0l2_cid;
>> + =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0l2_bdaddr_type;
>> =A0};
>
> so I am trying to come up with a better name for this value. It feels a
> little bit too long to me.
>
> I was considering l2_bdtype, but that is not really semantically correct
> here. Or would it be fine? We could do l2_bdatype, but that does not
> really make it any better either.

Yes, it is a little big to me too. But that was the best name I could
find. Other names just don't clearly say what this field means.

BR,

Andre
