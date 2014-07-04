Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 17/32] android/hal-sco: Connect SCO when opening input stream
Date: Fri,  4 Jul 2014 16:47:02 +0300
Message-Id: <1404481637-900-18-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1404481637-900-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1404481637-900-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-sco.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index ed90b23..1f5eb23 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -1040,7 +1040,12 @@ static int sco_open_input_stream(struct audio_hw_device *dev,
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
1.9.1

