Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] can't establish a connection
From: Marcel Holtmann <marcel@holtmann.org>
To: ben4fun <ben_4_fun@freenet.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1091742606.6143.17.camel@localhost>
References: <1091742606.6143.17.camel@localhost>
Content-Type: text/plain
Message-Id: <1091746301.20839.60.camel@pegasus>
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
Date: Fri, 06 Aug 2004 00:51:41 +0200

Hi Ben,

> I have a bluetooth dongle (broadcom) which is recognised when I
> plugged it. I think so because kdebluetooth says that an adaptor was
> found. But I can't pair it to my mobile phone (SE T610). The dongle
> doesn't recognise any incoming connection.
> 
> I found on the mailing list archive the following command: " hciconfig
> -a" this is what I obtained. I hope it could help.
> 
> "hci0:   Type: USB
>         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
>         DOWN
>         RX bytes:0 acl:0 sco:0 events:0 errors:0
>         TX bytes:3 acl:0 sco:0 commands:1 errors:0
>         Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DH1 HV1
>         Link policy:
>         Link mode: SLAVE ACCEPT"
> 
> I maybe should say that I have a mandrake 10.0 and the kernel 2.6.3.

go on with "hciconfig hci0 up" and have fun with your dongle.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
