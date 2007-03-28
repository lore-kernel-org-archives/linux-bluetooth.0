Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <460AD4A7.9050409@xmission.com>
Date: Wed, 28 Mar 2007 14:48:39 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <5FD5754DDBA0B1499B5A0B4BB5419485CD0D36@fmsmsx411.amr.corp.intel.com>
In-Reply-To: <5FD5754DDBA0B1499B5A0B4BB5419485CD0D36@fmsmsx411.amr.corp.intel.com>
Subject: Re: [Bluez-devel] Bluetooth Audio question
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

Mark

> I am assuming that no more work is done to maintain the btsco /
> snd-bt-sco 
> infrastructure. Is this correct?

I will accept patches but I am not working on it.

> I looked at the notes on using plugz and sbc. 
> 
> I am a bit confused. You mention a kernel patch. Is this needed for 
> using btsco or using plugz? I thought that by using all user space
> communication between the bluetooth and the Alsa, we don't have to worry
> about any kernel stuff. What is the kernel patch all about? My site uses
> 
> the 2.6.17.13 kernel.  
> 
> Do any of you know if there are any issues using plugz with a bluetooth 
> headset (for talking and listening with Skype) with Alsa 1.0.14rc3?

sadly, plugz does not have as many features as btsco, such as generating
rings in the headset. The daemon inside bluez-utils is being done right
so it can handle this but it's not ready for the desktop case yet.

brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
