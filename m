Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH] Fix device_match_pattern function
Date: Thu, 20 May 2010 12:09:01 +0200
Message-Id: <1274350142-19083-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes a problem adding uuids to list provided when a
driver is probed. Without this patch the same uuids were added
more than once to list and if two or more uuids were in the
same class id list only the first one was included repeatedly
---
 src/device.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/device.c b/src/device.c
index 6ba1612..d0768ce 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1053,7 +1053,7 @@ static GSList *device_match_pattern(struct btd_device *device,
 			continue;
 
 		if (record_has_uuid(rec, match_uuid))
-			uuids = g_slist_append(uuids, profile_uuid);
+			uuids = g_slist_append(uuids, match_uuid);
 	}
 
 	return uuids;
-- 
1.6.3.3

