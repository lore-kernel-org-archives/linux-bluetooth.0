Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 16/21] android/hal-sco: Defer SCO connection to write()
Date: Fri, 18 Jul 2014 12:48:15 +0300
Message-Id: <1405676900-17703-17-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1405676900-17703-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1405676900-17703-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Do not return error when opening output stream if SCO is not connected
yet, we will check it later with actual out_write().
---
 android/hal-sco.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index 1627b83..472c7e8 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -632,10 +632,8 @@ static int sco_open_output_stream(struct audio_hw_device *dev,
 		return -EIO;
 	}
 
-	if (ipc_connect_sco() != SCO_STATUS_SUCCESS) {
-		error("sco: cannot get fd");
-		return -EIO;
-	}
+	if (ipc_connect_sco() != SCO_STATUS_SUCCESS)
+		DBG("SCO is not connected yet; get fd on write()");
 
 	out = calloc(1, sizeof(struct sco_stream_out));
 	if (!out)
-- 
1.9.1

