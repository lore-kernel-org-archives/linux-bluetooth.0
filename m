Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [hcidump PATCHv2 1/2] Adds definitions for AMP Assoc data
Date: Thu, 10 May 2012 11:08:51 +0300
Message-Id: <1336637333-20723-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <20120508202209.GA10294@x220.hpllc.com>
References: <20120508202209.GA10294@x220.hpllc.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Definitions are needed for decoding A2MP Assoc Rsp.
---
 lib/a2mp.h |   38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/lib/a2mp.h b/lib/a2mp.h
index da937d1..61f1c1e 100644
--- a/lib/a2mp.h
+++ b/lib/a2mp.h
@@ -142,6 +142,44 @@ struct a2mp_disconn_rsp {
 #define A2MP_STATUS_PHYS_LINK_EXISTS			0x05
 #define A2MP_STATUS_SECURITY_VIOLATION			0x06
 
+#define A2MP_MAC_ADDR_TYPE		1
+#define A2MP_PREF_CHANLIST_TYPE		2
+#define A2MP_CONNECTED_CHAN		3
+#define A2MP_PAL_CAP_TYPE		4
+#define A2MP_PAL_VER_INFO		5
+
+struct a2mp_tlv {
+	uint8_t type;
+	uint16_t len;
+	uint8_t val[0];
+} __attribute__ ((packed));
+
+struct a2mp_pal_ver {
+	uint8_t ver;
+	uint16_t company_id;
+	uint16_t sub_ver;
+} __attribute__ ((packed));
+
+struct a2mp_country_triplet {
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
+struct a2mp_chan_list {
+	uint8_t country_code[3];
+	struct a2mp_country_triplet triplets[0];
+} __attribute__ ((packed));
+
 #ifdef __cplusplus
 }
 #endif
-- 
1.7.9.5

