Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/8] unit/test-uhid: Add /uhid/event/output test
Date: Wed, 21 May 2014 18:01:08 +0300
Message-Id: <1400684469-2693-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1400684469-2693-1-git-send-email-luiz.dentz@gmail.com>
References: <1400684469-2693-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-uhid.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/unit/test-uhid.c b/unit/test-uhid.c
index cb9b05a..a8aba9b 100644
--- a/unit/test-uhid.c
+++ b/unit/test-uhid.c
@@ -239,6 +239,10 @@ static const struct uhid_event ev_input = {
 	.type = UHID_INPUT,
 };
 
+static const struct uhid_event ev_output = {
+	.type = UHID_OUTPUT,
+};
+
 static void test_client(gconstpointer data)
 {
 	struct context *context = create_context(data);
@@ -259,6 +263,24 @@ static void test_client(gconstpointer data)
 	execute_context(context);
 }
 
+static void handle_output(struct uhid_event *ev, void *user_data)
+{
+	g_assert_cmpint(ev->type, ==, UHID_OUTPUT);
+
+	context_quit(user_data);
+}
+
+static void test_server(gconstpointer data)
+{
+	struct context *context = create_context(data);
+
+	bt_uhid_register(context->uhid, UHID_OUTPUT, handle_output, context);
+
+	g_idle_add(send_pdu, context);
+
+	execute_context(context);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -269,5 +291,7 @@ int main(int argc, char *argv[])
 						event(&ev_feature_answer));
 	define_test("/uhid/command/input", test_client, event(&ev_input));
 
+	define_test("/uhid/event/output", test_server, event(&ev_output));
+
 	return g_test_run();
 }
-- 
1.9.0

