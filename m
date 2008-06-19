Return-Path: <cyrus@holtmann.org>
Message-ID: <011101c8d1e5$63fd26b0$6e01a8c0@Raymondpc>
From: "colorant" <colorant@163.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
References: <e96e9eeb0806130507u139f58a2sa7094a65f9ecff17@mail.gmail.com><4852914F.6020209@earthlink.net>
	<008e01c8d113$c65174b0$6e01a8c0@Raymondpc>
Date: Thu, 19 Jun 2008 16:20:53 +0800
MIME-Version: 1.0
Subject: [Bluez-users] When Connect A2DP : Error 22 while configuring device
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi

    I am try to connect A2DP with Bluez

    When useing Aplay to try it , I have following problems :

~ # aplay -D bluetooth demo.wav
ALSA lib pcm_bluetooth.c:1158:(bluetooth_cfg) Error 22 while configuring 
device
aplay: main:510: audio open error: Invalid argument

Can Someone point out what might be the reason ?

My config file is :

~ # cat /etc/bluetooth/hcid.conf
#
# HCI daemon configuration file.
#

# HCId options
options {
        # Automatically initialize new devices
        autoinit yes;

        security auto;

        pairing multi;

        offmode devdown;

        passkey "1234"; // I use my pc with usb dongle to provide the a2dp 
service, so this is set to1234 not 0000 or 8888 etc.
}

# Default settings for HCI devices
device {
        name "%h-%d";

        class 0xff0100;
        # Default packet type
        #pkt_type DH1,DM1,HV1;

        iscan disable; pscan enable;

        # Page timeout (10s)
        pageto 16384;

        # Discoverable timeout (0 == disabled)
        discovto 0;

        lm accept;

        lp rswitch,hold,sniff,park;
}


~ # cat /etc/bluetooth/audio.conf
# Configuration file for the audio service

# This section contains options which are not specific to any
# particular interface
[General]

# If we want to disable support for specific services
# Defaults to supporting all implemented services
# disable=Sink

# SCO routing. Either PCM or HCI (in which case audio is routed to/from 
ALSA)
# Defaults to HCI
SCORouting=PCM

# Headset interface specific options (i.e. options which affect how the 
audio
# service interacts with remote headset devices)
[Headset]

# Set to true to only support HSP
# Defaults to false
DisableHFP=true

# Just an example of potential config options for the other interfaces
#[A2DP]
SourceCount=2






-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
