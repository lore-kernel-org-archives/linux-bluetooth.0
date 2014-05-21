Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/8] unit/test-uhid: Add /uhid/command/input test
Date: Wed, 21 May 2014 18:01:06 +0300
Message-Id: <1400684469-2693-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1400684469-2693-1-git-send-email-luiz.dentz@gmail.com>
References: <1400684469-2693-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-uhid.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/unit/test-uhid.c b/unit/test-uhid.c
index b8bb3a4..cb9b05a 100644
--- a/unit/test-uhid.c
+++ b/unit/test-uhid.c
@@ -235,6 +235,10 @@ static const struct uhid_event ev_feature_answer = {
 	.type = UHID_FEATURE_ANSWER,
 };
 
+static const struct uhid_event ev_input = {
+	.type = UHID_INPUT,
+};
+
 static void test_client(gconstpointer data)
 {
 	struct context *context = create_context(data);
@@ -249,6 +253,9 @@ static void test_client(gconstpointer data)
 						"/uhid/command/feature_answer"))
 		bt_uhid_send(context->uhid, &ev_feature_answer);
 
+	if (g_str_equal(context->data->test_name, "/uhid/command/input"))
+		bt_uhid_send(context->uhid, &ev_input);
+
 	execute_context(context);
 }
 
@@ -260,6 +267,7 @@ int main(int argc, char *argv[])
 	define_test("/uhid/command/destroy", test_client, event(&ev_destroy));
 	define_test("/uhid/command/feature_answer", test_client,
 						event(&ev_feature_answer));
+	define_test("/uhid/command/input", test_client, event(&ev_input));
 
 	return g_test_run();
 }
-- 
1.9.0

