Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44D0B1F7.2@xmission.com>
Date: Wed, 02 Aug 2006 08:08:55 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <7A6DA545D7FDCC4B93DB651FDBC1EDDE46C2E7@eumonex01.palmsource.com>
In-Reply-To: <7A6DA545D7FDCC4B93DB651FDBC1EDDE46C2E7@eumonex01.palmsource.com>
Subject: Re: [Bluez-devel] A2DP and Alsa Plugin
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

>> I've read about ALP. It looks exciting. I was glad to see ALP 
>> will include gstreamer as part of the foundation. You should 
>> help me write proper gstreamer plugins.
> 
> 	I did not worry about gstreamer as I tried the gstreamer
> alsasink yesterday. This allow you to create a graph with either
> bluetooth output or alsa output without modifying your .asoundrc. Just
> modify the device field. One address only as set in filename.

I was just cleaning out my mailbox and saw this discussion.

Is the memory footprint acceptable when introducing the alsa dependency
on your embedded platform? In my experience lib-alsa itself builds to
about 800KB on arm. The difference in cpu load is probably negligible.

Brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
