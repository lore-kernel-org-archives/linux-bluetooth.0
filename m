Return-Path: <cyrus@holtmann.org>
From: "Dirk-Jan C. Binnema" <djcb.bulk@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: "Dirk-Jan C. Binnema" <djcb@djcbsoftware.nl>
Subject: [PATCH 1/3] Update gatt_service_add size assert for dealing with 128-bit uuids
Date: Mon, 29 Jul 2013 11:42:48 -0700
Message-Id: <1375123370-20055-1-git-send-email-djcb.bulk@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Dirk-Jan C. Binnema" <djcb@djcbsoftware.nl>

To paraphrase Anderson Lizardo: "h" was overflowing for 128-bit services
because the handle is incremented after each attribute is added so at the
end we had: 0xffff + 1 == 0 (h is uint16_t).

As it seems more complex to try to remove the overflow without
affecting the logic too much, we update the assertion.
---
 attrib/gatt-service.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
index 4b02d39..1b84c89 100644
--- a/attrib/gatt-service.c
+++ b/attrib/gatt-service.c
@@ -341,7 +341,7 @@ gboolean gatt_service_add(struct btd_adapter *adapter, uint16_t uuid,
 	}
 
 	g_assert(size < USHRT_MAX);
-	g_assert(h - start_handle == (uint16_t) size);
+	g_assert(h == 0 || (h - start_handle == (uint16_t) size));
 	g_slist_free_full(chrs, free_gatt_info);
 
 	return TRUE;
-- 
1.8.1.4

