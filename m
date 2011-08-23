Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Aug 2011 13:09:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: shy <shyboysby@gmail.com>, Marcel Holtmann <marcel@holtmann.org>,
	padovan@profusion.mobi, linux-bluetooth@vger.kernel.org
Subject: Re: HID UNPLUG_VIRTUAL_CABLE event issue
Message-ID: <20110823100904.GA15817@dell>
References: <CAHabYV7pODc8ZNW_M4auZdwS+Qik8QfobUj6fK9_1rnkivcJ7g@mail.gmail.com>
 <CABBYNZKOEp3Uc07NcjmGFH42=bLLFxP6-Xz7injKGCV8aBOi1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZKOEp3Uc07NcjmGFH42=bLLFxP6-Xz7injKGCV8aBOi1Q@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Aug 23, 2011, Luiz Augusto von Dentz wrote:
> On Tue, Aug 23, 2011 at 11:54 AM, shy <shyboysby@gmail.com> wrote:
> > Hi Marcel,
> > According to connection_disconnect in input/device.c(Bluez version
> > 4.93), it would disconnect INTR and CONTROL L2cap link and then send
> > HIDP_CTRL_VIRTUAL_CABLE_UNPLUG message by the process sequence.
> > That seems it doesn't comply to the spec Page120, HID version 1.0.
> > Could you please confirm this case? If so, I would submit a patch.
> 
> You mean that the disconnect sequence is wrong? Note that we only send
> virtual cable unplug in case the device is being removed, otherwise it
> is just a regular disconnect.

I'm not really an expert with the HID implementation, but I think what's
causing confusion here are the close() (g_io_channel_shutdown) calls in
user-space code. Since the kernel keeps its own socket references
(created through HIDPCONNADD) this will not actually disconnect the
L2CAP channels and so it's still safe to send the unplug command
(triggered by the HIDPCONNDEL ioctl) and wait for the remote side to
disconnect.

So unless you've got actual traces (air or HCI) showing an incorrect
sequence I don't think there's anything wrong with the code.

Johan
