Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/14] device: Load services from storage
Date: Wed, 12 Dec 2012 16:47:57 +0100
Message-Id: <1355327283-1558-8-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355327283-1558-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355327283-1558-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Parse device attributes file for primary services, then add UUID service
to device pimaries list.
---
 src/device.c |   77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/src/device.c b/src/device.c
index da868b8..a515266 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2067,6 +2067,82 @@ next:
 		store_device_info(device);
 }
 
+static void load_att_info(struct btd_device *device, const gchar *local,
+				const gchar *peer)
+{
+	char filename[PATH_MAX + 1];
+	GKeyFile *key_file;
+	char *prim_uuid, *str;
+	char **groups, **handle, *service_uuid;
+	struct gatt_primary *prim;
+	uuid_t uuid;
+	char tmp[3];
+	int i;
+
+	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
+	prim_uuid = bt_uuid2string(&uuid);
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/attributes", local,
+			peer);
+	filename[PATH_MAX] = '\0';
+
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	groups = g_key_file_get_groups(key_file, NULL);
+
+	for (handle = groups; *handle; handle++) {
+		str = g_key_file_get_string(key_file, *handle, "UUID", NULL);
+		if (!str)
+			continue;
+
+		if (!g_str_equal(str, prim_uuid))
+			continue;
+
+		g_free(str);
+
+		prim = g_new0(struct gatt_primary, 1);
+		prim->range.start = atoi(*handle);
+		str = g_key_file_get_string(key_file, *handle, "Value", NULL);
+		if (!str) {
+			g_free(prim);
+			continue;
+		}
+
+		switch (strlen(str)) {
+		case 4:
+			uuid.type = SDP_UUID16;
+			sscanf(str, "%04hx", &uuid.value.uuid16);
+		break;
+		case 8:
+			uuid.type = SDP_UUID32;
+			sscanf(str, "%08x", &uuid.value.uuid32);
+			break;
+		case 32:
+			uuid.type = SDP_UUID128;
+			memset(tmp, 0, sizeof(tmp));
+			for (i = 0; i < 16; i++) {
+				memcpy(tmp, str + (i * 2), 2);
+				uuid.value.uuid128.data[i] =
+						(uint8_t) strtol(tmp, NULL, 16);
+			}
+			break;
+		default:
+			continue;
+		}
+
+		service_uuid = bt_uuid2string(&uuid);
+		memcpy(prim->uuid, service_uuid, MAX_LEN_UUID_STR + 1);
+		g_free(service_uuid);
+		g_free(str);
+
+		device->primaries = g_slist_append(device->primaries, prim);
+	}
+
+	g_strfreev(groups);
+	g_key_file_free(key_file);
+	g_free(prim_uuid);
+}
+
 static struct btd_device *device_new(struct btd_adapter *adapter,
 				const gchar *address)
 {
@@ -2115,6 +2191,7 @@ struct btd_device *device_create_from_storage(struct btd_adapter *adapter,
 	ba2str(src, srcaddr);
 
 	load_info(device, srcaddr, address, key_file);
+	load_att_info(device, srcaddr, address);
 
 	return device;
 }
-- 
1.7.9.5

