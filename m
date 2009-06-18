Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 18 Jun 2009 15:04:43 -0300
Message-ID: <e0ab60670906181104m3a0a95cdk13d3d4596ed6676@mail.gmail.com>
Subject: Unable to play music on mobile phone over bluetooth
From: Douglas Lopes Pereira <douglaslopespereira@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi guys,

I'm facing some problems while playing music on my N95 phone over a
bluetooth conection and trying to record it with arecord.

Here is what I'm doing:

- I have bluez 4.41 installed on my 2.6.30 system.
- My bluetooth dongle is recognized as (hciconfig -a):
  hci0:   Type: USB
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

- I started a conection on my phone to my bluetooth device, inserted
the PIN and it seems to work:
  RequestPinCode (/org/bluez/2471/hci0/dev_00_
1F_5D_3A_01_2D)

- On the cellphone a parenthesis involving the bluetooth simbol means
a conection established.
  In this case, the parenthesis are shown, then they desapear, they
are shown again for a few seconds and desapear :(

- Last configuration is to add following lines to ~/.asoundrc

pcm.bluetooth {
   type bluetooth
   device "00:1F:5D:3A:01:2D"
   profile "auto"
}

- When I start arecord (arecord -D bluetooth) this is what I get:

ALSA lib pcm_bluetooth.c:1607:(audioservice_expect)
BT_GET_CAPABILITIES failed : Input/output error(5)
arecord: main:590: audio open error: Input/output error

- By the way, if I start playing music on my phone, it uses the main
speaker, and no audio is sent via bluetooth (I checked with hcidump)

- I tryed with 2 different dondles and 2 different mobile phones.

Does anyone has a clue? Can anybody help me and point what I am doing wrong?

Thanks in advance.
Douglas
