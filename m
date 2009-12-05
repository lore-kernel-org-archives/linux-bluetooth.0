Return-Path: <cyrus@holtmann.org>
Subject: Re: Wiimote pairing?
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1260021437.3311.1899.camel@localhost.localdomain>
References: <1260021437.3311.1899.camel@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 05 Dec 2009 15:50:58 +0100
Message-ID: <1260024658.3041.14.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> I was under the impression that the Wiimote simply didn't use a PIN
> code, but it seems there's a way to pair it and associate it with a
> particular host by doing:
> http://wiibrew.org/wiki/Wiimote#Sync_Button
> 
> I looked through my dongles, and couldn't find one that would allow me
> to pass the modified host address as a PIN code as they all have "00" as
> part of the address.
> 
> bluetoothd uses strings everywhere for PIN code handling. It would be
> possible to change the RequestPinCode to also allow:
> {string,len} RequestPinCode(object device)
> without modifying the current behaviour.

that is no really how D-Bus would handle strings. From a D-Bus point of
view, the only way would be using a Byte array.

Potentially we could allow implementing a passkey agent as a plugin and
then you could implement special handling via a plugin. Problem then
again is how to identify that it is a Wiimote. Or did they actually
added a PnP SDP record to it. It has been so long that I hacked on these
devices.

Regards

Marcel


