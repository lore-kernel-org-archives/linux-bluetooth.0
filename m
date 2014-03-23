Return-Path: <cyrus@holtmann.org>
Message-ID: <532F33BB.8050000@gmail.com>
Date: Sun, 23 Mar 2014 19:19:23 +0000
From: Andrea <mariofutire@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Help on connecting a PS3 headset
References: <532CAAB8.5020403@gmail.com>
In-Reply-To: <532CAAB8.5020403@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 21/03/14 21:10, Andrea wrote:
> Hi,
> 
> I've been trying to manually connect a PS3 headset using bluez 5.16 without success.
> It does work using KDE Bluetooth tools (still based on bluez 4), but as I would like to use it on a
> headless box, I need to do it via CLI.
> 
> Using bluez 5.16 (both in Fedora 19 and on Arch on a Pi) I can pair the device but when I try to
> connect I get
> 

I think it is a regression of 5.16 vs 4.xxx
I've just installed Fedora 20 (using bluez 5.16) and the KDE Gui bluetooth tools can't connect
either with a very similar log from bluetoothctl

this is the output while I was using the KDE Gui tools.
it pairs well, connects, but the disconnect immediately.
at the end I tried manually froom here, with no success

I don't think the kernel version matters, as it is 3.13.6 in all cases.

any sort of traffic log I could provide to help resolving the issue?

andrea@thinkpad:~$ sudo bluetoothctl
[NEW] Controller 00:15:83:0C:BF:EB thinkpad [default]
[bluetooth]# devices
[CHG] Controller 00:15:83:0C:BF:EB Discovering: yes
[NEW] Device 00:22:A6:16:E3:F0 00-22-A6-16-E3-F0
[CHG] Device 00:22:A6:16:E3:F0 LegacyPairing: no
[CHG] Device 00:22:A6:16:E3:F0 Name: Wireless Headset
[CHG] Device 00:22:A6:16:E3:F0 Alias: Wireless Headset
[CHG] Device 00:22:A6:16:E3:F0 LegacyPairing: yes
[CHG] Controller 00:15:83:0C:BF:EB Discovering: no
[CHG] Device 00:22:A6:16:E3:F0 Connected: yes
[CHG] Device 00:22:A6:16:E3:F0 Modalias: usb:v12BAp0010d0140
[CHG] Device 00:22:A6:16:E3:F0 Modalias: usb:v12BAp0010d0140
[CHG] Device 00:22:A6:16:E3:F0 UUIDs has unsupported type
[CHG] Device 00:22:A6:16:E3:F0 Paired: yes
[CHG] Device 00:22:A6:16:E3:F0 Trusted: yes
[CHG] Device 00:22:A6:16:E3:F0 Connected: no
[CHG] Device 00:22:A6:16:E3:F0 Connected: yes
[CHG] Device 00:22:A6:16:E3:F0 Modalias: usb:v12BAp0010d0140
[CHG] Device 00:22:A6:16:E3:F0 Modalias: usb:v12BAp0010d0140
[CHG] Device 00:22:A6:16:E3:F0 Connected: no
[bluetooth]# connect 00:22:A6:16:E3:F0
Attempting to connect to 00:22:A6:16:E3:F0
[CHG] Device 00:22:A6:16:E3:F0 Connected: yes
[CHG] Device 00:22:A6:16:E3:F0 Modalias: usb:v12BAp0010d0140
[CHG] Device 00:22:A6:16:E3:F0 Modalias: usb:v12BAp0010d0140
Failed to connect: org.bluez.Error.NotAvailable
[CHG] Device 00:22:A6:16:E3:F0 Connected: no
[CHG] Device 00:22:A6:16:E3:F0 Alias: Wireless Headset
[CHG] Device 00:22:A6:16:E3:F0 Connected: yes
[CHG] Device 00:22:A6:16:E3:F0 Connected: no


