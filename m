Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 2/7] android: Fix error check from pthread_create
Date: Fri, 10 Jan 2014 02:24:23 +0100
Message-ID: <1389317068-12540-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1389317068-12540-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1389317068-12540-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

pthread_create() returns 0 on success or errno code which is non negative
number

---
 android/hal-audio.c | 4 ++--
 android/hal-ipc.c   | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 4b48783..c71b93c 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -548,10 +548,10 @@ static int audio_open(const hw_module_t *module, const char *name,
 	*device = &a2dp_dev->dev.common;
 
 	err = pthread_create(&ipc_th, NULL, ipc_handler, NULL);
-	if (err < 0) {
+	if (err) {
 		ipc_th = 0;
 		error("audio: Failed to start Audio IPC thread: %d (%s)",
-							-err, strerror(-err));
+							err, strerror(err));
 		return (-err);
 	}
 
diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index b19704a..97f1bcd 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -284,10 +284,10 @@ bool hal_ipc_init(void)
 	close(sk);
 
 	err = pthread_create(&notif_th, NULL, notification_handler, NULL);
-	if (err < 0) {
+	if (err) {
 		notif_th = 0;
-		error("Failed to start notification thread: %d (%s)", -err,
-							strerror(-err));
+		error("Failed to start notification thread: %d (%s)", err,
+							strerror(err));
 		close(cmd_sk);
 		cmd_sk = -1;
 		close(notif_sk);
-- 
1.8.4

