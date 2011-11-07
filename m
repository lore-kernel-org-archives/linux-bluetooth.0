Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v2 1/2] Add storage function to remove CCC of a device
Date: Mon,  7 Nov 2011 11:09:13 -0300
Message-Id: <1320674953-23040-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1318517589-17372-2-git-send-email-claudio.takahasi@openbossa.org>
References: <1318517589-17372-2-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/storage.c |   11 +++++++++++
 src/storage.h |    1 +
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index 7471b0f..e4ad4ab 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -1305,3 +1305,14 @@ int write_device_ccc(bdaddr_t *local, bdaddr_t *peer, uint16_t handle,
 
 	return textfile_put(filename, key, config);
 }
+
+void delete_device_ccc(bdaddr_t *local, bdaddr_t *peer)
+{
+	char filename[PATH_MAX + 1], addr[18];
+
+	ba2str(peer, addr);
+
+	/* Deleting all CCC values of a given address */
+	create_filename(filename, PATH_MAX, local, "ccc");
+	delete_by_pattern(filename, addr);
+}
diff --git a/src/storage.h b/src/storage.h
index 1cb3637..51259f6 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -87,6 +87,7 @@ int read_device_ccc(bdaddr_t *local, bdaddr_t *peer, uint16_t handle,
 							uint16_t *value);
 int write_device_ccc(bdaddr_t *local, bdaddr_t *peer, uint16_t handle,
 							uint16_t value);
+void delete_device_ccc(bdaddr_t *local, bdaddr_t *peer);
 
 #define PNP_UUID		"00001200-0000-1000-8000-00805f9b34fb"
 
-- 
1.7.7.2

