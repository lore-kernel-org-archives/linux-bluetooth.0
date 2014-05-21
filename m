Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/8] unit/test-uhid: Add /uhid/command/feature_answer test
Date: Wed, 21 May 2014 18:01:05 +0300
Message-Id: <1400684469-2693-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1400684469-2693-1-git-send-email-luiz.dentz@gmail.com>
References: <1400684469-2693-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-uhid.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/unit/test-uhid.c b/unit/test-uhid.c
index 25216b8..b8bb3a4 100644
--- a/unit/test-uhid.c
+++ b/unit/test-uhid.c
@@ -231,6 +231,10 @@ static const struct uhid_event ev_destroy = {
 	.type = UHID_DESTROY,
 };
 
+static const struct uhid_event ev_feature_answer = {
+	.type = UHID_FEATURE_ANSWER,
+};
+
 static void test_client(gconstpointer data)
 {
 	struct context *context = create_context(data);
@@ -241,6 +245,10 @@ static void test_client(gconstpointer data)
 	if (g_str_equal(context->data->test_name, "/uhid/command/destroy"))
 		bt_uhid_send(context->uhid, &ev_destroy);
 
+	if (g_str_equal(context->data->test_name,
+						"/uhid/command/feature_answer"))
+		bt_uhid_send(context->uhid, &ev_feature_answer);
+
 	execute_context(context);
 }
 
@@ -250,6 +258,8 @@ int main(int argc, char *argv[])
 
 	define_test("/uhid/command/create", test_client, event(&ev_create));
 	define_test("/uhid/command/destroy", test_client, event(&ev_destroy));
+	define_test("/uhid/command/feature_answer", test_client,
+						event(&ev_feature_answer));
 
 	return g_test_run();
 }
-- 
1.9.0

