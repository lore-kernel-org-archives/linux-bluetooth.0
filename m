Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 12/35] emulator: Add remove operation in HCI hook callback
Date: Wed, 12 Jun 2013 08:56:58 -0400
Message-Id: <1371041841-21793-13-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now it is possible remove the HCI hook callback after running it at
least once. It working similar to glib watchers, and it is removed when
the function calback return false, otherwise it is kept.
---
 src/shared/hciemu.c |   24 ++++++++++++++++++++----
 src/shared/hciemu.h |    2 +-
 tools/mgmt-tester.c |   10 ++++++----
 3 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/src/shared/hciemu.c b/src/shared/hciemu.c
index a0b347c..7ff651e 100644
--- a/src/shared/hciemu.c
+++ b/src/shared/hciemu.c
@@ -66,21 +66,37 @@ static void destroy_command_hook(gpointer data, gpointer user_data)
 	g_free(hook);
 }
 
+static void remove_command_hook(GList **lhooks,
+					struct hciemu_command_hook *hook)
+{
+	*lhooks = g_list_remove(*lhooks, hook);
+	g_free(hook);
+}
+
 static void master_command_callback(uint16_t opcode,
 				const void *data, uint8_t len,
 				btdev_callback callback, void *user_data)
 {
 	struct hciemu *hciemu = user_data;
-	GList *list;
+	GList *list, *next;
 
 	btdev_command_default(callback);
 
 	for (list = g_list_first(hciemu->post_command_hooks); list;
-						list = g_list_next(list)) {
+								list = next) {
 		struct hciemu_command_hook *hook = list->data;
 
-		if (hook->function)
-			hook->function(opcode, data, len, hook->user_data);
+		next = g_list_next(list);
+
+		if (hook->function) {
+			int ret;
+
+			ret = hook->function(opcode, data, len,
+							hook->user_data);
+			if (!ret)
+				remove_command_hook(&hciemu->post_command_hooks,
+									hook);
+		}
 	}
 }
 
diff --git a/src/shared/hciemu.h b/src/shared/hciemu.h
index a473c0e..dc7cc1f 100644
--- a/src/shared/hciemu.h
+++ b/src/shared/hciemu.h
@@ -44,7 +44,7 @@ const char *hciemu_get_address(struct hciemu *hciemu);
 const uint8_t *hciemu_get_master_bdaddr(struct hciemu *hciemu);
 const uint8_t *hciemu_get_client_bdaddr(struct hciemu *hciemu);
 
-typedef void (*hciemu_command_func_t)(uint16_t opcode, const void *data,
+typedef bool (*hciemu_command_func_t)(uint16_t opcode, const void *data,
 						uint8_t len, void *user_data);
 
 bool hciemu_add_master_post_command_hook(struct hciemu *hciemu,
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 844f7db..08b5ac8 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -2300,7 +2300,7 @@ static void command_generic_callback(uint8_t status, uint16_t length,
 	test_condition_complete(data);
 }
 
-static void command_hci_callback(uint16_t opcode, const void *param,
+static bool command_hci_callback(uint16_t opcode, const void *param,
 					uint8_t length, void *user_data)
 {
 	struct test_data *data = user_data;
@@ -2309,21 +2309,23 @@ static void command_hci_callback(uint16_t opcode, const void *param,
 	tester_print("HCI Command 0x%04x length %u", opcode, length);
 
 	if (opcode != test->expect_hci_command)
-		return;
+		return true;
 
 	if (length != test->expect_hci_len) {
 		tester_warn("Invalid parameter size for HCI command");
 		tester_test_failed();
-		return;
+		return false;
 	}
 
 	if (memcmp(param, test->expect_hci_param, length) != 0) {
 		tester_warn("Unexpected HCI command parameter value");
 		tester_test_failed();
-		return;
+		return false;
 	}
 
 	test_condition_complete(data);
+
+	return true;
 }
 
 static void test_command_generic(const void *test_data)
-- 
1.7.9.5

