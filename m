Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20040825152515.63936.qmail@web52606.mail.yahoo.com>
From: gonzalo briceno <gonzaloother@yahoo.com>
To: bluez-users@lists.sourceforge.net
Cc: gonzaloother@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Bluez setup and Bluetooth stack and 2.6 kernel
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
Date: Wed, 25 Aug 2004 08:25:15 -0700 (PDT)

I am new to all the bluetooth stuff so I appologize if
my question is a bit basic; however, I am sure that a
thorough answer will help lots of people.  My question
regards setting up the bluez package and a
misconception regarding the bluetooth stack.

A search on my machine for 'bluez' turns up 
---------------------begin search 
[root@localhost bluez-firmware-1.0]# find / -name
bluez*
/usr/lib/pkgconfig/bluez.pc
/usr/src/bluez-firmware-1.0.tar.gz
/usr/src/bluez-hcidump-1.10.tar.gz
/usr/src/bluez-hciemu-1.0.tar.gz
/usr/src/bluez-libs-2.9.tar.gz
/usr/src/bluez-pin-0.23.tar.gz
/usr/src/bluez-utils-2.9.tar.gz
/usr/src/bluez-libs-2.9
/usr/src/bluez-libs-2.9/bluez.pc.in
/usr/src/bluez-libs-2.9/bluez.pc
/usr/src/bluez-utils-2.9
/usr/src/bluez-firmware-1.0
/usr/src/bluez-pin-0.23
/usr/src/bluez-pin-0.23/bluez-pin-gpe.glade
/usr/src/bluez-pin-0.23/bluez-pin.glade
/usr/src/bluez-pin-0.23/bluez.conf
/usr/src/bluez-pin-0.23/po/bluez-pin.pot
/home/dl/bluez-firmware-1.0.tar.gz
/home/dl/bluez-hcidump-1.10.tar.gz
/home/dl/bluez-hciemu-1.0.tar.gz
/home/dl/bluez-libs-2.9.tar.gz
/home/dl/bluez-pin-0.23.tar.gz
/home/dl/bluez-utils-2.9.tar.gz
/lib/modules/2.4.20-8/kernel/net/bluetooth/bluez.o
---------------------end search 

You will notice(on the last line) that the bluez
module is installed only for the 2.4.20-8(redhat 9)
kernel and not my 2.6.7 kernel.

So I went ahead and downloaded 
bluez-libs-2.9
bluez-utils-2.9
bluez-firmware-1.0
bluez-pin-0.23

The bluez site says that the minimum is to install
bluez-libs and bluez-utils.  I installed those and
recompiled my kernel(2.6.7).  From the listing above
you will see that the new kernel does not have the
bluez module.  The README file in the bluez-firmware
directory reads,

In order to install Bluetooth firmware you need
following software packages:
        - Linux Bluetooth protocol stack (BlueZ)

So where is this bluetooth protocol stack?  I assume
it is in either bluez-libs or bluez-utils.  In my
kernel configuration options, I do not see a Bluez
bluetooth module, the closest thing is BlueFritz. 
What option should I use and/or how do I add it to the
kernel?

Perhaps a kernel patch will do the trick.  I
downloaded kernel 2.6.8.1 from www.kernel.org and
applied patch 'patch-2.6.8-mh1.gz' from the
bluez.sourceforge.net site.  Although the patch went
just fine I can see that there are no BLUEZxyz options
like there are in the 2.4.20-8 kernel config file. 
How in the world do I add these options to my new
kernel?  I have read a lot about USB and Bluetooth to
the point that I am getting confused.  Anyone with
clear insight as to how things work or instructions on
setting up BLUEZ please respond.  Thank you in
advance.


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
