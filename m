Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4215A788.9070205@yahoo-inc.com>
From: "Vegard B. Havdal" <vegardh@yahoo-inc.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Am stuck; HP laptop, Fedora
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
Date: Fri, 18 Feb 2005 09:30:00 +0100


Hello, I've spent some time getting BT to work on my HP NC6000 laptop, 
now looking for any clues. To put it shortly, I think I have everything 
installed right, but when I for instance fire up gnome-obex-send, it 
will hang when I scan for devices.

More detail:

I have FC2 with the 2.6.9-1.11_FC2 kernel. I got the latest bluez-libs 
and bluez-utils compiled fine:

-rw-r--r--  1 root root 55116 Feb 17 22:17 /usr/lib/libbluetooth.a
-rwxr-xr-x  1 root root   835 Feb 17 22:17 /usr/lib/libbluetooth.la
lrwxrwxrwx  1 root root    22 Feb 17 22:17 /usr/lib/libbluetooth.so -> 
libbluetooth.so.1.0.15
lrwxrwxrwx  1 root root    22 Feb 17 22:17 /usr/lib/libbluetooth.so.1 -> 
libbluetooth.so.1.0.15
-rwxr-xr-x  1 root root 59773 Feb 17 22:17 /usr/lib/libbluetooth.so.1.0.15
[vegardh@dhcp-244 vegardh]$

The kernel module is the one that was in the kernel in the first place, 
I haven't compiled that:

author:         Maxim Krasnyansky <maxk@qualcomm.com>, Marcel Holtmann 
<marcel@holtmann.org>
description:    Bluetooth Core ver 2.6
version:        2.6 21CCA1EA2920D6252535138
license:        GPL
alias:          net-pf-31
vermagic:       2.6.9-1.11_FC2 686 REGPARM 4KSTACKS gcc-3.3
depends:

And the device itself is on the USB:

T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=049f ProdID=0086 Rev= 8.02
S:  Manufacturer=ACTIONTEC
S:  Product=Bluetooth by hp

The BT works from Windows.

With obex_test I get this, can't get more debug or something from it:

[vegardh@dhcp-244 vegardh]$ obex_test -b
Using Bluetooth RFCOMM transport
OBEX Interactive test client/server.
 > s
Server register error! (Bluetooth)

I'd appreciate any clues, either from someone with experience with this 
laptop and linux, or if I've overlooked something.

Vegard


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
