Return-Path: <cyrus@holtmann.org>
From: Valmantas <walmis@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <821c07e60804292333g4271303lfade6b403acfb8b@mail.gmail.com>
References: <1209501760.14773.13.camel@ubuntu>
	<2d5a2c100804291906i261e1bqf5e91539d9cd9df8@mail.gmail.com>
	<821c07e60804292333g4271303lfade6b403acfb8b@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-FPXLwiB1pbjkNUzdCcox"
Date: Wed, 30 Apr 2008 12:45:44 +0300
Message-Id: <1209548744.5829.5.camel@ubuntu>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] bluetoothd-service-network fails to execute
	ifup	scripts from network.conf after repeated connection
	attempts (Patched)
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


--=-FPXLwiB1pbjkNUzdCcox
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ok, so i made a proper patch. It does not execute the scripts as the
previous did, but it does properly bring up the server side bnep
interfaces after numerous connections.

Waiting for review.

oh, and here's some output:

network[19366]: Authorization succedded. New connection: bnep0
network[19366]: Bringing up interface pan0
network[19366]: Bringing up interface bnep0
network[19366]: filter_function: sender=:1.60 destination=:1.58
obj_path=/org/bluez/network interface=org.bluez.network.Manager
method=FindConnection
network[19366]: /org/bluez/network:
org.bluez.network.Manager.FindConnection()
network[19366]: filter_function: sender=:1.5 destination=(null)
obj_path=/org/freedesktop/Hal/Manager
interface=org.freedesktop.Hal.Manager method=DeviceAdded
Found user 'avahi-autoipd' (UID 103) and group 'avahi-autoipd' (GID
110).
Successfully called chroot().
Successfully dropped root privileges.
Starting with address 169.254.5.87
Callout BIND, address 169.254.5.87 on interface pan0
network[19366]: filter_function: sender=:1.5 destination=(null)
obj_path=/org/freedesktop/Hal/Manager
interface=org.freedesktop.Hal.Manager method=DeviceRemoved
network[19366]: filter_function: sender=:1.5 destination=(null)
obj_path=/org/freedesktop/Hal/Manager
interface=org.freedesktop.Hal.Manager method=DeviceRemoved
Successfully claimed IP address 169.254.5.87
network[19366]: filter_function: sender=:1.5 destination=(null)
obj_path=/org/freedesktop/Hal/Manager
interface=org.freedesktop.Hal.Manager method=DeviceAdded
hcid[19363]: link_key_request (sba=00:09:DD:50:6E:2F,
dba=00:1A:92:FF:16:0D)
network[19366]: Connection from: 00:1A:92:FF:16:0D on PSM 15
hcid[19363]: link_key_notify (sba=00:09:DD:50:6E:2F,
dba=00:1A:92:FF:16:0D)
network[19366]: Requesting authorization for 00:1A:92:FF:16:0D
UUID:00001117-0000-1000-8000-00805f9b34fb
network[19366]: Authorization succedded. New connection: bnep0
network[19366]: Bringing up interface bnep0
network[19366]: filter_function: sender=:1.61 destination=:1.58
obj_path=/org/bluez/network interface=org.bluez.network.Manager
method=FindConnection
network[19366]: /org/bluez/network:
org.bluez.network.Manager.FindConnection()
network[19366]: filter_function: sender=:1.5 destination=(null)
obj_path=/org/freedesktop/Hal/Manager
interface=org.freedesktop.Hal.Manager method=DeviceAdded


Regards, 
Valmantas Palikša

--=-FPXLwiB1pbjkNUzdCcox
Content-Disposition: attachment; filename=008_server_bnep_ifup.patch
Content-Type: text/x-patch; name=008_server_bnep_ifup.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

--- network/common.c.old	2008-04-30 12:33:43.000000000 +0300
+++ network/common.c	2008-04-30 12:29:27.000000000 +0300
@@ -71,6 +71,7 @@
 	char *devname;
 	char *script;
 	int pid;
+	int is_initialized;
 };
 
 static gint find_devname(gconstpointer a, gconstpointer b)
@@ -235,22 +236,23 @@
 	/* Check if a script is running */
 	if ((l = g_slist_find_custom(pids, devname, find_devname))) {
 		bnep = l->data;
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
+			return bnep->pid;
 		}
-
-		return bnep->pid;
 	}
-
+	info("Bringing up interface %s", devname);
 	sd = socket(AF_INET6, SOCK_DGRAM, 0);
 	memset(&ifr, 0, sizeof(ifr));
 	strcpy(ifr.ifr_name, devname);
@@ -264,10 +266,13 @@
 			err);
 		return -err;
 	}
+	
+	if(!id && bnep->is_initialized)
+		return bnep->pid;
 
 	bnep = g_new0(struct bnep_data, 1);
 	bnep->devname = g_strdup(devname);
-
+	bnep->is_initialized = 1;
 	if (!id)
 		goto done;
 

--=-FPXLwiB1pbjkNUzdCcox
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--=-FPXLwiB1pbjkNUzdCcox
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-FPXLwiB1pbjkNUzdCcox--
