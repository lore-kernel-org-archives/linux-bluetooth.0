Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <IJTM7X$1B27DB0B4797131F8B5DE564475869A0@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "andi.c@libero.it" <andi.c@libero.it>
To: "bluez-devel" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Help with bluez pairing problem!!
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
Date: Mon, 18 Jul 2005 13:21:33 +0200

Hi to all,

i have a problem with pairing in a scenario where a pc trie=
s to push (via obex) a file to a cell phone. I set up all my environment =
and all works fine, on my cell the PC PIN is requested and after i enter =
it the file is trasmitted and all goes fine. But i ve this kind of proble=
m:

After the first authentication i still need (for my project require=
mentes) that next pushes to the cell ask again for PIN. To do this i thin=
k i suppose i need to delete (on my cell phone side or on my pc side) the=
 authentication info. I need to do it on my pc, but how can i programmati=
cally delete a pairing entry from the link_key file ?

thansk for every=
 kind of help !

Andrea


=0A=0A=0A=0A______________________________=
______________________________=0ALibero Flat, sempre a 4 Mega a 19,95 eur=
o al mese! =0AAbbonati subito su http://www.libero.it=0A=0A



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
