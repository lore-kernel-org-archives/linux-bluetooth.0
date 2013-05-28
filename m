Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <51A465AD.5030704@gmail.com>
References: <51A465AD.5030704@gmail.com>
Date: Tue, 28 May 2013 01:26:13 -0700
Message-ID: <CABBYNZL0OSwiK4rhDy8h8k61K-HpZpdGu1-M0zD5jZvMox59Vg@mail.gmail.com>
Subject: Re: linux-bluetooth@vger.kernel.org
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Sebastian Mahler <werbungsbunker@googlemail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,



On Tue, May 28, 2013 at 1:07 AM, Sebastian Mahler
<werbungsbunker@googlemail.com> wrote:
> Headset used Iqua BHS-611.
>
> How to reproduce this error:
>
> 1.    sudo hciconfig device up
> 2.    hcitool scan
> 3.    sudo bluez-simple-agent hci0 <mac>
> 4.    sudo bluez-test-device trusted <mac> yes
> 5.    pulseaudio -k; sleep 4; pulseaudio -vv;
> 6.    pactl load-module module-alsa-sink device="btheadset"
> 7.    pactl load-module module-alsa-source device="btheadset"

There are dedicated modules for bluetooth such as
module-bluetooth-discover which will do the device detection
automatically for you, and if you need you can also load manually via
module-bluetooth-device.

> 8.    aplay -D btheadset -f S16_LE wave.wav
>         Works
> 9.    arecord -D btheadset -f S16_LE wave2.wav
>         Recording WAVE 'wave2.wav' : Signed 16 bit Little Endian, Rate 8000
> Hz, Mono
>         Final wave2.wav is always 2.092 B in size and contains only a wave
> header and zeroes.
> 10.    parec
>         Shows no output.


> Please use as a bug report or - better - show a solution.
>
> Sebastian Mahler
>
> PS:
>
>   .asoundrc:
>
>    pcm.bt {
>            type plug
>            slave {
>                    pcm "bt_hw"
>            }
>    }
>
>    pcm.bt_hw {
>            type bluetooth
>            device 00:1A:7D:11:C0:66
>            profile "auto"
>    }

This probably doesn't work anymore, if ever worked, PA has native
modules for Bluetooth for quite long time, please use those instead of
using alsa.


--
Luiz Augusto von Dentz
