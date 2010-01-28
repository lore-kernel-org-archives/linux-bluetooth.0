Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC] Media API
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <2d5a2c101001280554l2064b6e7p84a5f236d74a4b9d@mail.gmail.com>
References: <2d5a2c101001040614o6627985ei278805369290b1b0@mail.gmail.com>
	 <1262648387.16627.343.camel@localhost.localdomain>
	 <2d5a2c101001280554l2064b6e7p84a5f236d74a4b9d@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 28 Jan 2010 15:15:36 +0100
Message-ID: <1264688136.3227.18.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> >> The idea is to complete replace the existing audio IPC with DBus.
> >> Johan and I discussed this a few times in the past and today we
> >> finally archive something, so here are some design choices so far:
> >>
> >> 1. Codec capabilities and configuration are blobs (array of bytes or
> >> 'ay'), so there is no attempt to format codec structures into dbus
> >> structures, this make it easier for both end points as well as
> >> bluetoothd and also enables proprietary codecs. (suggested by Marcel
> >> in the last BlueZ meeting)
> >>
> >> 2. The spec is not a2dp specific. So it should be possible to register
> >> end points for HFP and VDP.
> >
> > if you really wanna achieve that, then I would prefer not to use
> > StreamEndPoint as interface.
> >
> > So first of all it should be StreamEndpoint. While SEP takes the P into
> > account, the word "endpoint" in itself is proper enough.
> >
> > And if this should support HFP, then the term Stream is kinda tricky. We
> > could just allow that, but I prefer not to mix streaming with headset
> > functionality. So what about just using the "Endpoint" as a generic
> > agent type interface. Or "MediaEndpoint" if you need to tie it to the
> > media interface?
> 
> Here are the final documentation and a very basic implementation, note
> that to compile it needs dbus 1.3 (@Marcel: What about making it a
> hard dependency?), other remarks:

lets do it the same way we do within oFono for HFP.

#ifndef DBUS_TYPE_UNIX_FD
#define DBUS_TYPE_UNIX_FD -1
#endif

	if (media.enabled == TRUE) {
		if (DBUS_TYPE_UNIX_FD < 0)
			error("missing fd support");
		else
			register_driver...
	}

Regards

Marcel


