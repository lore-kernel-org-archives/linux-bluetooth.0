Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/7] device: Remove keys file in device_remove_stored()
Date: Tue, 27 Nov 2012 09:49:51 +0100
Message-Id: <1354006193-7199-5-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1354006193-7199-1-git-send-email-frederic.danis@linux.intel.com>
References: <1354006193-7199-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/device.c b/src/device.c
index a99ca34..6b64c5d 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2014,6 +2014,11 @@ static void device_remove_stored(struct btd_device *device)
 	filename[PATH_MAX] = '\0';
 	remove(filename);
 
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/keys", adapter_addr,
+			device_addr);
+	filename[PATH_MAX] = '\0';
+	remove(filename);
+
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s", adapter_addr,
 			device_addr);
 	filename[PATH_MAX] = '\0';
-- 
1.7.9.5

