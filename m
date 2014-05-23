Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] android/gatt: Add debug logs useful for PTS testing
Date: Fri, 23 May 2014 15:49:06 +0200
Message-Id: <1400852946-24498-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 532a416..804c6ba 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2165,6 +2165,9 @@ static void cache_all_srvc_chars(struct service *srvc, GSList *characteristics)
 							srvc->incl.range.end;
 		}
 
+		DBG("attr handle = 0x%04x, end handle = 0x%04x uuid: %s",
+				ch->ch.handle ,ch->end_handle, ch->ch.uuid);
+
 		if (!queue_push_tail(srvc->chars, ch)) {
 			error("gatt: Error while caching characteristic");
 			destroy_characteristic(ch);
@@ -2321,6 +2324,8 @@ static void gatt_discover_desc_cb(guint8 status, GSList *descs,
 		descr->id.instance = i++;
 		descr->handle = desc->handle;
 
+		DBG("attr handle = 0x%04x, uuid: %s", desc->handle, desc->uuid);
+
 		if (!queue_push_tail(ch->descriptors, descr))
 			free(descr);
 	}
-- 
1.8.4

