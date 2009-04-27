Return-Path: <cyrus@holtmann.org>
From: Alok Barsode <alokbarsode@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH 5/8] Initializing hciops plugin. Adding IO event handing.
Date: Mon, 27 Apr 2009 19:45:42 +0530
Message-Id: <1240841745-11006-5-git-send-email-alok.barsode@gmail.com>
In-Reply-To: <1240841745-11006-1-git-send-email-alok.barsode@gmail.com>
References: <1240841745-11006-1-git-send-email-alok.barsode@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 plugins/hciops.c |  134 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/main.c       |  122 +------------------------------------------------
 2 files changed, 134 insertions(+), 122 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 4f56443..32f82d0 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -24,17 +24,149 @@
 #ifdef HAVE_CONFIG_H
 #include <config.h>
 #endif
+#include <errno.h>
+#include <sys/socket.h>
+#include <sys/types.h>
+#include <sys/ioctl.h>
 
 #include <bluetooth/bluetooth.h>
+#include <bluetooth/hci.h>
+#include <bluetooth/hci_lib.h>
 
+#include <glib.h>
+
+#include "hcid.h"
 #include "plugin.h"
 #include "logging.h"
 
-static int hciops_init(void)
+
+static int init_all_devices(int ctl)
 {
+	struct hci_dev_list_req *dl;
+	struct hci_dev_req *dr;
+	int i;
+
+	dl = g_try_malloc0(HCI_MAX_DEV * sizeof(struct hci_dev_req) + sizeof(uint16_t));
+	if (!dl) {
+		info("Can't allocate devlist buffer: %s (%d)",
+							strerror(errno), errno);
+		return errno;
+	}
+
+	dl->dev_num = HCI_MAX_DEV;
+	dr = dl->dev_req;
+
+	if (ioctl(ctl, HCIGETDEVLIST, (void *) dl) < 0) {
+		info("Can't get device list: %s (%d)",
+							strerror(errno), errno);
+		return errno;
+	}
+
+	for (i = 0; i < dl->dev_num; i++, dr++) {
+		gboolean devup;
+
+		device_event(HCI_DEV_REG, dr->dev_id);
+
+		devup = hci_test_bit(HCI_UP, &dr->dev_opt);
+		if (devup)
+			device_event(HCI_DEV_UP, dr->dev_id);
+	}
+
+	g_free(dl);
 	return 0;
 }
 
+static gboolean io_stack_event(GIOChannel *chan, GIOCondition cond,
+								gpointer data)
+{
+	unsigned char buf[HCI_MAX_FRAME_SIZE], *ptr;
+	evt_stack_internal *si;
+	evt_si_device *sd;
+	hci_event_hdr *eh;
+	int type;
+	size_t len;
+	GIOError err;
+
+	ptr = buf;
+
+	err = g_io_channel_read(chan, (gchar *) buf, sizeof(buf), &len);
+	if (err) {
+		if (err == G_IO_ERROR_AGAIN)
+			return TRUE;
+
+		error("Read from control socket failed: %s (%d)",
+							strerror(errno), errno);
+		return FALSE;
+	}
+
+	type = *ptr++;
+
+	if (type != HCI_EVENT_PKT)
+		return TRUE;
+
+	eh = (hci_event_hdr *) ptr;
+	if (eh->evt != EVT_STACK_INTERNAL)
+		return TRUE;
+
+	ptr += HCI_EVENT_HDR_SIZE;
+
+	si = (evt_stack_internal *) ptr;
+	switch (si->type) {
+	case EVT_SI_DEVICE:
+		sd = (void *) &si->data;
+		device_event(sd->event, sd->dev_id);
+		break;
+	}
+
+	return TRUE;
+}
+
+static int hciops_init(void)
+{
+	struct sockaddr_hci addr;
+	struct hci_filter flt;
+	GIOChannel *ctl_io;
+	int sock;
+
+	/* Create and bind HCI socket */
+	sock = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
+	if (sock < 0) {
+		error("Can't open HCI socket: %s (%d)", strerror(errno),
+								errno);
+		return errno;
+	}
+
+	/* Set filter */
+	hci_filter_clear(&flt);
+	hci_filter_set_ptype(HCI_EVENT_PKT, &flt);
+	hci_filter_set_event(EVT_STACK_INTERNAL, &flt);
+	if (setsockopt(sock, SOL_HCI, HCI_FILTER, &flt,
+							sizeof(flt)) < 0) {
+		error("Can't set filter: %s (%d)", strerror(errno), errno);
+		return errno;
+	}
+
+	memset(&addr, 0, sizeof(addr));
+	addr.hci_family = AF_BLUETOOTH;
+	addr.hci_dev = HCI_DEV_NONE;
+	if (bind(sock, (struct sockaddr *) &addr,
+							sizeof(addr)) < 0) {
+		error("Can't bind HCI socket: %s (%d)",
+							strerror(errno), errno);
+		return errno;
+	}
+
+	ctl_io = g_io_channel_unix_new(sock);
+	g_io_channel_set_close_on_unref(ctl_io, TRUE);
+
+	g_io_add_watch(ctl_io, G_IO_IN, io_stack_event, NULL);
+
+	g_io_channel_unref(ctl_io);
+
+	/* Initialize already connected devices */
+	return init_all_devices(sock);
+}
+
 static void hciops_exit(void)
 {
 }
