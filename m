Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 2/9] unit/avdtp: Add duplicate SEID test
Date: Fri, 13 Feb 2015 11:06:01 +0200
Message-Id: <1423818368-15899-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1423818368-15899-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1423818368-15899-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add test adding two SEP, then remove first and create another one. With
the current code new SEP has the same SEID (2!). Following patches
fixing the bug.
---
 unit/test-avdtp.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index c9ff014..b6ab72c 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -583,6 +583,46 @@ static void test_server_seid(gconstpointer data)
 	lseps = NULL;
 }
 
+static void test_server_seid_duplicate(gconstpointer data)
+{
+	struct context *context = create_context(0x0103, data);
+	struct avdtp_local_sep *sep;
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		sep = avdtp_register_sep(AVDTP_SEP_TYPE_SINK,
+						AVDTP_MEDIA_TYPE_AUDIO,
+						0x00, TRUE, &sep_ind, NULL,
+						context);
+		g_assert(sep);
+
+		lseps = g_slist_append(lseps, sep);
+	}
+
+	/* Remove 1st element */
+	sep = g_slist_nth_data(lseps, 0);
+	lseps = g_slist_remove(lseps, sep);
+	avdtp_unregister_sep(sep);
+
+	/* Now register new element */
+	sep = avdtp_register_sep(AVDTP_SEP_TYPE_SINK,
+						AVDTP_MEDIA_TYPE_AUDIO,
+						0x00, TRUE, &sep_ind, NULL,
+						context);
+	g_assert(sep);
+	lseps = g_slist_append(lseps, sep);
+
+	/* Check SEID ids */
+
+	g_idle_add(send_pdu, context);
+
+	execute_context(context);
+
+	/* Remove all SEPs */
+	g_slist_free_full(lseps, unregister_sep);
+	lseps = NULL;
+}
+
 static gboolean sep_getcap_ind_frg(struct avdtp *session,
 					struct avdtp_local_sep *sep,
 					GSList **caps, uint8_t *err,
@@ -772,6 +812,9 @@ int main(int argc, char *argv[])
 	 */
 	define_test("/TP/SIG/SMG/BV-06-C-SEID-1", test_server_seid,
 			raw_pdu(0x00));
+	define_test("/TP/SIG/SMG/BV-06-C-SEID-2", test_server_seid_duplicate,
+			raw_pdu(0x00, 0x01),
+			raw_pdu(0x02, 0x01, 0x08, 0x08, 0x08, 0x08));
 	define_test("/TP/SIG/SMG/BV-05-C", test_client,
 			raw_pdu(0x00, 0x01));
 	define_test("/TP/SIG/SMG/BV-06-C", test_server,
-- 
2.1.0

