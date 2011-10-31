Return-Path: <cyrus@holtmann.org>
Message-ID: <1320082091.92641.YahooMailNeo@web31806.mail.mud.yahoo.com>
Date: Mon, 31 Oct 2011 10:28:11 -0700 (PDT)
From: Scott Haynie <scottahaynie@yahoo.com>
Reply-To: Scott Haynie <scottahaynie@yahoo.com>
Subject: No audio with HFP
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
Simply trying to place a handsfree call via bluetooth/HFP on Ubuntu 11.04 (or 11.10).  The call gets placed (using ofono cmds), but I hear no audio through the PC in/out.  I follow the steps outlined by Gustavo Padovan here, which involved manually setting up loopback btw bluez & Alsa:
http://padovan.org/blog/2010/02/handsfree-profile-into-bluez-and-ofono/

Eventually got that to produce A2DP audio (Ubuntu 11.10, bluez 4.96, PA 1:1.0).  But as for HFP, still nothing. When I selected "Handsfree Gateway" PA profile for my BT device, I can hear an audio stream open up but still no voice.

Tried various configurations/versions of bluez, pulseaudio, ofono, all to no avail (including building all of them from their latest source).
Tried several combinations of Enable flags in /etc/bluetooth/audio.conf.  Currently I get closest with "Enable=Source,Sink,Gateway,Headset".


Saw lots of commits related to HFP recently--- none of which are in an official bluez release yet-- are these supposed to fix these issues once and for all?
http://git.kernel.org/?p=bluetooth/bluez.git;a=history;f=audio/gateway.c;hb=HEAD


Since I have complete control of my PC, is there a known configuration that works on Ubuntu?  A2DP is nice, but I'm more interested in getting HFP to work properly.

Scott
