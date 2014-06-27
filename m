Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [RFC] doc: Add EIR to device properties
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CA+bD78i9+VUdNrGub8Df=EHLqgUzqo4LKs8JFu+BatQSXNgruA@mail.gmail.com>
Date: Fri, 27 Jun 2014 22:26:52 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <5C89CD2F-648F-475D-8E08-7F90493AA912@holtmann.org>
References: <1403897492-6233-1-git-send-email-scott@netsplit.com> <B3B3E392-D840-4924-86B6-951649CD7B79@holtmann.org> <CA+bD78i9+VUdNrGub8Df=EHLqgUzqo4LKs8JFu+BatQSXNgruA@mail.gmail.com>
To: Scott James Remnant <scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

>>> This patch proposes an extension to the D-Bus Device API to allow
>>> an application access to the last EIR data received from a device
>>> in inquiry or advertising mode.
>>> 
>> in general I have no objections in exposing the EIR and AD information. However I do not like to use EIR as property key. I know that on mgmt API we simply went with EIR_Data, but on the D-Bus API we most likely need to find a name that is a bit more generic and allows to represent EIR and AD information.
>> 
> 
> I did indeed just copy the mgmt API terminology here, since it's
> obviously _also_ not just the AD report but also the SR report as well
> since they're concatenated in the kernel during active scanning.

maybe something generic like InformationData. Honestly I do not know yet. I do however have bad feeling with calling it just EIR.

>> One important thing we have to consider are dual-mode devices that are found via LE and BR/EDR. With dual-mode topology from Bluetooth 4.1 this will become a real possibility and we want them to show under one object path. I think we need to brainstorm a little on how this can be done best.
>> 
> 
> The other interesting issue for 4.1 dual-mode topology, which turns
> out to be somewhat related, is that if there's only one object path
> for a BR/EDR/LE dual-mode device, which bearer is connected when the
> application calls org.bluez.Device1.Connect ?

Simple answer without overthinking it is both.

> At least the ConnectToProfile call makes that explicit since there's a
> Profile object, but even then, if the device supports LE L2CAP
> Connection Oriented Channels, do you want that profile connected over
> the BR/EDR or LE bearer if the device supports both?

We do not have services that will expose L2CAP Connection Oriented channels on both BR/EDR and LE and use the same UUID. The classic BR/EDR profiles will not be mapped over LE at this moment.

> But that method isn't used for establishing the GATT connection on the
> LE bearer. (And then you have the whole GATT over BR/EDR thing to
> worry about too).

The database is suppose to be the same. And honestly with dual-mode topology, the GATT over BR/EDR is essentially pointless. You will be just doing it over LE which is way simpler.

> (I also don't remember reading any limitation that a BR/EDR/LE device
> _must_ use its Public address during LE Advertisement, but you'd know
> better than me on that. Would there be a case where we see advertising
> from a device, that on pairing/connection turns out to be, via
> receiving IRK, a BR/EDR device we already knew about, and thus we'd
> have to deal with device objects merging?)

There is no requirement to use your public address in advertising. You can always use random private address.

And public address on BR/EDR and RPA on LE can be the case. The iPhone being the prime example here. And we already merge the objects together as good as we can. Johan can explain this since I have to admit I spaced out when he told me on how he did it. Or I just imagined it, which is possible ;)

If you have seen my proposal for Privacy mode 0x02, then I think that we are going for using public address when we are discoverable and RPA when non-discoverable. That allows us to avoid trackability in the most cases and still allow for a smoother operation during pairing.

Regards

Marcel

