Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 2/3] android/pan: Handle error case properly in NAP registration
Date: Thu, 23 Jan 2014 15:39:26 +0200
Message-Id: <1390484367-6332-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1390484367-6332-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1390484367-6332-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pan.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index 67c7556..67b62f2 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -471,8 +471,10 @@ static int set_forward_delay(void)
 	int fd, ret;
 
 	fd = open(FORWARD_DELAY_PATH, O_RDWR);
-	if (fd < 0)
+	if (fd < 0) {
+		error("open forward delay path : %s", strerror(errno));
 		return -errno;
+	}
 
 	ret = write(fd, "0", sizeof("0"));
 	close(fd);
@@ -728,7 +730,7 @@ bool bt_pan_register(const bdaddr_t *addr)
 	}
 
 	err = bnep_init();
-	if (err) {
+	if (err < 0) {
 		error("bnep init failed");
 		bt_adapter_remove_record(rec->handle);
 		return false;
@@ -736,6 +738,7 @@ bool bt_pan_register(const bdaddr_t *addr)
 
 	err = register_nap_server();
 	if (err < 0) {
+		error("Failed to register NAP");
 		bt_adapter_remove_record(rec->handle);
 		bnep_cleanup();
 		return false;
-- 
1.8.3.2

