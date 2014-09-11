Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 14/14] android/tester: Verify GATT instace IDs in callbacks
Date: Thu, 11 Sep 2014 08:08:52 +0200
Message-Id: <1410415732-23212-14-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1410415732-23212-1-git-send-email-marcin.kraglak@tieto.com>
References: <1410415732-23212-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/tester-main.c b/android/tester-main.c
index 4513fcb..385c00d 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -402,6 +402,9 @@ static bool verify_gatt_ids(btgatt_gatt_id_t *a, btgatt_gatt_id_t *b)
 	if (memcmp(&a->uuid, &b->uuid, sizeof(bt_uuid_t)))
 		return false;
 
+	if (a->inst_id != b->inst_id)
+		return false;
+
 	return true;
 }
 
-- 
1.9.3

