Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Message-ID: <pan.2005.01.21.01.42.29.140990@yahoo.com>
References: <pan.2005.01.21.01.14.47.519771@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] Re: hci_usb question
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
Date: Fri, 21 Jan 2005 03:42:30 +0200

On Fri, 21 Jan 2005 03:14:48 +0200, Paul Ionescu wrote:

> Also hci_usb creates 3 USB interfaces for my BT dongle. What are these 3
> USB interfaces for ?
> 

I just looked in the specs and some other places and found it:

One bluetooth bulk endpoint
One bluetooth isochronous endpoint
One firmware upgrade endpoint

And it seems that hci_usb only claims bluetooth USB Wireless Controller
class E0, and firmware upgrade which is USB class FE is left unclaimed.

So, if hic_usb would claim also USB class FE, then it would not appear as
red in usbview.

Thanks,
Paul




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
