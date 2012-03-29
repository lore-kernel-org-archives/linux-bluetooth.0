Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1333042298.1870.220.camel@aeonflux>
References: <1332892776-12060-1-git-send-email-andre.guedes@openbossa.org>
	<1332892776-12060-3-git-send-email-andre.guedes@openbossa.org>
	<20120329091236.GA22600@x220>
	<CACJA=fWJ_u7CMW0+8XMjbV5kxZ7y8PrsEFh7p2dEBsOTSnBLXg@mail.gmail.com>
	<1333042298.1870.220.camel@aeonflux>
Date: Thu, 29 Mar 2012 14:56:37 -0300
Message-ID: <CACJA=fWNRQWRgcggx5FD756RXZXaTcmUOtcPp_=_Tf_tYcJkuA@mail.gmail.com>
Subject: Re: [RFC 2/3] Bluetooth: Add dst_type parameter to hci_connect
From: Andre Guedes <andre.guedes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Mar 29, 2012 at 2:31 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Andre,
>
>> > On Tue, Mar 27, 2012, Andre Guedes wrote:
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 le->dst_type =3D (dst_type =3D=3D MGMT_ADDR=
_LE_RANDOM) ?
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ADDR_LE_DEV=
_RANDOM : ADDR_LE_DEV_PUBLIC;
>> >
>> > You might want to make a simple helper function for the type conversio=
n.
>> >
>> > Also, I'm not so sure it's a good idea to directly reuse mgmt API
>> > defines for the L2CAP socket interface. The values may in the end be t=
he
>> > same but probably there should be separate defines in l2cap.h.
>>
>> I'm not sure too.
>>
>> I think it would be better we define address type macros in
>> bluetooth.h and replace its prefix by BDADDR_TYPE_. So we would have
>> something like this in bluetooth.h:
>>
>> +/* BD Address type */
>> +#define BDADDR_TYPE_BREDR =A0 =A0 =A00x00
>> +#define BDADDR_TYPE_LE_PUBLIC =A00x01
>> +#define BDADDR_TYPE_LE_RANDOM =A00x02
>> +#define BDADDR_TYPE_INVALID =A0 =A00xff
>
> what is INVALID for? That seems like a pointless value to have.

Management interface defines a invalid address type macro, but I think
we can easily remove it.

>> What do you think?
>
> I also get the feeling that these are a bit long. What is the benefit of
> using BDADDR_TYPE_ namespace. Would not something like this be better:
>
> =A0 =A0 =A0 =A0BDADDR_BREDR =A0 =A0 0x00
> =A0 =A0 =A0 =A0BDADDR_LE_PUBLIC 0x01
> =A0 =A0 =A0 =A0BDADDR_LE_RANDOM 0x02

Yes, it would be better. I'll work on a patch for this and add it to
the RFC v2 series.

BR,

Andre
