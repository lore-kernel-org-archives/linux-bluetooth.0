Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: wim delvaux <wim.delvaux@adaptiveplanet.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Problems with multiple PANUs connecting via the same Bluetooth USB dongle
References: <1079743635953.samitius.70713.-NzbxEEFNkxHlpJ_X9rCCw@luukku.com>
In-Reply-To: <1079743635953.samitius.70713.-NzbxEEFNkxHlpJ_X9rCCw@luukku.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200403200326.32008.wim.delvaux@adaptiveplanet.com>
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
Date: Sat, 20 Mar 2004 03:26:31 +0100

On Saturday 20 March 2004 01:47, Sami Nikkarinen wrote:
I think I have read somewhere that multiple PAN connectoins depend on the=20
device.  Some devices support it some don't

W

> Hi,
>
> I have faced a small problem while trying to connect multiple PANUs via t=
he
> same Bluetooth dongle. Actually the problem doesn't exist with all
> Bluetooth dongles I have been using, since e.g. SCM Bluetooth Zio USB
> dongle can handle multiple PAN connections without any problems.
>
> But when I'm using e.g. MSI Bluetooth PC2PC USB dongle, the PAN connection
> to the first device is successfully established, but the second device
> can't connect to it (although it has been found during the discovery
> procedure). The attempt is just rejected, but I can't find any information
> regarding this attempt from /var/log/messages file or output of hcidump.
>
> I'm having exactly the same settings and configurations with both dongles,
> so I would guess that the problem must be dongle-specific.
>
> This is the output of 'hciconfig -a' command while using the SCM's dongle:
>
> hci0:	Type: USB
> 	BD Address: 00:10:60:A4:9D:4B ACL MTU: 192:8  SCO MTU: 64:8
> 	UP RUNNING PSCAN ISCAN
> 	RX bytes:4448065 acl:39552 sco:0 events:41899 errors:0
> 	TX bytes:4337261 acl:42250 sco:0 commands:88 errors:0
> 	Features: 0xff 0xff 0x0f 0x00
> 	Packet type: DM1 DH1 HV1
> 	Link policy: HOLD SNIFF PARK
> 	Link mode: ACCEPT MASTER
> 	Name: 'ABU BlueZ (0)'
> 	Class: 0x000100
> 	Service Classes: Unspecified
> 	Device Class: Computer, Uncategorized
> 	HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
> 	Manufacturer: Cambridge Silicon Radio (10)
>
> And this is the output of 'hciconfig -a' command while using the MSI's
> dongle:
>
> hci0:	Type: USB
> 	BD Address: 00:10:DC:AF:92:AE ACL MTU: 192:8  SCO MTU: 64:8
> 	UP RUNNING PSCAN ISCAN
> 	RX bytes:760026 acl:6813 sco:0 events:6982 errors:0
> 	TX bytes:686512 acl:6945 sco:0 commands:28 errors:0
> 	Features: 0xff 0xff 0x0f 0x00
> 	Packet type: DM1 DH1 HV1
> 	Link policy: HOLD SNIFF PARK
> 	Link mode: ACCEPT MASTER
> 	Name: 'ABU BlueZ (0)'
> 	Class: 0x000100
> 	Service Classes: Unspecified
> 	Device Class: Computer, Uncategorized
> 	HCI Ver: 1.1 (0x1) HCI Rev: 0x1e7 LMP Ver: 1.1 (0x1) LMP Subver: 0x1e7
> 	Manufacturer: Cambridge Silicon Radio (10)
>
> The only difference I can spot here is the HCI Revision and LMP Subversion
> fields, but can these explain the different performance of the dongles? Or
> is the reason somewhere else? At least it shouldn't be in any way related
> to the PAN profile, since the problems seem to exist in much lower level =
of
> Bluetooth.
>
> Regards, Sami
>
> ..............................................................
>  MTV3 Laajakaista - Hauskemman el=E4m=E4n puolesta.
>  http://www.mtv3.fi/liittyma/hankinta/laajakaista/
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=3DClick
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
