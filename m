Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4F044042.2080502@gmail.com>
References: <4EF3BACA.1080405@gmail.com>
	<CACJA=fVezGGcgAtbzG=+ouWq0PiHbgXN1YPwL+VDUphWS7wnrw@mail.gmail.com>
	<4EFA1EB8.9090005@gmail.com>
	<20111227203008.GA13870@joana>
	<4EFA447C.3030906@gmail.com>
	<20111228012248.GC13870@joana>
	<20111228012850.GD13870@joana>
	<4EFA7696.6060506@gmail.com>
	<20111228155225.GA23292@joana>
	<1325090923.1965.282.camel@aeonflux>
	<4F044042.2080502@gmail.com>
Date: Wed, 4 Jan 2012 11:16:00 -0300
Message-ID: <CACJA=fU4QerTS0EEz_Q+16_nPH73WEPadVM53-ZEV8vkEgQD8Q@mail.gmail.com>
Subject: Re: [bluetooth] linux-3.x regression (bisected)
From: Andre Guedes <andre.guedes@openbossa.org>
To: Rene Herman <rene.herman@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <padovan@profusion.mobi>,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rene,

On Wed, Jan 4, 2012 at 9:04 AM, Rene Herman <rene.herman@gmail.com> wrote:
>
> On 28-12-11 17:48, Marcel Holtmann wrote:
>
>> The correct patch would be something like this:
>>
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index 919e3c0..b6eb9c5 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -711,7 +711,8 @@ static void hci_cc_read_local_ext_features(struct
>> hci_dev *h
>> =A0 =A0 =A0 =A0 if (rp->status)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>
>> - =A0 =A0 =A0 memcpy(hdev->extfeatures, rp->features, 8);
>> + =A0 =A0 =A0 if (rp->page =3D=3D 1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy(hdev->extfeatures, rp->features, 8)=
;
>>
>> =A0 =A0 =A0 =A0 hci_req_complete(hdev, HCI_OP_READ_LOCAL_EXT_FEATURES,
>> rp->status);
>> =A0}
>>
>> The current patch is actually fully broken anyway. So besides switching
>> LE on when requesting page 0, you will also switch it off when
>> requesting any other page and it accidentally returns 0x00 since we
>> unconditionally overwrite it.
>
>
> Any word on a final fix for this?

Yes,this couple of patches fixes this issue:
http://article.gmane.org/gmane.linux.bluez.kernel/19950/
http://article.gmane.org/gmane.linux.bluez.kernel/19951/

They were already pushed to bluetooth-next tree.

BR,

Andre
