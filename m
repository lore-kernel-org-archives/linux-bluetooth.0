Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] android/pan: Fix no return on error path
Date: Mon,  2 Dec 2013 17:46:28 +0200
Message-Id: <1385999188-1546-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385999188-1546-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385999188-1546-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This fixes possible crash in case connect fails.
---
 android/pan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/pan.c b/android/pan.c
index 8e719b2..1c1015a 100644
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

