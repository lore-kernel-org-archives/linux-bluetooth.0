Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] setup pairing?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <41F71444.4080404@coriand.com>
References: <41F5C90D.90401@coriand.com> <1106660253.8242.7.camel@pegasus>
	 <41F71444.4080404@coriand.com>
Content-Type: text/plain
Message-Id: <1106719674.28444.1.camel@pegasus>
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
Date: Wed, 26 Jan 2005 07:07:54 +0100

Hi Franz,

> thanks for your response!
> 
> #./hciconfig -a
> hci0:   Type: UART
>         BD Address: 00:60:57:01:10:AE ACL MTU: 384:80  SCO MTU: 128:80
>         UP RUNNING PSCAN ISCAN
>         RX bytes:172 acl:0 sco:0 events:17 errors:0
>         TX bytes:80 acl:0 sco:0 commands:17 errors:0
>         Features: 0xff 0xff 0x09 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy:
>         Link mode: SLAVE ACCEPT
>         Name: 'WatchPad_15'
>         Class: 0x000000
>         Service Classes: Unspecified
>         Device Class: Miscellaneous,
>         HCI Ver: 1.1 (0x1) HCI Rev: 0xbc LMP Ver: 1.1 (0x1) LMP Subver: 0xbc
>         Manufacturer: Cambridge Silicon Radio (10)
> #
> 
> Problem is now, that I don't have ./hcidump cause of memory problems on
> this watch.

I assume that this is a problem with the PIN-helper. Check your logfiles
and install hcidump. You really need it to debug this stuff.

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
