Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: David Krapohl <david.krapohl@halifax.rwth-aachen.de>
To: bluez-devel@lists.sourceforge.net
Message-id: <200410311038.10680.david.krapohl@halifax.rwth-aachen.de>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-15
Subject: [Bluez-devel] l2cap.c fails on compile
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
Date: Sun, 31 Oct 2004 10:38:10 +0100

Can anybody confirm, that the latest bluetooth patch fails on compile?
I get this error message with patch-2.6.9-mh3 and vanilla-sources:

  CC [M]  net/bluetooth/l2cap.o
net/bluetooth/l2cap.c: In function `__l2cap_sock_close':
net/bluetooth/l2cap.c:77: nicht implementiert: =BBinline=AB beim Aufruf von=
=20
=BBl2cap_get_ident=AB gescheitert: function body not available
net/bluetooth/l2cap.c:284: nicht implementiert: von hier aufgerufen
net/bluetooth/l2cap.c:78: nicht implementiert: =BBinline=AB beim Aufruf von=
=20
=BBl2cap_send_req=AB gescheitert: function body not available
net/bluetooth/l2cap.c:291: nicht implementiert: von hier aufgerufen
make[2]: *** [net/bluetooth/l2cap.o] Fehler 1
make[1]: *** [net/bluetooth] Fehler 2
make: *** [net] Fehler 2

david



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
