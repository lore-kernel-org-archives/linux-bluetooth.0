Return-Path: <cyrus@holtmann.org>
From: "Christian Hoene" <hoene@uni-tuebingen.de>
To: <bluez-devel@lists.sourceforge.net>, <ekiga-devel-list@gnome.org>
Date: Wed, 29 Oct 2008 12:02:29 +0100
Message-ID: <003001c939b5$d685da50$83918ef0$@de>
MIME-Version: 1.0
Subject: [Bluez-devel] Common file "sbc.c" in Ekiga/Opal and Bluez
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
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello,

I just want to hint to the fact that the file in "sbc.c" containing the
Bluetooth audio codec appears twice in the repository of Ekiga/Opal =

> svn co https://opalvoip.svn.sourceforge.net/svnroot/opalvoip/opal/trunk
opal/plugins/audio/SBC/sbc.c
and as file "bluez/sbc/sbc.c" in
git://git.kernel.org/pub/scm/bluetooth/bluez.git.

Maybe, somebody has an idea to keep both versions in sync if one is
changing? Or is it not necessary?

Best regards,

 Christian


--------------------------------------------------------
Dr.-Ing. Christian Hoene
Computer Networks and Internet, University of T=FCbingen
Sand 13, 72076 T=FCbingen, Germany, Phone +49 7071 2970532
http://net.informatik.uni-tuebingen.de/~hoene




-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
