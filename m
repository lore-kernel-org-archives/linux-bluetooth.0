Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] l2cap.c fails on compile
From: Marcel Holtmann <marcel@holtmann.org>
To: David Krapohl <david.krapohl@halifax.rwth-aachen.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200410311038.10680.david.krapohl@halifax.rwth-aachen.de>
References: <200410311038.10680.david.krapohl@halifax.rwth-aachen.de>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1099215756.16247.33.camel@pegasus>
Mime-Version: 1.0
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
Date: Sun, 31 Oct 2004 10:42:36 +0100

Hi David,

> Can anybody confirm, that the latest bluetooth patch fails on compile?
> I get this error message with patch-2.6.9-mh3 and vanilla-sources:
>=20
>   CC [M]  net/bluetooth/l2cap.o
> net/bluetooth/l2cap.c: In function `__l2cap_sock_close':
> net/bluetooth/l2cap.c:77: nicht implementiert: =BBinline=AB beim Aufruf=
 von=20
> =BBl2cap_get_ident=AB gescheitert: function body not available
> net/bluetooth/l2cap.c:284: nicht implementiert: von hier aufgerufen
> net/bluetooth/l2cap.c:78: nicht implementiert: =BBinline=AB beim Aufruf=
 von=20
> =BBl2cap_send_req=AB gescheitert: function body not available
> net/bluetooth/l2cap.c:291: nicht implementiert: von hier aufgerufen
> make[2]: *** [net/bluetooth/l2cap.o] Fehler 1
> make[1]: *** [net/bluetooth] Fehler 2
> make: *** [net] Fehler 2

what compiler do you used?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
