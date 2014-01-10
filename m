Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 5/7] android/audio: Add skeleton for ipc_open_cmd function
Date: Fri, 10 Jan 2014 02:24:26 +0100
Message-ID: <1389317068-12540-6-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1389317068-12540-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1389317068-12540-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-audio.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 0b345ed..4c5a9d9 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -417,6 +417,13 @@ static int audio_close(hw_device_t *device)
 	return 0;
 }
 
+static int ipc_open_cmd(void)
+{
+	DBG("Not Implemented");
+
+	return AUDIO_STATUS_FAILED;
+}
+
 static void *ipc_handler(void *data)
 {
 	bool done = false;
@@ -436,7 +443,11 @@ static void *ipc_handler(void *data)
 
 		DBG("Audio IPC: Connected");
 
-		/* TODO: Register ENDPOINT here */
+		if (ipc_open_cmd() == AUDIO_STATUS_FAILED) {
+			error("audio: Failed to open endpoint, recover");
+			shutdown(audio_sk, SHUT_RDWR);
+			continue;
+		}
 
 		memset(&pfd, 0, sizeof(pfd));
 		pfd.fd = audio_sk;
-- 
1.8.4

