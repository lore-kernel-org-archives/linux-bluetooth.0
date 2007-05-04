Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Daniel Gollub <dgollub@suse.de>
To: bluez-devel@lists.sourceforge.net
Date: Fri, 4 May 2007 14:31:23 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ceyOGHO8ApOUsr6"
Message-Id: <200705041431.24251.dgollub@suse.de>
Subject: [Bluez-devel] [PATCH] apitest -
	dbus.decorators.explicitly_pass_message is obsolete
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--Boundary-00=_ceyOGHO8ApOUsr6
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

apitest is broken with dbus python bindings in version 0.80.1. The  call of 
dbus.decorators.explictly_pass_message is the problem. explicity_pass_message 
got removed from the dbus python bindings:

Date:   Thu Dec 7 18:37:58 2006 +0000

    dbus/decorators: Remove explicitly_pass_message

 dbus/decorators.py |   21 +--------------------
 1 files changed, 1 insertions(+), 20 deletions(-)


Fix attachted.

best regards,
Daniel

--Boundary-00=_ceyOGHO8ApOUsr6
Content-Type: text/x-diff; charset="us-ascii";
	name="bluez-utils-3.9-apitest-dbus.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="bluez-utils-3.9-apitest-dbus.diff"

--- test/apitest
+++ test/apitest
@@ -179,7 +179,6 @@
         for cmd in dev_cmds:
             print '\t%s' % cmd
 
-    @dbus.decorators.explicitly_pass_message
     def dev_signal_handler(*args, **keywords):
         dbus_message = keywords["dbus_message"]
         print '%s - %s: ' % (dbus_message.get_member(), dbus_message.get_path()),
@@ -187,7 +186,6 @@
             print '%s   ' % arg,
         print
 
-    @dbus.decorators.explicitly_pass_message
     def mgr_signal_handler(*args, **keywords):
         dbus_message = keywords["dbus_message"]
         print '%s: ' % dbus_message.get_member()

--Boundary-00=_ceyOGHO8ApOUsr6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--Boundary-00=_ceyOGHO8ApOUsr6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_ceyOGHO8ApOUsr6--