diff --git a/src/main.c b/src/main.c
index 93dbf71..309d4bb 100644
--- a/src/main.c
+++ b/src/main.c
@@ -506,41 +506,6 @@ static void device_devup_setup(int dev_id)
 		stop_security_manager(dev_id);
 }
 
-static void init_all_devices(int ctl)
-{
-	struct hci_dev_list_req *dl;
-	struct hci_dev_req *dr;
-	int i;
-
-	dl = g_try_malloc0(HCI_MAX_DEV * sizeof(struct hci_dev_req) + sizeof(uint16_t));
-	if (!dl) {
-		info("Can't allocate devlist buffer: %s (%d)",
-							strerror(errno), errno);
-		exit(1);
-	}
-
-	dl->dev_num = HCI_MAX_DEV;
-	dr = dl->dev_req;
-
-	if (ioctl(ctl, HCIGETDEVLIST, (void *) dl) < 0) {
-		info("Can't get device list: %s (%d)",
-							strerror(errno), errno);
-		exit(1);
-	}
-
-	for (i = 0; i < dl->dev_num; i++, dr++) {
-		gboolean devup;
-
-		device_event(HCI_DEV_REG, dr->dev_id);
-
-		devup = hci_test_bit(HCI_UP, &dr->dev_opt);
-		if (devup)
-			device_event(HCI_DEV_UP, dr->dev_id);
-	}
-
-	g_free(dl);
-}
-
 static void init_defaults(void)
 {
 	/* Default HCId settings */
@@ -582,51 +547,6 @@ void device_event(int event, int dev_id)
 	}
 }
 
-static gboolean io_stack_event(GIOChannel *chan, GIOCondition cond,
-								gpointer data)
-{
-	unsigned char buf[HCI_MAX_FRAME_SIZE], *ptr;
-	evt_stack_internal *si;
-	evt_si_device *sd;
-	hci_event_hdr *eh;
-	int type;
-	size_t len;
-	GIOError err;
-
-	ptr = buf;
-
-	err = g_io_channel_read(chan, (gchar *) buf, sizeof(buf), &len);
-	if (err) {
-		if (err == G_IO_ERROR_AGAIN)
-			return TRUE;
-
-		error("Read from control socket failed: %s (%d)",
-							strerror(errno), errno);
-		return FALSE;
-	}
-
-	type = *ptr++;
-
-	if (type != HCI_EVENT_PKT)
-		return TRUE;
-
-	eh = (hci_event_hdr *) ptr;
-	if (eh->evt != EVT_STACK_INTERNAL)
-		return TRUE;
-
-	ptr += HCI_EVENT_HDR_SIZE;
-
-	si = (evt_stack_internal *) ptr;
-	switch (si->type) {
-	case EVT_SI_DEVICE:
-		sd = (void *) &si->data;
-		device_event(sd->event, sd->dev_id);
-		break;
-	}
-
-	return TRUE;
-}
-
 static GMainLoop *event_loop;
 
 static void sig_term(int sig)
@@ -655,10 +575,8 @@ int main(int argc, char *argv[])
 {
 	GOptionContext *context;
 	GError *err = NULL;
-	struct sockaddr_hci addr;
-	struct hci_filter flt;
 	struct sigaction sa;
-	GIOChannel *ctl_io, *child_io;
+	GIOChannel *child_io;
 	uint16_t mtu = 0;
 	GKeyFile *config;
 
@@ -706,34 +624,6 @@ int main(int argc, char *argv[])
 		enable_debug();
 	}
 
-	/* Create and bind HCI socket */
-	main_opts.sock = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
-	if (main_opts.sock < 0) {
-		error("Can't open HCI socket: %s (%d)", strerror(errno),
-								errno);
-		exit(1);
-	}
-
-	/* Set filter */
-	hci_filter_clear(&flt);
-	hci_filter_set_ptype(HCI_EVENT_PKT, &flt);
-	hci_filter_set_event(EVT_STACK_INTERNAL, &flt);
-	if (setsockopt(main_opts.sock, SOL_HCI, HCI_FILTER, &flt,
-							sizeof(flt)) < 0) {
-		error("Can't set filter: %s (%d)", strerror(errno), errno);
-		exit(1);
-	}
-
-	memset(&addr, 0, sizeof(addr));
-	addr.hci_family = AF_BLUETOOTH;
-	addr.hci_dev = HCI_DEV_NONE;
-	if (bind(main_opts.sock, (struct sockaddr *) &addr,
-							sizeof(addr)) < 0) {
-		error("Can't bind HCI socket: %s (%d)",
-							strerror(errno), errno);
-		exit(1);
-	}
-
 	config = load_config(CONFIGDIR "/main.conf");
 
 	parse_config(config);
@@ -768,16 +658,6 @@ int main(int argc, char *argv[])
 
 	event_loop = g_main_loop_new(NULL, FALSE);
 
-	ctl_io = g_io_channel_unix_new(main_opts.sock);
-	g_io_channel_set_close_on_unref(ctl_io, TRUE);
-
-	g_io_add_watch(ctl_io, G_IO_IN, io_stack_event, NULL);
-
-	g_io_channel_unref(ctl_io);
-
-	/* Initialize already connected devices */
-	init_all_devices(main_opts.sock);
-
 	starting = FALSE;
 
 	manager_startup_complete();
-- 
1.5.6.3
