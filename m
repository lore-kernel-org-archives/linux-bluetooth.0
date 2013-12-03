Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] android/pan: Fix no return on error path
Date: Tue,  3 Dec 2013 17:53:10 +0200
Message-Id: <1386085993-22055-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1386085993-22055-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1386085993-22055-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This fixes possible crash in case connect fails.
---
 android/pan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/pan.c b/android/pan.c
index 87fa4e8..7e9b3c3 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -172,6 +172,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
 		error("%s", err->message);
 		bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
 		pan_device_free(dev);
+		return;
 	}
 
 	src = (local_role == HAL_PAN_ROLE_NAP) ? BNEP_SVC_NAP : BNEP_SVC_PANU;
-- 
1.8.3.2

