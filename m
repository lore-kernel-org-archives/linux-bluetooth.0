Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] connecting to a serial dongle with a PIN
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <86oec12tkz.fsf@coulee.tdb.com>
References: <86oec12tkz.fsf@coulee.tdb.com>
Content-Type: text/plain
Message-Id: <1114547055.10706.333.camel@pegasus>
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
Date: Tue, 26 Apr 2005 22:24:15 +0200

Hi Russell,

> Could someone please explain to me how I connect from a USB bluetooth
> dongle to a bluetooth serial dongle that uses a PIN.  I try this:
> 
>   # l2ping 00:0B:CE:00:7A:8F
>   Can't connect: Permission denied
> 
> A simultaneous hcidump shows:
> 
>   # hcidump -V
>   HCI sniffer - Bluetooth packet analyzer ver 1.17
>   device: hci0 snap_len: 1028 filter: 0xffffffff
>   < HCI Command: Create Connection (0x01|0x0005) plen 13
>   > HCI Event: Command Status (0x0f) plen 4
>       Create Connection (0x01|0x0005) status 0x00 ncmd 1
>   > HCI Event: PIN Code Request (0x16) plen 6
>   < HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
>   > HCI Event: Command Complete (0x0e) plen 10
>       PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
>   > HCI Event: Connect Complete (0x03) plen 11
>       status 0x18 handle 41 bdaddr 00:0B:CE:00:7A:8F type ACL encrypt 0x00
>       Error: Unknown LMP PDU

it seems that the PIN helper program can't be executed. Look at the
mailing list archives for help in this case.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
