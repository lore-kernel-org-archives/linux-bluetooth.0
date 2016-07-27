Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Matthew Waddell <matt@littlecraft.io>
Subject: HFP - No Audio
To: linux-bluetooth@vger.kernel.org
Message-ID: <5799150B.2040401@littlecraft.io>
Date: Wed, 27 Jul 2016 13:09:47 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am trying to configure HFP to allow in-call audio to be routed through 
my PC's audio card.  I'm interested to know the current state of 
support, and if anyone has had success in getting it to work.  I have 
tried various combinations of the following components, but have so far 
been unable to get the in-call audio working:

Kernel: 4.4.11, 4.6.4, 4.7 (unstable)
Bluez: 5.37, 5.7, 5.8, 5.9
Pulesaudio: 7, 8, 9
Ofono: 1.7, 1.8, 1.9
USB Bluetooth Adapters:
      0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (CSR8510 A10)
      0a5c:21e8 Broadcom Corp. BCM20702A0 Bluetooth 4.0 (with firmware 
001.002.014 build 1338)

I've can verify that ofono is able to detect the HFP capabilities of a 
connected device, and to establish a 'modem' to it. Pulseaudio is also 
notified when a call becomes active, and appears to load the appropriate 
loopbacks to route the audio from/to the call through the HFP modem. 
Hacking in some extra debug tracing to pulseaudio, I've verified that 
pulseaudio receives SCO packets from the file descriptor that it 
receives from ofono.  Still, I am unable to hear any audio from the call.

Something interesting that I've noticed, however, is that if I look at 
the in-call traffic with hcidump, it looks to me like the payloads of 
each of the SCO packets that are received from the remote device (the 
phone) are either all 0x0000 or 0x0001.  I have not seen cases where it 
is anything other than that.

Does anyone have any suggestions for what might be going on, or how I 
might be able to debug this further?

This post from May sounds like similar circumstances, and possibly even 
a success story:
http://www.spinics.net/lists/linux-bluetooth/msg67283.html


Thanks!
_matt
