Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 6/8] device: Remove keys file in device_remove_stored()
Date: Wed, 28 Nov 2012 14:39:25 +0100
Message-Id: <1354109967-6238-6-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1354109967-6238-1-git-send-email-frederic.danis@linux.intel.com>
References: <1354109967-6238-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/device.c b/src/device.c
index f9927da..9f05c1b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2022,6 +2022,11 @@ static void device_remove_stored(struct btd_device *device)
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

