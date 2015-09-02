Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v3 7/8] emulator/hciemu: add second client
Date: Wed,  2 Sep 2015 10:51:14 -0700
Message-Id: <1441216275-2954-7-git-send-email-jpawlowski@google.com>
In-Reply-To: <1441216275-2954-1-git-send-email-jpawlowski@google.com>
References: <1441216275-2954-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds second client in preparation for test that would try to
connect to two devices at same time.
---
 emulator/hciemu.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 emulator/hciemu.h |  2 ++
 2 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index 2e57b1f..7e35b00 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -49,12 +49,17 @@
 struct hciemu {
 	int ref_count;
 	enum btdev_type btdev_type;
+	enum btdev_type btdev_2_type;
 	struct bthost *host_stack;
+	struct bthost *host_2_stack;
 	struct btdev *master_dev;
 	struct btdev *client_dev;
+	struct btdev *client_2_dev;
 	guint host_source;
+	guint host_2_source;
 	guint master_source;
 	guint client_source;
+	guint client_2_source;
 	struct queue *post_command_hooks;
 	char bdaddr_str[18];
 };
@@ -252,7 +257,6 @@ static bool create_vhci(struct hciemu *hciemu)
 	}
 
 	hciemu->master_dev = btdev;
-
 	hciemu->master_source = create_source_btdev(fd, btdev);
 
 	return true;
@@ -266,37 +270,80 @@ struct bthost *hciemu_client_get_host(struct hciemu *hciemu)
 	return hciemu->host_stack;
 }
 
+struct bthost *hciemu_client_2_get_host(struct hciemu *hciemu)
+{
+	if (!hciemu)
+		return NULL;
+
+	return hciemu->host_2_stack;
+}
+
 static bool create_stack(struct hciemu *hciemu)
 {
-	struct btdev *btdev;
-	struct bthost *bthost;
-	int sv[2];
+	struct btdev *btdev, *btdev_2;
+	struct bthost *bthost, *bthost_2;
+	int sv[2], sv2[2];
 
 	btdev = btdev_create(hciemu->btdev_type, 0x00);
 	if (!btdev)
 		return false;
 
+
+	btdev_2 = btdev_create(hciemu->btdev_2_type, 0x01);
+	if (!btdev_2) {
+		btdev_destroy(btdev);
+		return false;
+	}
+
 	bthost = bthost_create();
 	if (!bthost) {
 		btdev_destroy(btdev);
+		btdev_destroy(btdev_2);
+		return false;
+	}
+
+	bthost_2 = bthost_create();
+	if (!bthost_2) {
+		bthost_destroy(bthost);
+		btdev_destroy(btdev);
+		btdev_destroy(btdev_2);
 		return false;
 	}
 
 	btdev_set_command_handler(btdev, client_command_callback, hciemu);
+	btdev_set_command_handler(btdev_2, client_command_callback, hciemu);
 
 	if (socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_NONBLOCK | SOCK_CLOEXEC,
 								0, sv) < 0) {
 		bthost_destroy(bthost);
+		bthost_destroy(bthost_2);
 		btdev_destroy(btdev);
+		btdev_destroy(btdev_2);
+		return false;
+	}
+
+	if (socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_NONBLOCK | SOCK_CLOEXEC,
+								0, sv2) < 0) {
+		bthost_destroy(bthost);
+		bthost_destroy(bthost_2);
+		btdev_destroy(btdev);
+		btdev_destroy(btdev_2);
+		close(sv[0]);
+		close(sv[1]);
 		return false;
 	}
 
 	hciemu->client_dev = btdev;
+	hciemu->client_2_dev = btdev_2;
 	hciemu->host_stack = bthost;
+	hciemu->host_2_stack = bthost_2;
 
 	hciemu->client_source = create_source_btdev(sv[0], btdev);
 	hciemu->host_source = create_source_bthost(sv[1], bthost);
 
+	hciemu->client_2_source = create_source_btdev(sv2[0], btdev_2);
+	hciemu->host_2_source = create_source_bthost(sv2[1], bthost_2);
+
 	return true;
 }
 
@@ -305,6 +352,7 @@ static gboolean start_stack(gpointer user_data)
 	struct hciemu *hciemu = user_data;
 
 	bthost_start(hciemu->host_stack);
+	bthost_start(hciemu->host_2_stack);
 
 	return FALSE;
 }
@@ -381,10 +429,14 @@ void hciemu_unref(struct hciemu *hciemu)
 
 	g_source_remove(hciemu->host_source);
 	g_source_remove(hciemu->client_source);
+	g_source_remove(hciemu->host_2_source);
+	g_source_remove(hciemu->client_2_source);
 	g_source_remove(hciemu->master_source);
 
 	bthost_destroy(hciemu->host_stack);
+	bthost_destroy(hciemu->host_2_stack);
 	btdev_destroy(hciemu->client_dev);
+	btdev_destroy(hciemu->client_2_dev);
 	btdev_destroy(hciemu->master_dev);
 
 	free(hciemu);
@@ -427,6 +479,14 @@ const uint8_t *hciemu_get_client_bdaddr(struct hciemu *hciemu)
 	return btdev_get_bdaddr(hciemu->client_dev);
 }
 
+const uint8_t *hciemu_get_client_2_bdaddr(struct hciemu *hciemu)
+{
+	if (!hciemu || !hciemu->client_2_dev)
+		return NULL;
+
+	return btdev_get_bdaddr(hciemu->client_2_dev);
+}
+
 const bool hciemu_is_master_le_scan_enabled(struct hciemu *hciemu)
 {
 	if (!hciemu || !hciemu->master_dev)
diff --git a/emulator/hciemu.h b/emulator/hciemu.h
index 3c2d098..525215d 100644
--- a/emulator/hciemu.h
+++ b/emulator/hciemu.h
@@ -46,12 +46,14 @@ struct hciemu *hciemu_ref(struct hciemu *hciemu);
 void hciemu_unref(struct hciemu *hciemu);
 
 struct bthost *hciemu_client_get_host(struct hciemu *hciemu);
+struct bthost *hciemu_client_2_get_host(struct hciemu *hciemu);
 
 const char *hciemu_get_address(struct hciemu *hciemu);
 uint8_t *hciemu_get_features(struct hciemu *hciemu);
 
 const uint8_t *hciemu_get_master_bdaddr(struct hciemu *hciemu);
 const uint8_t *hciemu_get_client_bdaddr(struct hciemu *hciemu);
+const uint8_t *hciemu_get_client_2_bdaddr(struct hciemu *hciemu);
 
 const bool hciemu_is_master_le_scan_enabled(struct hciemu *hciemu);
 
-- 
2.1.4

