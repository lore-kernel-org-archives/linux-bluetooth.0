Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: RE: [Bluez-users] Problems connecting to multiple rfcomm sockets
From: Marcel Holtmann <marcel@holtmann.org>
To: Steve Drew <steve.drew@empics.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <0DD4EA5DCF754A409C4E182C758C37F38205@tigris.i.empics.co.uk>
References: <0DD4EA5DCF754A409C4E182C758C37F38205@tigris.i.empics.co.uk>
Content-Type: text/plain
Message-Id: <1098895505.6730.10.camel@pegasus>
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
Date: Wed, 27 Oct 2004 18:45:05 +0200

Hi Steve,

> At This point running hcitool con shows the following connections 
> 
> Connections:
>         < ACL 00:02:EE:82:D9:29 handle 44 state 1 lm MASTER ENCRYPT
>         < ACL 00:0E:6D:1A:9A:3F handle 41 state 1 lm MASTER ENCRYPT
> 
> Running hcidump -x gives the output attached in hcidump.txt (hcidump is
> running from just before the 3rd connection is called, and until after
> the error (Host is down) is reported). 

the error is a page timeout and you can try to put your other devices
into hold mode before trying to connect the third. Another option is to
increase the page timeout or simple update the firmware to a HCI 18.x
version.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
