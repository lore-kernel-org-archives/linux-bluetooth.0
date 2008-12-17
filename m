Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Gateway profile
From: Marcel Holtmann <marcel@holtmann.org>
To: event <event.riga@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <664d43d60812151514m6c225403i528453fcb6f08430@mail.gmail.com>
References: <664d43d60812151512y6631ebf2j9665e1473193077d@mail.gmail.com>
	 <664d43d60812151514m6c225403i528453fcb6f08430@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 17 Dec 2008 03:48:53 +0100
Message-Id: <1229482133.10889.5.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Leonid,

> I've implemented gateway profile. I've tested basic things, like
> place/cancel/answer call. Others are in development. Some could not be
> tested as my carrier doesn't provide corresponding services (like
> 3-way call, etc.) so any help welcome.

thanks for the works, but can you please base the patch against the
latest GIT tree. It is kinda hard to review things that might already
have been implemented like sco_listen.

 audio/audio-api.txt  |   94 +++++
 audio/device.h       |    7 
 audio/gateway.c      |  938 +++++++++++++++++++++++++++++++++++++++++++++++++++
 audio/gateway.h      |   11 
 audio/manager.c      |  124 ++++--
 common/glib-helper.c |   85 +++-
 common/glib-helper.h |    1 
 7 files changed, 1205 insertions(+), 55 deletions(-)

So any changes to glib-helper.[ch] have to be in a separate patch and
need to be discussed independent from the gateway implementation.

Any audio-api.txt stuff should also go separately since that has to be
discussed. Also we can't send PCM data over D-Bus. It just doesn't work
like that. We do have the internal IPC for that and plugins for ALSA,
GStreamer and PulseAudio that should be used.

However the most important part is that you follow the coding style and
that is the kernel coding style. You make it really hard for us to
review the code like this and it can't be applied. I really want you to
add support for the gateway role to BlueZ, but the overall code in the
project needs to follow the same rules.

So please fix these issues first and then we do a deep review of it.

Regards

Marcel


