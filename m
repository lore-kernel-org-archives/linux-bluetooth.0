Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Richard C. Cox" <conardcox@earthlink.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] hci_usb unresolved symbols[nevermind]
References: <200505281427.28851.conardcox@earthlink.net>
In-Reply-To: <200505281427.28851.conardcox@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200505281503.56237.conardcox@earthlink.net>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 28 May 2005 15:03:55 -0400

My appologies...it was something dumb and simple I did.  I was not pre-loading 
the 'bluetooth' module before loading hci_usb.

Cheers,

Richard

On Saturday 28 May 2005 2:27 pm, Richard C. Cox wrote:
> Hello,
> 	I'm using a gentoo kernel (gentoo-sources-2.6.11-r9) and when I load the
> hci_usb module, I'm getting some unresolved symbols:
>
> May 28 14:14:26 kernel: hci_usb: Unknown symbol hci_free_dev
> May 28 14:14:26 kernel: hci_usb: Unknown symbol hci_alloc_dev
> May 28 14:14:26 kernel: hci_usb: Unknown symbol hci_unregister_dev
> May 28 14:14:26 kernel: hci_usb: Unknown symbol hci_register_dev
> May 28 14:14:26 kernel: hci_usb: Unknown symbol hci_free_dev
> May 28 14:14:26 kernel: hci_usb: Unknown symbol hci_alloc_dev
> May 28 14:14:26 kernel: hci_usb: Unknown symbol hci_unregister_dev
> May 28 14:14:26 kernel: hci_usb: Unknown symbol hci_register_dev
> May 28 14:14:26 kernel: Bluetooth: Core ver 2.7
>
> The hci_usb modules itself seems to load fine.  Google yields no answers
> for this one.  I must be doing something uniquely dumb here.
>
> Any suggestions would be appreciated.
>
> Thanks,
>
> Richard
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by Yahoo.
> Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
> Search APIs Find out how you can build Yahoo! directly into your own
> Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
