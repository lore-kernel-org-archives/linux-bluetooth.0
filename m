Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] TPL is not changing
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050131184526.1de2caf2.j0006@stu.matsue-ct.jp>
References: <20050130174730.3a78367f.j0006@stu.matsue-ct.jp>
	 <1107095863.24890.0.camel@pegasus>
	 <20050131184526.1de2caf2.j0006@stu.matsue-ct.jp>
Content-Type: text/plain
Message-Id: <1107176016.7902.3.camel@pegasus>
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
Date: Mon, 31 Jan 2005 13:53:36 +0100

Hi Kazuhiro,

> Thank you for your response.
> 
> My "hciconfig -a" says as follows:
> 
> hci0:   Type: PCCARD
>         BD Address: 00:90:02:05:15:79 ACL MTU: 672:8 SCO MTU: 64:0
>         UP RUNNING PSCAN ISCAN
>         RX bytes:1232 acl:0 sco:0 events:24 errors:0
>         TX bytes:361 acl:0 sco:0 commands:24 errors:0
>         Features: 0xff 0xfb 0x01 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'BlueZ (0)'
>         Class: 0x000100
>         Service Classes: Unspecified
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x8105 LMP Ver: 1.1 (0x1) LMP Subver: 0x8d40
>         Manufacturer: Ericsson Technology Licensing (0)

as Alain already mentioned, this chip lacks the support for power
control. Compare it with a CSR chip:

hci0:   Type: USB
        BD Address: 00:0B:AC:xx:xx:xx ACL MTU: 192:8 SCO MTU: 64:8
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset> 
                <timing accuracy> <role switch> <hold mode> <sniff mode> 
                <park state> <RSSI> <channel quality> <SCO link> <HV2 packets> 
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme> 
                <power control> <transparent SCO> 
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20e LMP Ver: 1.1 (0x1) LMP Subver: 0x20e
        Manufacturer: Cambridge Silicon Radio (10)

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
