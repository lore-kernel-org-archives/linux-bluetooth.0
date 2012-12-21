Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] adapter: Fix setting discoverable mode from settings
Date: Fri, 21 Dec 2012 14:13:05 +0100
Message-ID: <1356095585-14353-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Discoverable mode was not set to correct value read from settings.
---
 src/adapter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 55f03a4..6ff20e1 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2630,7 +2630,7 @@ static void load_config(struct btd_adapter *adapter)
 	} else if (stored_discoverable != adapter->discoverable) {
 		if (adapter->connectable)
 			mgmt_set_discoverable(adapter->dev_id,
-						adapter->discoverable,
+						stored_discoverable,
 						adapter->discov_timeout);
 		else
 			adapter->toggle_discoverable = true;
-- 
1.8.0

