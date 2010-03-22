Return-Path: <cyrus@holtmann.org>
Subject: Re: BlueZ GSoC 2010
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Vinicius Gomes <vinicius.gomes@openbossa.org>,
	BlueZ <linux-bluetooth@vger.kernel.org>
In-Reply-To: <2d5a2c101003220914m41188e22ha0872104d4c6db4f@mail.gmail.com>
References: <2a9506371003181850h15a417a4u35bc0ed70e60f548@mail.gmail.com>
	 <1269259999.21548.3330.camel@localhost.localdomain>
	 <2d5a2c101003220914m41188e22ha0872104d4c6db4f@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Mon, 22 Mar 2010 17:27:52 +0000
Message-ID: <1269278872.4465.271.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2010-03-22 at 18:14 +0200, Luiz Augusto von Dentz wrote:
> Hi Bastien,
> 
> On Mon, Mar 22, 2010 at 2:13 PM, Bastien Nocera <hadess@hadess.net> wrote:
> > Hey,
> >
> > On Thu, 2010-03-18 at 22:50 -0300, Vinicius Gomes wrote:
> >> Hi,
> >>
> >> BlueZ just got accepted as an organization for this year's Google
> >> Summer of Code.
> >>
> >> There is a small list of project ideas here[1], for the next days we
> >> need to polish it and add more content. Any help is appreciated.
> >>
> >> We are also looking for mentors, if this idea interests you, please
> >> contact me off-list or go to #bluez-gsoc at freenode, this is also
> >> where most of the discussion regarding GSoC will take place, in case
> >> you just want to follow it.
> >>
> >> As always, patches and suggestions are welcome ;-)
> >
> > A couple of comments:
> > - Is AVRCP 1.4 support really a full Summer's work? Could be with
> > PulseAudio or application integration?
> 
> Some avrcp 1.4 needs some integration so I guess it is ok.
> 
> > - The "any" adapter work is a waste of resources, as I've mentioned in
> > the past on the list.
> 
> Well if it eliminates one round trip for most application I guess it
> is worth adding, and we might add other tricks as storage and API
> simplifications on top of it.

One round-trip at the cost of more code on your side. I'm really not
sure it's worth it.

> > - The VDP support probably needs kernel-level hacking as well, to avoid
> > being constrained to one of the supported frameworks, and create a
> > user-space driver for the device (using CUSE?)
> 
> It could be considerate, but if that is a good idea to vdp it would
> also be for a2dp, there is also the problem that avdtp is currently
> implemented in bluetoothd so I wonder if we should start changing
> things or just implement vdp on top of the existing avdtp code.

Right, except that for sound we have a "broker" application in
PulseAudio. There's no such thing for V4L devices. In any case, it
should probably be a separate application that would take the data from
bluetoothd and make it available as a video device through v4l.

The VDP-using webcam I have uses MPEG-4 as the video codec, and you
probably don't want to have to reimplement that, so the broker app could
probably use GStreamer to make the video available.

> > I'd be happy to do testing and some integration work for both the VDP
> > and DUN works.
> >
> > I could also add:
> > - Port gnome-user-share to obexd, instead of obex-data-server (easy)
> > - Port osso-gwobex test suite and extend it (medium)
> > (Those 2 could be combined into one project)
> > - Printer (initial) setup integration in gnome-bluetooth (medium)
> 
> I guess those are too gnome related for being in BlueZ, expect maybe
> gwobex, of course we could help/co/mentor projects under gnome
> organization.

Or vice-versa :)
Given that porting gnome-user-share to obexd shouldn't be a long winded
task, porting the osso-gwobex test suite would nicely complete it.

The printer integration work could probably be re-used by other
bluetoothd-setup front-ends like KDE.

> > - Extended hostname support (using xdg-hostname) (medium)
> > - Kernel driver and user-space changes for Sixaxis joypad (including
> > rumble). The bdaddr assignment would be done in the kernel, with a
> > helper in bluetoothd, extra functionality would be added in the kernel
> > for the other features (medium)
> 
> Great ideas and those fits perfectly as bluez organization projects.

Cheers

