Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <457F0FF2.6080600@xmission.com>
Date: Tue, 12 Dec 2006 13:24:18 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <457655A2.6030001@xmission.com>	<45772B71.5020505@vasmac.com>	<457734F2.30204@xmission.com>	<457C2D10.5040801@free.fr>	<457EDCBB.8080207@xmission.com>
	<457F08B4.6050603@free.fr>
In-Reply-To: <457F08B4.6050603@free.fr>
Subject: Re: [Bluez-devel] org.bluez.Audio
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

Fabien

> But what about A2DP ? Wouldn't it make sense to use ALSA mixing facility 
> too ?

dmix essentially acts as an audio server. But it's not the only one we 
should consider. I've been looking at pulseaudio to see if it fits in 
the picture at all. Seems to handle sound adapters that come and go and 
includes a sort of audio routing mechanism.

Brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
