Return-Path: <mzuny@0pointer.de>
Date: Mon, 27 Aug 2007 17:15:14 +0200
From: Lennart Poettering <mzuny@0pointer.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Takashi Iwai <tiwai@suse.de>,
        BlueZ development <bluez-devel@lists.sourceforge.net>,
        =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
        hal@lists.freedesktop.org
Subject: Re: [patch] spec: Update alsa namespace to include virtual device
Message-ID: <20070827151514.GA8058@tango.0pointer.de>
References: <e29894ca0708230922n69a68aedqfb979c67042a965f@mail.gmail.com> <20070827141144.GA3190@tango.0pointer.de> <1188225287.15402.324.camel@violet> <20070827144720.GA6448@tango.0pointer.de> <1188227368.15402.336.camel@violet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1188227368.15402.336.camel@violet>
List-ID: <bluez-devel.lists.sourceforge.net>

On Mon, 27.08.07 17:09, Marcel Holtmann (marcel@holtmann.org) wrote:

> > > > OTOH i must say that this would make it very easy for me to add bt
> > > > support to PA, so I am not inherently opposed. However, I don't really
> > > > think going through ALSA for bt audio makes too much sense for PA. It
> > > > is probably better to integrate bt and PA directly, without having
> > > > this unnecessary abstraction in between.
> > > 
> > > I am currently working on the GStreamer sink. If you provide an exported
> > > plugin API for PulseAudio, you can have that easily. Otherwise it might
> > > not happen.
> > 
> > A stable plugin API is not going to happen anytime soon, sorry. Also,
> > it is not really practical to develop plugins out-of-tree. I
> > acknowledge the demand for it, but the plugin API is just too quickly
> > moving.
> > 
> > Hmm, I'd love to add proper BT support to PA myself, but unfortunately
> > I lack the hardware for it. It would be much easier to keep it up to
> > date for me then.
> 
> We are in a chicken-egg situation here. To write a plugin you need to
> use our SBC encoder and our IPC. Both of them are internal only.

Hmm, is it going to stay "internal"? Or are you going to stabilize the
API for it eventually? How volatile is that API?

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
