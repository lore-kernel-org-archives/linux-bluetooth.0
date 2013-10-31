Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] android: Add support for remote device name confirmation
Date: Thu, 31 Oct 2013 15:25:34 +0100
Message-Id: <1383229534-17157-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1383229534-17157-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1383229534-17157-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/adapter.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/android/adapter.c b/android/adapter.c
index e72e45b..10d4a8e 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -390,6 +390,28 @@ static void mgmt_discovering_event(uint16_t index, uint16_t length,
 						sizeof(cp), &cp, -1);
 }
 
+static void confirm_name_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	if (status != MGMT_STATUS_SUCCESS)
+		error("Failed to confirm name: %s (0x%02x)",
+						mgmt_errstr(status), status);
+}
+
+static void confirm_device_name(const bdaddr_t *addr, uint8_t addr_type)
+{
+	struct mgmt_cp_confirm_name cp;
+
+	memset(&cp, 0, sizeof(cp));
+	bacpy(&cp.addr.bdaddr, addr);
+	cp.addr.type = addr_type;
+
+	if (mgmt_reply(adapter->mgmt, MGMT_OP_CONFIRM_NAME, adapter->index,
+					sizeof(cp), &cp, confirm_name_complete,
+					NULL, NULL) == 0)
+		error("Failed to send confirm name request");
+}
+
 static int bdaddr_cmp(gconstpointer a, gconstpointer b)
 {
 	const bdaddr_t *bda = a;
@@ -519,7 +541,13 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 		g_free(buf);
 	}
 
-	/* TODO: name confirmation */
+	if (confirm) {
+		char addr[18];
+
+		ba2str(bdaddr, addr);
+		info("Device %s needs name confirmation.", addr);
+		confirm_device_name(bdaddr, bdaddr_type);
+	}
 
 	eir_data_free(&eir);
 }
-- 
1.8.4.1

