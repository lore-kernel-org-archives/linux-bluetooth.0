Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <IAM1IW$205B23707D0A369DE13B2731D4A79F3F@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "andi.c@libero.it" <andi.c@libero.it>
To: "bluez-devel" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] PAND error: Function not implemented(38)
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
Date: Thu, 20 Jan 2005 11:08:56 +0100

Hi to all,
making a pan connection on my linux box gives me the error:=0D
=

pand[3093]: Bluetooth PAN daemon version 2.13
pand[3093]: Connecting t=
o 00:10:60:A7:48:84
pand[3093]: Connect to 00:10:60:A7:48:84 failed. Fun=
ction not implemented(38)

All the modules are loaded (bnep included) ,=
 and all other hci operations work.
Even bnep connection can be created =
using the same host as slave with
pand -listen.

any suggestion ?=0A=0A=
=0A=0A____________________________________________________________=0A6X v=
elocizzare la tua navigazione a 56k? 6X Web Accelerator di Libero!=0AScar=
icalo su INTERNET GRATIS 6X http://www.libero.it=0A



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
