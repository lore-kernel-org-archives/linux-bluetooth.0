Return-Path: <cyrus@holtmann.org>
From: John Frankish <j-frankish@slb.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Sat, 20 Jun 2009 07:47:08 +0200
Subject: RE: Audio failures on bluetooth headset
Message-ID: <6AC5A55546F64545AE996F8200E3AC4E06A50F46@NL0105EXC01V01.eur.slb.com>
References: <e0ab60670906190801w42d91318h6ce0e178832f8e71@mail.gmail.com>
In-Reply-To: <e0ab60670906190801w42d91318h6ce0e178832f8e71@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Douglas Lopes Pereira
Sent: 19 June, 2009 19:02
To: linux-bluetooth@vger.kernel.org
Subject: Audio failures on bluetooth headset

Hi guys,

Here I am to share my problems again. Please, read if you have time.

I have bluez 4.41 installed on my 2.6.30 system and I´m trying to play
a .wav file using aplay on my bluetooth headset but the sound I hear
on the headset has failures, noises. Also, I'm trying to record my
voice on the same headset, but the result is terrible.

Following are the steps I'm taking:

- My bluetooth dongle is recognized as (hciconfig -a):
  hci0:   Type: USB
        BD Address: 00:10:60:30:1A:2D ACL MTU: 384:8 SCO MTU: 64:8
        UP RUNNING PSCAN
        RX bytes:10886 acl:31 sco:0 events:395 errors:0
        TX bytes:1961 acl:26 sco:0 commands:139 errors:0
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'debian-0'
        Class: 0x4a0204
        Service Classes: Networking, Capturing, Telephony
        Device Class: Phone, Cellular
        HCI Ver: 2.0 (0x3) HCI Rev: 0x7a6 LMP Ver: 2.0 (0x3) LMP Subver: 0x7a6
        Manufacturer: Cambridge Silicon Radio (10)

- I started the simple-agent:
   Agent registered

- Then I create the device using:
  dbus-send --system --type=method_call --print-reply --dest=org.bluez
/org/bluez/2705/hci0 org.bluez.Adapter.CreateDevice
string:00:08:1B:05:0A:0F

- Next step is to connect the headset:
  dbus-send --system --type=method_call --print-reply --dest=org.bluez
/org/bluez/2705/hci0/dev_00_08_1B_05_0A_0F org.bluez.Headset.Connect

- Now I need to configure ~/.asoundrc with my bluetooth device:

pcm.bluetooth {
   type bluetooth
   device "00:08:1B:05:0A:0F"
   profile "auto"
}

> Did you try the .asoundrc example in /etc/alsa?

- At this point I have my setup ready to play and record audio (at
least I should have). Then I start aplay:
  aplay -D bluetooth -f S16_LE myaudio.wav

> Did you try aplay -D plug:bluetooth -f S16_LE myaudio.wav?

  It works, but the audio I hear has a lot of noise and choppiness. I
read on bluez wiki that choppiness is expected, but is this the
scenario where it should happen?

- I also tryied arecord -D bluetooth -f S16_LE result.wav
  I was unable to understand the audio from result.wav. Hundreds of
following messages were found on syslog:

Jun 19 13:03:16 debian kernel: hci_scodata_packet: hci0 SCO packet for
unknown connection handle 39169
Jun 19 13:03:16 debian kernel: hci_scodata_packet: hci0 SCO packet for
unknown connection handle 144
Jun 19 13:03:16 debian kernel: hci_scodata_packet: hci0 SCO packet for
unknown connection handle 89
Jun 19 13:03:16 debian kernel: hci_scodata_packet: hci0 SCO packet for
unknown connection handle 5888
Jun 19 13:03:17 debian kernel: hci_scodata_packet: hci0 SCO packet for
unknown connection handle 32513
Jun 19 13:03:17 debian kernel: hci_scodata_packet: hci0 SCO packet for
unknown connection handle 19969
Jun 19 13:03:17 debian kernel: hci_scodata_packet: hci0 SCO packet for
unknown connection handle 65025

Am I doing something wrong? Can anybody point me a way to fix this problem?
Thanks in advance.
Douglas
--

