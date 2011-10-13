Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 1/7] Add storage functions to deal with CCC
Date: Thu, 13 Oct 2011 11:43:18 -0300
Message-Id: <1318517004-17003-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1318517004-17003-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1318517004-17003-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

CCC (Client Characteristic Configuration) is used to allow configuration
whether to send updates about an characteristic value.
---
 src/storage.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 src/storage.h |    4 ++++
 2 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index c64842c..082a046 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -1262,3 +1262,47 @@ int read_device_attributes(const bdaddr_t *sba, textfile_cb func, void *data)
 
 	return textfile_foreach(filename, func, data);
 }
+
+int read_device_ccc(bdaddr_t *local, bdaddr_t *peer, uint16_t handle,
+							uint16_t *value)
+{
+	char filename[PATH_MAX + 1], addr[18], key[23];
+	char *str;
+	unsigned int config;
+	int err = 0;
+
+	create_filename(filename, PATH_MAX, local, "ccc");
+
+	ba2str(peer, addr);
+	snprintf(key, sizeof(key), "%17s#%04X", addr, handle);
+
+	str = textfile_caseget(filename, key);
+	if (str == NULL)
+		return -ENOENT;
+
+	if (sscanf(str, "%04X", &config) != 1)
+		err = -ENOENT;
+	else
+		*value = config;
+
+	free(str);
+
+	return err;
+}
+
+int write_device_ccc(bdaddr_t *local, bdaddr_t *peer, uint16_t handle,
+							uint16_t value)
+{
+	char filename[PATH_MAX + 1], addr[18], key[23], config[5];
+
+	create_filename(filename, PATH_MAX, local, "ccc");
+
+	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+
+	ba2str(peer, addr);
+
+	snprintf(key, sizeof(key), "%17s#%04X", addr, handle);
+	snprintf(config, sizeof(config), "%04X", value);
+
+	return textfile_put(filename, key, config);
+}
diff --git a/src/storage.h b/src/storage.h
index dbe717f..1cb3637 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -83,6 +83,10 @@ char *read_device_characteristics(const bdaddr_t *sba, const bdaddr_t *dba,
 int write_device_attribute(const bdaddr_t *sba, const bdaddr_t *dba,
                                         uint16_t handle, const char *chars);
 int read_device_attributes(const bdaddr_t *sba, textfile_cb func, void *data);
+int read_device_ccc(bdaddr_t *local, bdaddr_t *peer, uint16_t handle,
+							uint16_t *value);
+int write_device_ccc(bdaddr_t *local, bdaddr_t *peer, uint16_t handle,
+							uint16_t value);
 
 #define PNP_UUID		"00001200-0000-1000-8000-00805f9b34fb"
 
-- 
1.7.7

