Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Heiko Wundram|Beenic <wundram@beenic.net>
To: bluez-devel@lists.sourceforge.net
Date: Wed, 4 Jul 2007 17:19:20 +0200
MIME-Version: 1.0
Message-Id: <200707041719.20662.wundram@beenic.net>
Subject: [Bluez-devel] Using BlueZ in commercial applications - Once again.
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi all!

I'm currently developing a (C++) Bluetooth (server) application under Linux=
, =

and recently noticed that the BlueZ library (-lbluetooth) is licensed under =

the GPL, at least according from the bluez-libs sources which I was scannin=
g =

for documentation (and according to quite a few mails on this list from =

others asking, but which never seem to gather enough interest to =

actually "deserve" a longer and more detailed reply than "yes, it is").

The BlueZ website documentation and FAQ pages have no single mention of =

linking (or, rather, not linking) BlueZ against commercial apps, though, =

which I gather should be put there at some update (for helpless souls like =

me... :-)).

Anyway, as my application links against -lbluetooth for SDP service =

registration (and also has source files include bluetooth/bluetooth.h and =

others for the AF_*- and similar constants to open and manage server socket=
s =

offered by the kernel modules), I don't see a big chance of keeping BlueZ a=
s =

my bluetooth stack, though, as the SDP service registration architecture =

isn't offered through the D-BUS interface yet (at least not according to th=
e =

documentation, if I understood that properly), and neither is server socket =

creation. Is this true?

Finally: is anyone feeling qualified and interested enough to properly expl=
ain =

to what extent BlueZ can and/or cannot be used in commercial (bluetooth =

server, in my case an implementation of the server-side of the OBEX File =

Transfer Profile) applications? I'm thinking of the fact that the constants =

that define Bluetooth sockets (in bluetooth/*) are specific to BlueZ and ar=
e =

GPL-marked by the file headers, but the kernel headers that define other =

Linux-specific constants have all been stripped of a license completely, =

which might, but not necessarily must mean something, as if I include a =

header file I don't link code, but only data.

Thanks in advance! I'd hate to be having to move to FreeBSD... :-)

-- =

Heiko Wundram
Product & Application Development
-------------------------------------
Office Germany - EXPO PARK HANNOVER
 =

Beenic Networks GmbH
Mail=E4nder Stra=DFe 2
30539 Hannover
 =

Fon        +49 511 / 590 935 - 15
Fax        +49 511 / 590 935 - 29
Mail       wundram@beenic.net


Beenic Networks GmbH
-------------------------------------
Sitz der Gesellschaft: Hannover
Gesch=E4ftsf=FChrer: Jorge Delgado
Registernummer: HRB 61869
Registergericht: Amtsgericht Hannover

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
