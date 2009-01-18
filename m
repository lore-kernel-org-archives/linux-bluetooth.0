Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Gateway profile
From: Marcel Holtmann <marcel@holtmann.org>
To: event <event.riga@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <664d43d60901160522o4d21bb03w45f1868c4b860245@mail.gmail.com>
References: <664d43d60812151512y6631ebf2j9665e1473193077d@mail.gmail.com>
	 <664d43d60812151514m6c225403i528453fcb6f08430@mail.gmail.com>
	 <1229482133.10889.5.camel@violet>
	 <664d43d60901160522o4d21bb03w45f1868c4b860245@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 18 Jan 2009 17:07:08 +0100
Message-Id: <1232294828.5095.39.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> >> I've implemented gateway profile. I've tested basic things, like
> >> place/cancel/answer call. Others are in development. Some could not be
> >> tested as my carrier doesn't provide corresponding services (like
> >> 3-way call, etc.) so any help welcome.
> >
> > thanks for the works, but can you please base the patch against the
> > latest GIT tree. It is kinda hard to review things that might already
> > have been implemented like sco_listen.
> >
> >  audio/audio-api.txt  |   94 +++++
> >  audio/device.h       |    7
> >  audio/gateway.c      |  938 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  audio/gateway.h      |   11
> >  audio/manager.c      |  124 ++++--
> >  common/glib-helper.c |   85 +++-
> >  common/glib-helper.h |    1
> >  7 files changed, 1205 insertions(+), 55 deletions(-)
> >
> > So any changes to glib-helper.[ch] have to be in a separate patch and
> > need to be discussed independent from the gateway implementation.
> >
> > Any audio-api.txt stuff should also go separately since that has to be
> > discussed. Also we can't send PCM data over D-Bus. It just doesn't work
> > like that. We do have the internal IPC for that and plugins for ALSA,
> > GStreamer and PulseAudio that should be used.
> >
> > However the most important part is that you follow the coding style and
> > that is the kernel coding style. You make it really hard for us to
> > review the code like this and it can't be applied. I really want you to
> > add support for the gateway role to BlueZ, but the overall code in the
> > project needs to follow the same rules.
> >
> > So please fix these issues first and then we do a deep review of it.
>
> Here is reworked and improved patches as you suggested with IPC support.
> 
> But I have some doubts and questions:
> 1. to distinguish between headset and gateway I've added one more alsa
> config option "role" which could be master (for gateway and probably
> a2dp source) or slave (which is default and works for headset and a2dp
> sink). I don't really like this approach so if you have any other idea
> it would be great.

we should use the terms "headset", "gateway", "sink" and "source" as
these are used through the specs.

> 2. my cell phone closes SCO connection when it doesn't need one,
> probably others act like this as well. SCO close results in
> bluetooth_hsp_write returning an error. What would be the best way to
> overcome this?

No idea what's the problem here. You should already get a notice of the
IPC that the channel is closed. On closed channels we have to discard
any kind of PCM data from the PC.

> 3. I've noticed that ipc interface duplicate dbus interface to some
> extent. Why can't pcm_bluetooth work over dbus directly?

D-Bus can't handle massive amount of PCM data payload. Also the ALSA
plugins don't really like dealing with a D-Bus mainloop. Hence we do
have the IPC as an alternate way of dealing with audio. We don't like to
do it, but we have to.

> 4. Aren't there any legal issues with implementing bluez? As I noticed
> in the spec that all the rights belong to Bluetooth SIG so it does
> look neither "free as in free beer" nor "free as in freedom" :)

BlueZ is a fully qualified host stack that complies with the SIG's
requirements. We do have to update the listing with a headset gateway
role at some point, but only once we have it fully working and actually
used in a product.

Regards

Marcel


