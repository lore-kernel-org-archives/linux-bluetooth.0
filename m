Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 11/12] unit/test-mgmt: Add /mgmt/destroy/1 test
Date: Mon,  8 Dec 2014 18:05:15 +0200
Message-Id: <1418054716-24231-12-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1418054716-24231-1-git-send-email-luiz.dentz@gmail.com>
References: <1418054716-24231-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This tests if mgmt_unref can be called within event callback.
---
 unit/test-mgmt.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/unit/test-mgmt.c b/unit/test-mgmt.c
index 8cd5565..c67678b 100644
--- a/unit/test-mgmt.c
+++ b/unit/test-mgmt.c
@@ -386,6 +386,17 @@ static void unregister_index_cb(uint16_t index, uint16_t length,
 	context_quit(context);
 }
 
+static void destroy_cb(uint16_t index, uint16_t length, const void *param,
+							void *user_data)
+{
+	struct context *context = user_data;
+
+	mgmt_unref(context->mgmt_client);
+	context->mgmt_client = NULL;
+
+	context_quit(context);
+}
+
 static void test_unregister_index(gconstpointer data)
 {
 	const struct command_test_data *test = data;
@@ -402,6 +413,22 @@ static void test_unregister_index(gconstpointer data)
 	execute_context(context);
 }
 
+static void test_destroy(gconstpointer data)
+{
+	const struct command_test_data *test = data;
+	struct context *context = create_context();
+
+	mgmt_register(context->mgmt_client, test->opcode, test->index,
+					destroy_cb, context, NULL);
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
@@ -422,5 +449,7 @@ int main(int argc, char *argv[])
 	g_test_add_data_func("/mgmt/unregister/2", &event_test_1,
 							test_unregister_index);
 
+	g_test_add_data_func("/mgmt/destroy/1", &event_test_1, test_destroy);
+
 	return g_test_run();
 }
-- 
1.9.3

