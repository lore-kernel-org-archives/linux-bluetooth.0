Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41991724.2000906@patbert.com>
From: Patrick <patbert@patbert.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Key bouncing
References: <1099916465.3186.21.camel@saag>
In-Reply-To: <1099916465.3186.21.camel@saag>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 15 Nov 2004 15:52:52 -0500

I was just about to ask about this same issue. I don't recall when it 
started but certain key combinations give the undesired effect.

Trying to type "cd " too quickly always comes out "cdd c" for example.

I have a D-Link adaptor as well.

What do you mean by HID mode?

Edd Dumbill wrote:
> Hi,
> 
> I've noticed that if typing quickly on my Apple Bluetooth keyboard I
> often get additional keypresses. For instance, 'mode' comes out as
> 'moddeo' sometimes.  This only affects me when my DLink dongle is in HCI
> mode -- I get no issues when in HID mode.  I've seen this in kernels
> 2.6.9 and 2.6.10-rc1.
> 
> % hidd --show
> 00:50:F2:E2:A4:B1 HID Boot Device [045e:007c] connected [boot-protocol]
> 00:0A:95:39:0F:9E HID Boot Device [05ac:0209] connected [boot-protocol]
> 
> % hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:0F:3D:38:D3:A8 ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:118698 acl:7768 sco:0 events:201 errors:0
>         TX bytes:1309 acl:42 sco:0 commands:20 errors:0
>         Features: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'saag-0'
>         Class: 0x100100
>         Service Classes: Object Transfer
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.2 (0x2) HCI Rev: 0x4d9 LMP Ver: 1.2 (0x2) LMP Subver:
> 0x4d9
>         Manufacturer: Cambridge Silicon Radio (10)
> 
> 
> -- Edd
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Sybase ASE Linux Express Edition - download now for FREE
> LinuxWorld Reader's Choice Award Winner for best database on Linux.
> http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
