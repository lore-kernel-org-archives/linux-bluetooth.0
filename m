Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Till Harbaum <harbaum@beecon.de>
To: bluez-devel@lists.sf.net
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_110MBZHtqDKSMg9"
Message-Id: <200408301753.25934.harbaum@beecon.de>
Subject: [Bluez-devel] Small bugfix for hstest
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 30 Aug 2004 17:53:25 +0200


--Boundary-00=_110MBZHtqDKSMg9
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

i have played around with hstest and some uart based hardware and found a 
problem, that only seems to happen with uart based devices:

A client may receive sco data packets that are bigger than the sco mtu. hstest 
returns packets of exactly the same size of the packets it received. If the 
packet received is bigger then the sco mtu, then packets bigger than sco mtu 
are being sent and being dropped in the kernel. As a result, no data is being 
sent at all. Instead multiple smaller sco packets should be sent.

The attached patch has to be applied to bluez-utils/test/hstest.c and fixes 
the problem inside hstest. It would as well be possible to make the kernel 
sco code detect this and fragment the payload accordingly. But imho this 
should be done in the application.

Regards,
  Till

-- 
Dr.-Ing. Till Harbaum                       Tel.:  +49 721 4998963
BeeCon GmbH                                 Fax:   +49 721 4998962
Haid-und-Neu Strasse 7, 76131 Karlsruhe     Mobil: +49 179 9087904
harbaum@beecon.de                           http://www.beecon.de

--Boundary-00=_110MBZHtqDKSMg9
Content-Type: text/x-diff;
  charset="us-ascii";
  name="hstest-uart.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="hstest-uart.patch"

--- hstest.c.old	2004-08-28 13:11:11.000000000 +0200
+++ hstest.c	2004-08-28 13:14:45.000000000 +0200
@@ -148,7 +148,7 @@
 
 	fd_set rfds;
 	struct timeval timeout;
-	unsigned char buf[2048];
+	unsigned char buf[2048], *p;
 	int maxfd, sel, rlen, wlen;
 
 	bdaddr_t local;
@@ -274,7 +274,15 @@
 					switch (mode) {
 					case PLAY:
 						rlen = read(fd, buf, rlen);
-						wlen = write(sd, buf, rlen);
+
+						wlen = 0; 
+						p = buf;
+						while(rlen > sco_mtu) {
+						        wlen += write(sd, p, sco_mtu);
+						        rlen -= sco_mtu;
+						        p += sco_mtu;
+						}
+						wlen += write(sd, p, rlen);
 						break;
 					case RECORD:
 						wlen = write(fd, buf, rlen);

--Boundary-00=_110MBZHtqDKSMg9--



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
