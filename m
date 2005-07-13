Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050713161256.27473.qmail@web53210.mail.yahoo.com>
From: Filipa Duarte <filipa_duarte@yahoo.com>
To: BlueZ Users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] BlueZ in embedded linux
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
Date: Wed, 13 Jul 2005 09:12:55 -0700 (PDT)

Hello,

I am trying to have the bluez-utils-2.14 running on my
embedded ppc with linux 2.4.20.

Are the bluez-utils-2.14 and bluez-libs-2.15 ok to run
with a kernel 2.4.20?


I was able to cross-compile without much problems and
have enable the kernel support, however I am not able
to run the hcid.  When I type hcid -n the result is: 
hcid[479]: Bluetooth HCI daemon 
and it does not go on from this point.

If I run hciconfig hci0 up;  hciconfig -a the result
is: 
hci0:   Type: USB
        BD Address: 00:10:60:AA:B0:CC ACL MTU: 192:8
SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:2838 acl:0 sco:0 events:67 errors:0
        TX bytes:228 acl:0 sco:0 commands:66 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00
0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2
HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.1 (0x1) HCI Rev: 0x33c LMP Ver: 1.1
(0x1) LMP Subver: 0x33c
        Manufacturer: Cambridge Silicon Radio (10)

which seams ok. However I changed the hcid.conf to a
diferent Name and Class. It seams it is not reading
from the hcid.conf file but from somewhere else. 

Any idea of what is happening?

Regards,

Filipa Duarte


		
____________________________________________________
Start your day with Yahoo! - make it your home page
http://www.yahoo.com/r/hs
 


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
