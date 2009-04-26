Return-Path: <cyrus@holtmann.org>
Message-ID: <121966.41193.qm@web95401.mail.in2.yahoo.com>
References: <6AC5A55546F64545AE996F8200E3AC4EFCA329@NL0105EXC01V01.eur.slb.com>
Date: Sun, 26 Apr 2009 22:07:07 +0530 (IST)
From: balaji palaniswami <balaji_palaniswami@yahoo.com>
Subject: Re: Upgrade bluez-4.17 to 4.36 - headset no longer works
To: John Frankish <j-frankish@slb.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <6AC5A55546F64545AE996F8200E3AC4EFCA329@NL0105EXC01V01.eur.slb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi John ,

I got same problem when updated to 4.36.
I got error 
ALSA lib pcm_bluetooth.c:(audioservice_expect) .....
ALSA lib pcm_bluetooth..c:(audioservice_recv) Bogus message ....

I could not remember exact error message.but it is similar your message.

In bluetooth daemon log ,
i got BT REQUEST < BT GET CAPABILTIES 
Invalid message length 

In code , i checked message header length is zero.hence it terminated client socket.
Then i assumed that problem is with alsa , so i reinstalled bluez-* packages and rebooted.

i tried aplay to play a song it started , immediately i aplay pcm write error mesage.so i concluded that its problem with aplay . i tried rythem music box in Ubuntu 8.10 .Finally , I heard song in Motorola 850 Headset.

 Thanks,
 Balaji.P



----- Original Message ----
From: John Frankish <j-frankish@slb.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Sent: Sunday, 26 April, 2009 3:24:24 PM
Subject: FW: Upgrade bluez-4.17 to 4.36 - headset no longer works

No feedback? Something basic must be wrong if a bt headset won't work...

-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of John Frankish
Sent: 19 April, 2009 09:13
To: linux-bluetooth@vger.kernel.org
Subject: Upgrade bluez-4.17 to 4.36 - headset no longer works

Hi,

I recently upgraded from bluez-4.17 to bluez-4.36 and now my se hbh-610 headset no longer works.

Any pointers would be gratefully received.

Thanks, John
------------

This ~/.asoundrc used to work:

Quote
pcm.bluetooth {
type bluetooth
device "00:12:EE:A6:1D:F4"
profile "auto"
}

ctl.bluetooth {
type bluetooth
}
Unquote

..with the following:
$ aplay -Dbluetooth -f S16_LE /usr/local/share/sounds/alsa/Noise.wav

..but with bluez-4.36, there is no sound and "bluetoothd -n" reports:

bluetoothd[7621]: link_key_request (sba=00:21:86:E4:4D:67, dba=00:12:EE:A6:1D:F4)
bluetoothd[7621]: Badly formated or unrecognized command: AT*SEAUDIO=4,4014
bluetoothd[7621]: Badly formated or unrecognized command: AT+CSCS="UTF-8"
bluetoothd[7621]: Badly formated or unrecognized command: AT*SEAM="HBH-610",13
bluetoothd[7621]: Badly formated or unrecognized command: AT+CLAN?

I tried the .asoundrc suggested in /etc/alsa/bluetooth.conf:

Quote
pcm.rawbluetooth {
        @args [ 00:12:EE:A6:1D:F4 ]
        @args.00:12:EE:A6:1D:F4 {
                type string
        }
        type bluetooth
        device "00:12:EE:A6:1D:F4"
}

pcm.bluetooth {
        @args [ 00:12:EE:A6:1D:F4 ]
        @args.00:12:EE:A6:1D:F4 {
                type string
        }
        type plug
        slave {
                pcm {
                        type bluetooth
                        device "00:12:EE:A6:1D:F4"
                }
        }
}
UnQuote

..but I got:

$ aplay -Dplug:bluetooth -f S16_LE /usr/local/share/sounds/alsa/Noise.wav

Playing WAVE '/usr/local/share/sounds/alsa/Noise.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Mono
ALSA lib pcm_bluetooth.c:1607:(audioservice_expect) BT_START_STREAM failed : Success(0)
ALSA lib pcm_bluetooth.c:1566:(audioservice_recv) Too short (1 bytes) IPC packet from bluetoothd
aplay: set_params:1015: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 16
CHANNELS: 1
RATE: 48000
PERIOD_TIME: 125000
PERIOD_SIZE: 6000
PERIOD_BYTES: 12000
PERIODS: 4
BUFFER_TIME: 500000
BUFFER_SIZE: 24000
BUFFER_BYTES: 48000
TICK_TIME: 0
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html



      Own a website.Get an unlimited package.Pay next to nothing.*Go to http://in.business.yahoo.com/

