Return-Path: <cyrus@holtmann.org>
Message-ID: <1327334612.32646.97.camel@novo.hadess.net>
Subject: Re: [RFC PATCH 0/3] Generate PIN for keyboards inside bluetoothd
From: Bastien Nocera <hadess@hadess.net>
To: Scott James Remnant <scott@netsplit.com>
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org
Date: Mon, 23 Jan 2012 16:03:32 +0000
In-Reply-To: <CA+bD78h+vp5EY+HSvArRSfySr3EWSi3f0qvK+PiKX6OH8Q7w-A@mail.gmail.com>
References: <1327100744-28782-1-git-send-email-scott@netsplit.com>
	 <1327320873.32646.77.camel@novo.hadess.net>
	 <CA+bD78h+vp5EY+HSvArRSfySr3EWSi3f0qvK+PiKX6OH8Q7w-A@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I should really send those mails in the afternoon...

On Mon, 2012-01-23 at 07:37 -0800, Scott James Remnant wrote:
> On Mon, Jan 23, 2012 at 4:14 AM, Bastien Nocera <hadess@hadess.net> wrote:
> 
> > On Fri, 2012-01-20 at 15:05 -0800, Scott James Remnant wrote:
> > > Here's a first pass of handling the HID profile recommendation for
> > > pairing keyboards inside bluetoothd, rather than expecting the UI
> > > Agent to deal with it.
> > >
> > > This requires agents implement a new DisplayPinCode method, since
> > > the existing DisplayPasskey method expects a numeric and PIN Codes
> > > are UTF-8 strings.
> >
> > When have you seen non-numerical PINs being used?
> >
> 
> Two devices on my desk right now use a UTF-8 text string as the fixed
> PIN, and three use their Bluetooth address in binary form. That being
> said, none of them are covered by this patch.

Right. I actually know about those:
http://git.gnome.org/browse/gnome-bluetooth/tree/wizard/pin-code-database.xml#n139

And it's not relevant to the discussion. Any chance you could send me
the details about your devices for me to add them to the database? :)

> > > As well as general type-stricty-ness, the method allows the UI to
> > > distinguish between a Bluetooth 2.0 keyboard (ie. all of them) and
> > > future Bluetooth 2.1 keyboards implementing SSP (for which there may
> > > be keypress notification). UIs might want to display them slightly
> > > differently (OS X does, and UI developers tend to just copy that).
> > >
> > > That said, the PINs generated here are 6-digit 0-padded numerics
> > > since that's probably less confusing for users and there are
> > > Bluetooth numeric keypads out there that can't do non-numerics.
> >
> > Less confusing for users? Unless the UI is broken and doesn't follow the
> > documentation, they should be showing a zero-padded 6 digit number:
> 
> Which is why a zero-padded 6 digit number is generated as the PIN
> here, for consistency with a Bluetooth 2.1 Passkey.
> 
> >                void DisplayPasskey(object device, uint32 passkey, uint8 entered)
> >                        [...]
> >                        Note that the passkey will always be a 6-digit number,
> >                        so the display should be zero-padded at the start if
> >                        the value contains less than 6 digits.
> >
> > I fail to see what the benefit of those new functions is, apart from
> > hypothetical correctness.
> >

My mistake here for quoting SSP related function.

> Firstly this indicates that a Bluetooth 2.0 keyboard is being paired
> using a PIN, rather than a Bluetooth 2.1 Secure Simple Pairing device
> with a passkey. A major UI difference is that the 2.0 device won't
> have typing notification, and the UI designer might want to respond
> slightly differently to this case.

if type == keyboard && ssp == FALSE:
    str pincode = generate_pincode();

We already know when we have a keyboard, we already know when we have a
non-SSP device. Why can't we use RequestPincode in the UI? We already
generate the random PIN for devices.

> > From what I can see, the whole operation can be implemented from
> > user-space without a problem.
> >
> > Care to explain what benefits this has for user-space?
> >
> 
> Marcel asked me to implement this in bluetoothd, so everyone can
> benefit equally rather than four different bluetooth agents all
> handling auto-pairing slightly differently.

In which case it needs not to regress from the existing solutions. We
have a database of devices with their specific pairing information, we
also have ways to show the PIN in special ways depending on the remote
device:
http://imageshack.us/f/192/returnr.png/
and
https://twitter.com/#!/hadessuk/status/160083075815063552

