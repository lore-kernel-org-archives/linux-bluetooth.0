Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Greg Kroah-Hartman <greg@kroah.com>
In-Reply-To: <20050209063650.GU1419@us.ibm.com>
References: <20050209063650.GU1419@us.ibm.com>
Content-Type: text/plain
Message-Id: <1107971878.13863.94.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: [PATCH 50/63] bluetooth/bfusb: change parameters of
 usb_{control,bulk}_msg() to msecs
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
Date: Wed, 09 Feb 2005 18:57:58 +0100

Hi Greg,

if you apply the USB core changes for this, then this patch is fine with
me and I think you should apply them all at once.

> Description: Change units of parameters being passed to
> usb_{control,bulk}_msg() to milliseconds. Patch is compile-tested.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

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
