Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: multi rfcomm/sco connection
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20041109144107.19373.qmail@webmail.aruba.it>
References: <20040727145602.30665.qmail@webmail.aruba.it>
	 <1090940808.4845.21.camel@pegasus>
	 <20041109144107.19373.qmail@webmail.aruba.it>
Content-Type: text/plain
Message-Id: <1100047927.25879.1.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 10 Nov 2004 01:52:07 +0100

Hi,

> I was looking, few months ago, for a way to solve a problem more or less 
> like your. 
> 
> All what I could do was to set the headphones to HV3 and the bt-dongle too, 
> in this mode it was possible to "listen"  audio on 3 different channels, the 
> problem, for me, was that this channels were "mixed" so if with a channel I 
> was receiving 24bit with 3 channels they were 72, but I could not find a way 
> to "demux" this caos who was coming out, but I remember I found a way to 
> "create" 3 different sco connections with just one bt-(usb)-dongle.

this sounds like a problem with the wrong alternate setting on the ISOC
interface of the USB device. Your workaround is not reliable and maybe
it is CSR specific. To get more than one SCO channel working the hci_usb
driver must be fixed to dynamicaly change the alternate settting.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
