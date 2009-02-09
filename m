Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 9 Feb 2009 19:51:15 +0800
Message-ID: <a172fe730902090351m6245a9f8uc39c2776752bcd9f@mail.gmail.com>
Subject: Turn off the bluetooth headset during audio playback via a2dp.
From: =?GB2312?B?seXA2g==?= <mykofzone@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

     If a2dp channel was disconnected during the audio playback , i
wanted to swtich the path to audiocard.
But after a2dp channel disconnect , "aplay" or "helix" would be hold
and can not exit normally. (I want to close the bluetooth device ,then
open a new audiocard device.)
How to fix this issue and is there other method to switch between
bluetooth headset and audiocard dynamically during audio playback via
a2dp?
Thanks very much.

My develop environment:
   kernel : 2.6.18.8
BlueZ : 3.26
   BT HW : STLC2500
   Headset : iTech
   Alsa : 1.0.16
	
MMI : Qtopia 4.3.1
Media engine : helix

BR
leibian
