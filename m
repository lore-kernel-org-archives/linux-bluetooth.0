Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/9] android/avrcp: Refactor get_caps() to allow parameter
Date: Fri, 28 Feb 2014 10:22:50 +0200
Message-Id: <1393575778-28681-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1393575778-28681-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1393575778-28681-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Allow passing parameter specifying capability ID.
---
 android/avrcp-lib.c | 6 ++----
 android/avrcp-lib.h | 4 ++--
 unit/test-avrcp.c   | 3 ++-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 1b5a294..6ae8df8 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -297,11 +297,9 @@ static int avrcp_send_req(struct avrcp *session, uint8_t code, uint8_t subunit,
 					session->tx_buf, len, func, user_data);
 }
 
-int avrcp_get_capabilities(struct avrcp *session, avctp_rsp_cb func,
-							void *user_data)
+int avrcp_get_capabilities(struct avrcp *session, uint8_t param,
+					avctp_rsp_cb func, void *user_data)
 {
-	uint8_t param = CAP_EVENTS_SUPPORTED;
-
 	return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANEL,
 				AVRCP_GET_CAPABILITIES, &param, sizeof(param),
 				func, user_data);
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 75802b9..e6e12c1 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -106,5 +106,5 @@ void avrcp_set_passthrough_handlers(struct avrcp *session,
 int avrcp_init_uinput(struct avrcp *session, const char *name,
 							const char *address);
 
-int avrcp_get_capabilities(struct avrcp *session, avctp_rsp_cb func,
-							void *user_data);
+int avrcp_get_capabilities(struct avrcp *session, uint8_t param,
+					avctp_rsp_cb func, void *user_data);
diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index bcd8f88..f222df8 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -353,7 +353,8 @@ static void test_client(gconstpointer data)
 	struct context *context = create_context(0x0100, data);
 
 	if (g_str_equal(context->data->test_name, "/TP/CFG/BV-01-C"))
-		avrcp_get_capabilities(context->session, NULL, NULL);
+		avrcp_get_capabilities(context->session, CAP_EVENTS_SUPPORTED,
+								NULL, NULL);
 
 	execute_context(context);
 }
-- 
1.8.3.2

