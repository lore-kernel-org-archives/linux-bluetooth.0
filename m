Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <474D724C.4060803@aircable.net>
Date: Wed, 28 Nov 2007 10:51:08 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
Cc: openobex-users@lists.sourceforge.net,
        BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] OpenProximity Official presentation
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Dear all,

I'm one of the developers of a company speciallized in bluetooth hardware
provider (www.aircable.net). We also make software, and have plenty
commitment
to Open Source software.

I had collaborated to both BlueZ and OpenOBEX a couple of times during the
last year, and during about the past 6 months a huge idea has been going
arround
my head.

As many might know there's a new way to do marketing using bluetooth,
which is
called proximity marketing, and lots of peoples are spending money and time
into this. I see plenty of questions at both forums asking for questions
related to this matters. So we (me and the others at the company) are
thinking
about starting a project to build the first GPL Proximity Marketing
System. So
that we can canalize all that energy and make one good solution once and
for all.

As we aren't gonna be the onlyones who are gonna get profits from using
it we
want to make an open call for others to collaborate in the project.
Everyone is
welcome to collaborate in the project. We only ask that all the code is
released under GPL license.

The idea would be to make an Open Source Proximity Marketing solution that
could run on an stand alone embedded machine. And using no more (and no
less)
than bluez, openobex and dbus. The project would also include making a web
interface so you could control the hole thing. Maybe it might be a good
idea to
make a web  interface to both BlueZ and OpenOBEX and then merge both? I
don't
know.

Anyway, we have created a google code project at [1] and a google group
[2] for
this so we don't use the mailing lists from BlueZ and Open Obex. Anyone
wanting
to join, please come by and be our guest. The more people who joins us, the
fatest we can start showing that Open Source is a perfect solution (once
again).

I had started by adding some of the code I had been working on, this
includes:
dbusObexFTP: This is a modified version of obexftp that adds a custom
transport
    so that obexftp uses dbus instead of plain hci calls. obexftpd is not
    working yet, as we can't still get a /dev/rfcomm# when acting as server.
proximityscanner: This is a piece of code that sets hcid into continuos
inquiry
    mode with no name resolution, and then prints to stdout new address as
    those are discovered. The project defines a C structure with function
    callbacks so that if you need you can resolve the name for a device.

Thank you all for reading this,
Manuel Naranjo
Wireless Cables Inc.
<manuel@aircable.net>

[1] http://code.google.com/p/proximitymarketing
[2] http://groups.google.com/group/openproximity


-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
