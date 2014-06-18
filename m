Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 11/11] android/health: trivial: Remove empty line
Date: Wed, 18 Jun 2014 16:33:54 +0300
Message-Id: <1403098434-28193-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403098434-28193-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1402905472-17643-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1403098434-28193-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/health.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/android/health.c b/android/health.c
index f893d0f..8625779 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1255,7 +1255,6 @@ bool bt_health_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 					mcl_disconnected, mcl_uncached,
 					NULL, /* CSP is not used right now */
 					NULL, &err);
-
 	if (!mcap) {
 		error("Error creating MCAP instance : %s", err->message);
 		g_error_free(err);
-- 
1.8.3.2

