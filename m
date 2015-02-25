Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] core: Load CSRK from storage
Date: Wed, 25 Feb 2015 15:42:11 +0200
Message-Id: <1424871733-14610-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1424871733-14610-1-git-send-email-luiz.dentz@gmail.com>
References: <1424871733-14610-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This loads both Local and Remote CSRK information from storage so it
can be used later.
---
 src/device.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/src/device.c b/src/device.c
index 002dbea..bef1f0c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -173,6 +173,11 @@ struct bearer_state {
 	bool svc_resolved;
 };
 
+struct csrk_info {
+	uint8_t key[16];
+	uint32_t counter;
+};
+
 struct btd_device {
 	int ref_count;
 
@@ -231,6 +236,9 @@ struct btd_device {
 	struct bearer_state bredr_state;
 	struct bearer_state le_state;
 
+	struct csrk_info *local_csrk;
+	struct csrk_info *remote_csrk;
+
 	sdp_list_t	*tmp_records;
 
 	time_t		bredr_seen;
@@ -627,6 +635,8 @@ static void device_free(gpointer user_data)
 	if (device->eir_uuids)
 		g_slist_free_full(device->eir_uuids, g_free);
 
+	g_free(device->local_csrk);
+	g_free(device->remote_csrk);
 	g_free(device->path);
 	g_free(device->alias);
 	free(device->modalias);
@@ -2280,6 +2290,37 @@ failed:
 	return str;
 }
 
+static void load_csrk(struct csrk_info **csrk, GKeyFile *key_file,
+							const char *group)
+{
+	char *str;
+	int i;
+	uint8_t *key;
+
+	str = g_key_file_get_string(key_file, group, "Key", NULL);
+	if (!str)
+		return;
+
+	*csrk = g_new0(struct csrk_info, 1);
+	key = (*csrk)->key;
+
+	for (i = 0; i < 16; i++) {
+		if (sscanf(str + (i * 2), "%2hhx", &key[i]) != 1)
+			goto fail;
+	}
+
+	(*csrk)->counter = g_key_file_get_integer(key_file, group, "Counter",
+									NULL);
+	g_free(str);
+
+	return;
+
+fail:
+	g_free(str);
+	g_free(*csrk);
+	*csrk = NULL;
+}
+
 static void load_info(struct btd_device *device, const char *local,
 			const char *peer, GKeyFile *key_file)
 {
@@ -2355,6 +2396,9 @@ static void load_info(struct btd_device *device, const char *local,
 			error("Unknown LE device technology");
 
 		g_free(str);
+
+		load_csrk(&device->local_csrk, key_file, "LocalSignatureKey");
+		load_csrk(&device->remote_csrk, key_file, "RemoteSignatureKey");
 	}
 
 	g_strfreev(techno);
-- 
2.1.0

