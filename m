Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] IBM Thinkpad A31p and Bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: jvp@lateapex.net
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200309130515.h8D5FHU06171@localhost.lateapex.net>
References: <200309130515.h8D5FHU06171@localhost.lateapex.net>
Content-Type: text/plain
Message-Id: <1063448359.28891.397.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 13 Sep 2003 12:19:14 +0200

Hi Jason,

> > No Bluetooth device attached to the USB bus. You have to switch it on ;)
> 
> I found the tiny button just now, after staring straight at it for the last
> couple of days.  Duh.
> 
> laptop# hciconfig -a
> hci0:   Type: USB 
>         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
>         DOWN 
>         RX bytes:0 acl:0 sco:0 events:0 errors:0
>         TX bytes:0 acl:0 sco:0 commands:0 errors:0
>         Features: 0x00 0x00 0x00 0x00
>         Packet type: DM1 DH1 HV1 
>         Link policy: 
>         Link mode: SLAVE ACCEPT 

send me the output of "hciconfig -a" after you brought this device up
and I can add the information to my list.

Regards

Marcel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
