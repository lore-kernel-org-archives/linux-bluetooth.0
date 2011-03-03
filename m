Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1299174593.18332.42.camel@novo.hadess.net>
References: <AANLkTimCFW3bZkmm_B8VfViMC1A+rDjWRnE5OSB7eCCJ@mail.gmail.com>
	<1299174593.18332.42.camel@novo.hadess.net>
Date: Thu, 3 Mar 2011 19:06:21 +0100
Message-ID: <AANLkTinhMeLRoG8GPrU8C9cNydj2Jxvfvp7PZ-7MCqGC@mail.gmail.com>
Subject: Re: New device driver: Nintendo Wii Remote
From: David Herrmann <dh.herrmann@googlemail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Mar 3, 2011 at 6:49 PM, Bastien Nocera <hadess@hadess.net> wrote:
> On Thu, 2011-03-03 at 18:42 +0100, David Herrmann wrote:
>> Hi
>>
>> The Nintendo Wii Remote (short Wiimote) is the remote for the Nintedo
>> Wii console and communicates via bluetooth. There have been many
>> approaches to write linux drivers (incomplete list:
>> http://wiibrew.org/wiki/Wiimote/Library), however, they all are
>> written as separate libraries and not as device drivers. This has the
>> disadvantage, that the application must actively connect to the
>> wiimote (probably performing a bt-inquiry beforehand) instead of
>> listening for incoming connections.
>> The latter one can be achieved by listening on the HID l2cap channels
>> (psm 0x11 and 0x13), though, the wiimote does not follow the HID
>> standard. Since the bluez input-plugin listens on these ports, the
>> driver needs to be integrated into the bluez-daemon or kernel to work
>> properly.
>
> You can do the pairing by hacking bluetoothd:
> https://bugzilla.gnome.org/show_bug.cgi?id=603845
>
> This is the first thing to fix to get proper Wiimote access. Marcel
> would also like the pairing and PIN setting to be handled directly in
> bluetoothd for this device.

This is not about pairing. Yes, it is true, the wiimote needs to be paired
once to get the address of the host so automatic reconnection works,
but I successfully paired the device via the dbus interface so pairing is
handled inside bluetoothd.
But once paired, no further pairing is needed if the device reconnects
to the host, everything works just fine without pairing. My issue is about
getting access to the listener sockets inside the input-plugin.

Furthermore, the PIN required by the wiimote is not always the same.
It depends whether the 1+2 buttons on the front of the wiimote are
pressed or whether the red-sync button on its back is pressed. One
time it's the bdaddr of the host, the other time its the bdaddr of the remote.

So when actively connecting to the remote (which requires pairing), the
driver needs to create its own PIN-agent for this connection which can
be done via CreatePairedDevice (dbus method on adapter API). So I guess
the PIN handling is fine, or did I misunderstood you?

Cheers
David
