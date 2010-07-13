Return-Path: <cyrus@holtmann.org>
Date: Tue, 13 Jul 2010 09:57:51 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Pavan Savoy <pavan_savoy@yahoo.co.in>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: ipc-sock/l2cap sock/g_io_fd
Message-ID: <20100713125751.GA13089@jh-x301>
References: <996696.28160.qm@web94910.mail.in2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <996696.28160.qm@web94910.mail.in2.yahoo.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavan,

On Tue, Jul 13, 2010, Pavan Savoy wrote:
> Marcel,

I don't know why you expect specifically Marcel to have some clue about
the audio stuff. He hasn't been much involved with the development of it
so I don't excpect you to get a reply from him ;)

> I am sort of lost among the various sockets that are in the
> bluez/audio, and trying to get a clear picture on what is what.
> 
> find attached the short image on my understanding of the audio
> structure (currently used by apps which use liba2dp and not the pcm
> plugins..- namely android..)
> 
> Is my understanding  correct ?
> What does the various sockets represent, as in stream.fd, server.fd -
> and the fd extracted from the session_io.
> 
> I sort of need to know which is which, as in which is communication
> over local IPC BT_IPC_SOCKET_NAME, which actually corresponds to the
> l2cap connection which is established in sink.c ?
> 
> How does it get into the sesssion->io ? Please help me understand
> these various sock fd's.

So I'd say there are three key sockets with A2DP. You've got the
signalling channel for A2DP (I think that's what you mean when you say
session->io). That socket stays always inside bluetoothd. Then there's a
local unix socket which is used to communicate with an external audio
process (alsa, gstreamer, pulseaudio, whatever). I suspect that'd match
the server.fd which you mentioned. Then, for every A2DP media transport
channel we transfer the socket over to the external audio process which
then takes care of writing (and reading in the case of SCO) of it.
That's what stream.fd is referring to.

With BlueZ 5.0 we're gonna scrap the unix socket completely since D-Bus
nowdays has support for file descriptor transfer from one process to
another. There's already a prototype patch for it but it hasn't been
merged upstream yet. Hopefully getting rid of the extra homebrewed IPC
should help simplify the picture a little bit.

Johan
