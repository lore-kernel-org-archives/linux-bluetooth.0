Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: David Woodhouse <dwmw2@infradead.org>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1141396234.8699.10.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-devel] dbus pin failure
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
Date: Fri, 03 Mar 2006 14:30:34 +0000

With the current bluez-utils (2.25) and bluez-pin (0.30) packages, the
PIN helper doesn't work. When hcid requests a PIN, I get this...

6047: arguments to dbus_message_iter_get_fixed_array() were incorrect,
assertion "(subtype == DBUS_TYPE_INVALID) || dbus_type_is_fixed
(subtype)" failed in file dbus-message.c line 1743.
This is normally a bug in some application using the D-BUS library.

-- 
dwmw2



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
