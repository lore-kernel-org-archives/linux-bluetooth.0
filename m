Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] timeout after rfcomm or pan connection
From: Marcel Holtmann <marcel@holtmann.org>
To: Christoph Torens <c.torens@web.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <opr4lpzclieocfdv@debian>
References: <opr4lpzclieocfdv@debian>
Content-Type: text/plain
Message-Id: <1078877392.30990.7.camel@pegasus>
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
Date: Wed, 10 Mar 2004 01:09:52 +0100

Hi Christoph,

> I want to use bluetooth to get a communication between two PC's.
> I have a "normal" PC with debian woody, and backports of Kernel 2.4.24 und  
> the bluez package.
> The Second PC is an embedded PC104 with Kernel 2.4.19 called "Viper" and  
> the with it shipped bluez package
> I have also two Acer 510 USB - Bluetooth Dongles

try to use the latest 2.4 or 2.6 kernel on both machines.

> What does works is this:
> With hcitool scan the devices find each other.
> l2ping works fine in both directions.
> I can set up an rfcomm conection by typing
> on Debian:
> debian:~# rfcomm -i hci0 listen /dev/rfcomm0 5
> Waiting for connection on channel 5
> Connection from 00:04:3E:C0:8B:30 to /dev/rfcomm0
> Press CTRL-C for hangup
> 
> on Viper:
> rfcomm -i hci0 connect /dev/rfcomm0 00:04:3e:c0:9d:79 5
> Connected /dev/rfcomm0 to 00:04:3E:C0:9D:79 on channel 5
> Press CTRL-C for hangup
> 
> The Problem:
> now if i press CTRL-C on the Viper it says the connection is closed, but  
> debian still says "press CTRL-C to hangup".
> And the hci0 device somehow gets crashed, because after the establishment  
> of the connection I get timeot on hci0 as it shows the following output:
> 
> root@viper root# hciconfig -a
> hci0:   Type: USB
>          BD Address: 00:04:3E:C0:8B:30 ACL MTU: 1356:5  SCO MTU: 48:1
>          UP RUNNING PSCAN ISCAN
>          RX bytes:1800 acl:37 sco:0 events:70 errors:0
>          TX bytes:1475 acl:39 sco:0 commands:27 errors:0
>          Features: 0xff 0x07 0x04 0x00
>          Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1
>          Link policy: HOLD SNIFF PARK
>          Link mode: SLAVE ACCEPT
> Can't read local name on hci0. Connection timed out(110)
> root@viper root# hciconfig hci0 down
> root@viper root# hciconfig hci0 up
> Can't init device hci0. Connection timed out(110)
> root@viper root#

Show us "hciconfig -a" before your system "crashes". I think this Acer
dongles uses the Zeevo chip.

> Additionaly I tried to set up a PAN connection instead of rfcomm. I think  
> this would be my favourite way for communication. This way I can use  
> /write a normal socket Programm for a communication, can't I?

You can write a socket program to communicate over L2CAP, RFCOMM or with
TCP/IP over BNEP. You have to choose ;)

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
