Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1305163228.15916.163.camel@aeonflux>
References: <1304030229-6672-3-git-send-email-claudio.takahasi@openbossa.org>
	<1304458357-21571-1-git-send-email-claudio.takahasi@openbossa.org>
	<20110504060357.GA3711@jh-x301>
	<1305163228.15916.163.camel@aeonflux>
Date: Thu, 12 May 2011 14:55:24 -0300
Message-ID: <BANLkTims0=RKEBMaSgG-Mw5RfUJKrWtR=A@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] Add Bluetooth address type definition
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel/Johan,

On Wed, May 11, 2011 at 10:20 PM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> Hi Johan,
>
>> > Values defined to LE(public and random) are defined in the Bluetooth
>> > Core Specification. For basic rate, there isn't address type concept.
>> > The constants introduced by this commit will be used to identify the
>> > remote address type, basically to distinguish LE/BR devices before
>> > to request the L2CAP connection.
>> > ---
>> > =C2=A0lib/bluetooth.h | =C2=A0 =C2=A04 ++++
>> > =C2=A01 files changed, 4 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/lib/bluetooth.h b/lib/bluetooth.h
>> > index 738e07a..98b8f1c 100644
>> > --- a/lib/bluetooth.h
>> > +++ b/lib/bluetooth.h
>> > @@ -130,6 +130,10 @@ typedef struct {
>> > =C2=A0#define BDADDR_ALL =C2=A0 (&(bdaddr_t) {{0xff, 0xff, 0xff, 0xff,=
 0xff, 0xff}})
>> > =C2=A0#define BDADDR_LOCAL (&(bdaddr_t) {{0, 0, 0, 0xff, 0xff, 0xff}})
>> >
>> > +#define BDADDR_TYPE_LE_PUBLIC =C2=A0 =C2=A0 =C2=A00x00
>> > +#define BRADDR_TYPE_LE_RANDOM =C2=A0 =C2=A0 =C2=A00x01
>> > +#define BDADDR_TYPE_BR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0xff
>>
>> Firstly this still needs Marcel's blessing (though I don't really see
>> any other solution than an address type with three possible values).
>> Secondly, if this is ever going to be added to the L2CAP socket address
>> you'd have to have 0x00 as BDADDR_TYPE_BR for backwards compatibility.
>
> I am still not 100% convinced, but yes, the default 0x00 then needs to
> be BDADDR_TYPE_BREDR. Otherwise we break APIs.
>
> Regards
>
> Marcel

Use the kernel advertising cache(for address type) plus a device
type(LE or BR) field in the mgmt_ev_device_found is another approach.
Can we proceed with this approach?

Claudio.
