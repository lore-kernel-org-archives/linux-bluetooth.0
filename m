Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: David Woodhouse <dwmw2@infradead.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1084268833.11301.0.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Subject: [Bluez-devel] autoconf breaks portability. Film at 11.
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 11 May 2004 10:47:13 +0100

I cannot build libs2. The autoconf stuff is broken. The last thing it
says is this:

configure.in:19: required file `./ltmain.sh' not found

Please can we ditch this crap and use sane makefiles instead?

-- 
dwmw2



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
