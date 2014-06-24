Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/11] android/health: Remove extra check
Date: Tue, 24 Jun 2014 15:11:57 +0300
Message-Id: <1403611922-26901-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403611922-26901-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403611922-26901-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

gerr is always set on error condition.
---
 android/health.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/android/health.c b/android/health.c
index a1ae292..4ff4356 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1281,10 +1281,7 @@ static void create_mcl_cb(struct mcap_mcl *mcl, GError *err, gpointer data)
 			MCAP_MDL_CB_INVALID);
 	if (!ret) {
 		error("health: error setting mdl callbacks on mcl");
-
-		if (gerr)
-			g_error_free(gerr);
-
+		g_error_free(gerr);
 		goto fail;
 	}
 
-- 
1.8.3.2

