Return-Path: <cyrus@holtmann.org>
Date: Sat, 6 Nov 2010 13:08:21 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: Socket type in audio IPC
Message-ID: <20101106110821.GA18604@jh-x301>
References: <4CD26B4F.8070709@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CD26B4F.8070709@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Thu, Nov 04, 2010, Andrzej Kaczmarek wrote:
> We have a problem with audio IPC, sometimes following printout can be
> seen in logs when A2DP connection fails:
> external/bluetooth/bluez/audio/pcm_bluetooth.c:1609:(audioservice_recv)
> Too short (1 bytes) IPC packet from bluetoothd
> 
> I was not able to catch this issue on my workstation for debugging so
> far, but it does not seem like ipc.h mismatch between BlueZ and ALSA
> plugin - we use one BlueZ version for a long time. Perhaps it's
> because of some unusual fragmentation (not sure how exactly sockets
> work internally) so my questions is why SOCK_STREAM sockets are used
> in audio IPC? Doesn't SOCK_SEQPACKET fit better here since we're
> dealing with messages rather than byte stream? There's no handling of
> fragmented packets in pcm_bluetooth.c at all so in case recv() returns
> less bytes than expected this is immediately returned as an error.

You're right that SOCK_SEQPACKET would be a better choice. However,
changing it would break all existing clients that use SOCK_STREAM. Since
we've already introduced the new D-Bus based solution for this which
requires updating the clients anyway I don't think it's worth trying to
fix this for the old unix socket based solution. FWIW, there are no
current plans to keep maintaining pcm_bluetooth.c since most people use
pulseaudio or some other solution and since it's quite tricky to make an
ALSA userspace plugin use D-Bus properly. Feel free to try to come up
with a patch to update pcm_bluetooth.c to use the new Media API though,
and it might just live a little bit longer ;)

Johan
