Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4537BB8C.10104@xmission.com>
Date: Thu, 19 Oct 2006 11:53:16 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <452E84DA.9090307@free.fr>
In-Reply-To: <452E84DA.9090307@free.fr>
Subject: Re: [Bluez-devel] [PATCH] Updated sco flow control feature
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

I would like to better document how to try this patch and use it with
the alsa sco plugin. I've started it in

https://help.ubuntu.com/community/BluetoothAudio

Is the sco plugin in our cvs current and will it enable your flow control?

Brad

> After a few very busy months at work i finally had the opportunity to go
> back to my bluez flow control patch i left in the middle of nowhere back
> in May. :-)
> You will find attached an updated version of the patch against
> 2.6.18-mh4, as well as a sample test program that shows the flow control
> stuff is really working.
> 
> Major changes compared to previous versions:
> * Packets are queued in the core, and are dequeue from there.
> * Flow control is achieved using high resolution timers. This means the
> code is really HZ independant, and things will even go better when the
> dyntick patch which has been in the air recently will be included in the
> mainline kernel.
> * Fixed a stupid bug that would cause packets to be sent really too
> slowly when HZ was < 1000
> * Should work with HZ = 100, 250, 1000, ... or whatever else. I tested
> with 250 HZ only for now.
> * Wrote a test program, "headsettest". To run this program you will need
> an USB dongle that supports SCO, as well as a
> headset. This program records your own voice for 30 seconds, then plays
> what it recorded in your ears for 30 seconds. Beware : Running it
> without the flow control patch is likely to crash your box !!
> * The patch is cleaner. This is mainly due to the fact i am getting to a
> better understanding of Linux socket layer.DEFAULT_SCO_RXBUFS;
>  	sk->sk_sndtime

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
