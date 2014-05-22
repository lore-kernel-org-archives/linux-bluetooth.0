Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 08/12] android/bluetooth: Read CSRK from the storage on startup
Date: Thu, 22 May 2014 21:06:22 +0200
Message-Id: <1400785586-22710-9-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1400785586-22710-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1400785586-22710-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index b910b01..f8a7b3d 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2344,6 +2344,28 @@ static struct device *create_device_from_info(GKeyFile *key_file,
 		dev->le_bonded = true;
 	}
 
+	str = g_key_file_get_string(key_file, peer, "LocalCSRK", NULL);
+	if (str) {
+		int i;
+
+		dev->valid_local_csrk = true;
+		for (i = 0; i < 16; i++)
+			sscanf(str + (i * 2), "%02hhX", &dev->local_csrk[i]);
+
+		g_free(str);
+	}
+
+	str = g_key_file_get_string(key_file, peer, "RemoteCSRK", NULL);
+	if (str) {
+		int i;
+
+		dev->valid_remote_csrk = true;
+		for (i = 0; i < 16; i++)
+			sscanf(str + (i * 2), "%02hhX", &dev->remote_csrk[i]);
+
+		g_free(str);
+	}
+
 	str = g_key_file_get_string(key_file, peer, "Name", NULL);
 	if (str) {
 		g_free(dev->name);
-- 
1.8.4

