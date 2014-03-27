Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/2] attrib/gatttool: Use define for UUID format check
Date: Thu, 27 Mar 2014 15:03:29 +0100
Message-Id: <1395929009-23366-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1395929009-23366-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1395929009-23366-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatttool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index ca178ce..5e0f820 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -426,7 +426,7 @@ static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		value = list->data[i];
 		handle = get_le16(value);
 
-		if (format == 0x01)
+		if (format == ATT_FIND_INFO_RESP_FMT_16BIT)
 			bt_uuid16_create(&uuid, get_le16(&value[2]));
 		else {
 			uint128_t u128;
-- 
1.9.0

