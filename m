Return-Path: <cyrus@holtmann.org>
Subject: Re: Binary PIN Support
From: Marcel Holtmann <marcel@holtmann.org>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Date: Thu, 02 Jun 2011 03:08:17 +0200
In-Reply-To: <BANLkTikAfy-=MRTb_SGa8d2td5oq73xGYg@mail.gmail.com>
References: <BANLkTikAfy-=MRTb_SGa8d2td5oq73xGYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1306976897.7131.5.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> Since only half of my binary-PIN patches got applied upstream, I want to start
> a new discussion about binary PIN support.
> 
> The thing is, the wiimote device (and as reported also some other
> devices) requires
> a BT-address (which may contain \0) as bluetooth pin. Current dbus
> design forbids
> strings containing \0 (used as string terminator) and so an agent cannot send
> binary PINs to bluetoothd as return value of RequestPinCode().
> 
> The BT specs 3.0+ HS (Volume 3, Part C, 3.2.3 Bluetooth Passkey) say
> the UI-input shall
> be UTF-8 encoded and preferably use only the UFT-8 range 0x00-0x7F to
> avoid multibyte
> characters. There is also a recommendation for multi-byte characters.
> Dbus uses utf-8 encoded strings so bluetoothd does not need to modify the
> PIN, but current implementation restricts/violates the specs because
> it disallows 0x00 as
> valid PIN character.
> 
> Since the idea with hex-encoding binary PINs and prefixing them with
> '$' did not get
> accepted, I have some other ideas for this:
> 
> 1: Use hard coded PINs for those devices. That is, use VID/PID
> detection during pairing
> and send hardcoded PIN (or based on src/dst address). Problem: VID/PID
> information is
> not available during pairing or may not be available, yet. Some
> devices may even reject
> SDP requests when not paired (as mentioned on IRC). Maybe someone has
> an idea how to
> get this working.

if I remember this correctly, then Wiimote does support DeviceID profile
and thus reports proper VID/PID combinations.

So just create some auto-pair support in bluetoothd (if needed via
plugins) and just auto-pair them like we would do with Secure Simple
Pairing anyway.

There is really no need at all to involve the UI code and mess up the
D-Bus API as it is. It was never designed for hardcoded PIN codes other
then numbers and strings anyway.

> 2: Extend DBus Agent API with a function RequestBinaryPinCode() which
> works exactly
> like RequestPinCode() but returns a bytearray (with length) instead of a string.
> A dbus agent then needs to signal to bluetoothd that it provides this
> method and bluetoothd
> shall call RequestBinaryPinCode() instead of RequestPinCode().
> However, I couldn't figure out a proper way to signal this capability
> to bluetoothd.
> The agent could send some kind of EnabledBinaryPinSupport-Signal to
> bluetoothd...

No way ever. We had that problem when we initially had to support a
fallback for the agent in 3.x series. Never ever again.

> 3: Use some kind of encoding in the UTF-8 string as proposed with the
> '$' character.
> However, this might break old software.

And how is that going to work out in reality. Same as $ is a valid
character. So also a clear no.

Go with 1) and try to just auto-pair the Wiimotes. That is the right
approach and makes a lot sense. It might be the one with the most work
on getting the DeviceID support integrated properly, but it is the right
way forward here.

Regards

Marcel


