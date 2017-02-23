Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Thu, 23 Feb 2017 16:34:05 +0300
From: "the.dmol@gmail.com" <the.dmol@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Jabra BT2046
Message-Id: <20170223163405.5a4d847c12932c5df4c74b14@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

Is there any way to let the named BT-headset to work with bluez (5.43)?

Here[1] is the log from bluetoothctl, i.e. it connects and then
disconnects after a second.  

I checked the headset with windows and android, and all works fine here.

Thanks for any help!

[1]

[MDR-ZX550BN]# connect 50:1A:A5:56:93:C7 
Attempting to connect to 50:1A:A5:56:93:C7 
[CHG] Device 50:1A:A5:56:93:C7 Connected: yes 
[CHG] Device 50:1A:A5:56:93:C7 ServicesResolved: yes 
Failed to connect: org.bluez.Error.NotAvailable 
[CHG] Device 50:1A:A5:56:93:C7 ServicesResolved: no 
[CHG] Device 50:1A:A5:56:93:C7 Connected: no 
[MDR-ZX550BN]# info 50:1A:A5:56:93:C7 
Device 50:1A:A5:56:93:C7 
        Name: JABRA BT2046 
        Alias: JABRA BT2046 
        Class: 0x200404 
        Icon: audio-card 
        Paired: yes 
        Trusted: yes 
        Blocked: no 
        Connected: no 
        LegacyPairing: no 
        UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb) 
        UUID: Handsfree                 (0000111e-0000-1000-8000-00805f9b34fb) 
[MDR-ZX550BN]# info 50:1A:A5:56:93:C7 
Device 50:1A:A5:56:93:C7 
        Name: JABRA BT2046 
        Alias: JABRA BT2046 
        Class: 0x200404 
        Icon: audio-card 
        Paired: yes 
        Trusted: yes 
        Blocked: no 
        Connected: no 
        LegacyPairing: no 
        UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb) 
        UUID: Handsfree                 (0000111e-0000-1000-8000-00805f9b34fb) 
[MDR-ZX550BN]# connect 50:1A:A5:56:93:C7 
Attempting to connect to 50:1A:A5:56:93:C7 
[CHG] Device 50:1A:A5:56:93:C7 Connected: yes 
[CHG] Device 50:1A:A5:56:93:C7 ServicesResolved: yes 
Failed to connect: org.bluez.Error.NotAvailable 
[CHG] Device 50:1A:A5:56:93:C7 ServicesResolved: no 
[CHG] Device 50:1A:A5:56:93:C7 Connected: no 
[MDR-ZX550BN]# show 
Controller 00:1A:7D:0A:BC:75 
        Name: BlueZ 5.43 
        Alias: BlueZ 5.43 
        Class: 0x0c010c 
        Powered: yes 
        Discoverable: yes 
        Pairable: yes 
        UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb) 
        UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb) 
        UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb) 
        UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb) 
        UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb) 
        UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb) 
        UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb) 
        Modalias: usb:v1D6Bp0246d052B 
        Discovering: yes 

--
the.dmol@gmail.com <the.dmol@gmail.com>
