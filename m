Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <457734F2.30204@xmission.com>
Date: Wed, 06 Dec 2006 14:24:02 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <457655A2.6030001@xmission.com> <45772B71.5020505@vasmac.com>
In-Reply-To: <45772B71.5020505@vasmac.com>
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

Jose

> I think that bt.audiod should only handle the audio control portion.
> The audio plugins should do direct bluetooth I/O.

I'll update the page then. I won't rule out having bt.audiod manage a 
file descriptor for the sco channel and pass it around like Fabien did 
in his daemon. Only one app could use the sco channel at a time.

In the case of a2dp where we're already dealing with long latencies, I 
would like to have bt.audiod mix, encode, and deliver the audio. The 
challenge there is to keep the latency consistent so a video player 
could accommodate it.

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
