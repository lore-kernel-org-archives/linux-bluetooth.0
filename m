Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Connection with
	aphonestaysopenafterclosingRFCOMM channel
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0503032110450.24841-100000@antilope>
References: <Pine.LNX.4.44.0503032110450.24841-100000@antilope>
Content-Type: text/plain
Message-Id: <1109952903.8058.72.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 04 Mar 2005 17:15:03 +0100

Hi Victor,

> And now with modules:
> 
> _before:
> 
> Module                  Size  Used by
> rfcomm                 35100  0 
> hidp                   27136  2 
> l2cap                  23044  10 rfcomm,hidp
> hci_usb                12744  2 
> bluetooth              43908  8 rfcomm,hidp,l2cap,hci_usb
> 
> _listening:
> 
> Module                  Size  Used by
> rfcomm                 35100  3 
> hidp                   27136  2 
> l2cap                  23044  10 rfcomm,hidp
> hci_usb                12744  2 
> bluetooth              43908  8 rfcomm,hidp,l2cap,hci_usb
> 
> _connected:
> 
> Module                  Size  Used by
> rfcomm                 35100  3 
> hidp                   27136  2 
> l2cap                  23044  12 rfcomm,hidp
> hci_usb                12744  3 
> bluetooth              43908  8 rfcomm,hidp,l2cap,hci_usb
> 
> _afrer:
> 
> Module                  Size  Used by
> rfcomm                 35100  1                  <---------- ?
> hidp                   27136  2 
> l2cap                  23044  12 rfcomm,hidp
> hci_usb                12744  3 
> bluetooth              43908  8 rfcomm,hidp,l2cap,hci_usb
> 
> 
> Hope that explains....

it does not explain it, but this is what I expected. Another reference
counting problem. Maybe introduced at that time I fixed another one of
these crazy problems. Funny is that this does not result in an oops. The
easiest way to fix this is, if you send me one of these phones, because
otherwise it will take quite some time to reproduce it.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
