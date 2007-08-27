Return-Path: <hal-bounces@lists.freedesktop.org>
Subject: Re: [patch] spec: Update alsa namespace to include virtual device
From: Marcel Holtmann <marcel@holtmann.org>
To: Lennart Poettering <mzuny@0pointer.de>
In-Reply-To: <20070827151514.GA8058@tango.0pointer.de>
References: <e29894ca0708230922n69a68aedqfb979c67042a965f@mail.gmail.com>
	<20070827141144.GA3190@tango.0pointer.de>
	<1188225287.15402.324.camel@violet>
	<20070827144720.GA6448@tango.0pointer.de>
	<1188227368.15402.336.camel@violet>
	<20070827151514.GA8058@tango.0pointer.de>
Date: Mon, 27 Aug 2007 17:24:55 +0200
Message-Id: <1188228295.15402.341.camel@violet>
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>,
        =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
        BlueZ development <bluez-devel@lists.sourceforge.net>,
        hal@lists.freedesktop.org
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/hal>,
	<mailto:hal-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/hal>
List-Post: <mailto:hal@lists.freedesktop.org>
List-Help: <mailto:hal-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/hal>,
	<mailto:hal-request@lists.freedesktop.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: hal-bounces@lists.freedesktop.org
Errors-To: hal-bounces@lists.freedesktop.org
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Lennart,

> > > A stable plugin API is not going to happen anytime soon, sorry. Also,
> > > it is not really practical to develop plugins out-of-tree. I
> > > acknowledge the demand for it, but the plugin API is just too quickly
> > > moving.
> > > 
> > > Hmm, I'd love to add proper BT support to PA myself, but unfortunately
> > > I lack the hardware for it. It would be much easier to keep it up to
> > > date for me then.
> > 
> > We are in a chicken-egg situation here. To write a plugin you need to
> > use our SBC encoder and our IPC. Both of them are internal only.
> 
> Hmm, is it going to stay "internal"? Or are you going to stabilize the
> API for it eventually? How volatile is that API?

that is fully 100% unstable right now. The IPC is totally unclear how it
has to look like in the end. It only works right now.

We might get the SBC encoder in a why it could be released as its own
library, but I prefer not doing it right now. It would actually slow
down the development process.

Regards

Marcel


_______________________________________________
hal mailing list
hal@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/hal
