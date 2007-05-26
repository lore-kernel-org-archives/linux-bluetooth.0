Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4658C395.6010908@jlab.org>
Date: Sat, 26 May 2007 19:32:37 -0400
From: Chris Carlin <carlin@jlab.org>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <20070526171539.GA16843@kobayashi-maru.wspse.de>
In-Reply-To: <20070526171539.GA16843@kobayashi-maru.wspse.de>
Subject: Re: [Bluez-devel] bluetooth-audio and bug in a2dpd (Patch included)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Matthias Hensler wrote:
> Hi!
> 
> Playing with the current plugz from CVS and a2dpd I experienced a lot of
> choppy audio with a BW-HF02 bluetooth audio receiver. I tracked down the
> problem to the transmit loop in a2dpd_output_a2dp.c. My receiver has an
> own buffer which runs full after around 3-4 seconds. In that case the
> write will fail with EAGAIN. The loop should take care of that and
> retry, however errno gets lost in the current implementation, so no
> single retry is made.

Great!

This modification made my Motorola S805 headphones usable and my 
Creative CB2530 headphones almost so (neither was usable at all before).

I had a feeling it was something sort of small but I was on the wrong 
track with finding the cause for the EAGAIN.

~Chris

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
