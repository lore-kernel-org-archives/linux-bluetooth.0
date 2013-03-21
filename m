Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: keybuk@google.com
In-Reply-To: <1363852154.2681.3.camel@novo>
References: <1363839008-8405-1-git-send-email-deymo@chromium.org>
	<1363852154.2681.3.camel@novo>
Date: Thu, 21 Mar 2013 16:07:46 -0700
Message-ID: <CAHZ1yCkx89ppxAKeP8O4Oe2tf9KxVYVfeJ4RRxsi2eaW94UgUA@mail.gmail.com>
Subject: Re: [PATCH 0/6] The Autopair strikes back
From: Scott James Remnant <keybuk@chromium.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: Alex Deymo <deymo@chromium.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Mar 21, 2013 at 12:49 AM, Bastien Nocera <hadess@hadess.net> wrote:

> On Wed, 2013-03-20 at 21:10 -0700, Alex Deymo wrote:
>> The goal of this patch set is to make the pairing process easier for
>> devices that have a fixed and dumb pincode (like 0000 or 1234) or that
>> accept any pincode as long as the same pincode is entered on the device
>> (keyboards/combos). The goal is:
>>  * Don't ask the user (i.e. the agent) a question if we know the right answer.
>> This makes the user happier. =)
>
> Is there any chance you could use:
> https://git.gnome.org/browse/gnome-bluetooth/tree/wizard/pin-code-database.xml
> even it means converting it to a different format?
>

One weird issue with this database is that it includes entries for
devices with which pairing is not possible:

<device oui="00:19:C1:" name="BD Remote Control" pin="NULL"/>
<device oui="00:1E:3D:" name="BD Remote Control" pin="NULL"/>
<device oui="00:06:F5:" name="BD Remote Control" pin="NULL"/>

These could be handled by BlueZ refusing to pair with them
automatically, but it could be argued that BlueZ should somehow reveal
to the user that pairing is not possible so it is not offered to begin
with.

It also includes entries for devices (with no distinguishing from the
above) for devices that should not ordinarily be paired:

<device type="mouse" pin="NULL"/>

Again these should be handled similarly to above - informing the user
that pairing is not required, but that connection is possible without
pairing.

It seems to confuse the types of devices that use fixed-length random PINs:

<device type="audio" oui="00:1A:80:" name="CMT-DH5BT" pin="max:4"/>

With keyboards, which should be just max:6. Note that BlueZ already
has the DisplayPinCode agent method precisely to deal with showing a
PIN - so the issue of help text is strictly an application one.

<device type="keyboard" pin="KEYBOARD"/>

> This would mean more supported devices out-of-the-box? I'd be happy
> maintaining the list outside of the bluez tree if the bluez developers
> don't want to take on the burden of maintaining it.
>

If the list isn't maintained in the BlueZ tree, then how will more
devices be supported out-of-the-box?

This, to me, has always seemed like something that should just work
without requiring any special behavior out of the agent. bluetoothctl
should be just as capable as a GNOME Wizard.

Scott
--
Scott James Remnant | Chrome OS Systems | keybuk@google.com | Google
