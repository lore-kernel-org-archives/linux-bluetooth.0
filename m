Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Wed, 28 Mar 2007 13:30:01 -0700
Message-ID: <5FD5754DDBA0B1499B5A0B4BB5419485CD0D36@fmsmsx411.amr.corp.intel.com>
From: "Allyn, Mark A" <mark.a.allyn@intel.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Bluetooth Audio question
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

Hello:
 
I am working on getting the plugz bluetooth audio working with a 
headset that my user wants to work with skype.
 
I cannot use btsco because it causes kernel oopses with Alsa 1.0.14rc3
and it
appears that there are structural changes that happened in Alsa, but not
the
btsco daemon or the snd-bt-sco kernel modules.

I am assuming that no more work is done to maintain the btsco /
snd-bt-sco 
infrastructure. Is this correct?

I looked at the notes on using plugz and sbc. 

I am a bit confused. You mention a kernel patch. Is this needed for 
using btsco or using plugz? I thought that by using all user space
communication between the bluetooth and the Alsa, we don't have to worry
about any kernel stuff. What is the kernel patch all about? My site uses

the 2.6.17.13 kernel.  

Do any of you know if there are any issues using plugz with a bluetooth 
headset (for talking and listening with Skype) with Alsa 1.0.14rc3?

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
