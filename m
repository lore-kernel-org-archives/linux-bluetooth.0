Return-Path: <cyrus@holtmann.org>
Subject: Wiimote pairing?
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Sat, 05 Dec 2009 13:57:17 +0000
Message-ID: <1260021437.3311.1899.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Heya,

I was under the impression that the Wiimote simply didn't use a PIN
code, but it seems there's a way to pair it and associate it with a
particular host by doing:
http://wiibrew.org/wiki/Wiimote#Sync_Button

I looked through my dongles, and couldn't find one that would allow me
to pass the modified host address as a PIN code as they all have "00" as
part of the address.

bluetoothd uses strings everywhere for PIN code handling. It would be
possible to change the RequestPinCode to also allow:
{string,len} RequestPinCode(object device)
without modifying the current behaviour.

What do you think?

Cheers

Reported to me through the RH bugzilla:
PS: https://bugzilla.redhat.com/show_bug.cgi?id=544564

