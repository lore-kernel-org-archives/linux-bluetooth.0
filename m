Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 11/17] emulator: Add support to create many remote devices in hciemu
Date: Wed, 26 Feb 2014 02:57:22 +0100
Message-ID: <1393379848-4031-12-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1393379848-4031-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1393379848-4031-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds possibility to add more remote devices
---
 emulator/btdev.c    |  2 +-
 src/shared/hciemu.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/hciemu.h | 11 ++++++++++
 3 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index bf0c9d2..1be3ba1 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -137,7 +137,7 @@ struct inquiry_data {
 
 #define DEFAULT_INQUIRY_INTERVAL 2 /* 2 miliseconds */
 
-#define MAX_BTDEV_ENTRIES 16
+#define MAX_BTDEV_ENTRIES 100
 
 
 static const uint8_t LINK_KEY_NONE[16] = { 0 };
diff --git a/src/shared/hciemu.c b/src/shared/hciemu.c
index 6c93005..c40f71e 100644
--- a/src/shared/hciemu.c
+++ b/src/shared/hciemu.c
@@ -57,6 +57,7 @@ struct hciemu {
 	guint client_source;
 	struct queue *post_command_hooks;
 	char bdaddr_str[18];
+	GList *remote_devs;
 };
 
 struct hciemu_command_hook {
@@ -358,6 +359,18 @@ struct hciemu *hciemu_ref(struct hciemu *hciemu)
 	return hciemu;
 }
 
+static void destroy_remotes(struct remote_dev *r)
+{
+	bthost_stop(r->bthost);
+
+	g_source_remove(r->client_source);
+	g_source_remove(r->host_source);
+
+	bthost_destroy(r->bthost);
+	btdev_destroy(r->btdev);
+	g_free(r);
+}
+
 void hciemu_unref(struct hciemu *hciemu)
 {
 	if (!hciemu)
@@ -378,6 +391,8 @@ void hciemu_unref(struct hciemu *hciemu)
 	btdev_destroy(hciemu->client_dev);
 	btdev_destroy(hciemu->master_dev);
 
+	g_list_free_full(hciemu->remote_devs, (GDestroyNotify)destroy_remotes);
+
 	free(hciemu);
 }
 
@@ -498,3 +513,51 @@ bool hciemu_del_hook(struct hciemu *hciemu, enum hciemu_hook_type type,
 
 	return btdev_del_hook(hciemu->master_dev, hook_type, opcode);
 }
+
+int hciemu_add_remote_devs(struct hciemu *hciemu, int number_of_devices)
+{
+	int i;
+
+	for (i = 0; i < number_of_devices; i++)  {
+		struct remote_dev *r;
+		struct btdev *btdev;
+		struct bthost *bthost;
+		int sv[2];
+
+		btdev = btdev_create(hciemu->btdev_type, 0x00);
+		if (!btdev)
+			break;
+
+		bthost = bthost_create();
+		if (!bthost) {
+			btdev_destroy(btdev);
+			break;
+		}
+
+		btdev_set_command_handler(btdev, client_command_callback,
+								hciemu);
+
+		if (socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_NONBLOCK |
+						SOCK_CLOEXEC, 0, sv) < 0) {
+			bthost_destroy(bthost);
+			btdev_destroy(btdev);
+			break;
+		}
+
+		r = g_malloc(sizeof(*r));
+		r->btdev = btdev;
+		r->bthost = bthost;
+
+		r->client_source = create_source_btdev(sv[0], btdev);
+		r->host_source = create_source_bthost(sv[1], bthost);
+
+		hciemu->remote_devs = g_list_prepend(hciemu->remote_devs, r);
+	}
+
+	return i;
+}
+
+GList *hciemu_get_remote_devs(struct hciemu *hciemu)
+{
+	return hciemu->remote_devs;
+}
diff --git a/src/shared/hciemu.h b/src/shared/hciemu.h
index d948867..52dee23 100644
--- a/src/shared/hciemu.h
+++ b/src/shared/hciemu.h
@@ -26,6 +26,13 @@
 
 struct hciemu;
 
+struct remote_dev {
+	struct btdev *btdev;
+	struct bthost *bthost;
+	guint client_source;
+	guint host_source;
+};
+
 enum hciemu_type {
 	HCIEMU_TYPE_BREDRLE,
 	HCIEMU_TYPE_BREDR,
@@ -67,3 +74,7 @@ int hciemu_add_hook(struct hciemu *hciemu, enum hciemu_hook_type type,
 
 bool hciemu_del_hook(struct hciemu *hciemu, enum hciemu_hook_type type,
 							uint16_t opcode);
+
+int hciemu_add_remote_devs(struct hciemu *hciemu, int number_of_devices);
+
+GList *hciemu_get_remote_devs(struct hciemu *hciemu);
-- 
1.8.4

