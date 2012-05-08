Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Adds definitions for AMP Assoc data
Date: Tue,  8 May 2012 12:44:06 +0300
Message-Id: <1336470247-1646-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Definitions are needed for decoding A2MP Assoc Rsp.
---
 lib/a2mp.h |   38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/lib/a2mp.h b/lib/a2mp.h
index da937d1..ac308e7 100644
--- a/lib/a2mp.h
+++ b/lib/a2mp.h
@@ -142,6 +142,44 @@ struct a2mp_disconn_rsp {
 #define A2MP_STATUS_PHYS_LINK_EXISTS			0x05
 #define A2MP_STATUS_SECURITY_VIOLATION			0x06
 
+#define MAC_ADDR_TYPE		1
+#define PREF_CHANLIST_TYPE	2
+#define CONNECTED_CHAN		3
+#define PAL_CAP_TYPE		4
+#define PAL_VER_INFO		5
+
+struct tlv {
+	uint8_t type;
+	uint16_t len;
+	uint8_t val[0];
+} __attribute__ ((packed));
+
+struct pal_ver {
+	uint8_t ver;
+	uint16_t company_id;
+	uint16_t sub_ver;
+} __attribute__ ((packed));
+
+struct country_triplet {
+	union {
+		struct {
+			uint8_t first_channel;
+			uint8_t num_channels;
+			int8_t max_power;
+		} __attribute__ ((packed)) chans;
+		struct {
+			uint8_t reg_extension_id;
+			uint8_t reg_class;
+			uint8_t coverage_class;
+		} __attribute__ ((packed)) ext;
+	};
+} __attribute__ ((packed));
+
+struct chan_list {
+	uint8_t country_code[3];
+	struct country_triplet triplets[0];
+} __attribute__ ((packed));
+
 #ifdef __cplusplus
 }
 #endif
-- 
1.7.9.5

