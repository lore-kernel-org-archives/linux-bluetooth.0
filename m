Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] timeout after rfcomm or pan connection
From: Marcel Holtmann <marcel@holtmann.org>
To: Christoph Torens <c.torens@web.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <opr4wj0bjgeocfdv@debian>
References: <20040309161702.24407.qmail@web40713.mail.yahoo.com>
	 <opr4mgbutyeocfdv@debian> <1078882388.30990.24.camel@pegasus>
	 <opr4wj0bjgeocfdv@debian>
Content-Type: text/plain
Message-Id: <1079358305.3405.32.camel@pegasus>
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
Date: Mon, 15 Mar 2004 14:45:05 +0100

Hi Christoph,

> it's been a few days since my last mail, hope you remeber some facts from  
> it.
> I managed to get one Acer 500 BT-Dongle with CSR chipset.
> I also upgraded to Kernel 2.4.21
> this is the latest kernel i can get from the vendor
> (this is "arcom" if anyone knows them
> the embedded pc is a: "Viper Embedded Linux Development Kit")

ask them if they use big or little endian with their Xscale. Show us the
Bluetooth specific parts of the kernel config.

> and now I have the following situation:
> 
> root@viper root# hciconfig -a
> hci0:   Type: USB
>          BD Address: 00:60:57:0C:88:1A ACL MTU: 192:8  SCO MTU: 64:8
>          UP RUNNING PSCAN ISCAN
>          RX bytes:1810 acl:0 sco:0 events:17 errors:0
>          TX bytes:299 acl:0 sco:0 commands:13 errors:0
>          Features: 0xff 0xff 0x0b 0x00
>          Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>          Link policy: HOLD SNIFF PARK
>          Link mode: SLAVE ACCEPT
>          Name: 'BlueZ (0) on viper'
>          Class: 0x000100
>          Service Classes: Unspecified
>          Device Class: Computer, Uncategorized
>          HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1) LMP Subver:  
> 0x175
>          Manufacturer: Cambridge Silicon Radio (10)
> 
> root@viper root# pand --search -Q 20 --service NAP -n
> pand[315]: PAN daemon ver 1.1
> pand[315]: Inquiring
> pand[315]: Searching for NAP on 00:04:3E:C0:9D:79
> pand[315]: Connecting to 00:04:3E:C0:9D:79
> pand[315]: bnep0 connected
> root@viper root# hciconfig -a
> hci0:   Type: USB
>          BD Address: 00:60:57:0C:88:1A ACL MTU: 192:8  SCO MTU: 64:8
>          UP RUNNING PSCAN ISCAN
>          RX bytes:2380 acl:9 sco:0 events:37 errors:0
>          TX bytes:495 acl:9 sco:0 commands:19 errors:0
>          Features: 0xff 0xff 0x0b 0x00
>          Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>          Link policy: HOLD SNIFF PARK
>          Link mode: SLAVE ACCEPT
>          Name: 'BlueZ (0) on viper'
>          Class: 0x000100
>          Service Classes: Unspecified
>          Device Class: Computer, Uncategorized
>          HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1) LMP Subver:  
> 0x175
>          Manufacturer: Cambridge Silicon Radio (10)
> 
> root@viper root# ifconfig -a
> bnep0     Link encap:Ethernet  HWaddr 00:60:57:0C:88:1A
>            BROADCAST MULTICAST  MTU:1500  Metric:1
>            RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>            TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>            collisions:0 txqueuelen:100
>            RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
> 
> eth0      Link encap:Ethernet  HWaddr 00:80:66:10:04:40
>            inet addr:192.168.0.50  Bcast:192.168.0.255  Mask:255.255.255.0
>            UP BROADCAST NOTRAILERS RUNNING MULTICAST  MTU:1500  Metric:1
>            RX packets:312 errors:1 dropped:0 overruns:1 frame:0
>            TX packets:642 errors:0 dropped:0 overruns:0 carrier:0
>            collisions:0 txqueuelen:100
>            RX bytes:37644 (36.7 KiB)  TX bytes:316263 (308.8 KiB)
>            Interrupt:1 Base address:0x9300
> 
> lo        Link encap:Local Loopback
>            inet addr:127.0.0.1  Mask:255.0.0.0
>            UP LOOPBACK RUNNING  MTU:16436  Metric:1
>            RX packets:8 errors:0 dropped:0 overruns:0 frame:0
>            TX packets:8 errors:0 dropped:0 overruns:0 carrier:0
>            collisions:0 txqueuelen:0
>            RX bytes:560 (560.0 B)  TX bytes:560 (560.0 B)
> 
> root@viper root# ifconfig bnep0 10.0.0.2
> root@viper root# hciconfig -a
> hci0:   Type: USB
>          BD Address: 00:60:57:0C:88:1A ACL MTU: 192:8  SCO MTU: 64:8
>          UP RUNNING PSCAN ISCAN
>          RX bytes:2657 acl:9 sco:0 events:40 errors:0
>          TX bytes:564 acl:12 sco:0 commands:22 errors:0
>          Features: 0xff 0xff 0x0b 0x00
>          Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>          Link policy: HOLD SNIFF PARK
>          Link mode: SLAVE ACCEPT
> Can't read local name on hci0. Connection timed out(110)
> root@viper root#

Run "hcidump -x" to see what is on the ACL link.

> ###
> 
> as you can see... I get the bnep connection and the interface bnep0.
> i try to set an ip adress and ...the hci device crashes.
> 
> any ideas?
> 
> ifconfig works on the other side at my debian-PC.
> 
> i have binary packages of bluez-libs provided by arcom
> bluez-pan is not provided by arcom, so i had to cross-compile bluez-libs,  
> bluez-sdp and finally bluez-pan

The userspace programs should not be involved, because after the bnep0
device shows up everything is handled by the kernel. Looks like a Xscale
specific bug.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
