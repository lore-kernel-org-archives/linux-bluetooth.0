Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 6/6] android/a2dp: Fix audio deregistration
Date: Mon, 10 Feb 2014 11:45:45 +0100
Message-ID: <1392029145-7954-6-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1392029145-7954-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1392029145-7954-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Unregistering a SEP can trigger abort_cfm callback if some device is
connected thus we should free setups list after all endpoints are
unregistered to avoid error in abort_cfm due to non-existing setup.
---
 android/a2dp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index bef037d..838ade8 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -1481,12 +1481,12 @@ static void bt_audio_unregister(void)
 	if (audio_retry_id > 0)
 		g_source_remove(audio_retry_id);
 
-	g_slist_free_full(setups, setup_free);
-	setups = NULL;
-
 	g_slist_free_full(endpoints, unregister_endpoint);
 	endpoints = NULL;
 
+	g_slist_free_full(setups, setup_free);
+	setups = NULL;
+
 	audio_ipc_cleanup();
 }
 
-- 
1.8.5.3

