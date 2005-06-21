Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Fernando Capitulino <lcapitulino@conectiva.com.br>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <42B82F8E.1050506@conectiva.com.br>
References: <42B82F8E.1050506@conectiva.com.br>
Content-Type: text/plain
Message-Id: <1119372621.26772.106.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: [PATCH] - Some errno usage fixes (bluez-libs).
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
Date: Tue, 21 Jun 2005 18:50:21 +0200

Hi Luiz,

> The bluez-libs functions hci_for_each_dev(), hci_devinfo() and
> hci_inquiry() don't save the 'errno' value when an error occurs.
> This causes the value of 'errno' to be overwrinting on some kind
> of errors.
> 
> The attached patch fixes it. Note that was necessary to change
> hci_inquiry() a bit, and I've added the missing error code to 'errno'
> when a device is not found by hci_for_each_dev(), it fixes things like
> that:

thanks for the patch. A slight modified version is in the CVS now.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
