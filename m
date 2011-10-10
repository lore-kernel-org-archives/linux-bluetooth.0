Return-Path: <cyrus@holtmann.org>
Subject: Question about A2DP, Pulseaudio.
From: Chan-yeol Park <chanyeol.park@samsung.com>
To: linux-bluetooth@vger.kernel.org
Content-type: text/plain; charset=UTF-8
Date: Mon, 10 Oct 2011 17:11:26 +0900
Message-id: <1318234286.16562.8.camel@chanten-desktop>
MIME-version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello bluetooth developers.

I have a few questions about BlueZ,PulseAudio.
If there are any plan to develop. I want to discuss how to implement the
below.

1. How to handle New Codec(A2DP) between BlueZ and PulseAudio
As far as I understand puleaduio add_card() working by UUID info.
however , in case of mpeg and other codec, we can't use it.

I think AudioSink dbus interface should provide codec info that headset
supports. Based on it, PulseaAudio can know headset support codec info.

Bluez audio.conf should have option related to this.

2. auto_connect.
Could you explain this purpose? 

4. Is there anyone could explain sco_sink, sco_source? If there are ALSA
code related to it, could you tell me the link that explain ?


BR
Chanyeol Park

