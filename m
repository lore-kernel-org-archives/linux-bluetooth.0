Return-Path: <cyrus@holtmann.org>
Subject: Re: BlueZ GSoC 2010
From: Bastien Nocera <hadess@hadess.net>
To: Vinicius Gomes <vinicius.gomes@openbossa.org>
Cc: BlueZ <linux-bluetooth@vger.kernel.org>
In-Reply-To: <2a9506371003181850h15a417a4u35bc0ed70e60f548@mail.gmail.com>
References: <2a9506371003181850h15a417a4u35bc0ed70e60f548@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Mon, 22 Mar 2010 12:13:19 +0000
Message-ID: <1269259999.21548.3330.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey,

On Thu, 2010-03-18 at 22:50 -0300, Vinicius Gomes wrote:
> Hi,
> 
> BlueZ just got accepted as an organization for this year's Google
> Summer of Code.
> 
> There is a small list of project ideas here[1], for the next days we
> need to polish it and add more content. Any help is appreciated.
> 
> We are also looking for mentors, if this idea interests you, please
> contact me off-list or go to #bluez-gsoc at freenode, this is also
> where most of the discussion regarding GSoC will take place, in case
> you just want to follow it.
> 
> As always, patches and suggestions are welcome ;-)

A couple of comments:
- Is AVRCP 1.4 support really a full Summer's work? Could be with
PulseAudio or application integration?
- The "any" adapter work is a waste of resources, as I've mentioned in
the past on the list.
- The VDP support probably needs kernel-level hacking as well, to avoid
being constrained to one of the supported frameworks, and create a
user-space driver for the device (using CUSE?)

I'd be happy to do testing and some integration work for both the VDP
and DUN works.

I could also add:
- Port gnome-user-share to obexd, instead of obex-data-server (easy)
- Port osso-gwobex test suite and extend it (medium)
(Those 2 could be combined into one project)
- Printer (initial) setup integration in gnome-bluetooth (medium)
- Extended hostname support (using xdg-hostname) (medium)
- Kernel driver and user-space changes for Sixaxis joypad (including
rumble). The bdaddr assignment would be done in the kernel, with a
helper in bluetoothd, extra functionality would be added in the kernel
for the other features (medium)

Cheers

