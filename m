Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Apr 2009 00:38:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Stuart Pook <linux-bluetooth4@pook.es>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez git + Linksys USBBT100 + 2.6.30-rc2 -> Segmentation fault
Message-ID: <20090419213837.GA6514@jh-x301>
References: <49D89DCD.7090808@pook.es> <49D8E48A.2060807@pook.es> <20090405172212.GB6612@jh-x301> <49EB7950.4000802@pook.es> <20090419200528.GA18068@jh-x301> <49EB93C2.3090702@pook.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <49EB93C2.3090702@pook.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stuart,

On Sun, Apr 19, 2009, Stuart Pook wrote:
> I did get one error that I had never seen before "Refusing headset":

That comes if a headset is trying to connect to you and there's already 
max_connected_headsets headsets connected (this variable defaults to 1 and 
can be overrided with the MaxConnected parameter in audio.conf.

> bluetoothd[32401]: Audio API: BT_REQUEST <- BT_START_STREAM
> bluetoothd[32401]: State changed /org/bluez/32401/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
> bluetoothd[32401]: Unable to get service record: Connection timed out (110)
> bluetoothd[32401]: Unable to get a SCO fd
> bluetoothd[32401]: headset_resume_complete: resume failed
> bluetoothd[32401]: Audio API: BT_ERROR -> BT_START_STREAM
> bluetoothd[32401]: telephony-dummy: device 0xb8f2c550 disconnected
> bluetoothd[32401]: State changed /org/bluez/32401/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
> bluetoothd[32401]: Unix client disconnected (fd=13)
> bluetoothd[32401]: Unable to get service record: Connection timed out (110)
> Segmentation fault

Could you please run bluetoothd through valgrind to get a proper 
backtrace. This time it should hopefully be more useful than the one we 
got from the infinite recursion case (with some luck a fix should be just 
a few minutes away from getting the log). Once we have the valgrind trace 
I'd also be interested in seeing the output of hcidump for the "Connection 
timed out" situation.

> In fact I get the "Too short (1 bytes) IPC packet from bluetoothd" error
> even from bluetoothd 4.36.

If this isn't caused by a bug the only possible reason I can think of as a 
cause for it is a mismatch between the alsa plugin and bluetoothd versions.

Btw, you might want to consider trying out pulseaudio 0.9.15. It's worked 
pretty flawlessly for me with bluez 4.34 and later versions (though I 
haven't actually tested the mono profiles very much with it).

Johan
