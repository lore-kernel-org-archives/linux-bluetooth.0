Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCV2 17/28] android/hal-sco: Connect SCO when opening input stream
Date: Wed,  4 Jun 2014 17:17:48 +0300
Message-Id: <1401891479-11965-17-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-sco.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index 2fa8fb7..06e0261 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -1038,7 +1038,12 @@ static int sco_open_input_stream(struct audio_hw_device *dev,
 	int chan_num, ret;
 	size_t resample_size;
 
-	DBG("");
+	DBG("config %p device flags 0x%02x", config, devices);
+
+	if (ipc_connect_sco() != SCO_STATUS_SUCCESS) {
+		error("sco: cannot get fd");
+		return -EIO;
+	}
 
 	in = calloc(1, sizeof(struct sco_stream_in));
 	if (!in)
-- 
1.8.3.2

