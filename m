Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <1122889987.42edf10360b7d@webmail.versatel.nl>
From: ac_extra@zonnet.nl
To: bluez-users@lists.sourceforge.net, bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] Rfcomm data stream stalls: BT credits ???
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon,  1 Aug 2005 11:53:07 +0200

Hi everyone,

This problem has been posted before by my friend Frank Wartena. But no
solution for the problem at that moment. Maybe you can help us.

We have a problem with a bluetooth sensor when I connect it to an iPAQ 3970 
running Familiar 0.8.0 (the problem is the same with 0.8.2).

The sensor I have sends a 12 byte message at a speed of about 1 Hz using the 
serial profile over bluetooth. I created a program that connects to this 
sensor using rfcomm sockets (so no TTY interface). I constantly read from 
the socket to get the data as soon as it arrives. I use the same software 
both on a PC with Debian and on an iPAQ with Familiar 0.8.0 (for the iPAQ I 
compile it with the arm-linux-gcc tool chain version 3.3.2).

On the pc the data stream runs perfectly, the data comes in at the proper 
rate and it keeps flowing. But on the iPAQ after some time (mostly around 
100 messages, but sometimes sooner) the data just stops coming in. When 
looking at the output of hcidump nothing stranges happens, the data just 
stops... After some period (which does not seem to be constant) it sends a 
few messages and then stops again, some time later a large bulk of messages 
comes in at once (a few hundred bytes). This behaviour continues; so 
sometimes a few messages and sometimes a large bulk of data but with large 
periods between them.

I added the hcidump output of both the PC and the iPAQ. In the output of the 
iPAQ I put the following line where the data stops "[extra space added, this 
is where the data stops flowing]".
The biggest difference I see between the two logs is that once in a while 
the PC sends a message that I think gives new flow control credits:

---
ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 30
---

These messages do not seem to be sent by the iPAQ!

This are the specs of the PC:
Linux 2.6.8-1-686-smp
--
hci0:   Type: USB
        BD Address: 00:0B:AC:EB:C5:96 ACL MTU: 192:8 SCO MTU: 64:8
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20e LMP Ver: 1.1 (0x1) LMP Subver: 
0x20e
        Manufacturer: Cambridge Silicon Radio (10)
        HCI 16.4
        Chip version: BlueCore02-External
        Max key size: 128 bit
        SCO mapping:  HCI
--
bluez-utils 2.15-1
bluez-hcidump 1.17-1
libbluetooth1 2.15-2


This are the specs of the iPAQ
Linux 2.4.19-rmk6-pxa1-hh37
--
hci0:   Type: UART
        BD Address: 00:02:C7:17:EC:57 ACL MTU: 128:8 SCO MTU: 64:8
        HCI Ver: 1.1 (0x1) HCI Rev: 0x72 LMP Ver: 1.1 (0x1) LMP Subver: 0x72
        Manufacturer: Cambridge Silicon Radio (10)
        HCI 11.2
--
bluez-libs 2.4
bluez-utils-nodbus 2.14
hcidump 1.5
libbluetooth1 2.14
libopietooth1 1.1.7


Bluetooth on the iPAQ does work because when I set up a rfcomm connection 
with sockets between the pc and the ipaq and I send data manually it works 
and all data arrives immediately. I also have another sensor which sends 40 
byte messages at 10 Hz and they all arrive properly and at the right rate. 
But also in that case the iPAQ does not send the credit message indicated 
above (maybe this second sensor does not check the credits??).

Has anybody seen this behaviour before and is there a solution for it? There 
are to many differences between the iPAQ and the PC to check easily from 
which difference the problem comes (kernel version, library version, 
UART/USB, HCI firmware version, ...).

Any help is welcome!

Regards,
Arjan Claassen
Frank Wartena

-- 
_____________________________________________________________________
Nu 12 maanden gratis Live Eredivisievoetbal bij 20 Mb ADSL voor maar
EUR 39,95 per maand. Bestel op www.versatel.nl/voetbal



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
