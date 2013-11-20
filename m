Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Bruno Bruzzano <brunano21@gmail.com>
Date: Wed, 20 Nov 2013 17:18:19 -0500
Message-ID: <CACA6DsU+5gp_diykBarJhmJ_WTLwVZc==CbPOVRKfkHdEtBY0w@mail.gmail.com>
Subject: BUG??
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

Maybe I encountered a bug. I'm using git version of Bluez5 on Fedora
20 beta and all crash when I try to connect to a generic profile. In
particular, the steps to reproduce it are the following:
- start bluetooth daemon (with -ndE args)
- using bluetoothctl (in client folder):
-- agent on
-- scan on
-- wait to discovery my android device
-- scan off
-- pair maddr -> pair complete!

After that I try to connect using AVRCP profile. It works.
The problem appears when a tap on my smartphone's player. Bluetoothd crashes!!

Here, you can find some pastebins.
bluetoothd -> http://pastebin.com/ZSER2Df6
bluetoothctl -> http://pastebin.com/rexVrruB

I hope someone can give me a feedback or a
tip!


Thanks in advance
