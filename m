Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: "Christoph Torens" <c.torens@web.de>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
MIME-Version: 1.0
Message-ID: <opr4lpzclieocfdv@debian>
Subject: [Bluez-users] timeout after rfcomm or pan connection
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
Date: Tue, 09 Mar 2004 16:43:50 +0100

Hi,

I want to use bluetooth to get a communication between two PC's.
I have a "normal" PC with debian woody, and backports of Kernel 2.4.24 und  
the bluez package.
The Second PC is an embedded PC104 with Kernel 2.4.19 called "Viper" and  
the with it shipped bluez package
I have also two Acer 510 USB - Bluetooth Dongles

What does works is this:
With hcitool scan the devices find each other.
l2ping works fine in both directions.
I can set up an rfcomm conection by typing
on Debian:
debian:~# rfcomm -i hci0 listen /dev/rfcomm0 5
Waiting for connection on channel 5
Connection from 00:04:3E:C0:8B:30 to /dev/rfcomm0
Press CTRL-C for hangup

on Viper:
rfcomm -i hci0 connect /dev/rfcomm0 00:04:3e:c0:9d:79 5
Connected /dev/rfcomm0 to 00:04:3E:C0:9D:79 on channel 5
Press CTRL-C for hangup

The Problem:
now if i press CTRL-C on the Viper it says the connection is closed, but  
debian still says "press CTRL-C to hangup".
And the hci0 device somehow gets crashed, because after the establishment  
of the connection I get timeot on hci0 as it shows the following output:

root@viper root# hciconfig -a
hci0:   Type: USB
         BD Address: 00:04:3E:C0:8B:30 ACL MTU: 1356:5  SCO MTU: 48:1
         UP RUNNING PSCAN ISCAN
         RX bytes:1800 acl:37 sco:0 events:70 errors:0
         TX bytes:1475 acl:39 sco:0 commands:27 errors:0
         Features: 0xff 0x07 0x04 0x00
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1
         Link policy: HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
Can't read local name on hci0. Connection timed out(110)
root@viper root# hciconfig hci0 down
root@viper root# hciconfig hci0 up
Can't init device hci0. Connection timed out(110)
root@viper root#

The hci0 device on debian keeps working.

Additionaly I tried to set up a PAN connection instead of rfcomm. I think  
this would be my favourite way for communication. This way I can use  
/write a normal socket Programm for a communication, can't I?
I type:
debian:~# pand -s -r NAP -M
and
root@viper root# pand -c 00:04:3e:c0:9d:79 --service NAP

I also get the bnep0 devices and can configure them with ifconfig
ping <localip> works, but trying to ping the remote ip i get an error in  
"dmesg":
hci_acl_tx_to: hci0 ACL tx timeout
hci_acl_tx_to: hci0 killing stalled ACL connection 00:04:3e:c0:9d:79

I get this error on both sides. and after this on both sides the hci0  
device is somehow down in the above mentioned way:
I get timeouts trying to "hciconfig -a" and "hciconfig hci0 up"

any ideas?
would appreciate any help. I'm pretty desperate...

Oh, and even if the rfcomm connection _would_ work. I didn't know how to  
use it.
How can I communicate over this? does minicom work? how? or how else can i  
use this?

-- 
MfG,
Christoph Torens


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
