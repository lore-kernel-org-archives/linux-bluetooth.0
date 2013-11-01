Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] android/hid: Fix passing vendor id as version to uHID
Date: Fri,  1 Nov 2013 15:08:39 +0200
Message-Id: <1383311321-28429-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1383311321-28429-1-git-send-email-luiz.dentz@gmail.com>
References: <1383311321-28429-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hid.c b/android/hid.c
index bbdc66a..57ad5e4 100644
--- a/android/hid.c
+++ b/android/hid.c
@@ -278,7 +278,7 @@ static int uhid_create(struct hid_device *dev)
 	ev.u.create.bus = BUS_BLUETOOTH;
 	ev.u.create.vendor = dev->vendor;
 	ev.u.create.product = dev->product;
-	ev.u.create.version = dev->vendor;
+	ev.u.create.version = dev->version;
 	ev.u.create.country = dev->country;
 	ev.u.create.rd_size = dev->rd_size;
 	ev.u.create.rd_data = dev->rd_data;
-- 
1.8.3.1

