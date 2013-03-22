Return-Path: <cyrus@holtmann.org>
Message-ID: <1363940639.29764.35.camel@novo>
Subject: Re: [PATCH 0/6] The Autopair strikes back
From: Bastien Nocera <hadess@hadess.net>
To: Scott James Remnant <keybuk@chromium.org>
Cc: Alex Deymo <deymo@chromium.org>, "linux-bluetooth@vger.kernel.org"
	 <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Date: Fri, 22 Mar 2013 09:23:59 +0100
In-Reply-To: <CAHZ1yCkx89ppxAKeP8O4Oe2tf9KxVYVfeJ4RRxsi2eaW94UgUA@mail.gmail.com>
References: <1363839008-8405-1-git-send-email-deymo@chromium.org>
	 <1363852154.2681.3.camel@novo>
	 <CAHZ1yCkx89ppxAKeP8O4Oe2tf9KxVYVfeJ4RRxsi2eaW94UgUA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2013-03-21 at 16:07 -0700, Scott James Remnant wrote:
> On Thu, Mar 21, 2013 at 12:49 AM, Bastien Nocera <hadess@hadess.net> wrote:
> 
> > On Wed, 2013-03-20 at 21:10 -0700, Alex Deymo wrote:
> >> The goal of this patch set is to make the pairing process easier for
> >> devices that have a fixed and dumb pincode (like 0000 or 1234) or that
> >> accept any pincode as long as the same pincode is entered on the device
> >> (keyboards/combos). The goal is:
> >>  * Don't ask the user (i.e. the agent) a question if we know the right answer.
> >> This makes the user happier. =)
> >
> > Is there any chance you could use:
> > https://git.gnome.org/browse/gnome-bluetooth/tree/wizard/pin-code-database.xml
> > even it means converting it to a different format?
> >
> 
> One weird issue with this database is that it includes entries for
> devices with which pairing is not possible:

It's a device database for gnome-bluetooth's wizard, not something
solely for pairing.

> <device oui="00:19:C1:" name="BD Remote Control" pin="NULL"/>
> <device oui="00:1E:3D:" name="BD Remote Control" pin="NULL"/>
> <device oui="00:06:F5:" name="BD Remote Control" pin="NULL"/>
> 
> These could be handled by BlueZ refusing to pair with them
> automatically, but it could be argued that BlueZ should somehow reveal
> to the user that pairing is not possible so it is not offered to begin
> with.

Completely agreed.

> It also includes entries for devices (with no distinguishing from the
> above)

from the above what?

>  for devices that should not ordinarily be paired:
> 
> <device type="mouse" pin="NULL"/>

Yes. I didn't want those device classes hard-coded in the wizard code
itself.

> Again these should be handled similarly to above - informing the user
> that pairing is not required, but that connection is possible without
> pairing.

They actually 

> It seems to confuse the types of devices that use fixed-length random PINs:
> 
> <device type="audio" oui="00:1A:80:" name="CMT-DH5BT" pin="max:4"/>
> 
> With keyboards, which should be just max:6. Note that BlueZ already
> has the DisplayPinCode agent method precisely to deal with showing a
> PIN - so the issue of help text is strictly an application one.

It's absolutely not a confusion. This device is a speaker box, with
input devices. The device supports a maximum of 4 digits for the PIN but
can enter any digits. So we truncate the maximum number of digits
requested from the device so that pairing is possible.

> <device type="keyboard" pin="KEYBOARD"/>
> 
> > This would mean more supported devices out-of-the-box? I'd be happy
> > maintaining the list outside of the bluez tree if the bluez developers
> > don't want to take on the burden of maintaining it.
> >
> 
> If the list isn't maintained in the BlueZ tree, then how will more
> devices be supported out-of-the-box?

It can be a separate project that BlueZ (optionally) depends on.

> This, to me, has always seemed like something that should just work
> without requiring any special behavior out of the agent. bluetoothctl
> should be just as capable as a GNOME Wizard.

I completely agree.

The database solves a number of problems, not all of them relevant to
the autopair plugin:
1) separates devices that can be paired, and those that will just be
connected to and marked as trusted (apple mouse vs. normal mouse)
2) gives out the PIN code for particular devices (see the list of GPS
devices in the database)
3) explains how to generate random PINs for particular devices (such as
the CMT-DH5BT above)
4) hints the UI as to how to present the pairing. For non-SSP keyboards,
pressing return is necessary, for the iCade, we want to use joystick
directions instead of digits.

So there's definitely a subset of that database which is useful.

I don't particularly care if you use the same format or not, but using
it would mean that the autopair plugin would work better out-of-the-box
(would you have guessed the non-numeric "NAVMAN" password for the navman
GPS one?).

Cheers
