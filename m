Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sun, 18 Aug 2013 23:41:24 +0200
Message-ID: <CAK4aCBbDAG82YKZLhLg_jTG_dQoDykwimO3a18fb7eGHiXgA0Q@mail.gmail.com>
Subject: Cannot connect to A2DP audio sink on Bluetooth headset
From: Fabrice Delente <delentef@gmail.com>
To: Liste Linux-Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello.

I have a headset that used to work with bluez-4.101 (on gentoo), but
all of a sudden it was impossible to connect, even though I haven't
changed anything to my configuration...

Anyway, I tried bluez-5.7 through a gentoo overlay, as stock gentoo
only carries bluez-4.101

Since blueman doesn't work with bluez-5.7, I have tried to connect to
the sink through bluetoothctl. However, as root, I get this:

[bluetooth]# connect 00:18:91:D0:7A:24
Attempting to connect to 00:18:91:D0:7A:24
[CHG] Device 00:18:91:D0:7A:24 Connected: yes
Failed to connect: org.bluez.Error.Failed

and /var/log/messages shows

Aug 18 23:34:21 smug bluetoothd[25436]: connect error: Connection refused (111)

or

Aug 18 23:35:17 smug bluetoothd[25436]: connect error: Permission denied (13)

Why does this happen? My /etc/bluetooth/audio.conf is

# Configuration file for the audio service

# This section contains options which are not specific to any
# particular interface
[General]
Enable=Sink
#Enable=Source,Sink,Control,Media
#Disable=Headset,Gateway,Socket

# Switch to master role for incoming connections (defaults to true)
Master=true

# If we want to disable support for specific services
# Defaults to supporting all implemented services
#Disable=Gateway,Source,Socket

# SCO routing. Either PCM or HCI (in which case audio is routed to/from ALSA)
# Defaults to HCI
SCORouting=HCI

# Automatically connect both A2DP and HFP/HSP profiles for incoming
# connections. Some headsets that support both profiles will only connect the
# other one automatically so the default setting of true is usually a good
# idea.
AutoConnect=true
#AutoConnect=A2DP

# Headset interface specific options (i.e. options which affect how the audio
# service interacts with remote headset devices)
[Headset]

# Set to true to support HFP, false means only HSP is supported
# Defaults to true
HFP=true

# Maximum number of connected HSP/HFP devices per adapter. Defaults to 1
MaxConnected=1

# Set to true to enable use of fast connectable mode (faster page scanning)
# for HFP when incoming call starts. Default settings are restored after
# call is answered or rejected. Page scan interval is much shorter and page
# scan type changed to interlaced. Such allows faster connection initiated
# by a headset.
FastConnectable=false

# Just an example of potential config options for the other interfaces
#[A2DP]
#SBCSources=1
#MPEG12Sources=0

Thanks.
