Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "blookk -" <blookk@hotmail.com>
To: bluez-devel@lists.sf.net
Subject: [Bluez-devel] LAN access server
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Message-ID: <BAY1-F38wr0qxO83cIO000af2e9@hotmail.com>
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
Date: Wed, 08 Sep 2004 12:35:09 +0000



Hello:

I am trying to create a LAN access server with bluetooth.

In server side I execute:
insmod rfcomm
insmod l2cap
hcid -n &
sdpd -n &
sdptool add sp
sdptool add  lan
dund --listen --persist

In client side:
insmod rfcomm
insmod l2cap
hcid -n &
sdpd -n &
sdptool add sp
sdptool add  lan
dund --connect 00:11:22:33:44:55
dund --search

after I do these things in messages of kernel say that "connection refused"

What happend?

Regrads

_________________________________________________________________
Dale rienda suelta a tu tiempo libre. Encuentra mil ideas para exprimir tu 
ocio con MSN Entretenimiento. http://entretenimiento.msn.es/



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
