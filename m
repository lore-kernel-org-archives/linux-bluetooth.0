Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: Hugues <morisset.hugues@gmail.com>
Subject: Bose Quiet Comfort 35 Remaining Battery Reporting
Message-ID: <58989E88.4000005@gmail.com>
Date: Mon, 6 Feb 2017 17:04:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I own a Bose QC35 bluetooth headset, sound is working great with
pulseaudio, but the battery reporting does not, I believe it is a
bluetooth issue because the device info doesn't say anything about
battery or power.
Any idea how I can make it report the remaining battery to upower so it
appears in my DE ?

The device info from bluetoothctl
info 04:52:C7:33:23:6E
Device 04:52:C7:33:23:6E
        Name: BQ35 Hugues
        Alias: BQ35 Hugues
        Class: 0x240418
        Icon: audio-card
        Paired: yes
        Trusted: yes
        Blocked: no
        Connected: yes
        LegacyPairing: no
        UUID: Vendor specific
(00000000-deca-fade-deca-deafdecacaff)
        UUID: Serial Port
(00001101-0000-1000-8000-00805f9b34fb)
        UUID: Headset
(00001108-0000-1000-8000-00805f9b34fb)
        UUID: Audio Source
(0000110a-0000-1000-8000-00805f9b34fb)
        UUID: Audio Sink
(0000110b-0000-1000-8000-00805f9b34fb)
        UUID: A/V Remote Control Target
(0000110c-0000-1000-8000-00805f9b34fb)
        UUID: Advanced Audio Distribu..
(0000110d-0000-1000-8000-00805f9b34fb)
        UUID: A/V Remote Control
(0000110e-0000-1000-8000-00805f9b34fb)
        UUID: Handsfree
(0000111e-0000-1000-8000-00805f9b34fb)
        UUID: PnP Information
(00001200-0000-1000-8000-00805f9b34fb)
        Modalias: bluetooth:v009Ep400Cd0129

Regards,
Hugues

