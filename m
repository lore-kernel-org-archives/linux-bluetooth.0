Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <5b9417770711150205y5066ee5fx4a160363a9dc7ca3@mail.gmail.com>
Date: Thu, 15 Nov 2007 04:05:48 -0600
From: "John H." <mistamaila@gmail.com>
To: "BlueZ development" <Bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-devel] ALSA lib pcm_bluetooth.c:1179:(bluetooth_cfg) Error
	22 while configuring device
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

F8 machine

I get this when I try to use the integrated bluez bluetooth with my
moto  550 headset
http://wiki.bluez.org/wiki/HOWTO/AudioDevices

ALSA lib pcm_bluetooth.c:1179:(bluetooth_cfg) Error 22 while configuring device

over and over after starting skype, and all the audio goes to my soundcard

I can play mp3s and such to my headset, so why is skype doing this?

the other problem is, I can get media players to play, once I turn on
my headset, audio to the headset, but the second time I try to do it,
it fails with this error 22 until I hit the button on the headset or
turn it off/back on.

I didn't have this problem with snd-bt-sco, but I am trying to switch
to straight up bluez.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
