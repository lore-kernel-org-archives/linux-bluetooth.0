Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 3/4] android/client: Support sending GATT Server responses
Date: Fri, 16 May 2014 13:00:41 +0200
Message-Id: <1400238042-16015-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1400238042-16015-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1400238042-16015-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We prepare response by filling btgatt_response_t union's first member
only. The same thing is done by JNI in Android, which ignores second
member. There is also no parameter to tell which union member is set.
More to this, second union member seams to be redundant duplicate of
first member's inner member (broken API?). JNI method is always called
with auth_req set to 0 thus this parameter is omitted in haltest.
---
 android/client/if-gatt.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index ebf9c59..252e89d 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -64,6 +64,9 @@ const btgatt_interface_t *if_gatt = NULL;
 #define VERIFY_CLIENT_IF(n, v) VERIFY_INT_ARG(n, v, "No client_if specified\n")
 #define VERIFY_SERVER_IF(n, v) VERIFY_INT_ARG(n, v, "No server_if specified\n")
 #define VERIFY_CONN_ID(n, v) VERIFY_INT_ARG(n, v, "No conn_if specified\n")
+#define VERIFY_TRANS_ID(n, v) VERIFY_INT_ARG(n, v, "No trans_id specified\n")
+#define VERIFY_STATUS(n, v) VERIFY_INT_ARG(n, v, "No status specified\n")
+#define VERIFY_OFFSET(n, v) VERIFY_INT_ARG(n, v, "No offset specified\n")
 #define VERIFY_HANDLE(n, v) VERIFY_HEX_ARG(n, v, "No "#v" specified\n")
 #define VERIFY_SERVICE_HANDLE(n, v) VERIFY_HANDLE(n, v)
 
@@ -1751,7 +1754,38 @@ static void gatts_send_indication_p(int argc, const char *argv[])
 
 static void gatts_send_response_p(int argc, const char *argv[])
 {
-	haltest_warn("%s is not implemented yet\n", __func__);
+	int conn_id;
+	int trans_id;
+	int status;
+	btgatt_response_t data;
+
+	memset(&data, 0, sizeof(data));
+
+	RETURN_IF_NULL(if_gatt);
+
+	VERIFY_CONN_ID(2, conn_id);
+	VERIFY_TRANS_ID(3, trans_id);
+	VERIFY_STATUS(4, status);
+	VERIFY_HANDLE(5, data.attr_value.handle);
+	VERIFY_OFFSET(6, data.attr_value.offset);
+
+	data.attr_value.auth_req = 0;
+	data.attr_value.len = 0;
+
+	if (argc <= 7) {
+		haltest_error("No data specified\n");
+		return;
+	}
+
+	data.attr_value.len = strlen(argv[7]);
+	scan_field(argv[7], data.attr_value.len, data.attr_value.value,
+						sizeof(data.attr_value.value));
+
+
+	haltest_info("conn_id %d, trans_id %d, status %d", conn_id, trans_id,
+									status);
+
+	EXEC(if_gatt->server->send_response, conn_id, trans_id, status, &data);
 }
 
 #define GATTS_METHODH(n, h) METHOD(#n, gatts_##n##_p, NULL, h)
@@ -1775,7 +1809,8 @@ static struct method server_methods[] = {
 	GATTS_METHODCH(delete_service, "<server_if> <service_handle>"),
 	GATTS_METHODH(send_indication,
 			"<server_if> <attr_handle> <conn_id> <confirm> [<data>]"),
-	GATTS_METHODH(send_response, "<conn_id> <trans_id> <status>"),
+	GATTS_METHODH(send_response,
+		"<conn_id> <trans_id> <status> <handle> <offset> [<data>]"),
 	END_METHOD
 };
 
-- 
1.9.3

