Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 4/7] Remove leftover field in remote_dev_info struct
Date: Tue, 24 Apr 2012 22:42:28 -0300
Message-Id: <1335318151-21063-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1335318151-21063-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1335318151-21063-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Field "bdaddr_type" of the remote_dev_info structure is not being
referenced in the code. Field "type" is already being used to store
the Bluetooth address type.
---
 src/adapter.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/src/adapter.h b/src/adapter.h
index 57d2089..29b5ad5 100644
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

