Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Richard Cox <conardcox@earthlink.net>
Reply-To: rcox27@triad.rr.com
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Connection dropped or cannot connect (Solved!!!!!!)
References: <000801c41e98$9e75d080$0100a8c0@terre> <200404101715.20122.conardcox@earthlink.net> <1081632356.5398.48.camel@pegasus>
In-Reply-To: <1081632356.5398.48.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200404111138.50546.conardcox@earthlink.net>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 11 Apr 2004 11:38:50 -0400

On Saturday 10 April 2004 05:25 pm, Marcel Holtmann wrote:
> Hi Richard,
>
> > " Do this adapter have the same problem? Is it CSR based?"
> >
> > Yes, according to the bluez hardware compatibilty list
> > (http://www.holtmann.org/linux/bluetooth/devices.html) it says:
> >
> > Belkin F8T003 USB Adapter  	CSR  	1.1  	hci_usb  	working  	Nayib Kiuhan
>
> you are kidding ;) I actually know what's in my own list, but I wanna be
> sure that the entry is correct. So check with "hciconfig -a".
>
> And "yes" means that the adapter is CSR based or that it have the same
> problem.
>
> > I'll certainly try defining that macro you listed above and see what
> > happens.
>
> Or you can remove these four lines:
>
> 	#ifndef CONFIG_BT_HCIUSB_ZERO_PACKET
> 	#undef  URB_ZERO_PACKET
> 	#define URB_ZERO_PACKET 0
> 	#endif
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

Marcel,

	First, let me thank you for your patience with my questions!  Now, for the 
readers of this list, I'll let you know the secret to fixing this problem, at 
least for my setup:

	I downloaded the kernel patch from your website (patch-2.4.25-mh3.gz), saved 
by .config, did a 'make mrproper', restored the .config, rebuilt the kernel, 
rebooted and... and that fixed my problems.  I run a Gentoo system with a 
'vanilla' 2.4.25 kernel, so the patch for the toplevel Makefile failed, but 
that didn't matter since it only affected the 'EXTRAVERSION' macro, which the 
vanilla kernel does not set.  

	Since I applied that patch and rebuilt the kernel, I've been surfing the web, 
listening to streaming media on my iPaq, etc for the past hour without a 
single disconnect!  Outstanding!  Before I patched, I couldn't do anything 
like this for more than 5 minutes before I would get the error that required 
removal of the usb dongle.  Anyone experiencing this particular problem 
should try that patch out before giving up.  

Best Wishes

Richard


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
