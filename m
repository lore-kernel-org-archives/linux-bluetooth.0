Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/11] android/health: trivial: Remove empty line
Date: Tue, 24 Jun 2014 15:11:56 +0300
Message-Id: <1403611922-26901-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403611922-26901-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403611922-26901-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/health.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/android/health.c b/android/health.c
index 361e052..a1ae292 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1566,7 +1566,6 @@ bool bt_health_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 					mcl_disconnected, mcl_uncached,
 					NULL, /* CSP is not used right now */
 					NULL, &err);
-
 	if (!mcap) {
 		error("health: MCAP instance creation failed %s", err->message);
 		g_error_free(err);
-- 
1.8.3.2

