Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<joakim.xj.ceder@stericsson.com>, <johan.hedberg@gmail.com>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH] BT_SECURITY_HIGH requires 16 digit pin code
Date: Fri, 27 Aug 2010 13:45:26 +0200
Message-ID: <1282909526-19374-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The security level BT_SECURITY_HIGH expects secure connection
and a minimum 16 digit pin code used for bonding. It's requitred by the
Sim Access Profile.

Patch on behalf of ST-Ericsson SA.

Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
---
 lib/hci.h       |    8 +++++++-
 src/dbus-hci.c  |   33 ++++++++++++++++++++++++++++-----
 src/security.c  |   38 ++++++++++++++++++++++++++++++++++----
 3 files changed, 69 insertions(+), 10 deletions(-)
 mode change 100644 => 100755 lib/bluetooth.h
 mode change 100644 => 100755 lib/hci.h
 mode change 100644 => 100755 lib/l2cap.h
 mode change 100644 => 100755 lib/rfcomm.h
 mode change 100644 => 100755 src/btio.c
 mode change 100644 => 100755 src/btio.h
 mode change 100644 => 100755 src/dbus-hci.c
 mode change 100644 => 100755 src/security.c

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
old mode 100644
new mode 100755
diff --git a/lib/hci.h b/lib/hci.h
old mode 100644
new mode 100755
index 512dab9..a313929
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -96,7 +96,7 @@ enum {
 #define HCISETLINKMODE	_IOW('H', 226, int)
 #define HCISETACLMTU	_IOW('H', 227, int)
 #define HCISETSCOMTU	_IOW('H', 228, int)
-
+#define HCISETCONNINFO	_IOW('H', 229, int)
 #define HCIBLOCKADDR	_IOW('H', 230, int)
 #define HCIUNBLOCKADDR	_IOW('H', 231, int)
 
@@ -2326,9 +2326,15 @@ struct hci_conn_info_req {
 	struct hci_conn_info conn_info[0];
 };
 
+struct hci_set_conn_info_req {
+	bdaddr_t bdaddr;
+	uint8_t  pin_len;
+	uint8_t  key_type;
+};
 struct hci_auth_info_req {
 	bdaddr_t bdaddr;
 	uint8_t  type;
+	uint8_t  level;
 };
 
 struct hci_inquiry_req {
diff --git a/lib/l2cap.h b/lib/l2cap.h
old mode 100644
new mode 100755
diff --git a/lib/rfcomm.h b/lib/rfcomm.h
old mode 100644
new mode 100755
diff --git a/src/btio.c b/src/btio.c
old mode 100644
new mode 100755
diff --git a/src/btio.h b/src/btio.h
old mode 100644
new mode 100755
diff --git a/src/dbus-hci.c b/src/dbus-hci.c
old mode 100644
new mode 100755
index 9055ffe..177f536
--- a/src/dbus-hci.c
+++ b/src/dbus-hci.c
@@ -165,6 +165,8 @@ static void pincode_cb(struct agent *agent, DBusError *err,
 {
 	struct btd_adapter *adapter = device_get_adapter(device);
 	pin_code_reply_cp pr;
+	struct hci_auth_info_req ar;
+	struct hci_set_conn_info_req cr;
 	bdaddr_t sba, dba;
 	size_t len;
 	int dev;
@@ -180,13 +182,30 @@ static void pincode_cb(struct agent *agent, DBusError *err,
 	adapter_get_address(adapter, &sba);
 	device_get_address(device, &dba);
 
-	if (err) {
-		hci_send_cmd(dev, OGF_LINK_CTL,
-				OCF_PIN_CODE_NEG_REPLY, 6, &dba);
-		goto done;
-	}
+	if (err)
+		goto reject;
 
 	len = strlen(pincode);
+	memset(&ar, 0, sizeof(ar));
+	bacpy(&ar.bdaddr, &dba);
+	if (ioctl(dev, HCIGETAUTHINFO, (unsigned long) &ar) < 0) {
+		error("Can't get auth info: %s (%d)", strerror(errno), errno);
+		goto reject;
+	}
+
+	if (ar.level == BT_SECURITY_HIGH && len < 16) {
+		error("Not enough secure PIN (expected 16 digit PIN, but got \
+							%d digit).", len);
+		goto reject;
+	}
+
+	bacpy(&cr.bdaddr, &dba);
+	cr.pin_len = len;
+	cr.key_type = 0xff;
+	if (ioctl(dev, HCISETCONNINFO, (unsigned long) &cr) < 0) {
+		error("Can't set conn info: %s (%d)", strerror(errno), errno);
+		goto reject;
+	}
 
 	set_pin_length(&sba, len);
 
@@ -196,7 +215,11 @@ static void pincode_cb(struct agent *agent, DBusError *err,
 	pr.pin_len = len;
 	hci_send_cmd(dev, OGF_LINK_CTL, OCF_PIN_CODE_REPLY,
 						PIN_CODE_REPLY_CP_SIZE, &pr);
+	goto done;
 
+reject:
+	hci_send_cmd(dev, OGF_LINK_CTL,
+			OCF_PIN_CODE_NEG_REPLY, 6, &dba);
 done:
 	hci_close_dev(dev);
 }
diff --git a/src/security.c b/src/security.c
old mode 100644
new mode 100755
index 667f1f1..b25d1e4
--- a/src/security.c
+++ b/src/security.c
@@ -309,6 +309,7 @@ static void link_key_request(int dev, bdaddr_t *sba, bdaddr_t *dba)
 	char sa[18], da[18];
 	uint8_t type;
 	int err;
+	int pinlen;
 
 	if (!get_adapter_and_device(sba, dba, &adapter, &device, FALSE))
 		device = NULL;
@@ -325,9 +326,11 @@ static void link_key_request(int dev, bdaddr_t *sba, bdaddr_t *dba)
 			DBG("HCIGETAUTHINFO failed %s (%d)",
 						strerror(errno), errno);
 		req.type = 0x00;
+		req.level = BT_SECURITY_LOW;
 	}
 
-	DBG("kernel auth requirements = 0x%02x", req.type);
+	DBG("kernel auth requirements = 0x%02x and security level = 0x%02x", \
+				req.type, req.level);
 
 	if (main_opts.debug_keys && device && device_get_debug_key(device, key))
 		type = 0x03;
@@ -341,18 +344,34 @@ static void link_key_request(int dev, bdaddr_t *sba, bdaddr_t *dba)
 
 	DBG("link key type = 0x%02x", type);
 
+	pinlen = read_pin_length(sba, dba);
+	DBG("stored link key type = 0x%02x pin_len = %d", type, pinlen);
+
 	/* Don't use unauthenticated combination keys if MITM is
-	 * required */
-	if (type == 0x04 && req.type != 0xff && (req.type & 0x01))
+	 * required and also don't use combination link keys authenticated with
+	 * an PIN code len < 16 if security level BT_SECURITY_HIGH is required*/
+	if ((type == 0x04 && req.type != 0xff && (req.type & 0x01)) ||
+		(type == 0x00 && req.level == BT_SECURITY_HIGH && pinlen < 16))
 		hci_send_cmd(dev, OGF_LINK_CTL, OCF_LINK_KEY_NEG_REPLY,
 								6, dba);
 	else {
 		link_key_reply_cp lr;
+		struct hci_set_conn_info_req cr;
 
 		memcpy(lr.link_key, key, 16);
 		bacpy(&lr.bdaddr, dba);
 
-		hci_send_cmd(dev, OGF_LINK_CTL, OCF_LINK_KEY_REPLY,
+		bacpy(&cr.bdaddr, dba);
+		cr.pin_len = pinlen;
+		cr.key_type = type;
+
+		if (ioctl(dev, HCISETCONNINFO, (unsigned long) &cr) < 0) {
+			error("Can't set conn info: %s (%d)", strerror(errno),
+									errno);
+			hci_send_cmd(dev, OGF_LINK_CTL, OCF_LINK_KEY_NEG_REPLY,
+									6, dba);
+		} else
+			hci_send_cmd(dev, OGF_LINK_CTL, OCF_LINK_KEY_REPLY,
 						LINK_KEY_REPLY_CP_SIZE, &lr);
 	}
 }
@@ -523,6 +542,7 @@ static void pin_code_request(int dev, bdaddr_t *sba, bdaddr_t *dba)
 	pin_code_reply_cp pr;
 	struct hci_conn_info_req *cr;
 	struct hci_conn_info *ci;
+	struct hci_auth_info_req ar;
 	char sa[18], da[18], pin[17];
 	int pinlen;
 
@@ -542,10 +562,20 @@ static void pin_code_request(int dev, bdaddr_t *sba, bdaddr_t *dba)
 	}
 	ci = cr->conn_info;
 
+	memset(&ar, 0, sizeof(ar));
+	bacpy(&ar.bdaddr, dba);
+	if (ioctl(dev, HCIGETAUTHINFO, (unsigned long) &ar) < 0) {
+		error("Can't get auth info: %s (%d)", strerror(errno), errno);
+		goto reject;
+	}
 	memset(pin, 0, sizeof(pin));
 	pinlen = read_pin_code(sba, dba, pin);
 
 	if (pinlen > 0) {
+		if (ar.level == BT_SECURITY_HIGH && pinlen < 16) {
+			error("Not 16 digit pin code.");
+			goto reject;
+		}
 		set_pin_length(sba, pinlen);
 		memcpy(pr.pin_code, pin, pinlen);
 		pr.pin_len = pinlen;
-- 
1.7.0.4

