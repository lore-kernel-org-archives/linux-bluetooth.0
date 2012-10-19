Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1350602001.2026.35.camel@aeonflux>
References: <1350565311-18330-1-git-send-email-frederic.danis@linux.intel.com>
	<1350565311-18330-2-git-send-email-frederic.danis@linux.intel.com>
	<1350602001.2026.35.camel@aeonflux>
Date: Thu, 18 Oct 2012 21:41:11 -0300
Message-ID: <CAJdJm_NxX6qJYiRrotGroBAJUne9OrwKSiuxF2aukPaUSt9k=A@mail.gmail.com>
Subject: Re: [PATCH v6 01/16] doc: Add settings storage documentation
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: =?ISO-8859-1?Q?Fr=E9d=E9ric_Danis?= <frederic.danis@linux.intel.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel/Fr=E9d=E9ric,

On Thu, Oct 18, 2012 at 8:13 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>> +  [0x0001]
>> +  UUID=3D00002800-0000-1000-8000-00805f9b34fb
>> +  Value=3D0018
>> +
>> +  [0x0004]
>> +  UUID=3D00002803-0000-1000-8000-00805f9b34fb
>> +  Value=3D020600002A
>> +
>> +  [0x0006]
>> +  UUID=3D00002a00-0000-1000-8000-00805f9b34fb
>> +  Value=3D4578616D706C6520446576696365
>
> You need to mention that values are hex encoded strings. Just to be
> clear here.
>
> I am not 100% convinced that we want to keep the sections/handles in hex
> value notation. Is that really a good idea?

Alternatively, we could have:

[Attribute<N>]
UUID=3D...
Value=3D...

where "<N>" is the attribute value handle (in decimal). The section
name could then be easily parsed to extract the handle from it.

What do you think?

Regards,
--=20
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
