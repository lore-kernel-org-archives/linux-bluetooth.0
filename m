Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 2/2] Fix memory leak of matched device drivers list
Date: Wed, 23 Mar 2011 09:20:52 -0300
Message-Id: <1300882852-1101-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index b4d13f2..771a908 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1111,8 +1111,7 @@ static GSList *device_match_driver(struct btd_device *device,
 
 		/* match pattern driver */
 		match = device_match_pattern(device, *uuid, profiles);
-		for (; match; match = match->next)
-			uuids = g_slist_append(uuids, match->data);
+		uuids = g_slist_concat(uuids, match);
 	}
 
 	return uuids;
-- 
1.7.4.1

