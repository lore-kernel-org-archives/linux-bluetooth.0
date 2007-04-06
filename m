Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4615D6C2.8080301@xmission.com>
Date: Thu, 05 Apr 2007 23:12:34 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <5FD5754DDBA0B1499B5A0B4BB5419485D8E1FC@fmsmsx411.amr.corp.intel.com>
In-Reply-To: <5FD5754DDBA0B1499B5A0B4BB5419485D8E1FC@fmsmsx411.amr.corp.intel.com>
Subject: Re: [Bluez-devel] Plugz and btsco
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

> I want to make sure, if I use the plugz (with headsetd and a2dpd), I do
> not need to
> have the btsco daemon nor the snd_bt_sco device. Is that correct?

it is correct that you don't need them

> I am attempting to use skype with a bluetooth headset. I am not seeing
> the device 
> in the menu on skype.

it will not appear in the list. you have to type in the dev name or
close skype and edit the config file

> I tried using alsa's aplay, but I am getting an error saying:
> 'channels count non available'.

what command line? what does .asoundrc look like?

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
