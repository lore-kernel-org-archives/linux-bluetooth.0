Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <452E99E8.6070406@vasmac.com>
Date: Thu, 12 Oct 2006 15:39:20 -0400
From: Jose Vasconcellos <jose@vasmac.com>
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

Hi, Fabien,

I'll take a look at your patch. I've been working on one myself.
As I mentioned earlier, I've taken a different approach that works
well. I use the standard HCI synchronous flow control. Now since
USB dongles don't generate this, I have the hci_usb_tx_complete
generate a HCI_EV_NUM_COMP_PKTS for transfer. Then the existing
system works fine. No timers are necessary. Only a small change
to hci_sched_sco in hci_core.c was necessary.

The problem I'm running into now is with dynamic isochronous
allocation. By default my driver sets interface 1 to use alternative 0
(i.e. no bandwidth). When the SCO is opened, this is changed to
alternative 2. All this works great. It's when the SCO is closed or
a second SCO is opened that causes problems as the bandwidth
needs to be reallocated.

Jose

 Chevalier wrote:
>
> Marcel, Brad, Jose,
>
> After a few very busy months at work i finally had the opportunity to 
> go back to my bluez flow control patch i left in the middle of nowhere 
> back in May. :-)
> You will find attached an updated version of the patch against 
> 2.6.18-mh4, as well as a sample test program that shows the flow 
> control stuff is really working.
>
> Major changes compared to previous versions:
> * Packets are queued in the core, and are dequeue from there.
> * Flow control is achieved using high resolution timers. This means 
> the code is really HZ independant, and things will even go better when 
> the dyntick patch which has been in the air recently will be included 
> in the mainline kernel.
> * Fixed a stupid bug that would cause packets to be sent really too 
> slowly when HZ was < 1000
> * Should work with HZ = 100, 250, 1000, ... or whatever else. I tested 
> with 250 HZ only for now.
> * Wrote a test program, "headsettest". To run this program you will 
> need an USB dongle that supports SCO, as well as a
> headset. This program records your own voice for 30 seconds, then 
> plays what it recorded in your ears for 30 seconds. Beware : Running 
> it without the flow control patch is likely to crash your box !!
> * The patch is cleaner. This is mainly due to the fact i am getting to 
> a better understanding of Linux socket layer.
>
> Random notes :
> I tryed to enable number of completed packets events for synchronous 
> connections,
> to get rid of all the timer stuff, however it didn't succeed.
> This is achieved using hcitool command while there are no active 
> connections :
>
> tannat:/home/fchevalier/tmp/linux-2.6.18-mh4-fch# hcitool cmd 0x003 
> 0X002F 0x01
> < HCI Command: ogf 0x03, ocf 0x002f, plen 1
>  01
> > HCI Event: 0x0e plen 4
>  01 2F 0C 00
> tannat:/home/fchevalier/tmp/linux-2.6.18-mh4-fch# hcitool cmd 0x003 
> 0X002E
> < HCI Command: ogf 0x03, ocf 0x002e, plen 0
> > HCI Event: 0x0e plen 5
>  01 2E 0C 00 01
>
> I tryed with 3 different USB dongles :
> * one of them did not support this feature (old CSR 1.1 dongle)
> * the two others supported the feature, however did never send any 
> completed packets events for SCO packets (Broadcom BCM2035 and ISSC).
>
> Due to this lack of working hardware i took the decision to stick with 
> timers, even though it is not the best technical choice :-(
>
> Limitations :
> For now the flow control only works with CVSD air encoding
> (ie 16 bit frames). If 8 bit frames are used, data will be sent twice 
> too fast.
>
> I am looking forward to your comments,
>
> Cheers,
>
> Fabien


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
