Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] android/handsfree: Use bdaddr provided for find_device()
Date: Thu,  6 Nov 2014 14:55:08 +0200
Message-Id: <1415278508-3929-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415278508-3929-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415278508-3929-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/handsfree.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 33fcbdd..9a2fdd0 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -2904,14 +2904,18 @@ static void disable_sco_server(void)
 
 static void bt_sco_get_fd(const void *buf, uint16_t len)
 {
-	int fd;
-	GError *err;
+	const struct sco_cmd_get_fd *cmd = buf;
 	struct sco_rsp_get_fd rsp;
 	struct hf_device *dev;
+	bdaddr_t bdaddr;
+	GError *err;
+	int fd;
 
 	DBG("");
 
-	dev = find_default_device();
+	android2bdaddr(cmd->bdaddr, &bdaddr);
+
+	dev = find_device(&bdaddr);
 	if (!dev || !dev->sco)
 		goto failed;
 
-- 
1.9.1

