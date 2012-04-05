Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ v1 6/7] Remove MGMT address type definition
Date: Thu,  5 Apr 2012 19:38:53 -0300
Message-Id: <1333665533-21814-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch replaces the address type defined in management interface
header by the new address type constants defined in the bluetooth.h.
---
 lib/mgmt.h        |    5 ----
 mgmt/main.c       |   26 +++++++++++-----------
 plugins/mgmtops.c |   60 ++++++++++++++--------------------------------------
 3 files changed, 29 insertions(+), 62 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index c9b0f1a..a58915b 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -53,11 +53,6 @@ struct mgmt_hdr {
 } __packed;
 #define MGMT_HDR_SIZE	6
 
-#define MGMT_ADDR_BREDR			0x00
-#define MGMT_ADDR_LE_PUBLIC		0x01
-#define MGMT_ADDR_LE_RANDOM		0x02
-#define MGMT_ADDR_INVALID		0xff
-
 struct mgmt_addr_info {
 	bdaddr_t bdaddr;
 	uint8_t type;
diff --git a/mgmt/main.c b/mgmt/main.c
index 3481e14..6e35071 100644
--- a/mgmt/main.c
+++ b/mgmt/main.c
@@ -306,7 +306,7 @@ static const char *typestr(uint8_t type)
 {
 	const char *str[] = { "BR/EDR", "LE Public", "LE Random" };
 
-	if (type <= MGMT_ADDR_LE_RANDOM)
+	if (type <= BDADDR_LE_RANDOM)
 		return str[type];
 
 	return "(unknown)";
@@ -1265,22 +1265,22 @@ static void cmd_find(int mgmt_sk, uint16_t index, int argc, char **argv)
 		index = 0;
 
 	type = 0;
-	hci_set_bit(MGMT_ADDR_BREDR, &type);
-	hci_set_bit(MGMT_ADDR_LE_PUBLIC, &type);
-	hci_set_bit(MGMT_ADDR_LE_RANDOM, &type);
+	hci_set_bit(BDADDR_BREDR, &type);
+	hci_set_bit(BDADDR_LE_PUBLIC, &type);
+	hci_set_bit(BDADDR_LE_RANDOM, &type);
 
 	while ((opt = getopt_long(argc, argv, "+lbh", find_options,
 								NULL)) != -1) {
 		switch (opt) {
 		case 'l':
-			hci_clear_bit(MGMT_ADDR_BREDR, &type);
-			hci_set_bit(MGMT_ADDR_LE_PUBLIC, &type);
-			hci_set_bit(MGMT_ADDR_LE_RANDOM, &type);
+			hci_clear_bit(BDADDR_BREDR, &type);
+			hci_set_bit(BDADDR_LE_PUBLIC, &type);
+			hci_set_bit(BDADDR_LE_RANDOM, &type);
 			break;
 		case 'b':
-			hci_set_bit(MGMT_ADDR_BREDR, &type);
-			hci_clear_bit(MGMT_ADDR_LE_PUBLIC, &type);
-			hci_clear_bit(MGMT_ADDR_LE_RANDOM, &type);
+			hci_set_bit(BDADDR_BREDR, &type);
+			hci_clear_bit(BDADDR_LE_PUBLIC, &type);
+			hci_clear_bit(BDADDR_LE_RANDOM, &type);
 			break;
 		case 'h':
 		default:
@@ -1388,7 +1388,7 @@ static void cmd_pair(int mgmt_sk, uint16_t index, int argc, char **argv)
 {
 	struct mgmt_cp_pair_device cp;
 	uint8_t cap = 0x01;
-	uint8_t type = MGMT_ADDR_BREDR;
+	uint8_t type = BDADDR_BREDR;
 	int opt;
 
 	while ((opt = getopt_long(argc, argv, "+c:t:h", pair_options,
@@ -1560,7 +1560,7 @@ static struct option block_options[] = {
 static void cmd_block(int mgmt_sk, uint16_t index, int argc, char **argv)
 {
 	struct mgmt_cp_block_device cp;
-	uint8_t type = MGMT_ADDR_BREDR;
+	uint8_t type = BDADDR_BREDR;
 	int opt;
 
 	while ((opt = getopt_long(argc, argv, "+t:h", block_options,
@@ -1607,7 +1607,7 @@ static void unblock_usage(void)
 static void cmd_unblock(int mgmt_sk, uint16_t index, int argc, char **argv)
 {
 	struct mgmt_cp_unblock_device cp;
-	uint8_t type = MGMT_ADDR_BREDR;
+	uint8_t type = BDADDR_BREDR;
 	int opt;
 
 	while ((opt = getopt_long(argc, argv, "+t:h", block_options,
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 1df4aec..f3c72e9 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -464,34 +464,6 @@ static void mgmt_new_link_key(int sk, uint16_t index, void *buf, size_t len)
 	bonding_complete(info, &ev->key.addr.bdaddr, 0);
 }
 
-static inline uint8_t addr_type(uint8_t mgmt_addr_type)
-{
-	switch (mgmt_addr_type) {
-	case MGMT_ADDR_BREDR:
-		return BDADDR_BREDR;
-	case MGMT_ADDR_LE_PUBLIC:
-		return BDADDR_LE_PUBLIC;
-	case MGMT_ADDR_LE_RANDOM:
-		return BDADDR_LE_RANDOM;
-	default:
-		return BDADDR_BREDR;
-	}
-}
-
-static inline uint8_t mgmt_addr_type(uint8_t addr_type)
-{
-	switch (addr_type) {
-	case BDADDR_BREDR:
-		return MGMT_ADDR_BREDR;
-	case BDADDR_LE_PUBLIC:
-		return MGMT_ADDR_LE_PUBLIC;
-	case BDADDR_LE_RANDOM:
-		return MGMT_ADDR_LE_RANDOM;
-	default:
-		return MGMT_ADDR_BREDR;
-	}
-}
-
 static void mgmt_device_connected(int sk, uint16_t index, void *buf, size_t len)
 {
 	struct mgmt_ev_device_connected *ev = buf;
@@ -527,7 +499,7 @@ static void mgmt_device_connected(int sk, uint16_t index, void *buf, size_t len)
 		eir_parse(&eir_data, ev->eir, eir_len);
 
 	btd_event_conn_complete(&info->bdaddr, &ev->addr.bdaddr,
-						addr_type(ev->addr.type),
+						ev->addr.type,
 						eir_data.name,
 						eir_data.dev_class);
 
@@ -610,7 +582,7 @@ static int mgmt_pincode_reply(int index, bdaddr_t *bdaddr, const char *pin,
 
 		cp = (void *) &buf[sizeof(*hdr)];
 		bacpy(&cp->addr.bdaddr, bdaddr);
-		cp->addr.type = MGMT_ADDR_BREDR;
+		cp->addr.type = BDADDR_BREDR;
 
 		buf_len = sizeof(*hdr) + sizeof(*cp);
 	} else {
@@ -625,7 +597,7 @@ static int mgmt_pincode_reply(int index, bdaddr_t *bdaddr, const char *pin,
 
 		cp = (void *) &buf[sizeof(*hdr)];
 		bacpy(&cp->addr.bdaddr, bdaddr);
-		cp->addr.type = MGMT_ADDR_BREDR;
+		cp->addr.type = BDADDR_BREDR;
 		cp->pin_len = pin_len;
 		memcpy(cp->pin_code, pin, pin_len);
 
@@ -692,7 +664,7 @@ static int mgmt_confirm_reply(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type,
 
 	cp = (void *) &buf[sizeof(*hdr)];
 	bacpy(&cp->addr.bdaddr, bdaddr);
-	cp->addr.type = mgmt_addr_type(bdaddr_type);
+	cp->addr.type = bdaddr_type;
 
 	if (write(mgmt_sock, buf, sizeof(buf)) < 0)
 		return -errno;
@@ -722,7 +694,7 @@ static int mgmt_passkey_reply(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type,
 
 		cp = (void *) &buf[sizeof(*hdr)];
 		bacpy(&cp->addr.bdaddr, bdaddr);
-		cp->addr.type = mgmt_addr_type(bdaddr_type);
+		cp->addr.type = bdaddr_type;
 
 		buf_len = sizeof(*hdr) + sizeof(*cp);
 	} else {
@@ -733,7 +705,7 @@ static int mgmt_passkey_reply(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type,
 
 		cp = (void *) &buf[sizeof(*hdr)];
 		bacpy(&cp->addr.bdaddr, bdaddr);
-		cp->addr.type = mgmt_addr_type(bdaddr_type);
+		cp->addr.type = bdaddr_type;
 		cp->passkey = htobl(passkey);
 
 		buf_len = sizeof(*hdr) + sizeof(*cp);
@@ -1567,7 +1539,7 @@ static void mgmt_device_found(int sk, uint16_t index, void *buf, size_t len)
 	confirm_name = (flags & MGMT_DEV_FOUND_CONFIRM_NAME);
 
 	btd_event_device_found(&info->bdaddr, &ev->addr.bdaddr,
-						addr_type(ev->addr.type),
+						ev->addr.type,
 						ev->rssi, confirm_name,
 						eir, eir_len);
 }
@@ -1897,11 +1869,11 @@ static int mgmt_start_discovery(int index)
 	info->discov_type = 0;
 
 	if (mgmt_bredr(info->current_settings))
-		hci_set_bit(MGMT_ADDR_BREDR, &info->discov_type);
+		hci_set_bit(BDADDR_BREDR, &info->discov_type);
 
 	if (mgmt_low_energy(info->current_settings)) {
-		hci_set_bit(MGMT_ADDR_LE_PUBLIC, &info->discov_type);
-		hci_set_bit(MGMT_ADDR_LE_RANDOM, &info->discov_type);
+		hci_set_bit(BDADDR_LE_PUBLIC, &info->discov_type);
+		hci_set_bit(BDADDR_LE_RANDOM, &info->discov_type);
 	}
 
 	memset(buf, 0, sizeof(buf));
@@ -2007,7 +1979,7 @@ static int mgmt_block_device(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type)
 
 	cp = (void *) &buf[sizeof(*hdr)];
 	bacpy(&cp->addr.bdaddr, bdaddr);
-	cp->addr.type = mgmt_addr_type(bdaddr_type);
+	cp->addr.type = bdaddr_type;
 
 	buf_len = sizeof(*hdr) + sizeof(*cp);
 
@@ -2037,7 +2009,7 @@ static int mgmt_unblock_device(int index, bdaddr_t *bdaddr,
 
 	cp = (void *) &buf[sizeof(*hdr)];
 	bacpy(&cp->addr.bdaddr, bdaddr);
-	cp->addr.type = mgmt_addr_type(bdaddr_type);
+	cp->addr.type = bdaddr_type;
 
 	buf_len = sizeof(*hdr) + sizeof(*cp);
 
@@ -2075,7 +2047,7 @@ static int mgmt_disconnect(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type)
 	hdr->index = htobs(index);
 
 	bacpy(&cp->addr.bdaddr, bdaddr);
-	cp->addr.type = mgmt_addr_type(bdaddr_type);
+	cp->addr.type = bdaddr_type;
 
 	if (write(mgmt_sock, buf, sizeof(buf)) < 0)
 		error("write: %s (%d)", strerror(errno), errno);
@@ -2099,7 +2071,7 @@ static int mgmt_unpair_device(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type)
 	hdr->index = htobs(index);
 
 	bacpy(&cp->addr.bdaddr, bdaddr);
-	cp->addr.type = mgmt_addr_type(bdaddr_type);
+	cp->addr.type = bdaddr_type;
 	cp->disconnect = 1;
 
 	if (write(mgmt_sock, buf, sizeof(buf)) < 0)
@@ -2192,7 +2164,7 @@ static int mgmt_load_link_keys(int index, GSList *keys, gboolean debug_keys)
 		struct link_key_info *info = l->data;
 
 		bacpy(&key->addr.bdaddr, &info->bdaddr);
-		key->addr.type = MGMT_ADDR_BREDR;
+		key->addr.type = BDADDR_BREDR;
 		key->type = info->type;
 		memcpy(key->val, info->key, 16);
 		key->pin_len = info->pin_len;
@@ -2362,7 +2334,7 @@ static int mgmt_confirm_name(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type,
 	hdr->len = htobs(sizeof(*cp));
 
 	bacpy(&cp->addr.bdaddr, bdaddr);
-	cp->addr.type = mgmt_addr_type(bdaddr_type);
+	cp->addr.type = bdaddr_type;
 	cp->name_known = name_known;
 
 	if (write(mgmt_sock, &buf, sizeof(buf)) < 0)
-- 
1.7.8.5

