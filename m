Return-Path: <cyrus@holtmann.org>
From: "Dirk-Jan C. Binnema" <djcb.bulk@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: "Dirk-Jan C. Binnema" <djcb@djcbsoftware.nl>
Subject: [PATCH 1/3] gatt-service: fix assertion in gatt_service_add for 128-bit uuids
Date: Thu, 25 Jul 2013 07:35:23 +0300
Message-Id: <1374726925-14571-1-git-send-email-djcb.bulk@gmail.com>
In-Reply-To: <CAJdJm_Op5rnFqxXq7dVN0m9hWr-Dtt1iwK4KnnGN9YcOGrZ3+A@mail.gmail.com>
References: <CAJdJm_Op5rnFqxXq7dVN0m9hWr-Dtt1iwK4KnnGN9YcOGrZ3+A@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Dirk-Jan C. Binnema" <djcb@djcbsoftware.nl>

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
1.8.3.2

