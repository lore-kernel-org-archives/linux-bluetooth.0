Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hci_acl_tx_to: hci0 ACL tx timeout
From: Marcel Holtmann <marcel@holtmann.org>
To: James Cameron <james.cameron@hp.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040630130948.GJ30504@hp.com>
References: <20040630112137.GE30504@hp.com>
	 <1088595657.4540.19.camel@pegasus> <20040630120249.GH30504@hp.com>
	 <1088599419.4540.24.camel@pegasus>  <20040630130948.GJ30504@hp.com>
Content-Type: text/plain
Message-Id: <1088601709.4540.28.camel@pegasus>
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
Date: Wed, 30 Jun 2004 15:21:49 +0200

Hi James,

> > I really think this is buggy hardware in the USB dongle or in the USB
> > host controller. Maybe it is also only a software problem and related to
> > the USB subsystem. I don't know.
> 
> Well, tell me what to try to determine where the cause is.  Surely it
> should be possible to instrument the kernel functions to gather more
> information about the problem?  Then we can say "yes, it's the
> hardware", or something else.

you can try to change the number of max bulk urb's to have 2 on rx and 2
on tx. May this helps (drivers/bluetooth/hci_usb.c).

Or disable CONFIG_BT_HCIUSB_SCO so no USB bandwith is consumed for ISOC
transfers.

> > If it is CSR based you can try "hciconfig hci0 revision".
> 
> hci0:   Type: USB
>         BD Address: 00:02:72:01:E5:FF ACL MTU: 192:8  SCO MTU: 64:8
>         HCI 16.4
>         Chip version: BlueCore02
>         Max key size: 56 bit
>         SCO mapping:  HCI
> 
> Does that help?  (any good?)

This chip should actually work fine.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
