Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <455FEBE0.6080600@xmission.com>
Date: Sat, 18 Nov 2006 22:30:08 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <455CCAF4.8020007@silicom.fr><7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EA7@eumonex01.palmsource.com>	<455EE00B.80504@free.fr>
	<7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EAE@eumonex01.palmsource.com>
In-Reply-To: <7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EAE@eumonex01.palmsource.com>
Subject: Re: [Bluez-devel] RE : RE : SCO on bluez : some architectural tips
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

Frederic

> We won't be able to use +/- in a game or system sound!

multiplayer gaming would not be acceptable with a2dp latencies. System 
sounds like taps that are supposed to be an immediate feedback would 
have to be turned off probably.

I want to have the bluetooth audio daemon keep track of latency for a 
given headset and leave it up to the app to do something about it. 
System sounds like tap feedback would be turned off for significant 
delay but single-player gaming and video playing could accommodate the 
delay.

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
