Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <I7DHVT$D2922A36BDAB2F92C5ECCB522F102031@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "andi.c@libero.it" <andi.c@libero.it>
To: "bluez-devel" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] help!! how re-compile bluetooth module ?
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
Date: Thu, 18 Nov 2004 12:43:05 +0100

Hello,
i am using BlueZ 2.7 and i am in need to make some
little change=
s to kernel module "bluetooth".
I suppose this module is compiled from t=
he set
of file stored in /linux/net/bluetooth, which 
containsa the fol=
lowing:

af_bluetooth.c
bnep
 cmtp
hci_conn.c
 hci_core.c
 hci_eve=
nt.c
 hci_sysfs.c
hidp
Kconfig
 l2cap.c
54 lib.c
Makefile
 rfcomm=0D
=
 sco.c

can someone tell me one compile a new module ?
thanks!
=0A=0A=
=0A=0A____________________________________________________________=0ALibe=
ro ADSL: navighi gratis a 1.2 Mega, senza canone e costi di attivazione. =
=0AAbbonati subito su http://www.libero.it =0A



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
