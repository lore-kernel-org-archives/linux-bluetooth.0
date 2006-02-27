Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Big rename for the D-Bus API
Message-ID: <20060227091006.GA17360@localhost.localdomain>
References: <1141022379.823.2.camel@localhost> <20060227073835.GA16640@localhost.localdomain> <1141026481.823.14.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
In-Reply-To: <1141026481.823.14.camel@localhost>
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
Date: Mon, 27 Feb 2006 11:10:06 +0200


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Marcel,

On Mon, Feb 27, 2006, Marcel Holtmann wrote:
> Did you had a chance to look at the current code inside the CVS? Besides
> two or three missing methods, everything has been implemented.

I haven't really had time to look at the new code, mostly because I have
been working with an obex server implementation lately (you'll get yet
another patch for openobex from me today or tomorrow ;)

However, I took a quick look at the code and made two small fixes to the
first issues that I found (attached). The first patch cleans up
sys.stdout.write() ugliness in dbus-test (however the change is not
tested since my python version doesn't like the
"@dbus.decorators.explicitly_pass_message" stuff).

The second patch fixes the code path where hci_open_dev fails in the
hcid_dbus_setname_complete function (othervice strncpy(name, pname,
sizeof(name) - 1)) will try to access uninitialized memory).

Johan

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dbus-test.patch"

Index: hcid/dbus-test
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-test,v
retrieving revision 1.13
diff -u -r1.13 dbus-test
--- hcid/dbus-test	26 Feb 2006 17:15:48 -0000	1.13
+++ hcid/dbus-test	27 Feb 2006 08:53:31 -0000
@@ -103,7 +103,7 @@
     def dbus_dev_setup(self):
         if not self.dev_path:
             try:
-                self.dbus_mrg_setup()
+                self.dbus_mgr_setup()
                 self.dev_path = self.manager.DefaultDevice()
             except dbus.DBusException, e:
                 print 'Failed to get default device: %s' % e
@@ -136,7 +136,7 @@
             print 'Failed to setup signal handler for manager path: %s' % e
             sys.exit(1)
 
-    def dbus_mrg_setup(self):
+    def dbus_mgr_setup(self):
         self.manager_obj = self.bus.get_object('org.bluez', '/org/bluez/Manager')
         self.manager = dbus.Interface(self.manager_obj, 'org.bluez.Manager')
 
@@ -158,28 +158,18 @@
     @dbus.decorators.explicitly_pass_message
     def dev_signal_handler(*args, **keywords):
         dbus_message = keywords["dbus_message"]
-        member = dbus_message.get_member()
-        sys.stdout.write(member) 
-        sys.stdout.write(' - ') 
-        sys.stdout.write(dbus_message.get_path())
-        sys.stdout.write(': ')
+        print '%s - %s: ' % (dbus_message.get_member(), dbus_message.get_path()),
         for arg in args[1:]:
-            sys.stdout.write(arg)
-            sys.stdout.write('   ')
-        sys.stdout.write('\n')
-        sys.stdout.flush()
+            print '%s   ' % arg,
+        print
 
     @dbus.decorators.explicitly_pass_message
     def mgr_signal_handler(*args, **keywords):
         dbus_message = keywords["dbus_message"]
-        member = dbus_message.get_member()
-        sys.stdout.write(member) 
-        sys.stdout.write(': ')
+        print '%s: ' % dbus_messsage.get_member()
         for arg in args[1:]:
-            sys.stdout.write(arg)
-            sys.stdout.write('   ')
-        sys.stdout.write('\n')
-        sys.stdout.flush()
+            print '%s   ' % arg,
+        print
 
     def signal_cb(self, sig, frame):
         print 'Caught signal, exiting'
@@ -346,7 +336,7 @@
             print 'Listening for events...'
         elif self.cmd in mgr_cmds:
             try:
-                self.dbus_mrg_setup()
+                self.dbus_mgr_setup()
             except dbus.DBusException, e:
                 print 'Failed to setup manager interface: %s' % e
                 sys.exit(1)

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dbus-name.patch"

Index: hcid/dbus.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.c,v
retrieving revision 1.78
diff -u -r1.78 dbus.c
--- hcid/dbus.c	26 Feb 2006 16:24:07 -0000	1.78
+++ hcid/dbus.c	27 Feb 2006 08:53:32 -0000
@@ -1078,7 +1078,7 @@
 	dd = hci_open_dev(id);
 	if (dd < 0) {
 		syslog(LOG_ERR, "HCI device open failed: hci%d", id);
-		memset(&rq, 0, sizeof(rq));
+		memset(&rp, 0, sizeof(rp));
 	} else {
 		memset(&rq, 0, sizeof(rq));
 		rq.ogf    = OGF_HOST_CTL;

--gBBFr7Ir9EOA20Yy--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
