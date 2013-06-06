Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH] adapter: remove unused toggle_discoverable
Date: Thu,  6 Jun 2013 14:54:18 +0100
Message-Id: <1370526858-6879-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 src/adapter.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index c2f0045..bb5737e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -172,7 +172,6 @@ struct btd_adapter {
 	struct btd_device *connect_le;	/* LE device waiting to be connected */
 	sdp_list_t *services;		/* Services associated to adapter */
 
-	bool toggle_discoverable;	/* discoverable needs to be changed */
 	gboolean initialized;
 
 	GSList *pin_callbacks;
-- 
1.8.1.4

