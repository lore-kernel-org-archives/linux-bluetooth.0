Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/11] android/health: Add actual error message to error print
Date: Tue, 24 Jun 2014 15:12:00 +0300
Message-Id: <1403611922-26901-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403611922-26901-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403611922-26901-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/health.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/health.c b/android/health.c
index c4df17a..2613ca6 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1285,7 +1285,7 @@ static void create_mcl_cb(struct mcap_mcl *mcl, GError *err, gpointer data)
 
 	ret = set_mcl_cb(channel->dev->mcl, channel->dev, &gerr);
 	if (!ret) {
-		error("health: error setting mdl callbacks on mcl");
+		error("health: error setting mdl callbacks: %s", gerr->message);
 		g_error_free(gerr);
 		goto fail;
 	}
-- 
1.8.3.2

