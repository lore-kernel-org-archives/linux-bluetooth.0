Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Exactly how the sockets are being used in
	between the user space and kernel?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050414102914.4371.qmail@webmail17.rediffmail.com>
References: <20050414102914.4371.qmail@webmail17.rediffmail.com>
Content-Type: text/plain
Message-Id: <1113475099.8989.8.camel@pegasus>
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
Date: Thu, 14 Apr 2005 12:38:19 +0200

Hi Vaishali,

> Thanks for replying to my question.Can u please explain me how the
> socket communication is going on between the user space and kernel
> space?
> I can find out the code defining new address familiy AF_BLUETOOTH.then
> new protocols for L2CAP,HCI and RFCOMM.
> in bluez utilities i can find that in files like l2test.c the calls
> are being made to socket functions.
> But i m unable to find out exactly how the other side i mean the
> kernel handles the socket calls.
> If u can provide a sample code just expalining the socket concept i
> would be grateful to u.

this mailing list (or any other BlueZ related list) is not for educating
you in how sockets work. Get yourself a book about that topic. For
example Linux Device Drivers.

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
