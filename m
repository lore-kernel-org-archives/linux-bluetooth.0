Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Suspend/resume issues with bluez
From: Nils Faerber <nils.faerber@kernelconcepts.de>
To: Mitsu Hadeishi <mitsu@syntheticzero.com>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <200403091754.52270.mitsu@syntheticzero.com>
References: <200403022202.19259.mitsu@syntheticzero.com>
	 <200403032224.08229.bluez-devel@cpinkney.org.uk>
	 <200403091754.52270.mitsu@syntheticzero.com>
Content-Type: text/plain
Message-Id: <1078918707.26239.129.camel@localhost>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 10 Mar 2004 12:38:27 +0100

Am Di, den 09.03.2004 schrieb Mitsu Hadeishi um 23:54:
> Hi,
Hi!

> Just a note to the list regarding suspend/resume.  I have a Thinkpad T40p 
> which was having problems with bluez and suspend/resume.  I just tried 
> installing the Affix drivers on my Thinkpad T40p; but I had the same problem 
> (well, it was slightly different, but the upshot was, Bluetooth didn't work 
> when I came back from suspend).
> 
> So I tried a suggestion written by someone else on this list, which was not 
> only to unload all of the Bluetooth modules, but also unload and reload the 
> USB modules.  This DID work, at least with the Affix drivers.  Perhaps the 
> same trick would work with the bluez drivers.

>>From my experience simply unloading the USB host controller driver
should be fully sufficient!
What happens is that the host controller is first removed. With removing
the host all devices disappear and are freed automatically.
When the system comes back simply insmod the host controller driver
again. The host will come back up and all devices are discovered as new
devices and will be initialised properly.

It may be though that you have to wait a moment after removing the host
controller driver module, like "sleep 1" before going to sleep. The 2.4.
kernel still has some problems to identify in some circumstances if all
pre-suspend actions have been performed properly.

On Debian I do on suspend

	/etc/hotplug/usb.rc stop
	sleep 1

and of course the inverse on resume

	/etc/hotplug/usb.rc start

without sleeping.

Works really good and also prevents some other nasty USB problems.

> Mitsu
CU
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          D1 : +49-170-2729106
--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
