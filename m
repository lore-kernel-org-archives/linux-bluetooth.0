Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] Remove use of read_device_id in input plugin
Date: Thu, 22 Sep 2011 18:51:51 +0300
Message-Id: <1316706712-17611-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1316706712-17611-1-git-send-email-luiz.dentz@gmail.com>
References: <1316706712-17611-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Make use of btd_device_get_vendor, btd_device_get_product and
btd_device_get_version intead.
---
 input/device.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/input/device.c b/input/device.c
index 70d0ba2..9ff7f20 100644
--- a/input/device.c
+++ b/input/device.c
@@ -596,8 +596,9 @@ static int hidp_add_connection(const struct input_device *idev,
 	extract_hid_record(rec, req);
 	sdp_record_free(rec);
 
-	read_device_id(src_addr, dst_addr, NULL,
-				&req->vendor, &req->product, &req->version);
+	req->vendor = btd_device_get_vendor(idev->device);
+	req->product = btd_device_get_product(idev->device);
+	req->version = btd_device_get_version(idev->device);
 
 	fake_hid = get_fake_hid(req->vendor, req->product);
 	if (fake_hid) {
-- 
1.7.6.2

