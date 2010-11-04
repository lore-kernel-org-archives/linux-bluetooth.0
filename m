Return-Path: <cyrus@holtmann.org>
Message-ID: <4CD26B4F.8070709@tieto.com>
Date: Thu, 04 Nov 2010 09:14:07 +0100
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Socket type in audio IPC
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

We have a problem with audio IPC, sometimes following printout can be seen in logs when A2DP connection fails:
external/bluetooth/bluez/audio/pcm_bluetooth.c:1609:(audioservice_recv) Too short (1 bytes) IPC packet from bluetoothd

I was not able to catch this issue on my workstation for debugging so far, but it does not seem like ipc.h mismatch between BlueZ and ALSA plugin - we use one BlueZ version for a long time. Perhaps it's because of some unusual fragmentation (not sure how exactly sockets work internally) so my questions is why SOCK_STREAM sockets are used in audio IPC? Doesn't SOCK_SEQPACKET fit better here since we're dealing with messages rather than byte stream? There's no handling of fragmented packets in pcm_bluetooth.c at all so in case recv() returns less bytes than expected this is immediately returned as an error.

BR,
Andrzej

