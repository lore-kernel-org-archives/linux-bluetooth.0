Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/8] unit/test-uhid: Add /uhid/command/destroy test
Date: Wed, 21 May 2014 18:01:04 +0300
Message-Id: <1400684469-2693-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1400684469-2693-1-git-send-email-luiz.dentz@gmail.com>
References: <1400684469-2693-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-uhid.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/unit/test-uhid.c b/unit/test-uhid.c
index e4b53e6..25216b8 100644
--- a/unit/test-uhid.c
+++ b/unit/test-uhid.c
@@ -227,6 +227,10 @@ static const struct uhid_event ev_create = {
 	.type = UHID_CREATE,
 };
 
+static const struct uhid_event ev_destroy = {
+	.type = UHID_DESTROY,
+};
+
 static void test_client(gconstpointer data)
 {
 	struct context *context = create_context(data);
@@ -234,6 +238,9 @@ static void test_client(gconstpointer data)
 	if (g_str_equal(context->data->test_name, "/uhid/command/create"))
 		bt_uhid_send(context->uhid, &ev_create);
 
+	if (g_str_equal(context->data->test_name, "/uhid/command/destroy"))
+		bt_uhid_send(context->uhid, &ev_destroy);
+
 	execute_context(context);
 }
 
@@ -242,6 +249,7 @@ int main(int argc, char *argv[])
 	g_test_init(&argc, &argv, NULL);
 
 	define_test("/uhid/command/create", test_client, event(&ev_create));
+	define_test("/uhid/command/destroy", test_client, event(&ev_destroy));
 
 	return g_test_run();
 }
-- 
1.9.0

