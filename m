Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] connection to Motorola V525 fails
From: Marcel Holtmann <marcel@holtmann.org>
To: Moritz Bunkus <moritz@bunkus.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040528154111.GD24083@bunkus.org>
References: <20040528154111.GD24083@bunkus.org>
Content-Type: text/plain
Message-Id: <1085766449.3321.50.camel@pegasus>
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
Date: Fri, 28 May 2004 19:47:29 +0200

Hi Moritz,

> I can't establish a working connection between my computer(s) and my
> bluetooth mobile, a Motorola V525. At [1] (sorry, only in German) a user
> has described how to get that exact combination to work properly, but it
> doesn't work for me.
> 
> So what does work? 'hcitool scan' finds my phone. 'sdptool browse
> 00:...' does list all the services on the phone, and I've found the
> channel for the OBEX transfers which is 9. But using the obextool from
> [2] fails. It does connect to the phone, and the following PIN
> verification completes successfully. Afterwards the phone asks me if the
> file transfer should be accepted, I hit 'yes' but that's it - no more
> data flows between the two devices.
> 
> Now a bit about my system and the software revisions I've used. I've
> tried with bluez-utils 2.4 through 2.7 (some of them Debian/unstable
> packages, 2.5 from souce). I've tried kernels 2.4.24, 2.6.4 and 2.6.6
> with the -mh1 patch. I've tried two different USB dongles, both are CSR
> based, but I only have one available at the moment. Here's the output of
> 'hciconfig -a' for this dongle:
> 
> hci0:   Type: USB
>         BD Address: 00:02:72:40:45:26 ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN 
>         RX bytes:4378 acl:44 sco:0 events:120 errors:0
>         TX bytes:1654 acl:48 sco:0 commands:43 errors:0
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
>         Link policy: RSWITCH HOLD SNIFF PARK 
>         Link mode: SLAVE ACCEPT 
>         Name: 'ls-bs-ws6-0'
>         Class: 0x000100
>         Service Classes: Unspecified
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver:
>         0x20d
>         Manufacturer: Cambridge Silicon Radio (10)
> 
> This is a device by Yakumo, one of the cheaper stuff sold around
> here. The other dongle was built by Acer, but I don't know its exact
> description. Both are USB dongles, obviously, and they're both
> recognized flawlessly. At the moment I don't have access to any other
> Bluetooth hardware - neither to computers with built-in Bluetooth
> support, nor to other dongles or devices.

everything is fine so far. Stay with 2.6.6-mh2.

> The remaining files are attached to this mail. The first is the
> hcid.conf which is basically the default configuration. I've also tried
> with enabling authentication and encryption, but basically I've left
> both disabled for most of the tests.

There is no need to change anything and keep auth and encrypt off,
because you don't want to set your device into security mode 3.

> The second file, 'motorola-v525-bluezutils24.dump', is the output of
> 'hcidump -t -x' during the call to 'obextool push test.jpg 00:... 9'. It
> was done with bluez-utils 2.4 (older package from Debian/unstable). The
> third is the same but with bluez-utils 2.7 (package from [3]).
> 
> I hope someone can make sense of the dumps. I can also provide an
> additional dump made by the author of [1] which shows a successful
> transfer to his Motorola V525.

Send us the binary versions of the dump (with -w and as root).

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
