Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm question 1
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050129053222.47103.qmail@web60910.mail.yahoo.com>
References: <20050129053222.47103.qmail@web60910.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1107007411.10735.16.camel@pegasus>
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
Date: Sat, 29 Jan 2005 15:03:31 +0100

Hi Michael,

>     Of course, hcid is running. Then when I typed
> "hcidump -x", and then choose the computer in mobile
> phone, after I entered the PIN, the following occurs:
> [root@cm218-253-8-120 root]# hcidump -x
> HCIDump - HCI packet analyzer ver 1.16
> device: hci0 snap_len: 1028 filter: 0xffffffff
> > HCI Event: Connect Request (0x04) plen 10
>   A8 D8 DD D9 0A 00 04 02 52 01
> < HCI Command: Accept Connection Request (0x01|0x0009)
> plen 7
>   A8 D8 DD D9 0A 00 01
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 09 04
> > HCI Event: PIN Code Request (0x16) plen 6
>   A8 D8 DD D9 0A 00
> < HCI Command: PIN Code Request Reply (0x01|0x000d)
> plen 23
>   A8 D8 DD D9 0A 00 05 42 6C 75 65 5A 00 00 00 00 00
> 00 00 00
>   00 00 00
> > HCI Event: Command Complete (0x0e) plen 10
>   01 0D 04 00 A8 D8 DD D9 0A 00
> > HCI Event: Connect Complete (0x03) plen 11
>   05 29 00 A8 D8 DD D9 0A 00 01 00
> But the mobile shows "PIN not match". So how can I do?

run "hcidump -X" and you might see your PIN. I guess it is "BlueZ" and
why are you using security mode 3?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
