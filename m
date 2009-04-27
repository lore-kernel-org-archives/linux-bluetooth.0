Return-Path: <cyrus@holtmann.org>
From: Alok Barsode <alokbarsode@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, Alok Barsode <alok.barsode@gmail.com>
Subject: [PATCH 6/8] Moving all adapter initialization code to hciops plugin.
Date: Mon, 27 Apr 2009 19:45:43 +0530
Message-Id: <1240841745-11006-6-git-send-email-alok.barsode@gmail.com>
In-Reply-To: <1240841745-11006-1-git-send-email-alok.barsode@gmail.com>
References: <1240841745-11006-1-git-send-email-alok.barsode@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/hciops.c |  248 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/hcid.h       |   11 +++
 src/main.c       |  249 +-----------------------------------------------------
 3 files changed, 259 insertions(+), 249 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 32f82d0..25f5171 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -24,10 +24,19 @@
 #ifdef HAVE_CONFIG_H
 #include <config.h>
 #endif
+
+#include <stdio.h>
 #include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <signal.h>
+#include <sys/stat.h>
 #include <sys/socket.h>
 #include <sys/types.h>
 #include <sys/ioctl.h>
+#include <sys/wait.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
@@ -35,10 +44,235 @@
 
 #include <glib.h>
 
+#include <dbus/dbus.h>
+
 #include "hcid.h"
+#include "sdpd.h"
+#include "adapter.h"
 #include "plugin.h"
 #include "logging.h"
