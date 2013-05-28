Return-Path: <cyrus@holtmann.org>
Message-ID: <51A4688C.2030808@gmail.com>
Date: Tue, 28 May 2013 10:19:24 +0200
From: Sebastian Mahler <werbungsbunker@googlemail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: [BUG] Using bluez 5.5 a bluetooth headset cannot be used as a recording
 device.
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Headset used Iqua BHS-611.

How to reproduce this error:

1.    sudo hciconfig device up
2.    hcitool scan
3.    sudo bluez-simple-agent hci0 <mac>
4.    sudo bluez-test-device trusted <mac> yes
5.    pulseaudio -k; sleep 4; pulseaudio -vv;
6.    pactl load-module module-alsa-sink device="btheadset"
7.    pactl load-module module-alsa-source device="btheadset"
8.    aplay -D btheadset -f S16_LE wave.wav
         Works
9.    arecord -D btheadset -f S16_LE wave2.wav
         Recording WAVE 'wave2.wav' : Signed 16 bit Little Endian, Rate 
8000 Hz, Mono
         Final wave2.wav is always 2.092 B in size and contains only a 
wave header and zeroes.
10.    parec
         Shows no output.


Please use as a bug report or - better - show a solution.

Sebastian Mahler

PS:

   .asoundrc:

    pcm.bt {
            type plug
            slave {
                    pcm "bt_hw"
            }
    }

    pcm.bt_hw {
            type bluetooth
            device 00:1A:7D:11:C0:66
            profile "auto"
    }

