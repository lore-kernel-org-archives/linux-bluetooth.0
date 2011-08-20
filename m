Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 02/12] Add storage functions to handle SMP keys
Date: Fri, 19 Aug 2011 21:11:58 -0300
Message-Id: <1313799128-8842-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1313799128-8842-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1313799128-8842-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For now, only the Long Term Key (LTK) is stored.
---
 src/storage.c |   34 ++++++++++++++++++++++++++++++++++
 src/storage.h |    2 ++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index 1f3da6e..3414e34 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -1341,3 +1341,37 @@ device_type_t read_device_type(const bdaddr_t *sba, const bdaddr_t *dba)
 
 	return type;
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
+	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
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
index bb64727..14e072d 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -87,6 +87,8 @@ int read_device_attributes(const bdaddr_t *sba, textfile_cb func, void *data);
 int write_device_type(const bdaddr_t *sba, const bdaddr_t *dba,
 						device_type_t type);
 device_type_t read_device_type(const bdaddr_t *sba, const bdaddr_t *dba);
+int write_longtermkeys(bdaddr_t *local, bdaddr_t *peer, const char *key);
+gboolean has_longtermkeys(bdaddr_t *local, bdaddr_t *peer);
 
 #define PNP_UUID		"00001200-0000-1000-8000-00805f9b34fb"
 
-- 
1.7.6

