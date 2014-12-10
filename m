Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 09/13] unit/test-mgmt: Add /mgmt/unregister/1 test
Date: Wed, 10 Dec 2014 16:21:07 +0200
Message-Id: <1418221271-7034-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1418221271-7034-1-git-send-email-luiz.dentz@gmail.com>
References: <1418221271-7034-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This tests if mgmt_unregister_all can be called within event callback.
---
 unit/test-mgmt.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/unit/test-mgmt.c b/unit/test-mgmt.c
index 331ee42..8dcaa4b 100644
--- a/unit/test-mgmt.c
+++ b/unit/test-mgmt.c
@@ -350,6 +350,32 @@ static void test_event2(gconstpointer data)
 	execute_context(context);
 }
 
+static void unregister_all_cb(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct context *context = user_data;
+
+	mgmt_unregister_all(context->mgmt_client);
+
+	context_quit(context);
+}
+
+static void test_unregister_all(gconstpointer data)
+{
+	const struct command_test_data *test = data;
+	struct context *context = create_context();
+
+	mgmt_register(context->mgmt_client, test->opcode, test->index,
+					unregister_all_cb, context, NULL);
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
@@ -365,5 +391,8 @@ int main(int argc, char *argv[])
 	g_test_add_data_func("/mgmt/event/1", &event_test_1, test_event);
 	g_test_add_data_func("/mgmt/event/2", &event_test_1, test_event2);
 
+	g_test_add_data_func("/mgmt/unregister/1", &event_test_1,
+							test_unregister_all);
+
 	return g_test_run();
 }
-- 
1.9.3

