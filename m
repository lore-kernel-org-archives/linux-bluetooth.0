Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: "Heiko Wundram (Beenic)" <wundram@beenic.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Thu, 5 Jul 2007 11:35:23 +0200
References: <200707041719.20662.wundram@beenic.net>
	<200707051108.32230.wundram@beenic.net>
	<Pine.LNX.4.63.0707051114450.25165@redbean.intranet.gw-instruments.de>
In-Reply-To: <Pine.LNX.4.63.0707051114450.25165@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
Message-Id: <200707051135.23459.wundram@beenic.net>
Subject: Re: [Bluez-devel]
	=?iso-8859-1?q?Using_BlueZ_in_commercial_applicatio?=
	=?iso-8859-1?q?ns_-_Once=09again=2E?=
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

Am Donnerstag 05 Juli 2007 um 11:20:31 schrieb Peter Wippich:
> This is not fully true. You need soem glue layer which needs to be GPL or
> LGPL. Check http://www.tomtom.com/page.php?Page=3Dgpl for examples.
>
> And I think you agree that the Tom Tom Navigation systems are commercial
> products.

Totally true, and that's why I asked about the D-BUS interface because that=
 is =

(supposedly, as it's LGPL-licensed) a glue layer which would work for my ca=
se =

(without me having to implement the glue code).

But generally, this means that in case the available glue layers don't fit =
my =

need, I will have to write a glue layer between my commercial application a=
nd =

BlueZ, which not only costs resources and time but also makes the applicati=
on =

more complex (and error-prone, because of blown code size and the need for =

IPC, as wrapping BlueZ in another library would defeat the purpose of the =

GPL-circumventing glue code), which is generally not acceptable for the =

small- to medium-scale fully integrated solution we're currently working on.

And, most importantly, we don't have a team of programmers like TomTom does=
 to =

develop this glue.

Anyway, I respect the licensing decision on the BlueZ developers part fully=
, =

which is not what I'm trying to debate about. But, as I said, as long as =

there is no fully functional glue code which works out of the box with =

commercial applications - the socket-API being one form of such glue code =

(but because that requires a GPL'd header to actually function, think of =

AF_BLUETOOTH defined only in bluetooth/bluetooth.h, it's out of the =

question) - BlueZ is simply unusable for our current needs, and I guess qui=
te =

a lot of other commercial Bluetooth developers would feel the same.

Anyway, thanks you two for taking the time to answer me.

-- =

Heiko Wundram
Product & Application Development
-------------------------------------
Office Germany - EXPO PARK HANNOVER
=A0
Beenic Networks GmbH
Mail=E4nder Stra=DFe 2
30539 Hannover
=A0
Fon =A0 =A0 =A0 =A0+49 511 / 590 935 - 15
Fax =A0 =A0 =A0 =A0+49 511 / 590 935 - 29
Mail =A0 =A0 =A0 wundram@beenic.net


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
