Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 03/11] Add storage functions to handle SMP keys
Date: Tue, 17 Jan 2012 20:28:42 -0300
Message-Id: <1326842930-31623-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1326842930-31623-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1326842930-31623-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For now, only the Long Term Key (LTK) is stored.
---
 src/storage.c |   32 ++++++++++++++++++++++++++++++++
 src/storage.h |    2 ++
 2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index a47720a..960eeb5 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -1310,3 +1310,35 @@ void delete_device_ccc(bdaddr_t *local, bdaddr_t *peer)
 	create_filename(filename, PATH_MAX, local, "ccc");
 	delete_by_pattern(filename, addr);
 }
+
+int write_longtermkeys(bdaddr_t *local, bdaddr_t *peer, const char *key)
+{
+	char filename[PATH_MAX + 1], addr[18];
+
+	if (!key)
+		return -EINVAL;
+
+	create_filename(filename, PATH_MAX, local, "longtermkeys");
+
+	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+
+	ba2str(peer, addr);
+	return textfile_put(filename, addr, key);
+}
+
+gboolean has_longtermkeys(bdaddr_t *local, bdaddr_t *peer)
+{
+	char filename[PATH_MAX + 1], addr[18], *str;
+
+	create_filename(filename, PATH_MAX, local, "longtermkeys");
+
+	ba2str(peer, addr);
+
+	str = textfile_caseget(filename, addr);
+	if (str) {
+		free(str);
+		return TRUE;
+	}
+
+	return FALSE;
+}
diff --git a/src/storage.h b/src/storage.h
index 51259f6..604cc49 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -88,6 +88,8 @@ int read_device_ccc(bdaddr_t *local, bdaddr_t *peer, uint16_t handle,
 int write_device_ccc(bdaddr_t *local, bdaddr_t *peer, uint16_t handle,
 							uint16_t value);
 void delete_device_ccc(bdaddr_t *local, bdaddr_t *peer);
+int write_longtermkeys(bdaddr_t *local, bdaddr_t *peer, const char *key);
+gboolean has_longtermkeys(bdaddr_t *local, bdaddr_t *peer);
 
 #define PNP_UUID		"00001200-0000-1000-8000-00805f9b34fb"
 
-- 
1.7.8.1

