Return-Path: <cyrus@holtmann.org>
Message-ID: <4F52570A.1090300@bluewin.ch>
Date: Sat, 03 Mar 2012 18:38:18 +0100
From: Simon Bachmann <simonbachmann@bluewin.ch>
MIME-Version: 1.0
To: bluetooth mailing list <linux-bluetooth@vger.kernel.org>
Subject: can't get bluetooth to work: Can't init device hci0: Connection timed
 out (110)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi there,

I'm having trouble getting bluetooth to work on my laptop.

First things firt, some info about the system:

Asus A93S Notebook
Built-in Bluetooth, vendor Lite-On Technology Corp. ID 04ca:3002
Arch Linux
Kernel 3.2.8
bluez 4.98

- The hardware seems to be recognised correctly:

# dmesg |grep tooth
[    7.355917] Bluetooth: Core ver 2.16
[    7.355935] Bluetooth: HCI device and connection manager initialized
[    7.355938] Bluetooth: HCI socket layer initialized
[    7.355940] Bluetooth: L2CAP socket layer initialized
[    7.355947] Bluetooth: SCO socket layer initialized
[    7.372899] Bluetooth: Generic Bluetooth USB driver ver 0.6
[   27.352796] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   73.128762] Bluetooth: RFCOMM TTY layer initialized
[   73.128775] Bluetooth: RFCOMM socket layer initialized
[   73.128777] Bluetooth: RFCOMM ver 1.11

- According to rfkill the device is not blocked

- The Problem: the device  hci0 is down and I cannot get it up:

# hciconfig hci0 up
Can't init device hci0: Connection timed out (110)

hciconfig reset gives the same error...

Searching the net I found out that I'm not the only one with this 
problem (see for example 
https://bbs.archlinux.org/viewtopic.php?id=126603), but a solution was 
nowhere to be found.

Any ideas what's wrong?

thanks

Simon


