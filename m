Return-Path: <cyrus@holtmann.org>
From: Galaha Shine <galaha.a.s@gmail.com>
To: bluez-devel@lists.sourceforge.net
Date: Fri, 17 Oct 2008 00:31:24 +0800
Message-Id: <1224174684.22702.11.camel@alex-laptop>
Mime-Version: 1.0
Subject: [Bluez-devel] how to change volume for a2dp headset?
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
Errors-To: bluez-devel-bounces@lists.sourceforge.net

hi,

I just wonder if it is possible to change a2dp headset volume by D-bus
command?

I notice there is a D-bus API SetSpeakerGain in bluez 3.36. I've try it
with my sco headset and it works. But it doesn't work when I try it with
a a2dp headset. Dbus returns an error that is unconnected. Then I
download bluez 4.13 which is the latest build. I notice that API
SetSpeakerGain becomes deprecated. Meanwhile I find control-api.txt
which seems haven't been implemented yet. 

Could anybody give me a hint how to control a2dp headset from host side
by D-bus command?

regards,
Galaha


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
