Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 1 Dec 2008 09:41:54 +0800
Message-ID: <BD8ED0C257AAA247BB6C9A92879522C10D9C0DEE@CNSCNEVS01.ap.sony.com>
From: "WanYan, Uranus" <Uranus.WanYan@sony.com.cn>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] StartDiscovery doesn't exist
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

Hello Every Developer;

	I am appreciating for your answer my question about "What's the
API different between inadapter-api.txt and dbus-api.txt in
bluez-utils-3.36.tar.gz".
	
	Now I develop application with Bluez 4.x. But something happens
abnormally. 
When I call function StartDiscovery over python-dbus, the system raise a
error:

File "/usr/lib/python2.5/site-packages/dbus/connection.py", line 607, in
call_blocking message, timeout)
dbus.exceptions.DBusException: org.freedesktop.DBus.Error.UnknownMethod:
Method "StartDiscovery" with signature "" on interface
"org.bluez.Adapter" doesn't exist

But the SetProperty, GetProperty are all right(These functions all come
from bluez4.x/doc/adapter-api.txt ).

	So I think maybe there are some librarys or other things version
too old.
	
	OS version:	Suse linux 11, 2.6.25.5-1.1-pae
	Daemon name: 	hcid
	
	So what's the problem? (Need I change the daemon hcid to
bluetoothd? If I need, how to do)

Thank you very much!

Uranus

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
