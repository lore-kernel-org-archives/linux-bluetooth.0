Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACUGKYMsJs8aE2woNnFjO+k_xkbY+xK-ZvE1ojpu4tuAERLZHg@mail.gmail.com>
References: <CACUGKYMsJs8aE2woNnFjO+k_xkbY+xK-ZvE1ojpu4tuAERLZHg@mail.gmail.com>
Date: Tue, 1 Jul 2014 10:41:32 +0300
Message-ID: <CABBYNZLVwDr0ZYEFbSGbFu3Rh0H836g9YmTQ1WworC_6qhaxpg@mail.gmail.com>
Subject: Re: bluetooth device
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: John Tobias <john.tobias.ph@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

On Tue, Jul 1, 2014 at 4:44 AM, John Tobias <john.tobias.ph@gmail.com> wrote:
> Hi All,
>
> I am using iMX6SL-eval board, running kernel 3.16.0-rc3-next-20140630,
> PulseAudio 5.0, Bluez 5.20. I ran bluetoothd and pulseaudio as
> follows:
>
> /usr/libexec/bluetooth/bluetoothd -EC
> /usr/bin/pulseaudio --system
>
> I was able to connect to the device through my phone as well as
> streaming music and the bluetooth able to capture the play/pause...
>
>
> If I ran pactl list sources short, I got the following:
>
> 0       alsa_output.platform-sound.analog-stereo.monitor
> module-alsa-card.c      s16le 2ch 44100Hz       SUSPENDED
> 1       alsa_input.platform-sound.analog-stereo module-alsa-card.c
>  s16le 2ch 44100Hz       SUSPENDED
> 2       bluez_source.D8_D1_XX_XX_XX_XX  module-bluez5-device.c  s16le
> 2ch 44100Hz       IDLE
>
> Then, for pact list sinks short:
>
> 0       alsa_output.platform-sound.analog-stereo
> module-alsa-card.c      s16le 2ch 44100Hz       SUSPENDED
>
>
> I load pulseaudio module:
>
> pactl load-module module-loopback
> source=bluez_source.D8_D1_XX_XX_XX_XX
> sink=alsa_output.platform-tas57xx.14.analog-stereo
>
> I checked the logs for pulseaudio and I was getting an error:
>
> Jan 01 00:27:09 localhost pulseaudio[283]: E: [pulseaudio]
> module-loopback.c: No such sink.
> Jan 01 00:27:09 localhost pulseaudio[283]: E: [pulseaudio] module.c:
> Failed to load module "module-loopback" (argument:
> "source=bluez_source.D8_D1_XX_XX_XX_XX
> sink=alsa_output.platform-tas57xx.14.analog-stereo"): initialization
> failed
>
>
> Any idea?.

You better ask this question in PulseAudio mailing list, btw usually
module-bluetooth-policy will take care of creating of loading the
loopback module but perhaps you don't have in your default.pa.


-- 
Luiz Augusto von Dentz
