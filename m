Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 30 Jun 2014 18:44:55 -0700
Message-ID: <CACUGKYMsJs8aE2woNnFjO+k_xkbY+xK-ZvE1ojpu4tuAERLZHg@mail.gmail.com>
Subject: bluetooth device
From: John Tobias <john.tobias.ph@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

I am using iMX6SL-eval board, running kernel 3.16.0-rc3-next-20140630,
PulseAudio 5.0, Bluez 5.20. I ran bluetoothd and pulseaudio as
follows:

/usr/libexec/bluetooth/bluetoothd -EC
/usr/bin/pulseaudio --system

I was able to connect to the device through my phone as well as
streaming music and the bluetooth able to capture the play/pause...


If I ran pactl list sources short, I got the following:

0       alsa_output.platform-sound.analog-stereo.monitor
module-alsa-card.c      s16le 2ch 44100Hz       SUSPENDED
1       alsa_input.platform-sound.analog-stereo module-alsa-card.c
 s16le 2ch 44100Hz       SUSPENDED
2       bluez_source.D8_D1_XX_XX_XX_XX  module-bluez5-device.c  s16le
2ch 44100Hz       IDLE

Then, for pact list sinks short:

0       alsa_output.platform-sound.analog-stereo
module-alsa-card.c      s16le 2ch 44100Hz       SUSPENDED


I load pulseaudio module:

pactl load-module module-loopback
source=bluez_source.D8_D1_XX_XX_XX_XX
sink=alsa_output.platform-tas57xx.14.analog-stereo

I checked the logs for pulseaudio and I was getting an error:

Jan 01 00:27:09 localhost pulseaudio[283]: E: [pulseaudio]
module-loopback.c: No such sink.
Jan 01 00:27:09 localhost pulseaudio[283]: E: [pulseaudio] module.c:
Failed to load module "module-loopback" (argument:
"source=bluez_source.D8_D1_XX_XX_XX_XX
sink=alsa_output.platform-tas57xx.14.analog-stereo"): initialization
failed


Any idea?.

Regards,

John
