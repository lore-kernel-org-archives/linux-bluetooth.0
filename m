Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45206B2C.6080801@xmission.com>
Date: Sun, 01 Oct 2006 19:28:12 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <59260DC6DFC1CF40B06388D43B284EBB22FFA6@destc0strmsx02.eu.sony.com>
In-Reply-To: <59260DC6DFC1CF40B06388D43B284EBB22FFA6@destc0strmsx02.eu.sony.com>
Subject: Re: [Bluez-devel] SBC: Is there a way to make the decoded signal
 louder?
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

Fritz

I take it you mean a signal encoded with our libsbc?

We need someone to go over the encoder algorithm and compare it with the
spec, computing max/min/overflow/underflow at each step and making
better use of the 32 bits we use for intermediate results. Some of the
intermediate results have underused high bits because we have overflows
happening otherwise.

We want to focus improvements like this on the separate libsbc
sourceforge project. It was branched off the libsbc code found inside btsco.

Brad

> my current problem is that the SBC decoded signal is ways too quiet.
> Are there possibilities in the SBC algorithm to get a louder signal?
> 
> Regards,
>   Fritz
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
