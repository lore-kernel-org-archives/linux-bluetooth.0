Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <E65CD2CAB74C80498703D6EF7624BB4C0239745E@zmaex.zma.zoran.com>
References: <E65CD2CAB74C80498703D6EF7624BB4C0239745E@zmaex.zma.zoran.com>
Date: Sat, 17 Jun 2006 12:21:17 +0200
Message-Id: <1150539677.17539.13.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Rfcomm always response DM mode
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Lan,

> I have a problem with rfcomm, it will always response DM mode for other
> device connection request, the bluetooth is running, the sdpd and hcid
> are running fine, and hciconfig shows like below:
> hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:0A:3A:55:C3:4C ACL MTU: 192:8 SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:414 acl:0 sco:0 events:22 errors:0
>         TX bytes:582 acl:0 sco:0 commands:22 errors:0
>         Features: 0xff 0xff 0x0b 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'BlueZ (0)'
>         Class: 0x140680
>         Service Classes: Rendering, Object Transfer
>         Device Class: Imaging, Printer
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP
> Subver:0x20d
>         Manufacturer: Cambridge Silicon Radio (10)
> 
> And I can find to other device, set up a connection and do a file
> transfer, but I cannot run it as a service. Like I said, the rfcomm will
> always reject connection. I don't know what I am missing, it just work
> for the old version.
> 
> By the way, did I still need rfcomm packet in order to get a connection
> from rfcomm, I think it is build-in the bluez packet? Anyway, I download
> rfcomm-0.10, and follow the instruction, but got a lot of compile
> errors. I am using the 2.25 utilas and libs from bluez, and after 3.0
> come out, I try to catch your latest version, but in utils's configure,
> it says DBUS didn't reach your requirement. You requested dbus-glib-l >
> 0.35, what I have is 0.22, is there anyway to poss that?

run "hcidump -X -V" in another terminal and send in its output.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
