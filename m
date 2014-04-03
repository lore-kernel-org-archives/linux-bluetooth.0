Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] android/avrcp-lib: Fix byte order in avrcp_get_item_attributes
Date: Thu,  3 Apr 2014 18:16:40 +0300
Message-Id: <1396538201-14283-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1396538201-14283-1-git-send-email-luiz.dentz@gmail.com>
References: <1396538201-14283-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index d6459ce..62a1c69 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -1868,15 +1868,22 @@ int avrcp_get_item_attributes(struct avrcp *session, uint8_t scope,
 				uint32_t *attrs)
 {
 	uint8_t pdu[12 + number * sizeof(uint32_t)];
+	int i;
 
 	pdu[0] = scope;
 	put_be64(uid, &pdu[1]);
 	put_be16(counter, &pdu[9]);
 	pdu[11] = number;
 
-	if (number > 0)
-		memcpy(&pdu[12], attrs, number * sizeof(uint32_t));
+	if (!number)
+		goto done;
 
+	for (i = 0; i < number; i++)
+		put_be32(attrs[i], &attrs[i]);
+
+	memcpy(&pdu[12], attrs, number * sizeof(uint32_t));
+
+done:
 	return avrcp_send_browsing_req(session, AVRCP_GET_ITEM_ATTRIBUTES,
 					pdu, sizeof(pdu),
 					get_item_attributes_rsp, session);
-- 
1.9.0

