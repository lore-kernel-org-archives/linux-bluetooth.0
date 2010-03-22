Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1269259999.21548.3330.camel@localhost.localdomain>
References: <2a9506371003181850h15a417a4u35bc0ed70e60f548@mail.gmail.com>
	 <1269259999.21548.3330.camel@localhost.localdomain>
Date: Mon, 22 Mar 2010 18:14:37 +0200
Message-ID: <2d5a2c101003220914m41188e22ha0872104d4c6db4f@mail.gmail.com>
Subject: Re: BlueZ GSoC 2010
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: Vinicius Gomes <vinicius.gomes@openbossa.org>,
	BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Mon, Mar 22, 2010 at 2:13 PM, Bastien Nocera <hadess@hadess.net> wrote:
> Hey,
>
> On Thu, 2010-03-18 at 22:50 -0300, Vinicius Gomes wrote:
>> Hi,
>>
>> BlueZ just got accepted as an organization for this year's Google
>> Summer of Code.
>>
>> There is a small list of project ideas here[1], for the next days we
>> need to polish it and add more content. Any help is appreciated.
>>
>> We are also looking for mentors, if this idea interests you, please
>> contact me off-list or go to #bluez-gsoc at freenode, this is also
>> where most of the discussion regarding GSoC will take place, in case
>> you just want to follow it.
>>
>> As always, patches and suggestions are welcome ;-)
>
> A couple of comments:
> - Is AVRCP 1.4 support really a full Summer's work? Could be with
> PulseAudio or application integration?

Some avrcp 1.4 needs some integration so I guess it is ok.

> - The "any" adapter work is a waste of resources, as I've mentioned in
> the past on the list.

Well if it eliminates one round trip for most application I guess it
is worth adding, and we might add other tricks as storage and API
simplifications on top of it.

> - The VDP support probably needs kernel-level hacking as well, to avoid
> being constrained to one of the supported frameworks, and create a
> user-space driver for the device (using CUSE?)

It could be considerate, but if that is a good idea to vdp it would
also be for a2dp, there is also the problem that avdtp is currently
implemented in bluetoothd so I wonder if we should start changing
things or just implement vdp on top of the existing avdtp code.

> I'd be happy to do testing and some integration work for both the VDP
> and DUN works.
>
> I could also add:
> - Port gnome-user-share to obexd, instead of obex-data-server (easy)
> - Port osso-gwobex test suite and extend it (medium)
> (Those 2 could be combined into one project)
> - Printer (initial) setup integration in gnome-bluetooth (medium)

I guess those are too gnome related for being in BlueZ, expect maybe
gwobex, of course we could help/co/mentor projects under gnome
organization.

> - Extended hostname support (using xdg-hostname) (medium)
> - Kernel driver and user-space changes for Sixaxis joypad (including
> rumble). The bdaddr assignment would be done in the kernel, with a
> helper in bluetoothd, extra functionality would be added in the kernel
> for the other features (medium)

Great ideas and those fits perfectly as bluez organization projects.


-- 
Luiz Augusto von Dentz
Computer Engineer
