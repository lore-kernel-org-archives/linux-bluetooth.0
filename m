Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 02/11] android/hid: Retrieve BOOT_DEVICE attribute from SDP and cache it
Date: Tue,  5 Nov 2013 00:20:06 +0200
Message-Id: <1383603615-9953-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383603615-9953-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383603615-9953-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will be usefull to handle when application level requests
get or set protocol from hid device.
---
 android/hid.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/android/hid.c b/android/hid.c
index 2498d2d..c0c9aeb 100644
--- a/android/hid.c
+++ b/android/hid.c
@@ -69,6 +69,7 @@ struct hid_device {
 	uint8_t		country;
 	int		rd_size;
 	void		*rd_data;
+	uint8_t		boot_dev;
 	GIOChannel	*ctrl_io;
 	GIOChannel	*intr_io;
 	guint		ctrl_watch;
@@ -446,6 +447,10 @@ static void hid_sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
 		if (data)
 			dev->subclass = data->val.uint8;
 
+		data = sdp_data_get(rec, SDP_ATTR_HID_BOOT_DEVICE);
+		if (data)
+			dev->boot_dev = data->val.uint8;
+
 		data = sdp_data_get(rec, SDP_ATTR_HID_DESCRIPTOR_LIST);
 		if (data) {
 			if (!SDP_IS_SEQ(data->dtd))
-- 
1.8.1.2

