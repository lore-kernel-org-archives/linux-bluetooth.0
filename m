Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 2/5] Add support for storing SMP keys
Date: Tue,  7 Jun 2011 20:08:11 -0300
Message-Id: <1307488094-19464-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1307488094-19464-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1307488094-19464-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/mgmtops.c |    4 ++--
 src/event.c       |   43 ++++++++++++++++++++++++++++++++++++++++---
 src/storage.c     |   25 ++++++++++++++++++++++++-
 src/storage.h     |    1 +
 4 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index e950fff..cc5fd78 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -383,8 +383,8 @@ static void mgmt_new_key(int sk, uint16_t index, void *buf, size_t len)
 	struct mgmt_ev_new_key *ev = buf;
 	struct controller_info *info;
 
-	if (len != sizeof(*ev)) {
-		error("new_key event size mismatch (%zu != %zu)",
+	if (len < sizeof(*ev)) {
+		error("new_key event size mismatch (%zu < %zu)",
 							len, sizeof(*ev));
 		return;
 	}
diff --git a/src/event.c b/src/event.c
index b258dda..edf8a0f 100644
--- a/src/event.c
+++ b/src/event.c
@@ -395,6 +395,42 @@ proceed:
 	adapter_set_state(adapter, STATE_IDLE);
 }
 
+static gchar *buf2str(uint8_t *data, int datalen)
+{
+	gchar *buf;
+	int i;
+
+	buf = g_new0(gchar, (datalen * 2) + 1);
+
+	for (i = 0; i < datalen; i++)
+		sprintf(buf + (i * 2), "%2.2x", data[i]);
+
+	return buf;
+}
+
+static int store_longtermkey(bdaddr_t *local, bdaddr_t *peer, unsigned char *key,
+			uint8_t type, int length, int dlen, uint8_t *data)
+{
+	GString *newkey;
+	char *val, *str;
+	int err;
+
+	val = buf2str(key, 16);
+	newkey = g_string_new(val);
+
+	g_string_append_printf(newkey, " %d %d %d ", type, length, dlen);
+
+	str = buf2str(data, dlen);
+	newkey = g_string_append(newkey, str);
+	g_free(str);
+
+	err = write_longtermkeys(local, peer, newkey->str);
+
+	g_string_free(newkey, TRUE);
+
+	return err;
+}
+
 int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer, uint8_t *key,
 		uint8_t key_type, uint8_t pin_length, int dlen, uint8_t *data)
 {
@@ -407,10 +443,11 @@ int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer, uint8_t *key,
 
 	DBG("storing link key of type 0x%02x", key_type);
 
-	if (key_type < 0x10)
-		ret = write_link_key(local, peer, key, key_type, pin_length);
+	if (key_type & 0x10)
+		ret = store_longtermkey(local, peer, key, key_type, pin_length,
+								dlen, data);
 	else
-		ret = write_longtermkeys(local, peer, NULL);
+		ret = write_link_key(local, peer, key, key_type, pin_length);
 
 	if (ret == 0 && device_is_temporary(device))
 		device_set_temporary(device, FALSE);
diff --git a/src/storage.c b/src/storage.c
index 786e24b..7ec8df2 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -1346,5 +1346,28 @@ device_type_t read_device_type(const bdaddr_t *sba, const bdaddr_t *dba)
 
 int write_longtermkeys(bdaddr_t *local, bdaddr_t *peer, const char *key)
 {
-	return 0;
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
+char *read_longtermkeys(bdaddr_t *local, bdaddr_t *peer)
+{
+	char filename[PATH_MAX + 1], addr[18];
+
+	create_filename(filename, PATH_MAX, local, "longtermkeys");
+
+	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+
+	ba2str(peer, addr);
+
+	return textfile_caseget(filename, addr);
 }
diff --git a/src/storage.h b/src/storage.h
index 923e819..23d9ab6 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -88,6 +88,7 @@ int write_device_type(const bdaddr_t *sba, const bdaddr_t *dba,
 						device_type_t type);
 device_type_t read_device_type(const bdaddr_t *sba, const bdaddr_t *dba);
 int write_longtermkeys(bdaddr_t *local, bdaddr_t *peer, const char *key);
+char *read_longtermkeys(bdaddr_t *local, bdaddr_t *peer);
 
 #define PNP_UUID		"00001200-0000-1000-8000-00805f9b34fb"
 
-- 
1.7.5.4

