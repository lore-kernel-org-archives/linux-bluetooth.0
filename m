Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] specific bluetooth configuration
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4201644B.5050302@ynet.sk>
References: <4201644B.5050302@ynet.sk>
Content-Type: text/plain
Message-Id: <1107387670.11944.23.camel@pegasus>
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
Date: Thu, 03 Feb 2005 00:41:10 +0100

Hi Kevin,

> In my kernel (2.6.9) are this bluetooth settings:
> CONFIG_BT=y
> CONFIG_BT_L2CAP=y
> # CONFIG_BT_SCO is not set
> # CONFIG_BT_RFCOMM is not set
> CONFIG_BT_BNEP=y
> # CONFIG_BT_BNEP_MC_FILTER is not set
> # CONFIG_BT_BNEP_PROTO_FILTER is not set
> # CONFIG_BT_HIDP is not set
> #
> # Bluetooth device drivers
> #
> CONFIG_BT_HCIUART=y
> CONFIG_BT_HCIUART_H4=y
> # CONFIG_BT_HCIUART_BCSP is not set
> # CONFIG_BT_HCIVHCI is not set
> # CONFIG_NETDEVICES is not set
> 
> My question is, if with this configuration is possible to make stable 
> bluetooth communications(f.g. with mobile phone).And if Yes, how?

only if your mobile phone supports the PAN profile and your host adapter
is using the H:4 transport protocol.

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
