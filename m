Return-Path: <cyrus@holtmann.org>
From: "Christian Hoene" <hoene@uni-tuebingen.de>
To: <bluez-devel@lists.sourceforge.net>
Date: Mon, 27 Oct 2008 10:54:27 +0100
Message-ID: <001501c9381a$022b7f40$06827dc0$@de>
MIME-Version: 1.0
Cc: 'Frans de Bont' <frans.de.bont@philips.com>
Subject: [Bluez-devel] Bad encoding performance of Linux SBC audio codec
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

I have made some extensive study on the compression performance of Linux's
SBC audio codec in comparison to the reference implementation.

I am sorry to say that the audio quality of the open source version of SBC
is far worse than the reference implementation.

Can anybody confirm these results?
Do you have any idea why the performance is so worse?

With best regards,

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
