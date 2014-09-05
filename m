Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] core: Fix idle watch not being removed properly
Date: Fri,  5 Sep 2014 15:49:09 +0300
Message-Id: <1409921352-28485-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The idle watch used to dispatch authorization should be removed when
waiting services to be resolved.
---
 src/adapter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 4e6315d..f9c58af 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4984,7 +4984,7 @@ static gboolean process_auth_queue(gpointer user_data)
 
 		/* Wait services to be resolved before asking authorization */
 		if (auth->svc_id > 0)
-			return TRUE;
+			return FALSE;
 
 		if (device_is_trusted(device) == TRUE) {
 			auth->cb(NULL, auth->user_data);
-- 
1.9.3

