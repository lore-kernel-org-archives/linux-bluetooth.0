Return-Path: <cyrus@holtmann.org>
From: David Stockwell <dstockwell@frequency-one.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] Added structs for AVRCP baseline messages
Date: Thu, 11 Aug 2011 09:13:19 -0500
Cc: lucas.demarchi@profusion.mobi, luiz.dentz@gmail.com,
	david_stockwell@att.net
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201108110913.20006.dstockwell@frequency-one.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added structs for AVRCP baseline messages:
  UnitInfo, SubUnitInfo, Passthrough and Vendor Dependent

Based on Release 4.96
---
 audio/control.c |   92 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 92 insertions(+), 0 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 188297a..8ddcc10 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -282,6 +282,98 @@ struct avrcp_spec_avc_pdu {
 #error "Unknown byte order"
 #endif
 
+/* structs for AVRCP UnitInfo, SubUnitInfo, and Passthrough messages. */
+
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+
+struct	avrcp_unitinfo {
+	struct avrcp_header	hdr;
+	uint8_t		ext_code;
+	uint8_t		unit:3;
+	uint8_t		unit_type:5;
+	uint8_t		company_id[3];
+} __attribute__ ((packed));
+
+struct	avrcp_subunit {
+	uint8_t		subunit_id_max:3;
+	uint8_t		subunit_type:5;
+} __attribute__ ((packed));
+
+struct	avrcp_subunitinfo {
+	struct avrcp_header	hdr;
+	uint8_t		extension:3;
+	uint8_t		_rs1:1;
+	uint8_t		page:3;
+	uint8_t		_rs0:1;
+	struct avrcp_subunit subunit[4];
+} __attribute__ ((packed));
+
+struct	avrcp_passthru {
+	struct avrcp_header	hdr;
+	uint8_t		key:7;
+	uint8_t		key_state:1;
+	uint8_t		op_len;	/* =length(company_id+op_data) */
+	uint8_t		company_id[3];
+	uint8_t		op_data[];
+} __attribute__ ((packed));
+
+struct	avrcp_vendor_dep {
+	struct avrcp_header	hdr;
+	uint8_t		company_id[3];
+	uint8_t		pdu_id;
+	uint8_t		packet_type:2;
+	uint8_t		_reserved:6;
+	uint16_t	length;
+	uint8_t		pdu_data[];
+} __attribute__ ((packed));
+
+#elif __BYTE_ORDER == __BIG_ENDIAN
+
+struct	avrcp_unitinfo {
+	struct avrcp_header	hdr;
+	uint8_t		ext_code;
+	uint8_t		unit_type:5;
+	uint8_t		unit:3;
+	uint8_t		company_id[3];
+} __attribute__ ((packed));
+
+struct	avrcp_subunit {
+	uint8_t		subunit_type:5;
+	uint8_t		subunit_id_max:3;
+} __attribute__ ((packed));
+
+struct	avrcp_subunitinfo {
+	struct avrcp_header	hdr;
+	uint8_t		_rs0:1;
+	uint8_t		page:3;
+	uint8_t		_rs1:1;
+	uint8_t		extension:3;
+	struct avrcp_subunit subunit[4];
+} __attribute__ ((packed));
+
+struct	avrcp_passthru {
+	struct avrcp_header	hdr;
+	uint8_t		key_state:1;
+	uint8_t		key:7;
+	uint8_t		op_len;	/* =length(company_id+op_data) */
+	uint8_t		company_id[3];
+	uint8_t		op_data[];
+} __attribute__ ((packed));
+
+struct	avrcp_vendor_dep {
+	struct avrcp_header	hdr;
+	uint8_t		company_id[3];
+	uint8_t		pdu_id;
+	uint8_t		_reserved:6;
+	uint8_t		packet_type:2;
+	uint16_t	length;
+	uint8_t		pdu_data[];
+} __attribute__ ((packed));
+
+#else
+#error "Unknown byte order"
+#endif
+
 struct avctp_state_callback {
 	avctp_state_cb cb;
 	void *user_data;
-- 
1.7.4.4

