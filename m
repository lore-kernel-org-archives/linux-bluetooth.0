Return-Path: <cyrus@holtmann.org>
Message-ID: <47D03C82.9060009@suse.de>
Date: Thu, 06 Mar 2008 19:48:34 +0100
From: Stefan Seyfried <seife@suse.de>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] [patch]  make apitest more useful
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This trivial 2-character patch makes apitest much more useful by allowing
stuff like "apitest -l DiscoverDevices" to work like i'd expect it to:

--- /usr/bin/apitest	2008-03-02 19:22:20.000000000 +0100
+++ /home/seife/bin/apitest.seife	2008-03-06 19:44:52.000000000 +0100
@@ -415,7 +415,7 @@ class Tester:
             self.dbus_dev_sig_setup()
             print 'Listening for events...'

-        elif self.cmd in mgr_cmds:
+        if self.cmd in mgr_cmds:
             try:
                 self.dbus_mgr_setup()
             except dbus.DBusException, e:


Now we can alias "hcitool scan" to "apitest -l DiscoverDevices" ;-)
-- =

Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg | "Well, surrounding them's out."

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG N=FCrnberg)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
