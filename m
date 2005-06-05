Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Catalin Drula <Catalin.Drula@imag.fr>
To: <bluez-devel@lists.sourceforge.net>
Message-ID: <Pine.GSO.4.33.0506051542010.28292-200000@horus.imag.fr>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-1117979476=:28292"
Subject: [Bluez-devel] [PATCH] hci_send_req: fix for EVT_CMD_STATUS
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
Date: Sun, 5 Jun 2005 15:51:16 +0200 (CEST)

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-1117979476=:28292
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

The attached patch fixes a bug in hci_send_req (bluez-libs-2.17/src/hci.c)
whereas the requests for commands that generate a "command status" event
(such as the "inquiry" command), as opposed to a "command complete" event,
would always fail.

Regards,

Catalin

--- bluez-libs-2.17/src/hci.c~	2005-05-09 20:33:24.000000000 +0200
+++ bluez-libs-2.17/src/hci.c	2005-06-05 15:30:27.000000000 +0200
@@ -770,7 +770,7 @@
 				errno = EIO;
 				goto failed;
 			}
-			break;
+			goto done;

 		case EVT_CMD_COMPLETE:
 			cc = (void *) ptr;

---559023410-851401618-1117979476=:28292
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=patch_hci_send_req
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0506051551160.28292@horus.imag.fr>
Content-Description: 
Content-Disposition: attachment; filename=patch_hci_send_req

LS0tIGJsdWV6LWxpYnMtMi4xNy9zcmMvaGNpLmN+CTIwMDUtMDUtMDkgMjA6
MzM6MjQuMDAwMDAwMDAwICswMjAwDQorKysgYmx1ZXotbGlicy0yLjE3L3Ny
Yy9oY2kuYwkyMDA1LTA2LTA1IDE1OjMwOjI3LjAwMDAwMDAwMCArMDIwMA0K
QEAgLTc3MCw3ICs3NzAsNyBAQA0KIAkJCQllcnJubyA9IEVJTzsNCiAJCQkJ
Z290byBmYWlsZWQ7DQogCQkJfQ0KLQkJCWJyZWFrOw0KKwkJCWdvdG8gZG9u
ZTsNCiANCiAJCWNhc2UgRVZUX0NNRF9DT01QTEVURToNCiAJCQljYyA9ICh2
b2lkICopIHB0cjsNCg==
---559023410-851401618-1117979476=:28292--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
