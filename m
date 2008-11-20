Return-Path: <cyrus@holtmann.org>
From: "Liu, Raymond" <raymond.liu@intel.com>
To: "vinicius.gomes@openbossa.org" <vinicius.gomes@openbossa.org>
Date: Thu, 20 Nov 2008 10:57:03 +0800
Message-ID: <0463F45F3606F4428ED35AC8C709F92E0217A025@pdsmsx502.ccr.corp.intel.com>
MIME-Version: 1.0
Cc: "bluez-devel@lists.sourceforge.net" <bluez-devel@lists.sourceforge.net>,
	"johan.hedberg@nokia.com" <johan.hedberg@nokia.com>
Subject: [Bluez-devel] could not uses introspect in obexd client for session
 or ftp from the root path.
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
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Vinicius
	
	I am trying to use the obex-client for ftp recent days.
	I found that after I call the CreateSession method. The data return by introspect method is not updated in the root path.
	Say, I can only use dbus-send --print-reply --dest=org.openobex.client /org/openobex/session0 org.freedesktop.DBus.Introspectable.Introspect to find out the ftp method.
	But dbus-send --print-reply --dest=org.openobex.client / org.freedesktop.DBus.Introspectable.Introspect will not show that there are a /org/openobex node under this path. So it might not be easy for a user to know what kind of interfaces is provided for the whole org.openobex.client service. Since they will not know what's the right node path name.
	
	I guess we can add a node, or child field, and a parent field in the generic_data structure, and update these information during the interface register operation, so that the introspect method can show the child node under a certain path?

Best Regards,
Raymond Liu


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
