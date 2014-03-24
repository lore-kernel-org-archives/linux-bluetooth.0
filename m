Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 22/22] attrib: Minor code optimization
Date: Mon, 24 Mar 2014 16:25:43 -0300
Message-Id: <1395689143-11091-23-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395689143-11091-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
 <1395689143-11091-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index f57d0bb..7363b4b 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -408,10 +408,8 @@ static struct gatt_included *included_from_buf(const uint8_t *buf, gsize len)
 
 	if (len == 8) {
 		bt_uuid_t uuid128;
-		bt_uuid_t uuid16;
 
-		bt_uuid16_create(&uuid16, get_le16(&buf[6]));
-		bt_uuid_to_uuid128(&uuid16, &uuid128);
+		get_uuid128(BT_UUID16, &buf[6], &uuid128);
 		bt_uuid_to_string(&uuid128, incl->uuid, sizeof(incl->uuid));
 	}
 
-- 
1.8.3.1

