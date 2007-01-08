Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Mon, 8 Jan 2007 15:41:07 -0800
Message-ID: <D8CE9CFA707C894180BAC8CDD154F8460AB03AE5@msiexch01.marvell.com>
From: "Quinton Yuan" <qyuan@marvell.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] 1. Re: 2 plugz issues (Brad Midgley)
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

Hi, there

I am new to the Bluez thing, thanks for the great work you guys have
done !
By following your documentation on project home page, I just installed
latest plugz package on Fedora Core 6 (kernel 2.6.18-1.2869), basically
both mono and stereo headset up running, except

1. For mono headset, need to apply Kevin's change to make it work (will
patch kernel later, but same question as Kevin, which kernel version
this patch can be applied ?)

2. For A2DP thing, audio quality sounds weird, I got lots of message as:
  A2DPD[805.068]: a2dp_handler: Sound System dry!, 

no matter what sample rate I use, audio seems being played back at very
lower rate, however, same setup a2play works fine, any hint on this ? 

Here is my system information
bluez-libs-3.7-1
bluez-libs-devel-3.7-1
bluez-hcidump-1.32-1
bluez-gnome-0.6-1.fc6
bluez-utils-cups-3.7-2
bluez-utils-3.7-2

gnome-bluetooth-libs-0.7.0-11.fc6
gnome-bluetooth-0.7.0-11.fc6
nautilus-sendto-bluetooth-0.7.5.fc6

alsa-lib-1.0.12-2.fc6
alsa-lib-devel-1.0.12-2.fc6
alsa-utils-1.0.12-3.fc6

xmms 1.2.10

Thanks in advance.

Regards/Quinton

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
