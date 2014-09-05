Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] android/tester: Set ssp_request_cb to default value in teardown
Date: Fri,  5 Sep 2014 10:09:55 +0200
Message-Id: <1409904596-10254-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1409904596-10254-1-git-send-email-marcin.kraglak@tieto.com>
References: <1409904596-10254-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It could be set te default_ssp_req_cb and should be set again to
ssp_request_cb.
---
 android/tester-main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/android/tester-main.c b/android/tester-main.c
index ce13bf7..be3d785 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -1633,6 +1633,12 @@ static void teardown(const void *test_data)
 	data->device->close(data->device);
 	audio_hw_device_close(data->audio);
 
+	/*
+	 * Ssp_request_cb pointer can be set do default_ssp_req_cb.
+	 * Set it back to ssp_request_cb
+	 */
+	bt_callbacks.ssp_request_cb = ssp_request_cb;
+
 	if (!data->bluetoothd_pid)
 		tester_teardown_complete();
 }
-- 
1.9.0

