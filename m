Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Can anybody help plz?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050405114604.26990.qmail@webmail18.rediffmail.com>
References: <20050405114604.26990.qmail@webmail18.rediffmail.com>
Content-Type: text/plain
Message-Id: <1112714081.12406.45.camel@notepaq>
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
Date: Tue, 05 Apr 2005 17:14:41 +0200

Hi,

> I have a small problem in understanding the blueZ source code for
> kernel 2.6.11.I am unable to find out exactly how the kernel
> implementations of the l2cap layer,hcilayer and rfcomm layer are
> interacting amongst themselves ?As well as how they interact with the
> user space libraries?
> 
> I have seen some functions in l2cap.c calling functions from
> hci_core.c which have been put as EXPORT_SYMBOL() in hci_core.c.
> Is it the way they are communicating or am i missing something?

the module interaction is done by the exported symbols as you already
realized. The upper layer modules like RFCOMM, BNEP etc. are using the
L2CAP socket interface inside the kernel. All userspace tools are using
the ioctls and the socket interfaces.

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
