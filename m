Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 2/9] adapter: remove unused toggle_discoverable
Date: Tue, 11 Jun 2013 11:56:20 +0100
Message-Id: <1370948187-3702-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1370948187-3702-1-git-send-email-gustavo@padovan.org>
References: <1370948187-3702-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 src/adapter.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index af3e3ea..5f01edf 100644
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

