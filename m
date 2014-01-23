Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/hal-audio: Do not allocate memory if fd < 0
Date: Thu, 23 Jan 2014 17:43:27 +0200
Message-Id: <1390491807-11095-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1390491807-11095-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1390491807-11095-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes memory leak when returning bad fd we still allocate memory which
is not freed in the caller function audio_open_output_stream().
---
 android/hal-audio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 2fbb956..9bbb53d 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -705,8 +705,7 @@ static int ipc_open_stream_cmd(uint8_t endpoint_id, uint16_t *mtu, int *fd,
 
 	result = audio_ipc_cmd(AUDIO_SERVICE_ID, AUDIO_OP_OPEN_STREAM,
 				sizeof(cmd), &cmd, &rsp_len, rsp, fd);
-
-	if (result == AUDIO_STATUS_SUCCESS) {
+	if (result == AUDIO_STATUS_SUCCESS && *fd >= 0) {
 		size_t buf_len = sizeof(struct audio_preset) +
 					rsp->preset[0].len;
 		*mtu = rsp->mtu;
-- 
1.8.3.2

