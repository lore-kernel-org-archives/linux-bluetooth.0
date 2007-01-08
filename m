Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Daniel Gollub <dgollub@suse.de>
To: bluez-devel@lists.sourceforge.net
Date: Tue, 9 Jan 2007 00:41:53 +0100
References: <200701081837.04388.dgollub@suse.de>
	<20070108184701.GA12689@jh-mbp>
In-Reply-To: <20070108184701.GA12689@jh-mbp>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_CbtoFSINfhoQR6C"
Message-Id: <200701090041.54299.dgollub@suse.de>
Subject: Re: [Bluez-devel] Should hcid wait for dbus daemon?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--Boundary-00=_CbtoFSINfhoQR6C
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 08 January 2007 19:47, Johan Hedberg wrote:
> Sounds like a useful feature. It should be quite simple to implement too
> since most of the required code already exists due to the dbus restart
> detection support. Feel free to provide a patch for it :)
How often should the daemons try to connect? Or infinitely?
If not infinitely, then configurable by command line parameter or fixed?

Attachted is a _simple_ proof of concept patch which . It retries every 5 
seconds. After #12 unsuccessfully dbus connect, it gives up and abort (as 
before).

Daniel

--Boundary-00=_CbtoFSINfhoQR6C
Content-Type: text/x-diff; charset="iso-8859-1";
	name="bluez-utils-dbus-retry.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bluez-utils-dbus-retry.diff"

Index: common/dbus.c
===================================================================
RCS file: /cvsroot/bluez/utils/common/dbus.c,v
retrieving revision 1.2
diff -u -p -r1.2 dbus.c
--- common/dbus.c	13 Nov 2006 07:58:40 -0000	1.2
+++ common/dbus.c	8 Jan 2007 22:52:18 -0000
@@ -39,6 +39,7 @@
 #include "list.h"
 
 #define DISPATCH_TIMEOUT	0
+#define MAX_DBUS_RETRY		12
 
 static int name_listener_initialized = 0;
 
@@ -485,13 +486,27 @@ static void dispatch_status_cb(DBusConne
 
 DBusConnection *init_dbus(const char *name, void (*disconnect_cb)(void *), void *user_data)
 {
+	int retry = 0;
 	struct disconnect_data *dc_data;
 	DBusConnection *conn;
 	DBusError err;
 
 	dbus_error_init(&err);
 
-	conn = dbus_bus_get(DBUS_BUS_SYSTEM, &err);
+	do {
+		if (dbus_error_is_set(&err))
+			dbus_error_free(&err);
+
+		conn = dbus_bus_get(DBUS_BUS_SYSTEM, &err);
+		if (conn)
+			break;
+
+		if (!retry)
+			info("Can't connect to DBUS. Will retry %i times.", MAX_DBUS_RETRY);
+
+		usleep(5000000);
+		retry++;
+	} while (!conn && retry < MAX_DBUS_RETRY);
 
 	if (dbus_error_is_set(&err)) {
 		error("Can't connect to system message bus: %s", err.message);

--Boundary-00=_CbtoFSINfhoQR6C
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_CbtoFSINfhoQR6C
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_CbtoFSINfhoQR6C--
