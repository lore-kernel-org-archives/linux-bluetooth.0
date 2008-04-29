Return-Path: <cyrus@holtmann.org>
From: Valmantas <walmis@gmail.com>
To: Bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-WAm4OQJnEhksR5qUvcbN"
Date: Tue, 29 Apr 2008 23:42:39 +0300
Message-Id: <1209501760.14773.13.camel@ubuntu>
Mime-Version: 1.0
Subject: [Bluez-devel] bluetoothd-service-network fails to execute ifup
	scripts from	network.conf after repeated connection attempts
	(Patched)
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


--=-WAm4OQJnEhksR5qUvcbN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After connecting to a server ﻿once, the relevent scripts in network.conf
are executed, and pan* and bnep* interfaces come up, but when you
disconnect and
reconnect the second time, neither the script gets executed, nor the
interface comes up and this makes the connection unusable. (You would
have to manually bring it up with "ifconfig bnep0 up" )

Also PANU role script does not get executed, ever, on incoming
connections, fixed in patch.

Example:
i have /etc/bluetooth/network.conf

[General]

[PANU Role]
Script=/usr/bin/my-ifup

[GN Role]
Script=/usr/bin/my-ifup

[NAP Role]
Script=/usr/bin/my-ifup

Connection 1 ( server pan0 (GN) )
 my-ifup gets executed with pan0 argument

Disconnect / Connect 2 ( server pan0 (GN) )
 No execution

Correct behaviour:
Connection 1 ( server pan0 (GN) )
 my-ifup gets executed with pan0 argument
 my-ifup gets executed with bnep0 argument

Disconnect / Connect 2 ( server pan0 (GN) )
 my-ifup gets executed with bnep0 argument

Disconnect / Connect 3 ( server pan0 (GN) )
 my-ifup gets executed with bnep0 argument


--=-WAm4OQJnEhksR5qUvcbN
Content-Disposition: attachment; filename=008_ifup_script_execution_fix.patch
Content-Type: text/x-patch; name=008_ifup_script_execution_fix.patch;
	charset=UTF-8
Content-Transfer-Encoding: 7bit

--- network/server.c.orig	2008-02-10 21:38:30.000000000 +0200
+++ network/server.c	2008-04-29 22:39:37.000000000 +0300
@@ -344,7 +344,7 @@
 			goto failed;
 		}
 
-		bnep_if_up(devname, 0);
+		bnep_if_up(devname, ns->id);
 	} else
 		bnep_if_up(devname, ns->id);
 
--- network/common.c.orig	2008-02-02 01:16:33.000000000 +0200
+++ network/common.c	2008-04-29 23:27:07.000000000 +0300
@@ -81,13 +81,34 @@
 	return strcmp(data->devname, devname);
 }
 
-static void script_exited(GPid pid, gint status, gpointer data)
+static gint find_devname_by_pid(gconstpointer a, gconstpointer b)
 {
+	struct bnep_data *data = (struct bnep_data *) a;
+	const GPid* pid= (GPid*)b;
+
+	if(data->pid == *pid) return 0;
+	if(data->pid > *pid) return 1;
+	if(data->pid < *pid) return -1;
+}
+
+static void script_exited(GPid pid, gint status, gpointer data)
+{	
+	struct bnep_data *bnep;
+	
 	if (WIFEXITED(status))
 		debug("%d exited with status %d", pid, WEXITSTATUS(status));
 	else
 		debug("%d was killed by signal %d", pid, WTERMSIG(status));
-
+		
+	
+	GSList* l = g_slist_find_custom(pids, &pid, find_devname_by_pid);
+	
+	bnep = l->data;
+	
+	info("Resetting PID - %s %d", bnep->devname, bnep->pid);
+	
+	bnep->pid = 0;
+	
 	g_spawn_close_pid(pid);
 }
 
@@ -231,24 +252,27 @@
 	struct bnep_data *bnep;
 	GSpawnFlags flags;
 	GSList *l;
-
+	
 	/* Check if a script is running */
-	if ((l = g_slist_find_custom(pids, devname, find_devname))) {
+	
+	l = g_slist_find_custom(pids, devname, find_devname);
+	if ( l != NULL ) {
 		bnep = l->data;
-
-		if (bnep->script && !strcmp(bnep->script, "avahi-autoipd")) {
-			argv[0] = bnep->script;
-			argv[1] = devname;
-			argv[2] = "--refresh";
-			argv[3] = NULL;
-
-			flags = G_SPAWN_DO_NOT_REAP_CHILD | G_SPAWN_SEARCH_PATH;
-			g_spawn_async(NULL, (char **) argv, NULL, flags,
-					bnep_setup, (gpointer) devname, &pid,
-					NULL);
+		if(bnep->pid != 0) {
+			if (bnep->script && !strcmp(bnep->script, "avahi-autoipd")) {
+				argv[0] = bnep->script;
+				argv[1] = devname;
+				argv[2] = "--refresh";
+				argv[3] = NULL;
+
+				flags = G_SPAWN_DO_NOT_REAP_CHILD | G_SPAWN_SEARCH_PATH;
+				g_spawn_async(NULL, (char **) argv, NULL, flags,
+						bnep_setup, (gpointer) devname, &pid,
+						NULL);
+			}
+			info("%s script is running", devname);
+			return bnep->pid;
 		}
-
-		return bnep->pid;
 	}
 
 	sd = socket(AF_INET6, SOCK_DGRAM, 0);
@@ -315,7 +339,7 @@
 	GSList *l;
 	GSpawnFlags flags;
 	const char *argv[4];
-
+	info("bringing down %s", devname);
 	l = g_slist_find_custom(pids, devname, find_devname);
 	if (!l)
 		return 0;

--=-WAm4OQJnEhksR5qUvcbN
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--=-WAm4OQJnEhksR5qUvcbN
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-WAm4OQJnEhksR5qUvcbN--
