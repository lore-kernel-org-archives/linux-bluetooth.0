Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <B3B3E392-D840-4924-86B6-951649CD7B79@holtmann.org>
References: <1403897492-6233-1-git-send-email-scott@netsplit.com>
	<B3B3E392-D840-4924-86B6-951649CD7B79@holtmann.org>
Date: Fri, 27 Jun 2014 13:15:09 -0700
Message-ID: <CA+bD78i9+VUdNrGub8Df=EHLqgUzqo4LKs8JFu+BatQSXNgruA@mail.gmail.com>
Subject: Re: [RFC] doc: Add EIR to device properties
From: Scott James Remnant <scott@netsplit.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jun 27, 2014 at 12:55 PM, Marcel Holtmann <marcel@holtmann.org> wro=
te:

>> This patch proposes an extension to the D-Bus Device API to allow
>> an application access to the last EIR data received from a device
>> in inquiry or advertising mode.
>>
> in general I have no objections in exposing the EIR and AD information. H=
owever I do not like to use EIR as property key. I know that on mgmt API we=
 simply went with EIR_Data, but on the D-Bus API we most likely need to fin=
d a name that is a bit more generic and allows to represent EIR and AD info=
rmation.
>

I did indeed just copy the mgmt API terminology here, since it's
obviously _also_ not just the AD report but also the SR report as well
since they're concatenated in the kernel during active scanning.

> One important thing we have to consider are dual-mode devices that are fo=
und via LE and BR/EDR. With dual-mode topology from Bluetooth 4.1 this will=
 become a real possibility and we want them to show under one object path. =
I think we need to brainstorm a little on how this can be done best.
>

The other interesting issue for 4.1 dual-mode topology, which turns
out to be somewhat related, is that if there's only one object path
for a BR/EDR/LE dual-mode device, which bearer is connected when the
application calls org.bluez.Device1.Connect ?

At least the ConnectToProfile call makes that explicit since there's a
Profile object, but even then, if the device supports LE L2CAP
Connection Oriented Channels, do you want that profile connected over
the BR/EDR or LE bearer if the device supports both?

But that method isn't used for establishing the GATT connection on the
LE bearer. (And then you have the whole GATT over BR/EDR thing to
worry about too).


(I also don't remember reading any limitation that a BR/EDR/LE device
_must_ use its Public address during LE Advertisement, but you'd know
better than me on that. Would there be a case where we see advertising
from a device, that on pairing/connection turns out to be, via
receiving IRK, a BR/EDR device we already knew about, and thus we'd
have to deal with device objects merging?)

Scott
--=20
Have you ever, ever felt like this?
Had strange things happen?  Are you going round the twist?
