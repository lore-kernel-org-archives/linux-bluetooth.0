Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 2/7] storage: Constify bdaddr_t pointers parameters
Date: Thu, 4 Oct 2012 14:05:59 +0200
Message-ID: <1349352364-5491-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1349352364-5491-1-git-send-email-szymon.janc@tieto.com>
References: <1349352364-5491-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/storage.c |   97 +++++++++++++++++++++++++++++++--------------------------
 src/storage.h |   95 ++++++++++++++++++++++++++++++-------------------------
 2 files changed, 105 insertions(+), 87 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index 96db6f5..df6b0aa 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -110,7 +110,7 @@ int write_device_alias(const char *src, const char *dst, uint8_t dst_type,
 	return textfile_put(filename, key, alias);
 }
 
-int write_discoverable_timeout(bdaddr_t *bdaddr, int timeout)
+int write_discoverable_timeout(const bdaddr_t *bdaddr, int timeout)
 {
 	char filename[PATH_MAX + 1], str[32];
 
@@ -143,7 +143,7 @@ int read_discoverable_timeout(const char *src, int *timeout)
 	return 0;
 }
 
-int write_pairable_timeout(bdaddr_t *bdaddr, int timeout)
+int write_pairable_timeout(const bdaddr_t *bdaddr, int timeout)
 {
 	char filename[PATH_MAX + 1], str[32];
 
@@ -176,7 +176,7 @@ int read_pairable_timeout(const char *src, int *timeout)
 	return 0;
 }
 
-int write_device_mode(bdaddr_t *bdaddr, const char *mode)
+int write_device_mode(const bdaddr_t *bdaddr, const char *mode)
 {
 	char filename[PATH_MAX + 1];
 
@@ -226,7 +226,7 @@ int read_on_mode(const char *src, char *mode, int length)
 	return 0;
 }
 
-int write_local_name(bdaddr_t *bdaddr, const char *name)
+int write_local_name(const bdaddr_t *bdaddr, const char *name)
 {
 	char filename[PATH_MAX + 1], str[249];
 	int i;
@@ -245,7 +245,7 @@ int write_local_name(bdaddr_t *bdaddr, const char *name)
 	return textfile_put(filename, "name", str);
 }
 
-int read_local_name(bdaddr_t *bdaddr, char *name)
+int read_local_name(const bdaddr_t *bdaddr, char *name)
 {
 	char filename[PATH_MAX + 1], *str;
 	int len;
@@ -266,7 +266,7 @@ int read_local_name(bdaddr_t *bdaddr, char *name)
 	return 0;
 }
 
-int write_local_class(bdaddr_t *bdaddr, uint8_t *class)
+int write_local_class(const bdaddr_t *bdaddr, uint8_t *class)
 {
 	char filename[PATH_MAX + 1], str[9];
 
@@ -279,7 +279,7 @@ int write_local_class(bdaddr_t *bdaddr, uint8_t *class)
 	return textfile_put(filename, "class", str);
 }
 
-int read_local_class(bdaddr_t *bdaddr, uint8_t *class)
+int read_local_class(const bdaddr_t *bdaddr, uint8_t *class)
 {
 	char filename[PATH_MAX + 1], tmp[3], *str;
 	int i;
@@ -301,8 +301,8 @@ int read_local_class(bdaddr_t *bdaddr, uint8_t *class)
 	return 0;
 }
 
-int read_remote_appearance(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
-							uint16_t *appearance)
+int read_remote_appearance(const bdaddr_t *local, const bdaddr_t *peer,
+				uint8_t bdaddr_type, uint16_t *appearance)
 {
 	char filename[PATH_MAX + 1], key[20], *str;
 
@@ -325,7 +325,7 @@ int read_remote_appearance(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
 	return 0;
 }
 
-int write_remote_appearance(bdaddr_t *local, bdaddr_t *peer,
+int write_remote_appearance(const bdaddr_t *local, const bdaddr_t *peer,
 				uint8_t bdaddr_type, uint16_t appearance)
 {
 	char filename[PATH_MAX + 1], key[20], str[7];
@@ -342,7 +342,8 @@ int write_remote_appearance(bdaddr_t *local, bdaddr_t *peer,
 	return textfile_put(filename, key, str);
 }
 
-int write_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t class)
+int write_remote_class(const bdaddr_t *local, const bdaddr_t *peer,
+								uint32_t class)
 {
 	char filename[PATH_MAX + 1], addr[18], str[9];
 
@@ -356,7 +357,8 @@ int write_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t class)
 	return textfile_put(filename, addr, str);
 }
 
-int read_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t *class)
+int read_remote_class(const bdaddr_t *local, const bdaddr_t *peer,
+							uint32_t *class)
 {
 	char filename[PATH_MAX + 1], addr[18], *str;
 
@@ -378,8 +380,8 @@ int read_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t *class)
 	return 0;
 }
 
