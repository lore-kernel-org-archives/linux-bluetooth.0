Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Thu, 5 Apr 2007 07:14:15 -0700
Message-ID: <5FD5754DDBA0B1499B5A0B4BB5419485D8E1FC@fmsmsx411.amr.corp.intel.com>
From: "Allyn, Mark A" <mark.a.allyn@intel.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Plugz and btsco
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Folks:
 
I want to make sure, if I use the plugz (with headsetd and a2dpd), I do
not need to
have the btsco daemon nor the snd_bt_sco device. Is that correct?
 
I am attempting to use skype with a bluetooth headset. I am not seeing
the device 
in the menu on skype.
 
I tried using alsa's aplay, but I am getting an error saying:
'channels count non available'.
 
I tried googling, but the only emails I see are from those who have 
installed btsco as well as plugz.
 
This is why I am a little confused.
 
I don't want to use btsco because there seems to be problems with the
kernel driver
snd-bt-sco with the 1.0.14rc3 series of alsa drivers (kernel oopses).
 
Has anyone sucessfuly used skype with plugz and headsetd / a2dpd without
either the
btsco daemon or the snd-bt-sco kernel driver?
 
Thank you
 
Mark Allyn

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
