Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 4/6] android/gatt: Use cached handle for descriptors discovery
Date: Fri, 18 Apr 2014 02:40:22 +0200
Message-Id: <1397781624-23817-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1397781624-23817-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1397781624-23817-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We can now just use cached end handle from characteristic instead of
calculating it.
---
 android/gatt.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 18f1a37..15107b9 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1979,21 +1979,11 @@ static bool build_descr_cache(int32_t conn_id, struct gatt_device *dev,
 					struct characteristic *ch)
 {
 	struct discover_desc_data *cb_data;
-	struct characteristic *next_ch;
 	uint16_t start, end;
 
 	/* Clip range to given characteristic */
 	start = ch->ch.value_handle + 1;
-	end = srvc->primary ? srvc->prim.range.end : srvc->incl.range.end;
-
-	/* Use next characteristic start as end. If there is none -
-	 * service end is valid end.
-	 * TODO: we should cache char end handle to avoid this search
-	 */
-	next_ch = queue_find(srvc->chars, match_char_by_higher_inst_id,
-					INT_TO_PTR(ch->id.instance));
-	if (next_ch)
-		end = next_ch->ch.handle - 1;
+	end = ch->end_handle;
 
 	/* If there are no descriptors, notify with fail status. */
 	if (start > end)
-- 
1.9.2

