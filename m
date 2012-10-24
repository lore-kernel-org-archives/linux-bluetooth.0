Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 13/16] device: Retrieve name from cache directory
Date: Wed, 24 Oct 2012 16:34:15 +0200
Message-Id: <1351089258-25179-14-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1351089258-25179-1-git-send-email-frederic.danis@linux.intel.com>
References: <1351089258-25179-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |   25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index bc7f8dd..4e0ac58 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1573,6 +1573,8 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 	const bdaddr_t *src;
 	char srcaddr[18], alias[MAX_NAME_LENGTH + 1];
 	uint16_t vendor, product, version;
+	char filename[PATH_MAX + 1];
+	GKeyFile *key_file;
 
 	device = g_try_malloc0(sizeof(struct btd_device));
 	if (device == NULL)
@@ -1600,7 +1602,28 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 	src = adapter_get_address(adapter);
 	ba2str(src, srcaddr);
 
-	read_device_name(srcaddr, address, bdaddr_type, device->name);
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", srcaddr,
+			address);
+	filename[PATH_MAX] = '\0';
+	key_file = g_key_file_new();
+
+	if (g_key_file_load_from_file(key_file, filename, 0, NULL)) {
+		char *str;
+		int len;
+
+		str = g_key_file_get_string(key_file, "General", "Name", NULL);
+		if (str) {
+			len = strlen(str);
+			if (len > HCI_MAX_NAME_LENGTH)
+				str[HCI_MAX_NAME_LENGTH] = '\0';
+
+			strcpy(device->name, str);
+			g_free(str);
+		}
+	}
+
+	g_key_file_free(key_file);
+
 	if (read_device_alias(srcaddr, address, bdaddr_type, alias,
 							sizeof(alias)) == 0)
 		device->alias = g_strdup(alias);
-- 
1.7.9.5

