Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 1/2] android/a2dp: Fix IPC response length calculation
Date: Tue, 14 Jan 2014 17:16:18 +0100
Message-ID: <1389716179-21874-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

struct audio_rsp_open_stream has only zero-length array member thus its
size equals to 0. We need to explicitly specify size of array element
type here.
---
 android/a2dp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 9f3164a..145cd67 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -1088,8 +1088,8 @@ static void bt_stream_open(const void *buf, uint16_t len)
 		return;
 	}
 
-	len = sizeof(*rsp) + setup->preset->len;
-	rsp = g_malloc0(sizeof(*rsp) + setup->preset->len);
+	len = sizeof(struct audio_preset) + setup->preset->len;
+	rsp = g_malloc0(len);
 	rsp->preset->len = setup->preset->len;
 	memcpy(rsp->preset->data, setup->preset->data, setup->preset->len);
 
-- 
1.8.5.2

