Return-Path: <cyrus@holtmann.org>
Subject: Re: Question about bluez audio plug-in license
From: Marcel Holtmann <marcel@holtmann.org>
To: "Chanyeol,Park" <chanyeol.park@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz-von@nokia.com
Date: Wed, 20 Jul 2011 12:13:44 +0200
In-Reply-To: <CAJx1FMOaDBWHGP8+-FkKVD_pTKC7n8NYm8fAdDGHzRwZw8ikyA@mail.gmail.com>
References: <CAJx1FMOaDBWHGP8+-FkKVD_pTKC7n8NYm8fAdDGHzRwZw8ikyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1311156825.21109.204.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> I have a question about bluez audio plug-in license. Is it possible to use
> bluez audio plug-in as LGPL? About half year ago I saw bluez and pulseaudio
> introduced “a2dp-codecs.h”. As far as I understand bluez audio plug-in
> license could be LGPL. However the header file license is GPL.
> 
> and I think even if we use MediaEndpoint with dbus, we need to include
> “a2dp-codec.h”.
> 
> If you know, could you explain this?

the specific file a2dp-codec.h can be easily licensed under LGPL. Same
as with rth.h. Both file are clearly an oversight on our part. Code that
is shared between PA and BlueZ should be LGPL license. For the SBC
encoder/decoder and IPC parts we have done that right. So yes, we can
just re-license these two header files.

However for the whole audio plugin, no that is GPL only.

Regards

Marcel


