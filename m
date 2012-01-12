Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ] Send the Extended Error result code,
 if requested in the failure cases
Date: Thu, 12 Jan 2012 20:45:01 +0530
Message-id: <1326381301-25862-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If HF has already requested for the Extended Error result code reporting,
then send the same in certain failure cases. Earlier in this case we were
sending normal error.
---
 audio/headset.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index 6aef6a8..c5ea58b 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -1331,7 +1331,8 @@ static gboolean rfcomm_io_cb(GIOChannel *chan, GIOCondition cond,
 		if (err == -EINVAL) {
 			error("Badly formated or unrecognized command: %s",
 					&slc->buf[slc->data_start]);
-			err = headset_send(hs, "\r\nERROR\r\n");
+			err = telephony_generic_rsp(device,
+						CME_ERROR_NOT_SUPPORTED);
 			if (err < 0)
 				goto failed;
 		} else if (err < 0)
-- 
1.7.4.1

