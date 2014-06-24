Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/11] android/health: trivial: Fix missing space
Date: Tue, 24 Jun 2014 15:11:58 +0300
Message-Id: <1403611922-26901-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403611922-26901-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403611922-26901-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/health.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/health.c b/android/health.c
index 4ff4356..a9287f6 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1453,6 +1453,7 @@ static struct health_channel *get_channel(uint16_t app_id,
 
 	return create_channel(app_id, mdep_index, dev);
 }
+
 static void bt_health_connect_channel(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_health_connect_channel *cmd = buf;
-- 
1.8.3.2

