Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] LAN access server
From: Marcel Holtmann <marcel@holtmann.org>
To: blookk - <blookk@hotmail.com>
Cc: bluez-devel@lists.sf.net
In-Reply-To: <BAY1-F38wr0qxO83cIO000af2e9@hotmail.com>
References: <BAY1-F38wr0qxO83cIO000af2e9@hotmail.com>
Content-Type: text/plain
Message-Id: <1094652818.5289.1.camel@notepaq>
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
Date: Wed, 08 Sep 2004 16:13:38 +0200

Hi,

> I am trying to create a LAN access server with bluetooth.
> 
> In server side I execute:
> insmod rfcomm
> insmod l2cap
> hcid -n &
> sdpd -n &
> sdptool add sp
> sdptool add  lan
> dund --listen --persist
> 
> In client side:
> insmod rfcomm
> insmod l2cap
> hcid -n &
> sdpd -n &
> sdptool add sp
> sdptool add  lan
> dund --connect 00:11:22:33:44:55
> dund --search
> 
> after I do these things in messages of kernel say that "connection refused"
> 
> What happend?

you haven't checked the mailing list archive, because I already wrote
sometimes that "sdptool add ..." is not necessary when using dund.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
