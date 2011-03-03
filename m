Return-Path: <cyrus@holtmann.org>
Subject: Re: New device driver: Nintendo Wii Remote
From: Bastien Nocera <hadess@hadess.net>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 03 Mar 2011 17:49:53 +0000
In-Reply-To: <AANLkTimCFW3bZkmm_B8VfViMC1A+rDjWRnE5OSB7eCCJ@mail.gmail.com>
References: <AANLkTimCFW3bZkmm_B8VfViMC1A+rDjWRnE5OSB7eCCJ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Message-ID: <1299174593.18332.42.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2011-03-03 at 18:42 +0100, David Herrmann wrote:
> Hi
> 
> The Nintendo Wii Remote (short Wiimote) is the remote for the Nintedo
> Wii console and communicates via bluetooth. There have been many
> approaches to write linux drivers (incomplete list:
> http://wiibrew.org/wiki/Wiimote/Library), however, they all are
> written as separate libraries and not as device drivers. This has the
> disadvantage, that the application must actively connect to the
> wiimote (probably performing a bt-inquiry beforehand) instead of
> listening for incoming connections.
> The latter one can be achieved by listening on the HID l2cap channels
> (psm 0x11 and 0x13), though, the wiimote does not follow the HID
> standard. Since the bluez input-plugin listens on these ports, the
> driver needs to be integrated into the bluez-daemon or kernel to work
> properly.

You can do the pairing by hacking bluetoothd:
https://bugzilla.gnome.org/show_bug.cgi?id=603845

This is the first thing to fix to get proper Wiimote access. Marcel
would also like the pairing and PIN setting to be handled directly in
bluetoothd for this device.

Cheers

