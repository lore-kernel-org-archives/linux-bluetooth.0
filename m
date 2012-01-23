Return-Path: <cyrus@holtmann.org>
Message-ID: <1327320873.32646.77.camel@novo.hadess.net>
Subject: Re: [RFC PATCH 0/3] Generate PIN for keyboards inside bluetoothd
From: Bastien Nocera <hadess@hadess.net>
To: Scott James Remnant <scott@netsplit.com>
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org
Date: Mon, 23 Jan 2012 12:14:33 +0000
In-Reply-To: <1327100744-28782-1-git-send-email-scott@netsplit.com>
References: <1327100744-28782-1-git-send-email-scott@netsplit.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2012-01-20 at 15:05 -0800, Scott James Remnant wrote:
> Here's a first pass of handling the HID profile recommendation for
> pairing keyboards inside bluetoothd, rather than expecting the UI
> Agent to deal with it.
> 
> This requires agents implement a new DisplayPinCode method, since
> the existing DisplayPasskey method expects a numeric and PIN Codes
> are UTF-8 strings.

When have you seen non-numerical PINs being used?

> As well as general type-stricty-ness, the method allows the UI to
> distinguish between a Bluetooth 2.0 keyboard (ie. all of them) and
> future Bluetooth 2.1 keyboards implementing SSP (for which there may
> be keypress notification). UIs might want to display them slightly
> differently (OS X does, and UI developers tend to just copy that).
> 
> That said, the PINs generated here are 6-digit 0-padded numerics
> since that's probably less confusing for users and there are
> Bluetooth numeric keypads out there that can't do non-numerics.

Less confusing for users? Unless the UI is broken and doesn't follow the
documentation, they should be showing a zero-padded 6 digit number:
                void DisplayPasskey(object device, uint32 passkey, uint8 entered)
                        [...]
                        Note that the passkey will always be a 6-digit number,
                        so the display should be zero-padded at the start if
                        the value contains less than 6 digits.

I fail to see what the benefit of those new functions is, apart from
hypothetical correctness.

In gnome-bluetooth, we have special-casing for keyboards with a
different PIN display, and instructions for users to press "Enter" after
entering the PIN. We use a random 6-digit number for every pairing that
doesn't use a hard-coded PIN.

>From what I can see, the whole operation can be implemented from
user-space without a problem.

Care to explain what benefits this has for user-space?

Cheers

