Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Tekram TM-304
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <41F0F4FE.6050703@nm.ru>
References: <41EF5879.7090005@nm.ru> <1106224337.8190.168.camel@pegasus>
	 <41F007D0.5060606@nm.ru> <1106252193.7955.7.camel@pegasus>
	 <41F0F4FE.6050703@nm.ru>
Content-Type: text/plain
Message-Id: <1106310763.7955.47.camel@pegasus>
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
Date: Fri, 21 Jan 2005 13:32:43 +0100

Hi George,

> Here we have problem, it seems like hciconfig does not see my dongle
> 
> hciconfig -a output:
> hci0:    Type: USB
>     BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
>     DOWN
>     RX bytes:0 acl:0 sco:0 events:0 errors:0
>     TX bytes:0 acl:0 sco:0 commands:0 errors:0
>     Features: 0x00 0x00 0x00 0x00
>     Packet type: DM1 DH1 HV1
>     Link policy:
>     Link mode: SLAVE ACCEPT
>  
> I think that BD Address should not consist of zeroes only ;)

the dongle is there. Did you tried to call "hciconfig hci0 up" or to
start hcid?

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
