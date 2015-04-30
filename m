Return-Path: <cyrus@holtmann.org>
From: "Ziv, Dotan" <dotanz@ti.com>
To: Marcel Holtmann <marcel@holtmann.org>, "Reizer, Eyal" <eyalr@ti.com>
CC: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Eyal Reizer
	<eyalreizer@gmail.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Pavan Savoy <pavan_savoy@ti.com>, "Mahaveer,
 Vishal" <vishalm@ti.com>,
        "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] Bluetooth: Add tty HCI driver
Date: Thu, 30 Apr 2015 15:08:34 +0000
Message-ID: <CFED3E0323D4A34CA12CA6A6CB42014223C43FEE@DFRE01.ent.ti.com>
References: <1430380089-2395-1-git-send-email-eyalr@ti.com>
 <20150430113103.3ad0bfac@lxorguk.ukuu.org.uk>
 <2A731A0F-6BEB-4614-94E8-90B28BEE2DD9@holtmann.org>
 <8665E2433BC68541A24DFFCA87B70F5B2365DFEB@DFRE01.ent.ti.com>
 <E924CD28-8A0C-4F39-AA87-D97185B68786@holtmann.org>
In-Reply-To: <E924CD28-8A0C-4F39-AA87-D97185B68786@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel

>-----Original Message-----
>From: Marcel Holtmann [mailto:marcel@holtmann.org]
>Sent: Thursday, April 30, 2015 5:58 PM
>To: Reizer, Eyal
>Cc: One Thousand Gnomes; Eyal Reizer; linux-kernel@vger.kernel.org; Pavan
>Savoy; Mahaveer, Vishal; linux-bluetooth@vger.kernel.org; Ziv, Dotan
>Subject: Re: [PATCH] Bluetooth: Add tty HCI driver
>
>Hi Eyal,
>
>>>>> tty_hci driver exposes a /dev/hci_tty character device node, that
>>>>> intends to emulate a generic /dev/ttyX device that would be used by
>>>>> the user-space Bluetooth stacks to send/receive data to/from the WL
>>>>> combo-connectivity chipsets.
>>>>
>>>> We have an in kernel bluetooth stack, why do we care about this -
>>>> how will people test and debug driver interactions with binary only
>>>> bluetooth stacks in userspace ?
>>>
>>> NAK to this driver.
>>>
>>> If you want to run an external Bluetooth stack, then use HCI User
>>> Channel. The functionality already exists.
>>
>> This is a pretty old driver that has been written a couple of years back=
 and is
>being used by customers (including android that use a userspace based stac=
k).
>> If there is another driver already available that provides same function=
ality,
>of course we will be happy to use it instead.
>> Any idea of where we can get info on the HCI User Channel?
>
>search for my BlueZ for Android presentation from Android Builders Summit
>from 2014. It has an explanation on how HCI User Channel works.
>
>Otherwise look into bluez.git since it contains a bunch of examples on how=
 to
>use the HCI User Channel. It is a generic functionality for raw access to =
the HCI
>layer. Look for HCI_CHANNEL_USER.
>
>>> We do not want to have two drivers for the same hardware. Work with
>>> the Bluetooth stack that is present in the kernel and please stop hacki=
ng
>around it.
>>>
>> There are in fact quite a few products that use commercial user space ba=
sed
>Bluetooth stacks.
>> One reason is that bluez has not been certified but I assume they have
>other reasons as well.
>
>Please stop this FUD. BlueZ has been qualified multiple times.
>
>And let me tell you this, when doing BlueZ for Android, we went through a
>lengthy period of qualification and fixing PTS with 65 errata today. I don=
't
>know if any commercial stack was actually such a good citizen in ensuring =
that
>the certification tools get fixed. And we documented all of it.
>

No argue here, as a matter of fact, we (TI) certified BlueZ several times i=
n the past. Our customers are using large variety of Kernel versions and mi=
ght use a different version of BlueZ. Our BQE requested us to certify the s=
tack per kernel and per BlueZ version which is practically impossible (due =
to certification costs and the time it takes).=20
If you are familiar with a way to bypass it, that would be great.

>Clone the bluez.git tree and look for android/{pts,pics,pixit}-*.txt files=
. They
>contain all details for qualifying BlueZ for Android stack.
>
>Regards
>
>Marcel

Regards,
Dotan
