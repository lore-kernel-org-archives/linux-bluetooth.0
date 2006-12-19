Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <458864F1.4070104@xmission.com>
Date: Tue, 19 Dec 2006 15:17:21 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44F6B7AE.1030209@jambit.com>
	<4582A310.60905@jambit.com>	<4583A020.2040808@xmission.com>
	<4587D051.8080703@jambit.com>
In-Reply-To: <4587D051.8080703@jambit.com>
Subject: Re: [Bluez-devel] How to use sbc.c ?
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

Frank

> What succeeded: With an older version of sbc.c I managed to encode a wav
> file, send it over the air and receive it, decode it and write it in a
> file. Well, it looks different than the original. In the original there
> is some information in the first bytes like: "WAVEfmt", a long area with
> zero bytes, then the characters "data" and then the data seems to begin.
> I do not find this in my received file. Is there something else I have
> to care about? Should I run sbcinfo and change sbc_init() according to
> the results?

there is not a way to send metadata about the original wav over the a2dp
stream. It sounds like you want a way to create a wav from the pcm
received on the other side. You will have to use a conversion utility.

> The newest download of sbc.c from http://sbc.cvs.sourceforge.net/sbc/
> under menu "CVS Browse" contains a simple bug, which lets the file
> compile, but crash on runtime: In function _sbc_analyze_eight() the
> array 't[8]' is referenced from t[1] to t[8], instead of t[0] to t[7].

fixed. thanks.

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
