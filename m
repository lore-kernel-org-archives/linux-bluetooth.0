Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hcid patch (patch 00.13)
Message-ID: <20051011100057.GA29401@localhost.localdomain>
References: <e1effdeb0510060731s191b17bbrd52897af77622ba6@mail.gmail.com> <1128784148.5212.17.camel@blade> <e1effdeb0510081605p56bcd8fcob8fcd77f616c105d@mail.gmail.com> <1128896442.19569.26.camel@blade> <20051010195850.GA23080@localhost.localdomain> <1128977357.7352.1.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
In-Reply-To: <1128977357.7352.1.camel@blade>
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
Date: Tue, 11 Oct 2005 13:00:57 +0300


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 10, 2005,  Marcel Holtmann wrote:
> I applied the patch, but this can't be the final solution. It will
> produce weird stuff on 64-bit machines:

Yeah, I suspected that could cause problems since
sizeof(int) != sizeof(void *) on those machines. I don't think those
compiler warnings are dangerous though, since they are probably meant to
warn about possible loss of data which shouldn't happen to us since our
values always fit within 2 bytes. I don't have a 64bit machine so I
can't verify this fix, but I think that sizeof(long) should be the same
as sizeof(void *) on both 32 and 64 bit machines. If that isn't the
case, the last resort could be to make some automake makro to check the
actual size of pointer types and add #defines to the code acordingly.

Anyway, the attached patch uses long for the pointer<->integer
typecasts. Let me know if it doesn't work.

Johan

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dbus-cleanup2.patch"

Index: hcid/dbus.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.c,v
retrieving revision 1.19
diff -u -r1.19 dbus.c
--- hcid/dbus.c	10 Oct 2005 20:46:55 -0000	1.19
+++ hcid/dbus.c	11 Oct 2005 09:43:21 -0000
@@ -507,7 +507,7 @@
 {
 	GIOCondition cond = G_IO_HUP | G_IO_ERR;
 	GIOChannel *io;
-	guint id;
+	gulong id;
 	int fd, flags;
 
 	if (!dbus_watch_get_enabled(watch))
@@ -520,7 +520,7 @@
 	if (flags & DBUS_WATCH_READABLE) cond |= G_IO_IN;
 	if (flags & DBUS_WATCH_WRITABLE) cond |= G_IO_OUT;
 
-	id = g_io_add_watch(io, cond, watch_func, watch);
+	id = (gulong) g_io_add_watch(io, cond, watch_func, watch);
 
 	dbus_watch_set_data(watch, (void *) id, NULL);
 
@@ -529,12 +529,12 @@
 
 static void remove_watch(DBusWatch *watch, void *data)
 {
-	guint id = (guint) dbus_watch_get_data(watch);
+	gulong id = (gulong) dbus_watch_get_data(watch);
 
 	dbus_watch_set_data(watch, NULL, NULL);
 
 	if (id)
-		g_io_remove_watch(id);
+		g_io_remove_watch((guint)id);
 }
 
 static void watch_toggled(DBusWatch *watch, void *data)
@@ -728,7 +728,7 @@
 
 	syslog(LOG_INFO, "registering  -  path:%s - id:%d",path, id);
 
-	if (!dbus_connection_register_object_path(conn, path, &obj_vtable, (void *)((uint32_t)id))) {
+	if (!dbus_connection_register_object_path(conn, path, &obj_vtable, (void *)(long) id)) {
 		syslog(LOG_ERR,"DBUS failed to register %s object", path);
 		/* ignore, the path was already registered */
 	}
@@ -826,7 +826,7 @@
 	const char *path;
 	const char *rel_path;
 	const char *tmp_iface = NULL;
-	const uint32_t udata = (uint32_t) data;
+	long udata = (long) data;
 	uint32_t result = BLUEZ_EDBUS_UNKNOWN_METHOD;
 	DBusHandlerResult ret = DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 	uint8_t found = 0;
@@ -837,7 +837,7 @@
 	method = dbus_message_get_member (msg);
 	signature = dbus_message_get_signature(msg);
 
-	syslog (LOG_INFO, "%s - path:%s, udata:0x%X", __PRETTY_FUNCTION__, path, udata);
+	syslog (LOG_INFO, "%s - path:%s, udata:0x%X", __PRETTY_FUNCTION__, path, (guint) udata);
 
 	if (strcmp(path, DEVICE_PATH) == 0) {
 		ptr_handlers = dev_services;
@@ -918,7 +918,7 @@
 	periodic_inquiry_cp inq_param;
 	DBusMessageIter iter;
 	DBusMessage *reply = NULL;
-	uint32_t udata = (uint32_t) data;
+	long udata = (long) data;
 	uint8_t length;
 	uint8_t max_period;
 	uint8_t min_period;
@@ -933,7 +933,7 @@
 		
 		}
 	} else
-		dev_id = udata;
+		dev_id = (int) udata;
 
 	if ((sock = hci_open_dev(dev_id)) < 0) {
 		syslog(LOG_ERR, "HCI device open failed");
@@ -997,7 +997,7 @@
 {
 	DBusMessageIter iter;
 	DBusMessage *reply = NULL;
-	uint32_t udata = (uint32_t) data;
+	long udata = (long) data;
 	int sock = -1;
 	int dev_id = -1;
 
@@ -1008,7 +1008,7 @@
 			goto failed;
 		}
 	} else
-		dev_id = udata;
+		dev_id = (int) udata;
 
 	if ((sock = hci_open_dev(dev_id)) < 0) {
 		syslog(LOG_ERR, "HCI device open failed");
@@ -1043,7 +1043,7 @@
 	DBusMessageIter  struct_iter;
 	DBusMessage *reply = NULL;
 	inquiry_info *info = NULL;
-	uint32_t udata = (uint32_t) data;
+	long udata = (long) data;
 	const char *paddr = addr;
 	int dev_id = -1;
 	int i;
@@ -1060,7 +1060,7 @@
 			goto failed;
 		}
 	} else
-		dev_id = udata;
+		dev_id = (int) udata;
 
 	dbus_message_iter_init(msg, &iter);
 	dbus_message_iter_get_basic(&iter, &length);
@@ -1112,7 +1112,7 @@
 	DBusMessageIter iter;
 	DBusMessage *reply = NULL;
 	char *str_bdaddr = NULL;
-	const uint32_t udata = (uint32_t) data;
+	long udata = (long) data;
 	bdaddr_t bdaddr;
 	uint8_t role;
 	int dev_id = -1;

--ZPt4rx8FFjLCG7dd--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
