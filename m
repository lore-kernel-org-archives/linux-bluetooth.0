Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 08/12] android/gatt: Do not stop discovery if scanning is not set
Date: Tue, 10 Jun 2014 18:53:59 +0300
Message-Id: <1402415643-32300-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1402415643-32300-1-git-send-email-luiz.dentz@gmail.com>
References: <1402415643-32300-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If scanning is not set the discovery might have been initiated by another
HAL so do not stop it.
---
 android/gatt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index f797e7d..8a8419c 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -661,6 +661,11 @@ connect:
 	device_set_state(dev, DEVICE_CONNECT_READY);
 	dev->bdaddr_type = addr_type;
 
+	if (!scanning) {
+		connect_next_dev();
+		return;
+	}
+
 	/*
 	 * We are ok to perform connect now. Stop discovery
 	 * and once it is stopped continue with creating ACL
-- 
1.9.3

