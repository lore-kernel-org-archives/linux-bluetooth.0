Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/bluetooth: Fix memory leak
Date: Fri, 22 Nov 2013 16:21:12 +0200
Message-Id: <1385130072-20503-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/bluetooth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 11b9d76..aa684bd 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -450,6 +450,7 @@ static void update_records(struct browse_req *req, sdp_list_t *recs)
 			memcpy(&uuid128, tmp, sizeof(uuid_t));
 			break;
 		default:
+			sdp_list_free(svcclass, free);
 			continue;
 		}
 
-- 
1.8.3.2

