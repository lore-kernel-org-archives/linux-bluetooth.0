Return-Path: <cyrus@holtmann.org>
From: Alok Barsode <alokbarsode@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, Alok Barsode <alok.barsode@gmail.com>
Subject: [PATCH 8/8] Exporting init_known_adapters from hciops plugin.
Date: Mon, 27 Apr 2009 19:45:45 +0530
Message-Id: <1240841745-11006-8-git-send-email-alok.barsode@gmail.com>
In-Reply-To: <1240841745-11006-1-git-send-email-alok.barsode@gmail.com>
References: <1240841745-11006-1-git-send-email-alok.barsode@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/hciops.c |   16 ++++++++--------
 src/adapter.c    |    8 ++++++++
 src/adapter.h    |    2 ++
 src/main.c       |    2 ++
 4 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 5845443..d43efbd 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -54,6 +54,7 @@
 #include "manager.h"
 #include "storage.h"
 
+static int sock;
 static int child_pipe[2];
 
 static gboolean child_exit(GIOChannel *io, GIOCondition cond, void *user_data)
@@ -273,8 +274,8 @@ void device_event(int event, int dev_id)
 		break;
 	}
 }
-
-static int init_all_devices(int ctl)
+ /* Initialize already connected devices */
+static int init_all_devices(void)
 {
 	struct hci_dev_list_req *dl;
 	struct hci_dev_req *dr;
@@ -290,7 +291,7 @@ static int init_all_devices(int ctl)
 	dl->dev_num = HCI_MAX_DEV;
 	dr = dl->dev_req;
 
-	if (ioctl(ctl, HCIGETDEVLIST, (void *) dl) < 0) {
+	if (ioctl(sock, HCIGETDEVLIST, (void *) dl) < 0) {
 		info("Can't get device list: %s (%d)",
 							strerror(errno), errno);
 		return errno;
@@ -360,7 +361,6 @@ static int hciops_setup(void)
 	struct sockaddr_hci addr;
 	struct hci_filter flt;
 	GIOChannel *ctl_io, *child_io;;
-	int sock;
 
 	if (pipe(child_pipe) < 0) {
 		error("pipe(): %s (%d)", strerror(errno), errno);
@@ -409,8 +409,7 @@ static int hciops_setup(void)
 
 	g_io_channel_unref(ctl_io);
 
-	/* Initialize already connected devices */
-	return init_all_devices(sock);
+	return 0;
 }
 
 static void hciops_cleanup(void)
@@ -418,8 +417,9 @@ static void hciops_cleanup(void)
 }
 
 static struct btd_adapter_ops hci_ops = {
-	.setup	 = hciops_setup,
-	.cleanup = hciops_cleanup,
+	.setup		     = hciops_setup,
+	.cleanup	     = hciops_cleanup,
+	.init_known_adapters = init_all_devices,
 };
 
 static int hciops_init(void)
diff --git a/src/adapter.c b/src/adapter.c
index db86228..5bc6dab 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2934,6 +2934,14 @@ void btd_adapter_cleanup_ops()
 	adapter_ops->cleanup();
 }
 
+int init_known_adapters()
+{
+	if (!adapter_ops)
+		return -1;
+
+	return adapter_ops->init_known_adapters();
+}
+
 static void agent_auth_cb(struct agent *agent, DBusError *derr,
 							void *user_data)
 {
diff --git a/src/adapter.h b/src/adapter.h
index b195c3c..35cbc8f 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -151,7 +151,9 @@ gboolean adapter_powering_down(struct btd_adapter *adapter);
 struct btd_adapter_ops {
 	int (*setup) ();
 	void (*cleanup) ();
+	int (*init_known_adapters)();
 };
 
 int btd_register_adapter_ops(struct btd_adapter_ops *btd_adapter_ops);
 void btd_adapter_cleanup_ops();
+int init_known_adapters();
diff --git a/src/main.c b/src/main.c
index a5a728c..346dc0c 100644
--- a/src/main.c
+++ b/src/main.c
@@ -411,6 +411,8 @@ int main(int argc, char *argv[])
 
 	event_loop = g_main_loop_new(NULL, FALSE);
 
+	init_known_adapters();
+
 	starting = FALSE;
 
 	manager_startup_complete();
-- 
1.5.6.3
