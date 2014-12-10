Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 08/13] unit/test-mgmt: Add /mgmt/event/2 test
Date: Wed, 10 Dec 2014 16:21:06 +0200
Message-Id: <1418221271-7034-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1418221271-7034-1-git-send-email-luiz.dentz@gmail.com>
References: <1418221271-7034-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This tests if multiple events can be received.
---
 unit/test-mgmt.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/unit/test-mgmt.c b/unit/test-mgmt.c
index a610d1a..331ee42 100644
--- a/unit/test-mgmt.c
+++ b/unit/test-mgmt.c
@@ -314,6 +314,9 @@ static void event_cb(uint16_t index, uint16_t length, const void *param,
 {
 	struct context *context = user_data;
 
+	if (g_test_verbose())
+		printf("Event received\n");
+
 	context_quit(context);
 }
 
@@ -331,6 +334,22 @@ static void test_event(gconstpointer data)
 	execute_context(context);
 }
 
+static void test_event2(gconstpointer data)
+{
+	const struct command_test_data *test = data;
+	struct context *context = create_context();
+
+	mgmt_register(context->mgmt_client, test->opcode, test->index,
+						event_cb, context, NULL);
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
@@ -344,6 +363,7 @@ int main(int argc, char *argv[])
 								test_response);
 
 	g_test_add_data_func("/mgmt/event/1", &event_test_1, test_event);
+	g_test_add_data_func("/mgmt/event/2", &event_test_1, test_event2);
 
 	return g_test_run();
 }
-- 
1.9.3

