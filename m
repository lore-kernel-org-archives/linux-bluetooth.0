Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluepin bash script with immediate pin response
From: Marcel Holtmann <marcel@holtmann.org>
To: Burkhard Fischer <b.fi2@web.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <400E5E94.6030104@web.de>
References: <400D599B.3070004@web.de> <1074648240.7088.30.camel@pegasus>
	 <400E5E94.6030104@web.de>
Content-Type: text/plain
Message-Id: <1074693437.7088.85.camel@pegasus>
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
Date: Wed, 21 Jan 2004 14:57:17 +0100

Hi Burkhard,

> here some more informations and the attached hci dump
> 
> /bin/bluepin:
> 
> #!/bin/bash
> #sleep 1
> echo "PIN:6bkgLuRqDpSIYZgP"
> 
> command:
> 
> magito:/etc/bluetooth# ciptool connect 00:04:0E:84:06:CA
> Can't connect L2CAP socket: Connection refused

	> HCI Event: Link Key Request(0x17) plen 6
	  CA 06 84 0E 04 00 
	< HCI Command: Link Key Request Negative Reply(0x01|0x000c) plen 6
	  CA 06 84 0E 04 00 
	> HCI Event: PIN Code Request(0x16) plen 6
	  CA 06 84 0E 04 00 
	> ACL data: handle 0x0000 flags 0x02 dlen 16
	    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 4 status 0
	< HCI Command: PIN Code Request Reply(0x01|0x000d) plen 23
	  CA 06 84 0E 04 00 10 36 62 6B 67 4C 75 52 71 44 70 53 49 59 
	  5A 67 50 
	> HCI Event: Disconn Complete(0x05) plen 4
	  00 00 00 13 

the problem seems to be the AP itself, because l2cap_conn_rsp with
result code 4 means "Connection refused - no resources available". Try
to update the firmware of your AP.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