-int write_device_name(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
-							const char *name)
+int write_device_name(const bdaddr_t *local, const bdaddr_t *peer,
+					uint8_t peer_type, const char *name)
 {
 	char filename[PATH_MAX + 1], key[20], str[HCI_MAX_NAME_LENGTH + 1];
 	int i;
@@ -433,8 +435,9 @@ done:
 	return 0;
 }
 
-int write_remote_eir(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
-						uint8_t *data, uint8_t data_len)
+int write_remote_eir(const bdaddr_t *local, const bdaddr_t *peer,
+					uint8_t peer_type, uint8_t *data,
+					uint8_t data_len)
 {
 	char filename[PATH_MAX + 1], key[20], str[481];
 	int i;
@@ -453,8 +456,8 @@ int write_remote_eir(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
 	return textfile_put(filename, key, str);
 }
 
-int read_remote_eir(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
-								uint8_t *data)
+int read_remote_eir(const bdaddr_t *local, const bdaddr_t *peer,
+					uint8_t peer_type, uint8_t *data)
 {
 	char filename[PATH_MAX + 1], key[18], *str;
 	int i;
@@ -494,8 +497,9 @@ done:
 	return 0;
 }
 
-int write_version_info(bdaddr_t *local, bdaddr_t *peer, uint16_t manufacturer,
-					uint8_t lmp_ver, uint16_t lmp_subver)
+int write_version_info(const bdaddr_t *local, const bdaddr_t *peer,
+					uint16_t manufacturer, uint8_t lmp_ver,
+					uint16_t lmp_subver)
 {
 	char filename[PATH_MAX + 1], addr[18], str[16];
 
@@ -510,7 +514,7 @@ int write_version_info(bdaddr_t *local, bdaddr_t *peer, uint16_t manufacturer,
 	return textfile_put(filename, addr, str);
 }
 
-int write_features_info(bdaddr_t *local, bdaddr_t *peer,
+int write_features_info(const bdaddr_t *local, const bdaddr_t *peer,
 				unsigned char *page1, unsigned char *page2)
 {
 	char filename[PATH_MAX + 1], addr[18];
@@ -554,7 +558,7 @@ static int decode_bytes(const char *str, unsigned char *bytes, size_t len)
 	return 0;
 }
 
-int read_remote_features(bdaddr_t *local, bdaddr_t *peer,
+int read_remote_features(const bdaddr_t *local, const bdaddr_t *peer,
 				unsigned char *page1, unsigned char *page2)
 {
 	char filename[PATH_MAX + 1], addr[18], *str;
@@ -587,8 +591,8 @@ int read_remote_features(bdaddr_t *local, bdaddr_t *peer,
 	return err;
 }
 
-int write_lastseen_info(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
-								struct tm *tm)
+int write_lastseen_info(const bdaddr_t *local, const bdaddr_t *peer,
+					uint8_t peer_type, struct tm *tm)
 {
 	char filename[PATH_MAX + 1], key[20], str[24];
 
@@ -605,8 +609,8 @@ int write_lastseen_info(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
 	return textfile_put(filename, key, str);
 }
 
-int write_lastused_info(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
-								struct tm *tm)
+int write_lastused_info(const bdaddr_t *local, const bdaddr_t *peer,
+					uint8_t peer_type, struct tm *tm)
 {
 	char filename[PATH_MAX + 1], key[20], str[24];
 
@@ -623,8 +627,9 @@ int write_lastused_info(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
 	return textfile_put(filename, key, str);
 }
 
-int write_link_key(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
-				unsigned char *key, uint8_t type, int length)
+int write_link_key(const bdaddr_t *local, const bdaddr_t *peer,
+					uint8_t peer_type, unsigned char *key,
+					uint8_t type, int length)
 {
 	char filename[PATH_MAX + 1], addr[20], str[38];
 	int i;
@@ -653,8 +658,9 @@ int write_link_key(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
 	return textfile_put(filename, addr, str);
 }
 
-int read_link_key(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
-					unsigned char *key, uint8_t *type)
+int read_link_key(const bdaddr_t *local, const bdaddr_t *peer,
+					uint8_t peer_type, unsigned char *key,
+					uint8_t *type)
 {
 	char filename[PATH_MAX + 1], addr[20], tmp[3], *str;
 	int i;
@@ -697,7 +703,7 @@ done:
 	return 0;
 }
 
-ssize_t read_pin_code(bdaddr_t *local, bdaddr_t *peer, char *pin)
+ssize_t read_pin_code(const bdaddr_t *local, const bdaddr_t *peer, char *pin)
 {
 	char filename[PATH_MAX + 1], addr[18], *str;
 	ssize_t len;
@@ -760,8 +766,8 @@ gboolean read_trust(const bdaddr_t *local, const char *addr, uint8_t addr_type)
 	return ret;
 }
 
-int write_device_profiles(bdaddr_t *src, bdaddr_t *dst, uint8_t dst_type,
-							const char *profiles)
+int write_device_profiles(const bdaddr_t *src, const bdaddr_t *dst,
+					uint8_t dst_type, const char *profiles)
 {
 	char filename[PATH_MAX + 1], key[20];
 
@@ -778,7 +784,7 @@ int write_device_profiles(bdaddr_t *src, bdaddr_t *dst, uint8_t dst_type,
 	return textfile_put(filename, key, profiles);
 }
 
-int delete_entry(bdaddr_t *src, const char *storage, bdaddr_t *dst,
+int delete_entry(const bdaddr_t *src, const char *storage, const bdaddr_t *dst,
 							uint8_t dst_type)
 {
 	char filename[PATH_MAX + 1], key[20];
@@ -1147,7 +1153,7 @@ int read_device_id(const gchar *srcaddr, const gchar *dstaddr,
 	return 0;
 }
 
-int write_device_pairable(bdaddr_t *bdaddr, gboolean mode)
+int write_device_pairable(const bdaddr_t *bdaddr, gboolean mode)
 {
 	char filename[PATH_MAX + 1];
 
@@ -1158,7 +1164,7 @@ int write_device_pairable(bdaddr_t *bdaddr, gboolean mode)
 	return textfile_put(filename, "pairable", mode ? "yes" : "no");
 }
 
-int read_device_pairable(bdaddr_t *bdaddr, gboolean *mode)
+int read_device_pairable(const bdaddr_t *bdaddr, gboolean *mode)
 {
 	char filename[PATH_MAX + 1], *str;
 
@@ -1359,8 +1365,9 @@ int read_device_attributes(const bdaddr_t *sba, textfile_cb func, void *data)
 	return textfile_foreach(filename, func, data);
 }
 
-int read_device_ccc(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
-					uint16_t handle, uint16_t *value)
+int read_device_ccc(const bdaddr_t *local, const bdaddr_t *peer,
+					uint8_t bdaddr_type, uint16_t handle,
+					uint16_t *value)
 {
 	char filename[PATH_MAX + 1], addr[18], key[25];
 	char *str;
@@ -1386,8 +1393,9 @@ int read_device_ccc(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
 	return err;
 }
 
-int write_device_ccc(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
-					uint16_t handle, uint16_t value)
+int write_device_ccc(const bdaddr_t *local, const bdaddr_t *peer,
+					uint8_t bdaddr_type, uint16_t handle,
+					uint16_t value)
 {
 	char filename[PATH_MAX + 1], addr[18], key[25], config[5];
 
@@ -1403,7 +1411,7 @@ int write_device_ccc(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
 	return textfile_put(filename, key, config);
 }
 
-void delete_device_ccc(bdaddr_t *local, bdaddr_t *peer)
+void delete_device_ccc(const bdaddr_t *local, const bdaddr_t *peer)
 {
 	char filename[PATH_MAX + 1], addr[18];
 
@@ -1414,8 +1422,8 @@ void delete_device_ccc(bdaddr_t *local, bdaddr_t *peer)
 	delete_by_pattern(filename, addr);
 }
 
-int write_longtermkeys(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
-								const char *key)
+int write_longtermkeys(const bdaddr_t *local, const bdaddr_t *peer,
+					uint8_t bdaddr_type, const char *key)
 {
 	char filename[PATH_MAX + 1], addr[20];
 
@@ -1432,7 +1440,8 @@ int write_longtermkeys(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
 	return textfile_put(filename, addr, key);
 }
 
-gboolean has_longtermkeys(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type)
+gboolean has_longtermkeys(const bdaddr_t *local, const bdaddr_t *peer,
+							uint8_t bdaddr_type)
 {
 	char filename[PATH_MAX + 1], key[20], *str;
 
diff --git a/src/storage.h b/src/storage.h
index 6a8df83..741b8a7 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -27,50 +27,57 @@ int read_device_alias(const char *src, const char *dst, uint8_t dst_type,
 						char *alias, size_t size);
 int write_device_alias(const char *src, const char *dst, uint8_t dst_type,
 							const char *alias);
-int write_discoverable_timeout(bdaddr_t *bdaddr, int timeout);
+int write_discoverable_timeout(const bdaddr_t *bdaddr, int timeout);
 int read_discoverable_timeout(const char *src, int *timeout);
-int write_pairable_timeout(bdaddr_t *bdaddr, int timeout);
+int write_pairable_timeout(const bdaddr_t *bdaddr, int timeout);
 int read_pairable_timeout(const char *src, int *timeout);
-int write_device_mode(bdaddr_t *bdaddr, const char *mode);
+int write_device_mode(const bdaddr_t *bdaddr, const char *mode);
 int read_device_mode(const char *src, char *mode, int length);
 int read_on_mode(const char *src, char *mode, int length);
-int write_local_name(bdaddr_t *bdaddr, const char *name);
-int read_local_name(bdaddr_t *bdaddr, char *name);
-int write_local_class(bdaddr_t *bdaddr, uint8_t *class);
-int read_local_class(bdaddr_t *bdaddr, uint8_t *class);
-int write_remote_appearance(bdaddr_t *local, bdaddr_t *peer,
+int write_local_name(const bdaddr_t *bdaddr, const char *name);
+int read_local_name(const bdaddr_t *bdaddr, char *name);
+int write_local_class(const bdaddr_t *bdaddr, uint8_t *class);
+int read_local_class(const bdaddr_t *bdaddr, uint8_t *class);
+int write_remote_appearance(const bdaddr_t *local, const bdaddr_t *peer,
 				uint8_t bdaddr_type, uint16_t appearance);
-int read_remote_appearance(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
-							uint16_t *appearance);
-int write_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t class);
-int read_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t *class);
-int write_device_name(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
-							const char *name);
+int read_remote_appearance(const bdaddr_t *local, const bdaddr_t *peer,
+				uint8_t bdaddr_type, uint16_t *appearance);
+int write_remote_class(const bdaddr_t *local, const bdaddr_t *peer,
+							uint32_t class);
+int read_remote_class(const bdaddr_t *local, const bdaddr_t *peer,
+							uint32_t *class);
+int write_device_name(const bdaddr_t *local, const bdaddr_t *peer,
+					uint8_t peer_type, const char *name);
 int read_device_name(const char *src, const char *dst, uint8_t dst_type,
 								char *name);
-int write_remote_eir(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
-					uint8_t *data, uint8_t data_len);
-int read_remote_eir(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
-								uint8_t *data);
-int write_version_info(bdaddr_t *local, bdaddr_t *peer, uint16_t manufacturer, uint8_t lmp_ver, uint16_t lmp_subver);
-int write_features_info(bdaddr_t *local, bdaddr_t *peer, unsigned char *page1, unsigned char *page2);
-int read_remote_features(bdaddr_t *local, bdaddr_t *peer, unsigned char *page1, unsigned char *page2);
-int write_lastseen_info(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
-								struct tm *tm);
-int write_lastused_info(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
-								struct tm *tm);
-int write_link_key(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
-				unsigned char *key, uint8_t type, int length);
-int read_link_key(bdaddr_t *local, bdaddr_t *peer, uint8_t peer_type,
-					unsigned char *key, uint8_t *type);
-ssize_t read_pin_code(bdaddr_t *local, bdaddr_t *peer, char *pin);
+int write_remote_eir(const bdaddr_t *local, const bdaddr_t *peer,
+			uint8_t peer_type, uint8_t *data, uint8_t data_len);
+int read_remote_eir(const bdaddr_t *local, const bdaddr_t *peer,
+					uint8_t peer_type, uint8_t *data);
+int write_version_info(const bdaddr_t *local, const bdaddr_t *peer,
+				uint16_t manufacturer, uint8_t lmp_ver,
+				uint16_t lmp_subver);
+int write_features_info(const bdaddr_t *local, const bdaddr_t *peer,
+				unsigned char *page1, unsigned char *page2);
+int read_remote_features(const bdaddr_t *local, const bdaddr_t *peer,
+				unsigned char *page1, unsigned char *page2);
+int write_lastseen_info(const bdaddr_t *local, const bdaddr_t *peer,
+					uint8_t peer_type, struct tm *tm);
+int write_lastused_info(const bdaddr_t *local, const bdaddr_t *peer,
+					uint8_t peer_type, struct tm *tm);
+int write_link_key(const bdaddr_t *local, const bdaddr_t *peer,
+					uint8_t peer_type, unsigned char *key,
+					uint8_t type, int length);
+int read_link_key(const bdaddr_t *local, const bdaddr_t *peer,
+			uint8_t peer_type, unsigned char *key, uint8_t *type);
+ssize_t read_pin_code(const bdaddr_t *local, const bdaddr_t *peer, char *pin);
 gboolean read_trust(const bdaddr_t *local, const char *addr,
 						uint8_t addr_type);
 int write_trust(const char *src, const char *addr, uint8_t addr_type,
 							gboolean trust);
-int write_device_profiles(bdaddr_t *src, bdaddr_t *dst, uint8_t dst_type,
-							const char *profiles);
-int delete_entry(bdaddr_t *src, const char *storage, bdaddr_t *dst,
+int write_device_profiles(const bdaddr_t *src, const bdaddr_t *dst,
+				uint8_t dst_type, const char *profiles);
+int delete_entry(const bdaddr_t *src, const char *storage, const bdaddr_t *dst,
 							uint8_t dst_type);
 int store_record(const gchar *src, const gchar *dst, uint8_t dst_type,
 							sdp_record_t *rec);
@@ -89,8 +96,8 @@ int store_device_id(const gchar *src, const gchar *dst, uint8_t dst_type,
 int read_device_id(const gchar *src, const gchar *dst, uint8_t dst_type,
 					uint16_t *source, uint16_t *vendor,
 					uint16_t *product, uint16_t *version);
-int write_device_pairable(bdaddr_t *local, gboolean mode);
-int read_device_pairable(bdaddr_t *local, gboolean *mode);
+int write_device_pairable(const bdaddr_t *local, gboolean mode);
+int read_device_pairable(const bdaddr_t *local, gboolean *mode);
 gboolean read_blocked(const bdaddr_t *local, const bdaddr_t *remote,
 							uint8_t remote_type);
 int write_blocked(const bdaddr_t *local, const bdaddr_t *remote,
@@ -110,11 +117,13 @@ int write_device_attribute(const bdaddr_t *sba, const bdaddr_t *dba,
 				uint8_t bdaddr_type, uint16_t handle,
 							const char *chars);
 int read_device_attributes(const bdaddr_t *sba, textfile_cb func, void *data);
-int read_device_ccc(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
-					uint16_t handle, uint16_t *value);
-int write_device_ccc(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
-					uint16_t handle, uint16_t value);
-void delete_device_ccc(bdaddr_t *local, bdaddr_t *peer);
-int write_longtermkeys(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type,
-							const char *key);
-gboolean has_longtermkeys(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_type);
+int read_device_ccc(const bdaddr_t *local, const bdaddr_t *peer,
+			uint8_t bdaddr_type, uint16_t handle, uint16_t *value);
+int write_device_ccc(const bdaddr_t *local, const bdaddr_t *peer,
+					uint8_t bdaddr_type, uint16_t handle,
+					uint16_t value);
+void delete_device_ccc(const bdaddr_t *local, const bdaddr_t *peer);
+int write_longtermkeys(const bdaddr_t *local, const bdaddr_t *peer,
+					uint8_t bdaddr_type, const char *key);
+gboolean has_longtermkeys(const bdaddr_t *local, const bdaddr_t *peer,
+							uint8_t bdaddr_type);
-- 
1.7.9.5

