Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Connection dropped or cannot connect
From: Marcel Holtmann <marcel@holtmann.org>
To: rcox27@triad.rr.com
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200404101715.20122.conardcox@earthlink.net>
References: <000801c41e98$9e75d080$0100a8c0@terre>
	 <200404101642.14384.conardcox@earthlink.net>
	 <1081631352.5398.43.camel@pegasus>
	 <200404101715.20122.conardcox@earthlink.net>
Content-Type: text/plain
Message-Id: <1081632356.5398.48.camel@pegasus>
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
Date: Sat, 10 Apr 2004 23:25:56 +0200

Hi Richard,

> " Do this adapter have the same problem? Is it CSR based?"
> 
> Yes, according to the bluez hardware compatibilty list 
> (http://www.holtmann.org/linux/bluetooth/devices.html) it says:
>  
> Belkin F8T003 USB Adapter  	CSR  	1.1  	hci_usb  	working  	Nayib Kiuhan

you are kidding ;) I actually know what's in my own list, but I wanna be
sure that the entry is correct. So check with "hciconfig -a".

And "yes" means that the adapter is CSR based or that it have the same
problem.

> I'll certainly try defining that macro you listed above and see what happens.

Or you can remove these four lines:

	#ifndef CONFIG_BT_HCIUSB_ZERO_PACKET
	#undef  URB_ZERO_PACKET
	#define URB_ZERO_PACKET 0
	#endif

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
