Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] android/avrcp-lib: Fix byte order in avrcp_get_folder_items
Date: Thu,  3 Apr 2014 18:16:41 +0300
Message-Id: <1396538201-14283-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1396538201-14283-1-git-send-email-luiz.dentz@gmail.com>
References: <1396538201-14283-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 62a1c69..3209023 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -1762,16 +1762,23 @@ int avrcp_get_folder_items(struct avrcp *session, uint8_t scope,
 				uint32_t start, uint32_t end, uint8_t number,
 				uint32_t *attrs)
 {
-
 	uint8_t pdu[10 + number * sizeof(uint32_t)];
+	int i;
 
 	pdu[0] = scope;
 	put_be32(start, &pdu[1]);
 	put_be32(end, &pdu[5]);
 	pdu[9] = number;
 
-	memcpy(&pdu[10], attrs, number);
+	if (!number)
+		goto done;
 
+	for (i = 0; i < number; i++)
+		put_be32(attrs[i], &attrs[i]);
+
+	memcpy(&pdu[10], attrs, number * sizeof(*attrs));
+
+done:
 	return avrcp_send_browsing_req(session, AVRCP_GET_FOLDER_ITEMS,
 					pdu, sizeof(pdu),
 					get_folder_items_rsp, session);
-- 
1.9.0

