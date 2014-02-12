Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android: Fix memory leak: uuid free
Date: Wed, 12 Feb 2014 16:22:07 +0200
Message-Id: <1392214927-2715-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Free uuid before exiting.
---
 android/bluetooth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 5de3401..b818e88 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1557,6 +1557,8 @@ int bt_adapter_add_record(sdp_record_t *rec, uint8_t svc_hint)
 
 		sdp_uuid2strn(uuid, uuid_str, sizeof(uuid_str));
 		DBG("UUID %s already added", uuid_str);
+
+		bt_free(uuid);
 		return -EALREADY;
 	}
 
-- 
1.8.3.2

