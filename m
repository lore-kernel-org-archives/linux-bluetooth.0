Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH 3/3] Send the Extended Error result code,
 if requested in the failure cases
Date: Thu, 24 Nov 2011 19:44:36 +0530
Message-id: <1322144076-1913-3-git-send-email-s.syam@samsung.com>
In-reply-to: <1322144076-1913-1-git-send-email-s.syam@samsung.com>
References: <1322144076-1913-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If HF has already requested for the Extended Error result code reporting,
then send the same in certain failure cases. Earlier in this case we were
sending normal Error.
---
 audio/headset.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index 6aef6a8..2bddedc 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -1331,7 +1331,13 @@ static gboolean rfcomm_io_cb(GIOChannel *chan, GIOCondition cond,
 		if (err == -EINVAL) {
 			error("Badly formated or unrecognized command: %s",
 					&slc->buf[slc->data_start]);
-			err = headset_send(hs, "\r\nERROR\r\n");
+
+			if (slc->enabled)
+				err = headset_send(hs, "\r\n+CME ERROR: %d\r\n",
+						CME_ERROR_NOT_SUPPORTED);
+			else
+				err = headset_send(hs, "\r\nERROR\r\n");
+
 			if (err < 0)
 				goto failed;
 		} else if (err < 0)
-- 
1.7.4.1

