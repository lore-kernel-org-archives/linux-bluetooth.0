Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Jan 2012 00:56:34 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Scott James Remnant <scott@netsplit.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: RFA: Implementing HID spec recommendation for Keyboard PINs
Message-ID: <20120118225634.GA15541@x220.P-661HNU-F1>
References: <CA+bD78jG+f2kaq66YTdJnOhBGE-=gfeoHYPpmpe6OxZUyBZv7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CA+bD78jG+f2kaq66YTdJnOhBGE-=gfeoHYPpmpe6OxZUyBZv7Q@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

On Wed, Jan 18, 2012, Scott James Remnant wrote:
> The Bluetooth HID profile recommends (4.1, p24) that rather than
> prompting the user for a PIN on the host, which then needs to be
> entered into the connecting keyboard, instead the host simply generate
> the PIN and display it to the user instead. Part of this will be
> implemented as a plugin, but since UI is involved, the Agent is
> involved as well. As far as I can tell, there are two options:
> 
>  1) re-use the existing DisplayPasskey(object device, uint32 passkey) method
> 
>     Disadvantages:
>     - this isn't a Passkey but a PIN, which means it would have to be
> converted to a numeric before display. So the plugin would have to
> generate a numeric, stuff it into a 0-padded 6-digit string for return
> as the PIN but then we'd have to convert back to a numeric again for
> sending to the agent.
> 
>     - the agent would not know that this isn't a Bluetooth 2.1 device,
> but a 2.0 device following the HID recommendation - agents might want
> to format the display differently, e.g. knowing that it will never get
> keypress notification for these devices
> 
>  2) add a new DisplayPinCode(object device, string pin) method
> 
>     Disadvantages:
>     - this adds a new method existing agents would have to implement,
> but only in the cases where the plugin was enabled so hopefully the
> distribution is at least aware of it - otherwise the important step of
> what PIN to type would be lost
> 
>     - slightly larger code change.
> 
> 
> My preference is for #2, but I wanted to request advice before proceeding.

3) Keep using RequestPinCode and have let the agent be responsible for
generating and showing a PIN to the user which is immediately sent as a
reply to the agent callback (while the UI prompt remains). The agent has
access to the remote device class through the device D-Bus object path
that's part of the agent callback parameters, so the UI should be able
to quite easily take this special action for keyboards.

	Disadvantages: (slightly) more code in the UI
	Advantages: less code in bluetoothd (and it's plugins)

As a variant of 3) we could also add a "hint" parameter to the
RequestPinCode callback to let the UI know that it'd be desirable to
show a fixed PIN (as opposed to a user-entered one) but let the UI
decide how it ultimately wants to interact with the user.

Johan
