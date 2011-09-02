Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 2/5] MAP: Fix type of read_status in message_filter
Date: Fri,  2 Sep 2011 10:57:41 +0200
Message-Id: <1314953864-25686-2-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1314953864-25686-1-git-send-email-lkslawek@gmail.com>
References: <1314953864-25686-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/messages.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/messages.h b/plugins/messages.h
index d9348c7..5b0fd2d 100644
--- a/plugins/messages.h
+++ b/plugins/messages.h
@@ -113,7 +113,7 @@ struct messages_filter {
 	uint8_t type;
 	char *period_begin;
 	char *period_end;
-	uint8_t *read_status;
+	uint8_t read_status;
 	char *recipient;
 	char *originator;
 	uint8_t priority;
-- 
1.7.4.1

