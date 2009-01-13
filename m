Return-Path: <cyrus@holtmann.org>
Message-ID: <e6fea9c20901130025w21145356yacf4a4d051033e76@mail.gmail.com>
Date: Tue, 13 Jan 2009 09:25:45 +0100
From: "Thierry Pierret" <tpi@qspin.be>
To: linux-bluetooth@vger.kernel.org
Subject: BlueZ 4.26 : headset profile
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I wish my computer to play the role of a headset, with the aim to play
music from my bluetooth-capable player onto the computer soundcard.

First I had to enable the "Gateway" option in the "audio.conf" file in
order to get the Headset service exposed. By the same way, you must
enable the "Headset" option in order to be an audio gateway). It
sounds already weird to me.

Then I have to configure the .asoundrc file for the alsa-plugin
configuration. How do I specify my own bluetooth adapter as the music
source ? I tried this :

pcm.bluetooth {
       type bluetooth
       device XX:XX:XX:XX:XX:XX
       profile hifi
}

where the specified address is the local address. But it did not work,
of course :

$ arecord -D bluetooth -f S16_LE /var/tmp/record.wav &
bluetoothd[1826]: Accepted new client connection on unix socket (fd=13)
bluetoothd[1826]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[1826]: Audio API: BT_ERROR -> BT_GET_CAPABILITIES
ALSA lib pcm_bluetooth.c:1561:(audioservice_expect)
BT_GET_CAPABILITIES failed : Input/output error(5)
bluetoothd[1826]: Unix client disconnected (fd=13)
arecord: main:552: audio open error: Input/output error


May I ask some help at this point ?

Regards.

Thierry Pierret
