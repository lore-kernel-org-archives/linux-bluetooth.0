Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] HCI Event: Connect Complete with Status 09
From: Marcel Holtmann <marcel@holtmann.org>
To: Andreas Gaufer <andreas.gaufer@blue-cell-networks.com>
Cc: Bluez Devel <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040610160148.1ca400c4.Andreas.Gaufer@blue-cell-networks.com>
References: <20040609185348.65a9f382.Andreas.Gaufer@blue-cell-networks.com>
	 <40C74EDD.6060903@csr.com>
	 <20040609212529.6901de52.Andreas.Gaufer@blue-cell-networks.com>
	 <1086862843.1607.33.camel@pegasus>
	 <20040610160148.1ca400c4.Andreas.Gaufer@blue-cell-networks.com>
Content-Type: text/plain
Message-Id: <1086877940.7930.32.camel@pegasus>
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
Date: Thu, 10 Jun 2004 16:32:20 +0200

Hi Andreas,

> Same behaviour w/o CONFIG_BT_HCIUSB_SCO. I disribe it again a bit more percise:
> 
> hcitool -i hci1 cc 00:0A:D9:37:11:29
> 
> < HCI Command: Create Connection(0x01|0x0005) plen 13
>   29 11 37 D9 0A 00 18 CC 02 00 00 00 00 
> > HCI Event: Command Status(0x0f) plen 4
>   00 01 05 04 
> > HCI Event: Connect Complete(0x03) plen 11
>   00 29 00 29 11 37 D9 0A 00 01 00
> 
> hcitool con
> Connections:
>         < ACL 00:0A:D9:37:11:29 handle 41 state 1 lm MASTER 
> 
> hcitool -i hci1 cc 00:0A:D9:37:11:29
> Can't create connection: Input/output error
> 
> < HCI Command: Create Connection(0x01|0x0005) plen 13
>   29 11 37 D9 0A 00 18 CC 02 00 00 00 00 
> > HCI Event: Command Status(0x0f) plen 4
>   0B 01 05 04 
> 
> hcitool con
> Connections:
> 
> hcitool -i hci1 dc 00:0A:D9:37:11:29
> Get connection info failed: No such file or directory
> 
> hcitool -i hci1 cmd 0x01 0x0006 0x29 0x00 0x13
> < HCI Command: ogf 0x01, ocf 0x0006, plen 3
>   29 00 13 
> > HCI Event: 0x0f plen 4
>   00 01 06 04 
> 
> 
> So the entry in the list that "hcitool con" prints gets lost when
> the secound cc is issued and fails. The chip still has the handle
> and it can be disconnected with hcitoom cmd.
> 
> Im wondering witch part of the bluez Stack is maintaining the
> list and why the entry is dropped in case of a failed cc. I just
> can imagine that all acl handles are dropped that belong to that mac.
> 
> IMHO it would be great if a handle could only be removed from the 
> list if there is a successfull disconnect.

whoops, this looks really like a bug in the BlueZ stack. When the second
(in this case negative) command status arrives the stack must think of a
create connection failure and drop the connection from its internal list
without sending a disconnect. Check the hci_*.c kernel files.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
