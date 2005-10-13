Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Logitech diNovo hub not recognized
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <434D4765.603@imap.cc>
References: <434C6E2E.9070105@imap.cc>
	 <1129097566.4922.1.camel@localhost.localdomain>  <434D4765.603@imap.cc>
Content-Type: multipart/mixed; boundary="=-qUvpFziLlaaXMxX/UQp3"
Message-Id: <1129195847.6543.1.camel@localhost.localdomain>
Mime-Version: 1.0
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
Date: Thu, 13 Oct 2005 11:30:47 +0200


--=-qUvpFziLlaaXMxX/UQp3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Alex,

> Thanks much for your response. I compiled and installed bluez-libs-2.21 
> and bluez-utils-2.21, removing the corresponding Fedora binary packages. 
> Unfortunately, hid2hci and hciconfig -a produced exactly the same results.
> 
> Here is the output of /proc/bus/usb/devices, with only the Logitech 
> receiver inserted:
> 
> T:  Bus=02 Lev=02 Prnt=02 Port=01 Cnt=02 Dev#=  3 Spd=1.5 MxCh= 0
> D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=046d ProdID=c50c Rev=22.40
> S:  Manufacturer=Logitech
> S:  Product=USB Receiver
> C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr= 98mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
> E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
> I:  If#= 1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=usbhid
> E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
> 
> T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh=10
> B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
> D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS= 8 #Cfgs=  1
> P:  Vendor=0000 ProdID=0000 Rev= 2.06
> S:  Manufacturer=Linux 2.6.13-1.1526_av0 ehci_hcd
> S:  Product=EHCI Host Controller
> S:  SerialNumber=0000:00:02.1
> C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms

try the attached patch. Hopefully they haven't changed the protocol.

Regards

Marcel


--=-qUvpFziLlaaXMxX/UQp3
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: hid2hci.c
===================================================================
RCS file: /cvsroot/bluez/utils/tools/hid2hci.c,v
retrieving revision 1.6
diff -u -r1.6 hid2hci.c
--- hid2hci.c	5 Jul 2005 21:15:53 -0000	1.6
+++ hid2hci.c	13 Oct 2005 09:28:09 -0000
@@ -226,6 +226,7 @@
 	{ HCI, 0x046d, 0xc703, switch_logitech },
 	{ HCI, 0x046d, 0xc704, switch_logitech },
 	{ HCI, 0x046d, 0xc705, switch_logitech },
+	{ HCI, 0x046d, 0xc50c, switch_logitech },
 	{ -1 }
 };
 

--=-qUvpFziLlaaXMxX/UQp3--



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
