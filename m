Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] trying to send data at HCI level
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050225082547.84269.qmail@web26603.mail.ukl.yahoo.com>
References: <20050225082547.84269.qmail@web26603.mail.ukl.yahoo.com>
Content-Type: text/plain
Message-Id: <1109322208.7872.10.camel@notepaq>
Mime-Version: 1.0
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
Date: Fri, 25 Feb 2005 10:03:27 +0100

Hi Benny,

> I was trying to send HCI command i define all the
> debug tools of buetooth.ko.
> Therfore I create AF_Bluetooth socket family.
> My data isn't received by my dongle.
> 
> for debuging I was searching for the command read()
> from socket in the hci_sock.c side.
> But I didn't find it. 
> I think that it's hci_sock_sendmsg() wich forward my
> HCI command to hci_usb.ko.
> 
> but how bluetooth.ko layer catch my HCI command?

I have no idea what you are doing, but the HCI raw socket allows you to
send any command you like. Look at the library source code for more
information.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
