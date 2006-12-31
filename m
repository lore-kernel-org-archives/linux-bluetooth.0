Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45978B84.30408@glidos.net>
Date: Sun, 31 Dec 2006 10:05:56 +0000
From: Paul Gardiner <osronline@glidos.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <20061230003939.B156CE6AD9@mx-b.vdnet.lt>
In-Reply-To: <20061230003939.B156CE6AD9@mx-b.vdnet.lt>
Subject: Re: [Bluez-users] cannot find device
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Nerijus Baliunas wrote:
> Hello,
> 
> My PDA used to find the device when I had Fedora Core 5, but cannot
> when I upgraded to FC6. hcid.conf is default from FC6 (bluez-utils-3.7-2):
 >
 >    .
 >    .
 >    .
 >
> hciconfig -a
> hci0:	Type: USB
> 	BD Address: 00:13:46:00:12:CB ACL MTU: 377:10 SCO MTU: 16:0
> 	UP RUNNING PSCAN ISCAN AUTH ENCRYPT 
> 	RX bytes:8639 acl:0 sco:0 events:249 errors:0
> 	TX bytes:5296 acl:0 sco:0 commands:202 errors:0
> 	Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
> 	Packet type: DM3 DM5 DH3 DH5 HV1 HV2 HV3 
> 	Link policy: RSWITCH HOLD SNIFF PARK 
> 	Link mode: SLAVE ACCEPT 
> 	Name: 'xxx-0'
> 	Class: 0x120104
> 	Service Classes: Networking, Object Transfer
> 	Device Class: Computer, Desktop workstation
> 	HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x309
> 	Manufacturer: Broadcom Corporation (15)
> 
> Any ideas why PDA cannot find the device? I found in mailing list archives and tried
> unsuccessfully:
> apitest SetDiscoverableTimeout 0
> apitest SetMode discoverable
> 
> "to make this work you need to set discovto to 0, because otherwise hcid
> will automatically switch you device into non-discoverable mode to
> protect you." - where do I need to set discovto to 0?

I was me having similar problems, but it looks to be with a different
cause, because hciconfig didn't list PSCAN and ISCAN in my case.

Cheers,
	Paul.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
