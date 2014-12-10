Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 10/13] unit/test-mgmt: Add /mgmt/unregister/2 test
Date: Wed, 10 Dec 2014 16:21:08 +0200
Message-Id: <1418221271-7034-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1418221271-7034-1-git-send-email-luiz.dentz@gmail.com>
References: <1418221271-7034-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This tests if mgmt_unregister_index can be called within event callback.
---
 unit/test-mgmt.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/unit/test-mgmt.c b/unit/test-mgmt.c
index 8dcaa4b..8cd5565 100644
--- a/unit/test-mgmt.c
+++ b/unit/test-mgmt.c
@@ -376,6 +376,32 @@ static void test_unregister_all(gconstpointer data)
 	execute_context(context);
 }
 
+static void unregister_index_cb(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct context *context = user_data;
+
+	mgmt_unregister_index(context->mgmt_client, index);
+
+	context_quit(context);
+}
+
+static void test_unregister_index(gconstpointer data)
+{
+	const struct command_test_data *test = data;
+	struct context *context = create_context();
+
+	mgmt_register(context->mgmt_client, test->opcode, test->index,
+					unregister_index_cb, context, NULL);
+	mgmt_register(context->mgmt_client, test->opcode, test->index,
+						event_cb, context, NULL);
+
+	g_assert_cmpint(write(context->fd, test->cmd_data, test->cmd_size), ==,
+								test->cmd_size);
+
+	execute_context(context);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -393,6 +419,8 @@ int main(int argc, char *argv[])
 
 	g_test_add_data_func("/mgmt/unregister/1", &event_test_1,
 							test_unregister_all);
+	g_test_add_data_func("/mgmt/unregister/2", &event_test_1,
+							test_unregister_index);
 
 	return g_test_run();
 }
-- 
1.9.3

