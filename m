Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4E91AC1C.9020306@optimaster.eu>
References: <bf39f3bbabbfb3881523f71163d1359b@optimaster.eu>
	<4E91AC1C.9020306@optimaster.eu>
Date: Sun, 9 Oct 2011 22:53:38 +0300
Message-ID: <CABBYNZ+UU_ADSYscvzr2g5n+u55JF0qf5ksxEs_hn7s3B+-8ZA@mail.gmail.com>
Subject: Re: [pulseaudio-discuss] Fwd: Re: Bluetooth Headset Problem #2
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Krisztian Kocsis <krisztian.kocsis@optimaster.eu>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sun, Oct 9, 2011 at 5:13 PM, Krisztian Kocsis
<krisztian.kocsis@optimaster.eu> wrote:
>
>
> -------- Original Message --------
> Subject:        [pulseaudio-discuss] Fwd: Re: Bluetooth Headset Problem #2
> Date:   Sat, 08 Oct 2011 15:52:11 +0200
> From:   krisztian.kocsis@optimaster.eu
> Reply-To:       General PulseAudio Discussion
> <pulseaudio-discuss@lists.freedesktop.org>
> To:     <pulseaudio-discuss@lists.freedesktop.org>
>
>
>
> Sorry, here are the attachments.
>
> -------- Original Message --------
> Subject: Re: Bluetooth Headset Problem
> Date: Sat, 08 Oct 2011 14:11:31 +0200
>  From: krisztian.kocsis@optimaster.eu
> To: Luiz Augusto von Dentz<luiz.dentz@gmail.com>
>
> Hello!
>
> I didn't help!
>
> Here is who I test it:
>
> - Load kernel (2.6.24.6) modules: bluetooth, hci_usb, l2cap, rfcomm,
> sco
> - Start bluez (4.96): bluetoothd -d -n (debug, foreground)
> - Start simple-agent: simple-agent 0000
> - Test device connection with: hcitool cc 00:07:A4:EE:8F:03 (already
> paired)
> - Start pulseaudio (0.9.23):
> LD_LIBRARY_PATH=/afc/lib/pulse-0.9.23/modules /afc/bin/pulseaudio
> --system --high-priority --disallow-exit --log-target=stderr
> --use-pid-file --disable-shm -vvvvvvv
> - Connect to headset: dbus-send --system --print-reply --dest=org.bluez
> /org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03 org.bluez.Headset.Connect
> (dbus 1.4.14)
> - Activate hsp profile: pactl set-card-profile 0 hsp
> - Trying to play a WAV: paplay -p -v /afc/tmp/test.wav (hangs at Time:
> 0.000s)
> - Trying to play an MP3 with mpg123 (1.13.3): mpg123 -vvvvv -o pulse
> /afc/tmp/armin.mp3 (hangs at frame 6)
>
> Did I miss some commands or actions which are required to play
> something on a headset?
> I'v attached the config files of bluez and pulseaudio and the logs
> also.

What is the audio routing in this system, HCI or PCM directly in the
controller with or without a alsa device? Actually before you do check
about that check how it works with a normal Linux distro and a dongle,
that uses HCI routing so the audio is sent/received via socket
interface. Embedded devices normally uses PCM routing which you need
check in the hardware documentation, currently you will need a alsa
device to be able to properly route passing it as argument to
module-device-bluetooth (iirc sco-sink/sco-source).

Again you need to be able to respond what routing settings you
controller uses, otherwise we won't be able to help you.

-- 
Luiz Augusto von Dentz