+#include "manager.h"
+#include "storage.h"
+
+static int child_pipe[2];
+
+static gboolean child_exit(GIOChannel *io, GIOCondition cond, void *user_data)
+{
+	int status, fd = g_io_channel_unix_get_fd(io);
+	pid_t child_pid;
+
+	if (read(fd, &child_pid, sizeof(child_pid)) != sizeof(child_pid)) {
+		error("child_exit: unable to read child pid from pipe");
+		return TRUE;
+	}
+
+	if (waitpid(child_pid, &status, 0) != child_pid)
+		error("waitpid(%d) failed", child_pid);
+	else
+		debug("child %d exited", child_pid);
+
+	return TRUE;
+}
+
+static void at_child_exit(void)
+{
+	pid_t pid = getpid();
+
+	if (write(child_pipe[1], &pid, sizeof(pid)) != sizeof(pid))
+		error("unable to write to child pipe");
+}
+
+static void configure_device(int dev_id)
+{
+	struct hci_dev_info di;
+	uint16_t policy;
+	int dd;
+
+	if (hci_devinfo(dev_id, &di) < 0)
+		return;
+
+	if (hci_test_bit(HCI_RAW, &di.flags))
+		return;
+
+	dd = hci_open_dev(dev_id);
+	if (dd < 0) {
+		error("Can't open device hci%d: %s (%d)",
+						dev_id, strerror(errno), errno);
+		return;
+	}
+
+	/* Set device name */
+	if ((main_opts.flags & (1 << HCID_SET_NAME)) && main_opts.name) {
+		change_local_name_cp cp;
+
+		memset(cp.name, 0, sizeof(cp.name));
+		expand_name((char *) cp.name, sizeof(cp.name),
+						main_opts.name, dev_id);
+
+		hci_send_cmd(dd, OGF_HOST_CTL, OCF_CHANGE_LOCAL_NAME,
+					CHANGE_LOCAL_NAME_CP_SIZE, &cp);
+	}
+
+	/* Set device class */
+	if ((main_opts.flags & (1 << HCID_SET_CLASS))) {
+		write_class_of_dev_cp cp;
+		uint32_t class;
+		uint8_t cls[3];
+
+		if (read_local_class(&di.bdaddr, cls) < 0) {
+			class = htobl(main_opts.class);
+			cls[2] = get_service_classes(&di.bdaddr);
+			memcpy(cp.dev_class, &class, 3);
+		} else {
+			if (!(main_opts.scan & SCAN_INQUIRY))
+				cls[1] &= 0xdf; /* Clear discoverable bit */
+			cls[2] = get_service_classes(&di.bdaddr);
+			memcpy(cp.dev_class, cls, 3);
+		}
+
+		hci_send_cmd(dd, OGF_HOST_CTL, OCF_WRITE_CLASS_OF_DEV,
+					WRITE_CLASS_OF_DEV_CP_SIZE, &cp);
+	}
+
+	/* Set page timeout */
+	if ((main_opts.flags & (1 << HCID_SET_PAGETO))) {
+		write_page_timeout_cp cp;
+
+		cp.timeout = htobs(main_opts.pageto);
+		hci_send_cmd(dd, OGF_HOST_CTL, OCF_WRITE_PAGE_TIMEOUT,
+					WRITE_PAGE_TIMEOUT_CP_SIZE, &cp);
+	}
+
+	/* Set default link policy */
+	policy = htobs(main_opts.link_policy);
+	hci_send_cmd(dd, OGF_LINK_POLICY,
+				OCF_WRITE_DEFAULT_LINK_POLICY, 2, &policy);
+
+	hci_close_dev(dd);
+}
+
+static void init_device(int dev_id)
+{
+	struct hci_dev_req dr;
+	struct hci_dev_info di;
+	pid_t pid;
+	int dd;
+
+	/* Do initialization in the separate process */
+	pid = fork();
+	switch (pid) {
+		case 0:
+			atexit(at_child_exit);
+			break;
+		case -1:
+			error("Fork failed. Can't init device hci%d: %s (%d)",
+					dev_id, strerror(errno), errno);
+		default:
+			debug("child %d forked", pid);
+			return;
+	}
+
+	dd = hci_open_dev(dev_id);
+	if (dd < 0) {
+		error("Can't open device hci%d: %s (%d)",
+					dev_id, strerror(errno), errno);
+		exit(1);
+	}
 
+	memset(&dr, 0, sizeof(dr));
+	dr.dev_id = dev_id;
+
+	/* Set link mode */
+	dr.dev_opt = main_opts.link_mode;
+	if (ioctl(dd, HCISETLINKMODE, (unsigned long) &dr) < 0) {
+		error("Can't set link mode on hci%d: %s (%d)",
+					dev_id, strerror(errno), errno);
+	}
+
+	/* Set link policy */
+	dr.dev_opt = main_opts.link_policy;
+	if (ioctl(dd, HCISETLINKPOL, (unsigned long) &dr) < 0 &&
+							errno != ENETDOWN) {
+		error("Can't set link policy on hci%d: %s (%d)",
+					dev_id, strerror(errno), errno);
+	}
+
+	/* Start HCI device */
+	if (ioctl(dd, HCIDEVUP, dev_id) < 0 && errno != EALREADY) {
+		error("Can't init device hci%d: %s (%d)",
+					dev_id, strerror(errno), errno);
+		goto fail;
+	}
+
+	if (hci_devinfo(dev_id, &di) < 0)
+		goto fail;
+
+	if (hci_test_bit(HCI_RAW, &di.flags))
+		goto done;
+
+done:
+	hci_close_dev(dd);
+	exit(0);
+
+fail:
+	hci_close_dev(dd);
+	exit(1);
+}
+
+static void device_devreg_setup(int dev_id)
+{
+	struct hci_dev_info di;
+	gboolean devup;
+
+	init_device(dev_id);
+
+	memset(&di, 0, sizeof(di));
+
+	if (hci_devinfo(dev_id, &di) < 0)
+		return;
+
+	devup = hci_test_bit(HCI_UP, &di.flags);
+
+	if (!hci_test_bit(HCI_RAW, &di.flags))
+		manager_register_adapter(dev_id, devup);
+}
+
+static void device_devup_setup(int dev_id)
+{
+	configure_device(dev_id);
+
+	start_security_manager(dev_id);
+
+	/* Return value 1 means ioctl(DEVDOWN) was performed */
+	if (manager_start_adapter(dev_id) == 1)
+		stop_security_manager(dev_id);
+}
+
+void device_event(int event, int dev_id)
+{
+	switch (event) {
+	case HCI_DEV_REG:
+		info("HCI dev %d registered", dev_id);
+		device_devreg_setup(dev_id);
+		break;
+
+	case HCI_DEV_UNREG:
+		info("HCI dev %d unregistered", dev_id);
+		manager_unregister_adapter(dev_id);
+		break;
+
+	case HCI_DEV_UP:
+		info("HCI dev %d up", dev_id);
+		device_devup_setup(dev_id);
+		break;
+
+	case HCI_DEV_DOWN:
+		info("HCI dev %d down", dev_id);
+		manager_stop_adapter(dev_id);
+		stop_security_manager(dev_id);
+		break;
+	}
+}
 
 static int init_all_devices(int ctl)
 {
@@ -125,9 +359,21 @@ static int hciops_init(void)
 {
 	struct sockaddr_hci addr;
 	struct hci_filter flt;
-	GIOChannel *ctl_io;
+	GIOChannel *ctl_io, *child_io;;
 	int sock;
 
+	if (pipe(child_pipe) < 0) {
+		error("pipe(): %s (%d)", strerror(errno), errno);
+		return errno;
+	}
+
+	child_io = g_io_channel_unix_new(child_pipe[0]);
+	g_io_channel_set_close_on_unref(child_io, TRUE);
+	g_io_add_watch(child_io,
+			G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+			child_exit, NULL);
+	g_io_channel_unref(child_io);
+
 	/* Create and bind HCI socket */
 	sock = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
 	if (sock < 0) {
diff --git a/src/hcid.h b/src/hcid.h
index 236449d..e6f85d3 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -42,6 +42,8 @@
 #define MODE_LIMITED		0x03
 #define MODE_UNKNOWN		0xff
 
+#define HCID_DEFAULT_DISCOVERABLE_TIMEOUT 180 /* 3 minutes */
+
 /* Timeout for hci_send_req (milliseconds) */
 #define HCI_REQ_TIMEOUT		5000
 
@@ -66,8 +68,17 @@ struct main_opts {
 	int		sock;
 };
 
+enum {
+	HCID_SET_NAME,
+	HCID_SET_CLASS,
+	HCID_SET_PAGETO,
+	HCID_SET_DISCOVTO,
+};
+
 extern struct main_opts main_opts;
 
+char *expand_name(char *dst, int size, char *str, int dev_id);
+
 void device_event(int event, int dev_id);
 void hci_req_queue_remove(int dev_id, bdaddr_t *dba);
 
diff --git a/src/main.c b/src/main.c
index 309d4bb..a5a728c 100644
--- a/src/main.c
+++ b/src/main.c
@@ -28,17 +28,13 @@
 #endif
 
 #include <stdio.h>
-#include <errno.h>
-#include <fcntl.h>
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
-#include <signal.h>
 #include <sys/stat.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 #include <sys/types.h>
-#include <sys/wait.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
@@ -57,21 +53,9 @@
 #include "dbus-common.h"
 #include "agent.h"
 #include "manager.h"
-#include "storage.h"
-
-#define HCID_DEFAULT_DISCOVERABLE_TIMEOUT 180 /* 3 minutes */
-
-enum {
-	HCID_SET_NAME,
-	HCID_SET_CLASS,
-	HCID_SET_PAGETO,
-	HCID_SET_DISCOVTO,
-};
 
 struct main_opts main_opts;
 
-static int child_pipe[2];
-
 static gboolean starting = TRUE;
 
 static GKeyFile *load_config(const char *file)
@@ -260,7 +244,7 @@ static void update_service_classes(const bdaddr_t *bdaddr, uint8_t value)
  * Device name expansion
  *   %d - device id
  */
-static char *expand_name(char *dst, int size, char *str, int dev_id)
+char *expand_name(char *dst, int size, char *str, int dev_id)
 {
 	register int sp, np, olen;
 	char *opt, buf[10];
@@ -314,198 +298,6 @@ static char *expand_name(char *dst, int size, char *str, int dev_id)
 	return dst;
 }
 
-static gboolean child_exit(GIOChannel *io, GIOCondition cond, void *user_data)
-{
-	int status, fd = g_io_channel_unix_get_fd(io);
-	pid_t child_pid;
-
-	if (read(fd, &child_pid, sizeof(child_pid)) != sizeof(child_pid)) {
-		error("child_exit: unable to read child pid from pipe");
-		return TRUE;
-	}
-
-	if (waitpid(child_pid, &status, 0) != child_pid)
-		error("waitpid(%d) failed", child_pid);
-	else
-		debug("child %d exited", child_pid);
-
-	return TRUE;
-}
-
-static void at_child_exit(void)
-{
-	pid_t pid = getpid();
-
-	if (write(child_pipe[1], &pid, sizeof(pid)) != sizeof(pid))
-		error("unable to write to child pipe");
-}
-
-static void configure_device(int dev_id)
-{
-	struct hci_dev_info di;
-	uint16_t policy;
-	int dd;
-
-	if (hci_devinfo(dev_id, &di) < 0)
-		return;
-
-	if (hci_test_bit(HCI_RAW, &di.flags))
-		return;
-
-	dd = hci_open_dev(dev_id);
-	if (dd < 0) {
-		error("Can't open device hci%d: %s (%d)",
-						dev_id, strerror(errno), errno);
-		return;
-	}
-
-	/* Set device name */
-	if ((main_opts.flags & (1 << HCID_SET_NAME)) && main_opts.name) {
-		change_local_name_cp cp;
-
-		memset(cp.name, 0, sizeof(cp.name));
-		expand_name((char *) cp.name, sizeof(cp.name),
-						main_opts.name, dev_id);
-
-		hci_send_cmd(dd, OGF_HOST_CTL, OCF_CHANGE_LOCAL_NAME,
-					CHANGE_LOCAL_NAME_CP_SIZE, &cp);
-	}
-
-	/* Set device class */
-	if ((main_opts.flags & (1 << HCID_SET_CLASS))) {
-		write_class_of_dev_cp cp;
-		uint32_t class;
-		uint8_t cls[3];
-
-		if (read_local_class(&di.bdaddr, cls) < 0) {
-			class = htobl(main_opts.class);
-			cls[2] = get_service_classes(&di.bdaddr);
-			memcpy(cp.dev_class, &class, 3);
-		} else {
-			if (!(main_opts.scan & SCAN_INQUIRY))
-				cls[1] &= 0xdf; /* Clear discoverable bit */
-			cls[2] = get_service_classes(&di.bdaddr);
-			memcpy(cp.dev_class, cls, 3);
-		}
-
-		hci_send_cmd(dd, OGF_HOST_CTL, OCF_WRITE_CLASS_OF_DEV,
-					WRITE_CLASS_OF_DEV_CP_SIZE, &cp);
-	}
-
-	/* Set page timeout */
-	if ((main_opts.flags & (1 << HCID_SET_PAGETO))) {
-		write_page_timeout_cp cp;
-
-		cp.timeout = htobs(main_opts.pageto);
-		hci_send_cmd(dd, OGF_HOST_CTL, OCF_WRITE_PAGE_TIMEOUT,
-					WRITE_PAGE_TIMEOUT_CP_SIZE, &cp);
-	}
-
-	/* Set default link policy */
-	policy = htobs(main_opts.link_policy);
-	hci_send_cmd(dd, OGF_LINK_POLICY,
-				OCF_WRITE_DEFAULT_LINK_POLICY, 2, &policy);
-
-	hci_close_dev(dd);
-}
-
-static void init_device(int dev_id)
-{
-	struct hci_dev_req dr;
-	struct hci_dev_info di;
-	pid_t pid;
-	int dd;
-
-	/* Do initialization in the separate process */
-	pid = fork();
-	switch (pid) {
-		case 0:
-			atexit(at_child_exit);
-			break;
-		case -1:
-			error("Fork failed. Can't init device hci%d: %s (%d)",
-					dev_id, strerror(errno), errno);
-		default:
-			debug("child %d forked", pid);
-			return;
-	}
-
-	dd = hci_open_dev(dev_id);
-	if (dd < 0) {
-		error("Can't open device hci%d: %s (%d)",
-					dev_id, strerror(errno), errno);
-		exit(1);
-	}
-
-	memset(&dr, 0, sizeof(dr));
-	dr.dev_id = dev_id;
-
-	/* Set link mode */
-	dr.dev_opt = main_opts.link_mode;
-	if (ioctl(dd, HCISETLINKMODE, (unsigned long) &dr) < 0) {
-		error("Can't set link mode on hci%d: %s (%d)",
-					dev_id, strerror(errno), errno);
-	}
-
-	/* Set link policy */
-	dr.dev_opt = main_opts.link_policy;
-	if (ioctl(dd, HCISETLINKPOL, (unsigned long) &dr) < 0 &&
-							errno != ENETDOWN) {
-		error("Can't set link policy on hci%d: %s (%d)",
-					dev_id, strerror(errno), errno);
-	}
-
-	/* Start HCI device */
-	if (ioctl(dd, HCIDEVUP, dev_id) < 0 && errno != EALREADY) {
-		error("Can't init device hci%d: %s (%d)",
-					dev_id, strerror(errno), errno);
-		goto fail;
-	}
-
-	if (hci_devinfo(dev_id, &di) < 0)
-		goto fail;
-
-	if (hci_test_bit(HCI_RAW, &di.flags))
-		goto done;
-
-done:
-	hci_close_dev(dd);
-	exit(0);
-
-fail:
-	hci_close_dev(dd);
-	exit(1);
-}
-
-static void device_devreg_setup(int dev_id)
-{
-	struct hci_dev_info di;
-	gboolean devup;
-
-	init_device(dev_id);
-
-	memset(&di, 0, sizeof(di));
-
-	if (hci_devinfo(dev_id, &di) < 0)
-		return;
-
-	devup = hci_test_bit(HCI_UP, &di.flags);
-
-	if (!hci_test_bit(HCI_RAW, &di.flags))
-		manager_register_adapter(dev_id, devup);
-}
-
-static void device_devup_setup(int dev_id)
-{
-	configure_device(dev_id);
-
-	start_security_manager(dev_id);
-
-	/* Return value 1 means ioctl(DEVDOWN) was performed */
-	if (manager_start_adapter(dev_id) == 1)
-		stop_security_manager(dev_id);
-}
-
 static void init_defaults(void)
 {
 	/* Default HCId settings */
@@ -521,32 +313,6 @@ static void init_defaults(void)
 		strcpy(main_opts.host_name, "noname");
 }
 
-void device_event(int event, int dev_id)
-{
-	switch (event) {
-	case HCI_DEV_REG:
-		info("HCI dev %d registered", dev_id);
-		device_devreg_setup(dev_id);
-		break;
-
-	case HCI_DEV_UNREG:
-		info("HCI dev %d unregistered", dev_id);
-		manager_unregister_adapter(dev_id);
-		break;
-
-	case HCI_DEV_UP:
-		info("HCI dev %d up", dev_id);
-		device_devup_setup(dev_id);
-		break;
-
-	case HCI_DEV_DOWN:
-		info("HCI dev %d down", dev_id);
-		manager_stop_adapter(dev_id);
-		stop_security_manager(dev_id);
-		break;
-	}
-}
-
 static GMainLoop *event_loop;
 
 static void sig_term(int sig)
@@ -576,7 +342,6 @@ int main(int argc, char *argv[])
 	GOptionContext *context;
 	GError *err = NULL;
 	struct sigaction sa;
-	GIOChannel *child_io;
 	uint16_t mtu = 0;
 	GKeyFile *config;
 
@@ -628,18 +393,6 @@ int main(int argc, char *argv[])
 
 	parse_config(config);
 
-	if (pipe(child_pipe) < 0) {
-		error("pipe(): %s (%d)", strerror(errno), errno);
-		exit(1);
-	}
-
-	child_io = g_io_channel_unix_new(child_pipe[0]);
-	g_io_channel_set_close_on_unref(child_io, TRUE);
-	g_io_add_watch(child_io,
-			G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-			child_exit, NULL);
-	g_io_channel_unref(child_io);
-
 	agent_init();
 
 	if (hcid_dbus_init() < 0) {
-- 
1.5.6.3
