Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH] Fix repeated insertion of uuids when a device driver is matched
Date: Sat, 22 May 2010 12:01:39 +0200
Message-Id: <1274522499-7844-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/src/device.c b/src/device.c
index 6ba1612..2b6b97f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1085,7 +1085,9 @@ static GSList *device_match_driver(struct btd_device *device,
 		/* match pattern driver */
 		match = device_match_pattern(device, *uuid, profiles);
 		for (; match; match = match->next)
-			uuids = g_slist_append(uuids, match->data);
+			if (!g_slist_find_custom(uuids, match->data,
+					(GCompareFunc) strcasecmp))
+				uuids = g_slist_append(uuids, match->data);
 	}
 
 	return uuids;
-- 
1.6.3.3

