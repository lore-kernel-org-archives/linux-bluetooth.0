Return-Path: <cyrus@holtmann.org>
Message-ID: <c2a31c480810100619y21637babj3947fb1789b5d428@mail.gmail.com>
Date: Fri, 10 Oct 2008 18:49:54 +0530
From: "sreevani medhahal" <sreevani.medhahal@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: regarding headset test
In-Reply-To: <c2a31c480810070309g6bc3fe47oa41d47f1dc6b03b8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <c2a31c480810070309g6bc3fe47oa41d47f1dc6b03b8@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
 i am resending this mail .Kindly suggest your inputs for the below.

 I have the following query...
1)    Headset Model Number: motorola HT820
when i tried hstest play new.wav <bd_addr> channel_no
here what should be the channel no ?
$./hstest play email.wav  00:07:A4:B7:51:8D 1
Voice setting: 0x0060
RFCOMM channel connected
Can't connect SCO audio channel: Address already in use

output of :$ hciconfig -a
hci0:   Type: USB
       BD Address: 00:02:5B:02:97:76 ACL MTU: 310:10 SCO MTU: 64:8
       UP RUNNING PSCAN
       RX bytes:203468 acl:2048 sco:274 events:9024 errors:5
       TX bytes:1274949 acl:5837 sco:0 commands:740 errors:0
       Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x59 0x83
       Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
       Link policy: RSWITCH HOLD SNIFF PARK
       Link mode: SLAVE ACCEPT
       Name: 'training01-0'
       Class: 0x2a0100
       Service Classes: Networking, Capturing, Audio
       Device Class: Computer, Uncategorized
       HCI Ver: 2.1 (0x4) HCI Rev: 0x1306 LMP Ver: 2.1 (0x4) LMP Subver: 0x1306
       Manufacturer: Cambridge Silicon Radio (10)




I tried mailing on the bluez-users list :but no luck (hence attempting it here)
2)
I am using
   Headset Model Number: motorola HT820

Contents of .asoundrc is as below:
 cat ~/.asoundrc
pcm.bluetooth {
 type bluetooth
 device 00:07:A4:B7:51:8D
}

using bluez4.6 & kernel 2.6.27.rc6

when i use
$aplay -D bluetooth -f S16_LE shutdown1.wav
Playing WAVE 'shutdown1.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stere
I am able to hear it in my HT820

where as when i do
1)
arecord -D bluetooth -r 44100 -f S16_LE new.wav
Recording WAVE 'new.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Mono
I kept the above command running for few seconds & then pressed ctrl-c.
there is new.wav file created of size just 44 bytes & when i try aplay
on this nothing is heard( i think this is due to no recording on this
file).
2) I get the following error For
 I use the below command to hear what i have said in the microphone.!
$ arecord -Dplug:bluetooth -f S16_LE | aplay -D bluetooth -f S16_LE
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
ALSA lib pcm_bluetooth.c:712:(bluetooth_a2dp_hw_params)
BT_SETCONFIGURATION failed : Input/output error(5)
arecord: set_params:1015: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 16
CHANNELS: 1
RATE: 8000
PERIOD_TIME: 128000
PERIOD_SIZE: 1024
PERIOD_BYTES: 2048
PERIODS: 6
BUFFER_TIME: 768000
BUFFER_SIZE: 6144
BUFFER_BYTES: 12288
TICK_TIME: 0
aplay: playback:2148: read error

Let me know if i need to specify any other information.
regards,
S M
