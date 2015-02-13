Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 1/9] unit/avdtp: Add SEP register/unregister tests
Date: Fri, 13 Feb 2015 11:06:00 +0200
Message-Id: <1423818368-15899-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1423818368-15899-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1423818368-15899-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add register_sep and unregister_sep testing registering maximum amount
of SEPs.
---
 unit/test-avdtp.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index 8fe5ce3..c9ff014 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -39,6 +39,10 @@
 #include "src/log.h"
 #include "android/avdtp.h"
 
+#define MAX_SEID 0x3E
+
+GSList *lseps = NULL;
+
 struct test_pdu {
 	bool valid;
 	bool fragmented;
@@ -551,6 +555,34 @@ static void test_server_0_sep(gconstpointer data)
 	execute_context(context);
 }
 
+static void unregister_sep(void *data)
+{
+	struct avdtp_local_sep *sep = data;
+
+	avdtp_unregister_sep(sep);
+}
+
+static void test_server_seid(gconstpointer data)
+{
+	struct context *context = create_context(0x0103, data);
+	struct avdtp_local_sep *sep;
+	int i;
+
+	for (i = 0; i < MAX_SEID; i++) {
+		sep = avdtp_register_sep(AVDTP_SEP_TYPE_SINK,
+						AVDTP_MEDIA_TYPE_AUDIO,
+						0x00, TRUE, &sep_ind, NULL,
+						context);
+		g_assert(sep);
+
+		lseps = g_slist_append(lseps, sep);
+	}
+
+	/* Remove all SEPs */
+	g_slist_free_full(lseps, unregister_sep);
+	lseps = NULL;
+}
+
 static gboolean sep_getcap_ind_frg(struct avdtp *session,
 					struct avdtp_local_sep *sep,
 					GSList **caps, uint8_t *err,
@@ -738,6 +770,8 @@ int main(int argc, char *argv[])
 	 * To verify that the following procedures are implemented according to
 	 * their specification in AVDTP.
 	 */
+	define_test("/TP/SIG/SMG/BV-06-C-SEID-1", test_server_seid,
+			raw_pdu(0x00));
 	define_test("/TP/SIG/SMG/BV-05-C", test_client,
 			raw_pdu(0x00, 0x01));
 	define_test("/TP/SIG/SMG/BV-06-C", test_server,
-- 
2.1.0

