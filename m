Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] D-Link DBT-120
From: Marcel Holtmann <marcel@holtmann.org>
To: Gene Imes <ebi7@ozob.net>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1078518584.11763.2.camel@tr1a.ozob.net>
References: <1078322158.11523.83.camel@go2>
	 <1078322721.2787.86.camel@pegasus>  <1078339075.8547.2.camel@go2>
	 <1078487569.2762.56.camel@pegasus>
	 <1078493466.27893.11.camel@tr1a.ozob.net> <1078503094.3700.5.camel@pegasus>
	 <1078518584.11763.2.camel@tr1a.ozob.net>
Content-Type: text/plain
Message-Id: <1078525247.19852.29.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 05 Mar 2004 23:20:48 +0100

Hi Gene,

> > what kind of USB host controller driver do you use? What do lspci say?
> 
> Hope this helps.
> 
> #
> # USB Host Controller Drivers
> #
> CONFIG_USB_EHCI_HCD=y
> # CONFIG_USB_EHCI_SPLIT_ISO is not set
> # CONFIG_USB_OHCI_HCD is not set
> CONFIG_USB_UHCI_HCD=y

Alan Stern is working on a better UHCI support that could explain it and
there was a unlink-while-submit patch for the OHCI driver I use. Please
check the latest 2.6.4-bk kernel and if it you still have a problem on
unplug post it to the USB mailing list, so some of the patches from the
-mm branch are forwarded for inclusion.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
