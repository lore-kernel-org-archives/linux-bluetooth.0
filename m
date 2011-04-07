Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 5/9] Fix device type when creating from primary services storage
Date: Thu,  7 Apr 2011 14:30:10 -0300
Message-Id: <1302197414-833-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1302197414-833-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1302197414-833-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GATT services exported through basic rate need to be created based
on the "profiles" file. For GATT over LE, "primary" file entries need
to be used to create the devices and primary services objects.
---
 src/adapter.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 6caff9a..8380a58 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2176,7 +2176,7 @@ static void create_stored_device_from_primary(char *key, char *value,
 	if (l)
 		device = l->data;
 	else {
-		device = device_create(connection, adapter, key, DEVICE_TYPE_BREDR);
+		device = device_create(connection, adapter, key, DEVICE_TYPE_LE);
 		if (!device)
 			return;
 
-- 
1.7.4.1

