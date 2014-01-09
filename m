Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <szymon.janc@tieto.com>,
	<johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/4] android/audio: Change mainloop handle in ipc_handler
Date: Thu, 9 Jan 2014 12:45:54 +0100
Message-ID: <1389267956-2297-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1389267956-2297-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1389267956-2297-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make sure we wait 1 sec  after each loop iteration.
It is important in case of failure that we do not overload cpu.

---
 android/hal-audio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 7a7c111..4a12bcb 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -465,15 +465,14 @@ failed:
 
 static void *ipc_handler(void *data)
 {
-	bool done = false;
 	struct pollfd pfd;
+	bool done;
 
 	DBG("");
 
-	while (!done) {
+	for (done = false; !done; sleep(1)) {
 		if(!create_audio_ipc()) {
 			error("a2dp: Failed to create listening socket");
-			sleep(1);
 			continue;
 		}
 
-- 
1.8.4

