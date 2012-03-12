Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 4/5] HID: autoload hid-multitouch as needed
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: =?iso-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
In-Reply-To: <1331574151.14217.86.camel@aeonflux>
Date: Mon, 12 Mar 2012 21:47:19 +0100
Cc: Jiri Kosina <jkosina@suse.cz>,
 Henrik Rydberg <rydberg@euromail.se>,
 "benjamin.tissoires" <benjamin.tissoires@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "Gustavo F. Padovan" <padovan@profusion.mobi>,
 linux-bluetooth@vger.kernel.org
Message-Id: <4B25AD62-B1C9-4C57-AE64-34EB7F47DC9B@enac.fr>
References: <1331053026-21272-1-git-send-email-benjamin.tissoires@gmail.com> <1331053026-21272-5-git-send-email-benjamin.tissoires@gmail.com>   <alpine.LNX.2.00.1203072234550.29034@pobox.suse.cz>  <20120308105737.GA11201@polaris.bitmath.org>  <6E17845C-6F9F-4CB6-AA5D-DEEDCD2089E8@enac.fr>  <alpine.LNX.2.00.1203121650500.18356@pobox.suse.cz> <1331574151.14217.86.camel@aeonflux>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Marcel and Jiri

> Hi Jiri,
>=20
>>>> What if we were to change the definition of a HID device on the
>>>> modalias level?
>>>>=20
>>>> In practise, a HID device can be either an usb device, a hid =
device,
>>>=20
>>> Just to be sure: do you mean "bluetooth device"? or is there such a=20=

>>> thing as a hid device per se? I'm asking because I've always been=20
>>> surprised at seeing usbhid/ in hid/, which kind of breaks the =
potential=20
>>> symmetry between USB and Bluetooth wrt hid.
>>=20
>> Please don't get confused by the directory layout ... this has mostly=20=

>> non-technical reasons -- Marcel wanted to keep bluetooth/hidp under =
his=20
>> wings, and I didn't have reasons to object strongly.
>>=20
>> I am adding Marcel and Gustavo to CC just in case they have changed =
their=20
>> mind, but it's definitely a side-topic in this discussion.
>=20
> I have not changed my mind. HIDP is Bluetooth specific and should stay
> there. Especially since we are currently discussing changes to make
> things also work over Bluetooth Low Energy (LE), but that is a =
complete
> different topic and it just started.

Just in case it makes a difference, I knew nothing about HIDP when I =
wrote the message above. My point was rather that hid looks like a bus =
to which several transport layers can connect (USB, Bluetooth, ZigBee, =
etc), and that having USB-specific code in hid/ (as opposed to having it =
in usb/) seems biased towards USB. I was (and am still) wondering how =
much it limits future uses of the hid core by making it USB-dependent.

In other words: is the hid core generic enough or are there steps to =
take to make it more generic wrt transport layers? If we are talking =
about restructuring parts of it, this seems like the right time to ask =
:-)

Cheers,

St.
