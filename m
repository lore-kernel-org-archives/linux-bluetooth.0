Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Daniel Hertrich" <daniel.hertrich@gmx.de>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <31511.1143197715@www019.gmx.net>
Content-Type: text/plain; charset="us-ascii"
Subject: [Bluez-devel] "Can't connect RFCOMM socket"
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
Date: Fri, 24 Mar 2006 11:55:15 +0100 (MET)

Dear bluez developers,

with the bluez drivers I tried to make a connection from my Sharp Zaurus
SL-C3000 PDA using various BT hardware (USB and compact flash devices) to my
Nokia phone. First I thought the problem was hardware-related, hence I
bought some other hardware and tried. But since I always get the same error
message I now suspect it is the software.
Could you please give some advice where to look for the source of the
problem?

What I have:
* Linux kernel 2.4.20 on ARM machine (Sharp Zaurus)
* Bluez drivers bluez-*.ipk from http://bluez.sf.net/download/zaurus 

What I do:
* Create rfcomm device: mknod -m 666 /dev/rfcomm0 c 216 0
* Plug in BT hardware via CF or USB
* hciconfig hci0 up
--> hciconfig then shows the bdaddr of the hardware
* hcitool -i hci0 scan
--> bdaddr of surrounding BT devices are shown, so hardware seems to work
fine
* rfcomm bind /dev/rfcomm0 00:02:EE:0D:71:96 1
--> The phone asks "connect to ?" I confirm and enter the pin which is
stored in /etc/bluetooth/pin. After a few seconds:
--> Can't connecto to RFCOMM socket: Resource temporarily unavailable


Some of the hci* tools complained about a missing libsdp library.
I investigated a little in the source tree of the libraries and found a
libsdp.c file (or similar) in the libbluetooth tree, so I assumed it is safe
to use libbluetooth instead of libsdp. So I did a
ln -s /usr/lib/libbluetooth.so /usr/lib/libsdp.so.2
and then the tools stopped complaining.
Can this be the reason?
But what to do instead against the libsdp problem?

Thanks for any hint!
daniel

-- 
Dipl.-Ing. Daniel Hertrich
Reichertshofen, Germany
http://www.hermocom.com
http://www.daniel-hertrich.de

Echte DSL-Flatrate dauerhaft für 0,- Euro*!
"Feel free" mit GMX DSL! http://www.gmx.net/de/go/dsl


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
