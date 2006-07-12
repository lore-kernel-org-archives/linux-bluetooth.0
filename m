Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: William Voorhees <will.voorhees@gmail.com>
To: bluez-users@lists.sourceforge.net
Date: Tue, 11 Jul 2006 23:07:03 -0500
Message-Id: <1152677223.5330.12.camel@Godel>
Mime-Version: 1.0
Subject: [Bluez-users] Apple Wireless Keyboard
Reply-To: will.voorhees@gmail.com,
        BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello!

First I'd like to thank you very much for your continued efforts in
making Bluetooth on Linux work well. 

I've been trying to get my Logitech MX900 mouse, and Apple wireless
keyboard to be recognized on boot on my Ubununtu 6.06 system.
Unfortunately documentation for the bluez seems pretty sparse. So far
I've edited the /etc/default/bluez-utils file to contain this section:


############ HIDD
#
# To have Bluetooth mouse and keyboard support, get the
# Linux 2.6.6 patch or better from bluez.org, and set 
# HIDD_ENABLED to 1.
HIDD_ENABLED=1
HIDD_OPTIONS=" --server --search"
HIDD_OPTIONS=" -i 00:07:61:19:FA:E9 --server"
HIDD_OPTIONS=" -i 00:0A:95:44:AF:88 --server"
# to make hidd always use a particular interface, use something
# like this, substituting the bdaddr of the interface:
# HIDD_OPTIONS="-i AA:BB:CC:DD:EE:FF --server"
#
# remove '--master' if you're having trouble working with Ericsson
# T630 phones with hidd operational at the same time.

Where 00:07:61:19:FA:E9 is the address of my mouse and 00:0A:95:44:AF:88
the address of my keyboard. With this setup I am able to get the mouse
to work, but only if I run hidd --search by hand, after boot. 

I've tried enabling security mode three to pair the keyboard(I read in
the forum archives that it need it) but that didn't seem to work at all.
If anyone could provide me with any details on how to setup my keyboard
and mouse I'd really appetite it.




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
