Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/5] android: Remove mgmt_version and mgmt_revision static variables
Date: Tue, 5 Nov 2013 15:18:46 +0100
Message-ID: <1383661128-25029-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383661128-25029-1-git-send-email-szymon.janc@tieto.com>
References: <1383661128-25029-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to keep those as Android daemon is expecting new
enough kernel to operate.
---
 android/main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/android/main.c b/android/main.c
index 7ee47fc..d68abe1 100644
--- a/android/main.c
+++ b/android/main.c
@@ -68,9 +68,6 @@
 static GMainLoop *event_loop;
 static struct mgmt *mgmt_if = NULL;
 
-static uint8_t mgmt_version = 0;
-static uint8_t mgmt_revision = 0;
-
 static uint16_t adapter_index = MGMT_INDEX_NONE;
 static guint adapter_timeout = 0;
 
@@ -588,6 +585,7 @@ static void read_version_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
 	const struct mgmt_rp_read_version *rp = param;
+	uint8_t mgmt_version, mgmt_revision;
 
 	DBG("");
 
-- 
1.8.4.2

