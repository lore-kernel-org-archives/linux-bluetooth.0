Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 8/8] unit/test-uhid: Add /uhid/event/feature test
Date: Wed, 21 May 2014 18:01:09 +0300
Message-Id: <1400684469-2693-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1400684469-2693-1-git-send-email-luiz.dentz@gmail.com>
References: <1400684469-2693-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-uhid.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/unit/test-uhid.c b/unit/test-uhid.c
index a8aba9b..85e1356 100644
--- a/unit/test-uhid.c
+++ b/unit/test-uhid.c
@@ -243,6 +243,10 @@ static const struct uhid_event ev_output = {
 	.type = UHID_OUTPUT,
 };
 
+static const struct uhid_event ev_feature = {
+	.type = UHID_FEATURE,
+};
+
 static void test_client(gconstpointer data)
 {
 	struct context *context = create_context(data);
@@ -270,11 +274,19 @@ static void handle_output(struct uhid_event *ev, void *user_data)
 	context_quit(user_data);
 }
 
+static void handle_feature(struct uhid_event *ev, void *user_data)
+{
+	g_assert_cmpint(ev->type, ==, UHID_FEATURE);
+
+	context_quit(user_data);
+}
+
 static void test_server(gconstpointer data)
 {
 	struct context *context = create_context(data);
 
 	bt_uhid_register(context->uhid, UHID_OUTPUT, handle_output, context);
+	bt_uhid_register(context->uhid, UHID_FEATURE, handle_feature, context);
 
 	g_idle_add(send_pdu, context);
 
@@ -292,6 +304,7 @@ int main(int argc, char *argv[])
 	define_test("/uhid/command/input", test_client, event(&ev_input));
 
 	define_test("/uhid/event/output", test_server, event(&ev_output));
+	define_test("/uhid/event/feature", test_server, event(&ev_feature));
 
 	return g_test_run();
 }
-- 
1.9.0

