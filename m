Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: Connection issue with headset
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <41FE4744.5010804@tootai.net>
References: <41FA06A5.3010904@tootai.net> <ctdn6n$sqs$1@sea.gmane.org>
	 <41FE4744.5010804@tootai.net>
Content-Type: text/plain
Message-Id: <1107183514.7902.13.camel@pegasus>
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
Date: Mon, 31 Jan 2005 15:58:34 +0100

Hi Daniel,

> I check further and still I can't get it work. If I do a hcitool scan no
> device is found. But the info command is working:
> 
> nomade:/etc/bluetooth# hcitool info 00:0b:2e:06:01:2e
> Requesting information ...
>         BD Address:  00:0b:2e:06:01:2e
>         Device Name: BT1000
>         LMP Version: 1.1 (0x1) LMP Subversion: 0x405
>         Manufacturer: Transilica, Inc. (24)
>         Features: 0xff 0xf9 0x31 0x00 0x00 0x00 0x00 0x00
>                 <3-slot packets> <5-slot packets> <encryption> <slot offset>
>                 <timing accuracy> <role switch> <hold mode> <sniff mode>
>                 <park state> <SCO link> <HV2 packets> <HV3 packets>
>                 <u-law log> <A-law log> <CVSD>

what is in /proc/bus/usb/devices? I think that this dongle don't has the
needed USB ISOC endpoints for SCO data.

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
