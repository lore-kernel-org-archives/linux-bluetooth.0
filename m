Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH] tools: Fix glib assert in mgmt-tester if hci_vhci module is not loaded
Date: Mon, 21 Jan 2013 21:25:54 +0100
Message-Id: <1358799954-6140-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Print descriptive warning on HCI emulation setup failure and fail test
gracefully. This is better comparing to glib assertion when not fully
initialized HCI emulation is being unreferenced.
---
 src/shared/hciemu.c | 31 ++++++++++++++++++++++---------
 tools/mgmt-tester.c |  4 ++++
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/src/shared/hciemu.c b/src/shared/hciemu.c
index d523743..a15102d 100644
--- a/src/shared/hciemu.c
+++ b/src/shared/hciemu.c
@@ -188,7 +188,7 @@ static guint create_source_btdev(int fd, struct btdev *btdev)
 	return source;
 }
 
-static void create_vhci(struct hciemu *hciemu)
+static bool create_vhci(struct hciemu *hciemu)
 {
 	struct btdev *btdev;
 	uint8_t bdaddr[6];
@@ -197,7 +197,7 @@ static void create_vhci(struct hciemu *hciemu)
 
 	btdev = btdev_create(BTDEV_TYPE_BREDR, 0x00);
 	if (!btdev)
-		return;
+		return false;
 
 	str = hciemu_get_address(hciemu);
 
@@ -210,15 +210,17 @@ static void create_vhci(struct hciemu *hciemu)
 	fd = open("/dev/vhci", O_RDWR | O_NONBLOCK | O_CLOEXEC);
 	if (fd < 0) {
 		btdev_destroy(btdev);
-		return;
+		return false;
 	}
 
 	hciemu->master_dev = btdev;
 
 	hciemu->master_source = create_source_btdev(fd, btdev);
+
+	return true;
 }
 
-static void create_stack(struct hciemu *hciemu)
+static bool create_stack(struct hciemu *hciemu)
 {
 	struct btdev *btdev;
 	struct bthost *bthost;
@@ -226,12 +228,12 @@ static void create_stack(struct hciemu *hciemu)
 
 	btdev = btdev_create(BTDEV_TYPE_BREDR, 0x00);
 	if (!btdev)
-		return;
+		return false;
 
 	bthost = bthost_create();
 	if (!bthost) {
 		btdev_destroy(btdev);
-		return;
+		return false;
 	}
 
 	btdev_set_command_handler(btdev, client_command_callback, hciemu);
@@ -240,7 +242,7 @@ static void create_stack(struct hciemu *hciemu)
 								0, sv) < 0) {
 		bthost_destroy(bthost);
 		btdev_destroy(btdev);
-		return;
+		return false;
 	}
 
 	hciemu->client_dev = btdev;
@@ -248,6 +250,8 @@ static void create_stack(struct hciemu *hciemu)
 
 	hciemu->client_source = create_source_btdev(sv[0], btdev);
 	hciemu->host_source = create_source_bthost(sv[1], bthost);
+
+	return true;
 }
 
 static gboolean start_stack(gpointer user_data)
@@ -267,8 +271,17 @@ struct hciemu *hciemu_new(void)
 	if (!hciemu)
 		return NULL;
 
-	create_vhci(hciemu);
-	create_stack(hciemu);
+	if (!create_vhci(hciemu)) {
+		g_free(hciemu);
+		return NULL;
+	}
+
+	if (!create_stack(hciemu)) {
+		g_source_remove(hciemu->master_source);
+		btdev_destroy(hciemu->master_dev);
+		g_free(hciemu);
+		return NULL;
+	}
 
 	g_idle_add(start_stack, hciemu);
 
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index bf61f9d..63e7714 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -217,6 +217,10 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 					index_removed_callback, NULL, NULL);
 
 	data->hciemu = hciemu_new();
+	if (!data->hciemu) {
+		tester_warn("Failed to setup HCI emulation");
+		tester_pre_setup_failed();
+	}
 }
 
 static void test_pre_setup(const void *test_data)
-- 
1.8.1

