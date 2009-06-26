Return-Path: <cyrus@holtmann.org>
From: John Frankish <j-frankish@slb.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 26 Jun 2009 15:18:25 +0200
Subject: RE: Headset doesn't work at all (ALSA)
Message-ID: <6AC5A55546F64545AE996F8200E3AC4E06B667D1@NL0105EXC01V01.eur.slb.com>
References: <200906261122.39383.sojkam1@fel.cvut.cz>
In-Reply-To: <200906261122.39383.sojkam1@fel.cvut.cz>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Michal Sojka
Sent: 26 June, 2009 13:23
To: linux-bluetooth@vger.kernel.org
Subject: Headset doesn't work at all (ALSA)

Hi,

I cannot make my BT headset (Motorola HS820) work. I use Debian
with 2.6.30 kernel and the following versions of packages:

ii  bluez                                  4.42-1                                 Bluetooth tools and daemons
ii  bluez-alsa                             4.42-1                                 Bluetooth ALSA support

I've followed http://wiki.bluez.org/wiki/HOWTO/AudioDevices without success.
I have the following in .asoundrc:

>$ cat .asoundrc
>pcm.bluetoothraw {
>   type bluetooth
>   device 00:07:A4:87:E2:EE
>}
>pcm.bluetooth {
>    type plug
>    slave {
>        pcm bluetoothraw
>    }
>}

Then I tried:

>$ aplay -D bluetooth  'rec.wav'
>Playing WAVE 'rec.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Mono
>aplay: pcm_write:1528: write error: Connection timed out

>> does aplay -D plug:bluetooth  rec.wav help?

[snip]
