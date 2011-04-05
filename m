Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH] Fixing characteristic read by uuid
Date: Tue,  5 Apr 2011 15:38:04 -0300
Message-Id: <1302028684-5267-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the charecteristic to be read was the last one of a given range, it
was not being listed.
---
 src/attrib-server.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 2e95628..7ee496e 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -431,7 +431,7 @@ static uint16_t read_by_type(struct gatt_channel *channel, uint16_t start,
 		if (a->handle < start)
 			continue;
 
-		if (a->handle >= end)
+		if (a->handle > end)
 			break;
 
 		if (bt_uuid_cmp(&a->uuid, uuid)  != 0)
-- 
1.7.1

