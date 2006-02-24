Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
From: Joshua Wright <jwright@hasborg.com>
Subject: RE: [Bluez-devel] sdptool fails with ppc6700
To: <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
Message-ID: <E1FCej2-00031k-Fv@mail.sourceforge.net>
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
Date: Fri, 24 Feb 2006 10:19:07 -0500

Also try "sdptool records bdaddr"

-Josh
--
Sent from my XV6700 handheld

> Try usimg sdptool browse XX:XX:XX:XX:XX:XX --l2cap (some phones do not im=
plement Public Browse Group which is used for discovery by default) and if =
this does not help for some phones you have to ask for specific profiles to=
 get an answer (new Motorola's): sdptool search --bdaddr XX:XX:XX:XX:XX:XX =
DUN for an example.



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
