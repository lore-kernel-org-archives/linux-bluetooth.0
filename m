Return-Path: <cyrus@holtmann.org>
Message-ID: <4FCAE7BB.3030804@jesshaas.com>
Date: Sat, 02 Jun 2012 21:27:39 -0700
From: Jess Haas <pa@jesshaas.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Using multiple bluetooth headsets at the same time
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

	I am wanting to stream to multiple bluetooth headsets at the same time
using the a2dp profile. One headset works great but I can't seem to get
a second one to work.

	I have both headsets paired and connected and can play using either one
but when I start playback on the second one(using mplayer -ao
alsa:device=bluetooth file.mp3)  I get this error:
[AO_ALSA] alsa-lib: audio/pcm_bluetooth.c:1614:(audioservice_expect)
BT_OPEN failed : Invalid argument(22)
[AO_ALSA] Unable to set hw-parameters: Invalid argument

Any ideas on if its possible to get this to work and if so where to
start? I don't mind doing a little coding but have no real experience
with kernel stuff.

This is my asound.conf:
pcm.bluetooth {
        type bluetooth
        device 00:11:67:39:5A:34
	profile "a2dp"
}


pcm.bluetooth2 {
        type bluetooth
        device 00:11:67:66:E2:4B
        profile "a2dp"
}

Thanks,
   Jess
