Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: hci_usb question
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <pan.2005.01.21.01.42.29.140990@yahoo.com>
References: <pan.2005.01.21.01.14.47.519771@yahoo.com>
	 <pan.2005.01.21.01.42.29.140990@yahoo.com>
Content-Type: text/plain
Message-Id: <1106310120.7955.45.camel@pegasus>
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
Date: Fri, 21 Jan 2005 13:22:00 +0100

Hi Paul,

> > Also hci_usb creates 3 USB interfaces for my BT dongle. What are these 3
> > USB interfaces for ?
> > 
> 
> I just looked in the specs and some other places and found it:
> 
> One bluetooth bulk endpoint
> One bluetooth isochronous endpoint
> One firmware upgrade endpoint
> 
> And it seems that hci_usb only claims bluetooth USB Wireless Controller
> class E0, and firmware upgrade which is USB class FE is left unclaimed.
> 
> So, if hic_usb would claim also USB class FE, then it would not appear as
> red in usbview.

ask the author of usbview or check its source code. I don't know what
red means.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
