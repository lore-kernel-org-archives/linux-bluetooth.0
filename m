Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Feb 2009 11:14:14 -0500
From: jayjwa <jayjwa@atr2.ath.cx>
To: linux-bluetooth@vger.kernel.org
Subject: BT headset stops working
Message-ID: <alpine.LNX.2.00.0902230153190.8142@nge2.ngu.pk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



I upgraded from bluez-3.x to bluez-4.30 and found my headset no longer works.

I figured out pairing:

# simple-agent hci0 00:1A:45:01:F9:42

RequestPinCode (/org/bluez/18088/hci0/dev_00_1A_45_01_F9_42)
Enter PIN Code: 0000
Release
New device (/org/bluez/18088/hci0/dev_00_1A_45_01_F9_42)


but when playback should start, I see these familiar messages:


# sox -t mp3 sound_test.mp3 -t alsa pcm.bluetooth

ALSA lib pcm_bluetooth.c:1563:(audioservice_expect) BT_START_STREAM failed : Success(0)
ALSA lib pcm_bluetooth.c:1531:(audioservice_recv) Bogus message type 5 - name received from audio service
sox soxio: Can't open output file `pcm.bluetooth': cannot prepare audio interface for use

btusb_isoc_complete: hci0 corrupted SCO packet

hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
hci_scodata_packet: hci0 SCO packet for unknown connection handle 0

(many of these scrolling off the screen)

It's the same headset that's always worked before (after patching the kernel 
to put back the ripped out SCO functionality vs ESCO link patch):


Requesting information ...
         BD Address:  00:1A:45:01:F9:42
         OUI Company: GN Netcom as (00-1A-45)
         Device Name: Jabra BT135
         LMP Version: 2.0 (0x3) LMP Subversion: 0xbfa
         Manufacturer: Cambridge Silicon Radio (10)
         Features: 0xfc 0xfe 0x0b 0x00 0x08 0x08 0x00 0x00
                 <encryption> <slot offset> <timing accuracy> <role switch>
                 <hold mode> <sniff mode> <RSSI> <channel quality> <SCO link>
                 <HV2 packets> <HV3 packets> <u-law log> <A-law log> <CVSD>
                 <paging scheme> <transparent SCO> <AFH cap. slave>
                 <AFH cap. master>

Pan doesn't appear to work either, but one problem at a time. Apologies if 
this is the wrong list; I was under the impression this list was the successor 
to the bluez-users list at Source Forge, as stated on www.bluez.org, but since 
arriving here it appears to be bluetooth equal to the linux-kernel list 
(development).




