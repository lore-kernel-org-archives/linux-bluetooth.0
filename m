Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] packet types / speed (USB dongles)?
From: Marcel Holtmann <marcel@holtmann.org>
To: Lutz Pressler <Lutz.Pressler@SerNet.DE>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <E1BTRbh-0005QP-00@intern.SerNet.DE>
References: <E1BTRbh-0005QP-00@intern.SerNet.DE>
Content-Type: text/plain
Message-Id: <1085691569.8896.59.camel@pegasus>
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
Date: Thu, 27 May 2004 22:59:29 +0200

Hi Lutz,

> > every CSR based that I have seen so far supports every packet type from
> > the Bluetooth 1.1 specification. However you can set the used packet
> > types by yourself, but this makes no sense. Simply enable them all and
> > let the link manager decide what's the best to use. The HVx packets for
> > SCO audio links and don't matter for the data transfers over ACL.
> Is it normal than that file transfer with obexftp to the phone is
> not faster than 1 MB per minute?

I never did any bandwith tests with OBEX, but actually the flow of
L2CAP<->RFCOMM<->OBEX gives you a big performance decrease of the 1 Mbit
bandwith of a piconet. But this must not be a problem of the dongle,
because both link managers must decide to use the correct packet type.
And of course the phone CPU must be fast enough to handle the RFCOMM and
OBEX protocol very well. There are more bottlenecks so this question is
not really easy to answer.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
