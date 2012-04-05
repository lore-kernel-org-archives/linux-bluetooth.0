Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ v1 4/7] Remove leftover field in remote_dev_info struct
Date: Thu,  5 Apr 2012 19:38:45 -0300
Message-Id: <1333665525-21326-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Field "bdaddr_type" of the remote_dev_info structure is not being
referenced in the code. Field "type" is already being used to store
the Bluetooth address type.
---
 src/adapter.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/src/adapter.h b/src/adapter.h
index c47d180..a5ea4c6 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -78,7 +78,6 @@ struct remote_dev_info {
 	char **uuids;
 	size_t uuid_count;
 	GSList *services;
-	uint8_t bdaddr_type;
 	uint8_t flags;
 };
 
-- 
1.7.8.5

