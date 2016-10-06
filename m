Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Schaefer, Brandon" <brandon.schaefer@flukenetworks.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Headset profile no audio; works with a2dp
Date: Thu, 6 Oct 2016 20:20:03 +0000
Message-ID: <7D498A2F2F79AE4DBE2DF69CA72B3B55388EC338@US-EVT-EXM03-P.global.tektronix.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bluez version: 5.40
Pulseaudio: 6.0

I have headset that I am able to pair, connect, and play audio via the a2dp_sink profile of pulseaudio. When I switch to headset_head_unit profile, I can no longer send audio to the headset. I first went to pulseaudio to see if they had any suggestions as I found a very similar case to mine (https://bugs.freedesktop.org/show_bug.cgi?id=97064). 

Tanu kindly pointed out that there seemed to be missing a dbus signal from bluetoothd, specifically "PropertiesChanged" signal on MediaTransport1 interface. I did some inspection, and transport_update_playing() in profiles/audio/transport.c shows Playing = 0 and not 1, which is the case when using a2dp_sink profile.

Headset_head_unit:
bluetoothd[756]: profiles/audio/transport.c:transport_update_playing() /org/bluez/hci0/dev_00_11_C2_08_15_F6/fd0 State=TRANSPORT_STATE_IDLE Playing=0

a2dp_sink:
bluetoothd[756]: profiles/audio/transport.c:transport_update_playing() /org/bluez/hci0/dev_00_11_C2_08_15_F6/fd0 State=TRANSPORT_STATE_ACTIVE Playing=1

Any recommendation on what might be the issue? Happy to provide any logs that could be useful.


