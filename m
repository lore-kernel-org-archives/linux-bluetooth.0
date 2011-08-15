Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1313356642.3373.170.camel@aeonflux>
References: <1313325793-27866-1-git-send-email-iliak@ti.com>
	<1313356642.3373.170.camel@aeonflux>
Date: Mon, 15 Aug 2011 10:52:42 +0300
Message-ID: <CABBYNZKeKQY2QXX2KX6=iyf3o10Wu=iq8PnhiSAJM2E_+RDP2g@mail.gmail.com>
Subject: Re: [PATCH v2 bluetooth-next] Added ioctl flow specification command
 on HCI socket
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: ilia.kolominsky@gmail.com, linux-bluetooth@vger.kernel.org,
	Ilia Kolomisnky <iliak@ti.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Aug 15, 2011 at 12:17 AM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> Hi Ilia,
>
>> While it is possible to send flow specification HCI command
>> from the user space directly via the send api of HCI socket,
>> a more specific approach is preferable over the opaque
>> HCI command, since it will allow for centralized mangament of
>> flow specifiaction requests for different l2cap flows over
>> the same acl link in future. This feature was used successfully
>> for solving the qos A2DP issue in piconet with concurent file
>> transfer.
>>
>> Signed-off-by: Ilia Kolomisnky <iliak@ti.com>
>> ---
>> =A0include/net/bluetooth/hci.h =A0 =A0 =A0| =A0 38 ++++++++++++++++++---=
-
>> =A0include/net/bluetooth/hci_core.h | =A0 =A03 ++
>> =A0net/bluetooth/hci_conn.c =A0 =A0 =A0 =A0 | =A0 =A01 +
>> =A0net/bluetooth/hci_core.c =A0 =A0 =A0 =A0 | =A0 63 +++++++++++++++++++=
+++++++++++++++++++
>> =A0net/bluetooth/hci_event.c =A0 =A0 =A0 =A0| =A0 37 +++++++++++++++++++=
+++
>> =A0net/bluetooth/hci_sock.c =A0 =A0 =A0 =A0 | =A0 =A02 +
>> =A06 files changed, 137 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>> index be30aab..f0f90d5 100644
>> --- a/include/net/bluetooth/hci.h
>> +++ b/include/net/bluetooth/hci.h
>> @@ -109,6 +109,8 @@ enum {
>> =A0#define HCISETLINKMODE =A0 =A0 =A0 _IOW('H', 226, int)
>> =A0#define HCISETACLMTU _IOW('H', 227, int)
>> =A0#define HCISETSCOMTU _IOW('H', 228, int)
>> +#define HCISETFLOWSPEC _IOW('H', 229, int)
>> +
>
> I am not accepting any new addition of ioctl() at this moment. We are
> moving towards a proper defined management API. And that is how this
> should be addressed.
>
> And these kind of ictol() that have to execute a HCI command and wait
> for the result are not a good for being an ioctl() in the first place.
>
> Regards
>
> Marcel

I got the impression that the spec indicates this should first be
negotiated on l2cap level since there is a command with exact same
parameters, perhaps the way to go would be to have this as a socket
option and require some capability to be able to set them, after the
L2CAP QoS negotiation completes the kernel could automatically set the
HCI QoS based on that.

--=20
Luiz Augusto von Dentz
