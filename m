Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHabYV7pODc8ZNW_M4auZdwS+Qik8QfobUj6fK9_1rnkivcJ7g@mail.gmail.com>
References: <CAHabYV7pODc8ZNW_M4auZdwS+Qik8QfobUj6fK9_1rnkivcJ7g@mail.gmail.com>
Date: Tue, 23 Aug 2011 12:45:11 +0300
Message-ID: <CABBYNZKOEp3Uc07NcjmGFH42=bLLFxP6-Xz7injKGCV8aBOi1Q@mail.gmail.com>
Subject: Re: HID UNPLUG_VIRTUAL_CABLE event issue
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: shy <shyboysby@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, padovan@profusion.mobi,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Aug 23, 2011 at 11:54 AM, shy <shyboysby@gmail.com> wrote:
> Hi Marcel,
> According to connection_disconnect in input/device.c(Bluez version
> 4.93), it would disconnect INTR and CONTROL L2cap link and then send
> HIDP_CTRL_VIRTUAL_CABLE_UNPLUG message by the process sequence.
> That seems it doesn't comply to the spec Page120, HID version 1.0.
> Could you please confirm this case? If so, I would submit a patch.

You mean that the disconnect sequence is wrong? Note that we only send
virtual cable unplug in case the device is being removed, otherwise it
is just a regular disconnect.


-- 
Luiz Augusto von Dentz
