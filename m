Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/49] Bluetooth: Add mgmt support for LE Secure Connections LTK types
Date: Wed,  3 Dec 2014 17:01:59 +0200
Message-Id: <1417618963-18010-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We need a dedicated LTK type for LTK resulting from a Secure Connections
based SMP pairing. This patch adds a new define for it and ensures that
both the New LTK event as well as the Load LTKs command supports it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/mgmt.h |  3 +++
 net/bluetooth/mgmt.c         | 33 ++++++++++++++++++++++++++-------
 net/bluetooth/smp.h          | 13 +++++++++++++
 3 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index b391fd663468..9b382ea34fd9 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -184,6 +184,9 @@ struct mgmt_cp_load_link_keys {
 
 #define MGMT_LTK_UNAUTHENTICATED	0x00
 #define MGMT_LTK_AUTHENTICATED		0x01
+#define MGMT_LTK_P256_UNAUTH		0x02
+#define MGMT_LTK_P256_AUTH		0x03
+#define MGMT_LTK_P256_DEBUG		0x04
 
 struct mgmt_ltk_info {
 	struct mgmt_addr_info addr;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index cbeef5f62f3b..7974a39a42d9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4910,18 +4910,26 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 		else
 			addr_type = ADDR_LE_DEV_RANDOM;
 
-		if (key->master)
-			type = SMP_LTK;
-		else
-			type = SMP_LTK_SLAVE;
-
 		switch (key->type) {
 		case MGMT_LTK_UNAUTHENTICATED:
 			authenticated = 0x00;
+			type = key->master ? SMP_LTK : SMP_LTK_SLAVE;
 			break;
 		case MGMT_LTK_AUTHENTICATED:
 			authenticated = 0x01;
+			type = key->master ? SMP_LTK : SMP_LTK_SLAVE;
+			break;
+		case MGMT_LTK_P256_UNAUTH:
+			authenticated = 0x00;
+			type = SMP_LTK_P256;
+			break;
+		case MGMT_LTK_P256_AUTH:
+			authenticated = 0x01;
+			type = SMP_LTK_P256;
 			break;
+		case MGMT_LTK_P256_DEBUG:
+			authenticated = 0x00;
+			type = SMP_LTK_P256_DEBUG;
 		default:
 			continue;
 		}
@@ -6101,8 +6109,19 @@ void mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 
 static u8 mgmt_ltk_type(struct smp_ltk *ltk)
 {
-	if (ltk->authenticated)
-		return MGMT_LTK_AUTHENTICATED;
+	switch (ltk->type) {
+	case SMP_LTK:
+	case SMP_LTK_SLAVE:
+		if (ltk->authenticated)
+			return MGMT_LTK_AUTHENTICATED;
+		return MGMT_LTK_UNAUTHENTICATED;
+	case SMP_LTK_P256:
+		if (ltk->authenticated)
+			return MGMT_LTK_P256_AUTH;
+		return MGMT_LTK_P256_UNAUTH;
+	case SMP_LTK_P256_DEBUG:
+		return MGMT_LTK_P256_DEBUG;
+	}
 
 	return MGMT_LTK_UNAUTHENTICATED;
 }
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index 7c3c351909f5..81d24c0ea08b 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -146,8 +146,21 @@ enum {
 	SMP_STK,
 	SMP_LTK,
 	SMP_LTK_SLAVE,
+	SMP_LTK_P256,
+	SMP_LTK_P256_DEBUG,
 };
 
+static inline bool smp_ltk_is_sc(struct smp_ltk *key)
+{
+	switch (key->type) {
+	case SMP_LTK_P256:
+	case SMP_LTK_P256_DEBUG:
+		return true;
+	}
+
+	return false;
+}
+
 static inline u8 smp_ltk_sec_level(struct smp_ltk *key)
 {
 	if (key->authenticated)
-- 
2.1.0

