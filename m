Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Jan 2012 10:14:01 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Scott James Remnant <scott@netsplit.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: RFA: Implementing HID spec recommendation for Keyboard PINs
Message-ID: <20120119081401.GA17764@x220.P-661HNU-F1>
References: <CA+bD78jG+f2kaq66YTdJnOhBGE-=gfeoHYPpmpe6OxZUyBZv7Q@mail.gmail.com>
 <20120118225634.GA15541@x220.P-661HNU-F1>
 <CA+bD78gWACGpx_eNUCQ5xDZMV72exEeRTWavmU4qBdr3A0ihDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+bD78gWACGpx_eNUCQ5xDZMV72exEeRTWavmU4qBdr3A0ihDw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

On Wed, Jan 18, 2012, Scott James Remnant wrote:
> > On Wed, Jan 18, 2012, Scott James Remnant wrote:
> >> The Bluetooth HID profile recommends (4.1, p24) that rather than
> >> prompting the user for a PIN on the host, which then needs to be
> >> entered into the connecting keyboard, instead the host simply generate
> >> the PIN and display it to the user instead. Part of this will be
> >> implemented as a plugin, but since UI is involved, the Agent is
> >> involved as well. As far as I can tell, there are two options:
> >>
> >>
> > 3) Keep using RequestPinCode and have let the agent be responsible for
> > generating and showing a PIN to the user which is immediately sent as a
> > reply to the agent callback (while the UI prompt remains).
> >
> 
> Marcel has specifically instructed me not to do that, stating that the
> Agent is not supposed to be "smart" like this but only to directly
> interact with the user.
> 
> See http://thread.gmane.org/gmane.linux.bluez.kernel/20391 yesterday

Well, it's what most BlueZ UIs do already now. They look for the
LegacyPairing property in DeviceFound signals, and if it's True they
will pre-generate and show a PIN to the user even before calling
CreatePairedDevice (for devices that can be assumed to have an
interactive PIN entering method).

One problem that you'll face is that it's not guaranteed that your side
will get the PIN request first or even at the same time as the other
side.  IIRC this depends on the controller manufacturer, who initiated
the connection, what security mode you're using (3 has some special
behavior), etc. I.e. in the worst case the user has already entered the
PIN on the remote side when you get the request on your side. Then when
you decide to auto-generate a PIN it's most certainly not going to match
what the user already entered on the other device.

For best interoperability with quirky devices I think the safest way
would be to make your best guess whether the user is able to enter the
PIN on the remote side (e.g. yes for a mobile phone, no for a headset
and yes for a keyboard) but still give the possibility to override this
if the user wants to enter the PIN by himself after all.

Johan
