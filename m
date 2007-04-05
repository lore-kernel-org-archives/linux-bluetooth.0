Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Daniel Gollub <dgollub@suse.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Thu, 5 Apr 2007 17:29:37 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_iXRFGdkgmm4KEYJ"
Message-Id: <200704051729.38458.dgollub@suse.de>
Subject: [Bluez-devel] input service - listen for adapter changes
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

--Boundary-00=_iXRFGdkgmm4KEYJ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

latest CVS version of the input service doesn't work anymore. The fix, to get 
the input service started event there is no adapter available, prevent the 
initialization of any  adapter. So the local address which is used by the 
input manager is always 00:00:00:00:00:00.

Attachted is a quick and very dirty hack to listen for HCI events if an 
adapter got plugged in. Only the local address of the default adapter will be 
used. If the default adapter change the local address of the manager gets 
overwritten. And the input devices of the new default adapter get 
reregistered (the old one unregistered...)

I am not quite sure if this is the correct approach. Even if we should always 
use the default adapter. I see still here some problem with the use of 
multiple adapters.. should the manager only list the configured input devices 
of the current default adapter?

Keep in mind .. this makes it impossible to have a bluetooth mouse configured 
with Adapter A and a bluetooth keyboard with Adapter B (rare usecase). At 
least you are not able to manage both at the same time...

best regards,
Daniel

--Boundary-00=_iXRFGdkgmm4KEYJ
Content-Type: text/x-diff; charset="us-ascii";
	name="bluez-utils-input-service-defaultdadapter.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bluez-utils-input-service-defaultdadapter.diff"

Index: input/manager.c
===================================================================
RCS file: /cvsroot/bluez/utils/input/manager.c,v
retrieving revision 1.11
diff -u -p -r1.11 manager.c
--- input/manager.c	4 Apr 2007 21:36:45 -0000	1.11
+++ input/manager.c	5 Apr 2007 15:25:05 -0000
@@ -27,6 +27,8 @@
 
 #include <stdlib.h>
 
+#include <errno.h>
+
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
 #include <bluetooth/hci_lib.h>
@@ -831,13 +833,89 @@ static int register_stored_inputs(struct
 	return 0;
 }
 
+static inline void device_event(GIOChannel *chan, gpointer data)
+{
+	struct manager *mgr = data;
+	char new_addr[18];
+	bdaddr_t src;
+	int dev_id;
+
+	bacpy(&src, BDADDR_ANY);
+
+	dev_id = hci_get_route(&src);
+	if (dev_id < 0) {
+		error("Bluetooth device not available");
+		return;
+	}
+
+	if (hci_devba(dev_id, &src) < 0) {
+		error("Can't get local adapter device info");
+		return;
+	}
+
+	if (!bacmp(&mgr->src, &src))
+		return;
+
+	ba2str(&src, new_addr);
+	info("Default Adapter changed: hci%i(%s)", dev_id, new_addr);
+
+	manager_free(mgr);
+	mgr = g_new0(struct manager, 1);
+
+	bacpy(&mgr->src, &src);
+	register_stored_inputs(mgr);
+}
+
+static gboolean io_stack_event(GIOChannel *chan, GIOCondition cond, gpointer data) 
+{ 
+        unsigned char buf[HCI_MAX_FRAME_SIZE], *ptr; 
+        evt_stack_internal *si; 
+        hci_event_hdr *eh; 
+        int type; 
+        size_t len; 
+        GIOError err; 
+ 
+        ptr = buf; 
+ 
+        if ((err = g_io_channel_read(chan, (gchar *) buf, sizeof(buf), &len))) { 
+                if (err == G_IO_ERROR_AGAIN) 
+                        return TRUE; 
+ 
+                error("Read from control socket failed: %s (%d)", 
+                                                        strerror(errno), errno); 
+                return FALSE; 
+        } 
+ 
+        type = *ptr++; 
+ 
+        if (type != HCI_EVENT_PKT) 
+                return TRUE; 
+ 
+        eh = (hci_event_hdr *) ptr; 
+        if (eh->evt != EVT_STACK_INTERNAL) 
+                return TRUE; 
+ 
+        ptr += HCI_EVENT_HDR_SIZE; 
+ 
+        si = (evt_stack_internal *) ptr; 
+        switch (si->type) { 
+        case EVT_SI_DEVICE: 
+                device_event(chan, data); 
+                break; 
+        } 
+ 
+        return TRUE; 
+}
+
 int input_init(DBusConnection *conn)
 {
 	struct manager *mgr;
 	bdaddr_t src;
-#if 0
 	int dev_id;
-#endif
+
+        struct sockaddr_hci addr;
+        struct hci_filter flt;
+        GIOChannel *ctl_io;
 
 	connection = dbus_connection_ref(conn);
 
@@ -854,24 +932,55 @@ int input_init(DBusConnection *conn)
 
 	info("Registered input manager path:%s", INPUT_PATH);
 
-	/* Set the default adapter */
+	/* Set the default adapter, if present ... */
 	bacpy(&src, BDADDR_ANY);
-#if 0
+
 	dev_id = hci_get_route(&src);
 	if (dev_id < 0) {
-		error("Bluetooth device not available");
+		info("Bluetooth device not available");
+	} else if (hci_devba(dev_id, &src) < 0) {
+		error("Can't get local adapter device info");
 		goto fail;
+	} else {
+		bacpy(&mgr->src, &src);
+
+		/* Register well known HID devices */
+		register_stored_inputs(mgr);
 	}
 
-	if (hci_devba(dev_id, &src) < 0) {
-		error("Can't get local adapter device info");
+
+        /* Create and bind HCI socket - and listen for the default adapter */
+	int sock;
+        if ((sock = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI)) < 0) {
+                error("Can't open HCI socket: %s (%d)",
+                                                        strerror(errno), errno);
 		goto fail;
-	}
-#endif
+        }
 
-	bacpy(&mgr->src, &src);
-	/* Register well known HID devices */
-	register_stored_inputs(mgr);
+       /* Set filter */
+        hci_filter_clear(&flt);
+        hci_filter_set_ptype(HCI_EVENT_PKT, &flt);
+        hci_filter_set_event(EVT_STACK_INTERNAL, &flt);
+        if (setsockopt(sock, SOL_HCI, HCI_FILTER, &flt, sizeof(flt)) < 0) {
+                error("Can't set filter: %s (%d)",
+                                                        strerror(errno), errno);
+		goto fail;
+        }
+
+        addr.hci_family = AF_BLUETOOTH;
+        addr.hci_dev = HCI_DEV_NONE;
+        if (bind(sock, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+                error("Can't bind HCI socket: %s (%d)",
+                                                        strerror(errno), errno);
+		goto fail;
+        }
+
+        ctl_io = g_io_channel_unix_new(sock);
+        g_io_channel_set_close_on_unref(ctl_io, TRUE);
+
+        g_io_add_watch(ctl_io, G_IO_IN, io_stack_event, mgr);
+
+        g_io_channel_unref(ctl_io);
 
 	server_start(connection);
 

--Boundary-00=_iXRFGdkgmm4KEYJ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_iXRFGdkgmm4KEYJ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_iXRFGdkgmm4KEYJ--
