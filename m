Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <szymon.janc@tieto.com>,
	<johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 3/4] android/audio: Add skeleton for open_endpoint_cmd function
Date: Thu, 9 Jan 2014 12:45:55 +0100
Message-ID: <1389267956-2297-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1389267956-2297-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1389267956-2297-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-audio.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 4a12bcb..95efa89 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -412,6 +412,13 @@ static int audio_close(hw_device_t *device)
 	return 0;
 }
 
+static int open_endpoint_cmd(void)
+{
+	DBG("Not Implemented");
+
+	return AUDIO_STATUS_FAILED;
+}
+
 static bool create_audio_ipc(void)
 {
 	struct sockaddr_un addr;
@@ -478,7 +485,10 @@ static void *ipc_handler(void *data)
 
 		DBG("Audio IPC: Connected");
 
-		/* TODO: Register ENDPOINT here */
+		if (open_endpoint_cmd() == AUDIO_STATUS_FAILED) {
+			error("a2dp: failed to open endpoint");
+			continue;
+		}
 
 		memset(&pfd, 0, sizeof(pfd));
 		pfd.fd = audio_sk;
-- 
1.8.4

