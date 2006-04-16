Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <a3b1b800604160901k6e86614bueceba1bcd5466d5d@mail.gmail.com>
From: "Jan Benes" <jbenes@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] sdp_connect and co, timing
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
Date: Sun, 16 Apr 2006 18:01:54 +0200

hello,
I'm trying ot write an application that scans for devices, asks for
name and services and eventually sends some files/data. I'm running in
threads. I've already discovered that I must use exclusive access to
the dongle during connection-time. I also don't do any connecting
while asking for services or scanning for devices. Still, sometimes,
the sdp_connect fails to connect for some time. Also, rarely, the
inquiry fails. Is it possible that there needs to be some time gap
between such requests? Do scanning/asking for
services/connectiong/sending cause "collisions"?

PS: also, what are the possible responses from a sdp_connect (or the
respective socket functinos from the function itself. I can't find
them anywhere)

thanks, Jan


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
