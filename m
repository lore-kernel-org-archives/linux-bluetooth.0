Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42DDFDD4.7050204@soft.uni-linz.ac.at>
From: Simon Vogl <vogl@soft.uni-linz.ac.at>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=UTF-8; format=flowed
Subject: [Bluez-devel] zeevo module and h4 implementation
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
Date: Wed, 20 Jul 2005 09:31:32 +0200

Hi,
I have a Zeevo module here with a firmware that is not fully compliant
to the BT specification, as it seems: The module sends hci command packet=
s(!)
over the uart, which of course confuses the stack, and blocks further com=
munication.

Details: It seems like the module has the PIN stored on-device and sends
the link_key_failed command to the host as an indication for an unsuccess=
ful
pairing attempt.

Besides me looking for a different firmware, are there any objections to =
extend
the h4 module with command packet reading support? And what should I do w=
ith them
afterwards besides ignoring - would hcid be interested in this informatio=
n, or
a d-bus interface?

cheers
Simon

--=20
_______________________________________________________________________
Dr. Simon Vogl
ARC Seibersdorf research GmbH
Research Studios Austria, Studio Pervasive Computing Applications
Altenberger Stra=C3=9Fe 69, A-4040 Linz, Austria

Tel: +43 732 2468-8517, Fax: +43 732 2468-8426
mailto: simon.vogl@researchstudio.at



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
