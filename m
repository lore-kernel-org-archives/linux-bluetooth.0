Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH v1 4/4] monitor/rfcomm: Add support for mcc frame decoding
Date: Fri, 07 Nov 2014 18:36:27 +0530
Message-id: <1415365587-6217-5-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1415365587-6217-1-git-send-email-gowtham.ab@samsung.com>
References: <1415365587-6217-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes made to decode MCC frame in RFCOMM for btmon.

      RFCOMM: Unnumbered Info with Header Check (UIH)(0xef)
         Address: 0x01 cr 0 dlci 0x00
         Control: 0xef poll/final 0
         Length: 10
         FCS: 0xaa
         MCC Message type: DLC Parameter Negotiation RSP(0x20)
           Length: 8
        20 e0 27 00 9a 02 00 07 aa                        .'......       

---
 monitor/rfcomm.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 78 insertions(+), 5 deletions(-)

diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
index 1a5c560..80e0556 100644
--- a/monitor/rfcomm.c
+++ b/monitor/rfcomm.c
@@ -44,6 +44,12 @@
 #include "sdp.h"
 #include "rfcomm.h"
 
+static char *cr_str[] = {
+	"RSP",
+	"CMD"
+};
+
+#define CR_STR(type) cr_str[GET_CR(type)]
 #define GET_LEN8(length) ((length & 0xfe) >> 1)
 #define GET_LEN16(length) ((length & 0xfffe) >> 1)
 #define GET_CR(type)	((type & 0x02) >> 1)
@@ -57,8 +63,14 @@ struct rfcomm_lhdr {
 	uint8_t credits; /* only for UIH frame */
 } __attribute__((packed));
 
+struct rfcomm_lmcc {
+	uint8_t type;
+	uint16_t length;
+} __attribute__((packed));
+
 struct rfcomm_frame {
 	struct rfcomm_lhdr hdr;
+	struct rfcomm_lmcc mcc;
 	struct l2cap_frame l2cap_frame;
 };
 
@@ -80,16 +92,78 @@ static void print_rfcomm_hdr(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 	print_field("%*cFCS: 0x%2.2x", indent, ' ', hdr.fcs);
 }
 
+struct mcc_data {
+	uint8_t type;
+	const char *str;
+};
+
+static const struct mcc_data mcc_table[] = {
+	{ 0x08, "Test Command" },
+	{ 0x28, "Flow Control On Command" },
+	{ 0x18, "Flow Control Off Command" },
+	{ 0x38, "Modem Status Command" },
+	{ 0x24, "Remote Port Negotiation Command" },
+	{ 0x14, "Remote Line Status" },
+	{ 0x20, "DLC Parameter Negotiation" },
+	{ 0x04, "Non Supported Command" },
+	{ }
+};
+
+static inline bool mcc_frame(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
+{
+	uint8_t length, ex_length, type;
+	const char *type_str;
+	int i;
+	struct l2cap_frame *frame = &rfcomm_frame->l2cap_frame;
+	struct rfcomm_lmcc mcc;
+	const struct mcc_data *mcc_data = NULL;
+
+	if (!l2cap_frame_get_u8(frame, &mcc.type) ||
+			!l2cap_frame_get_u8(frame, &length))
+		return false;
+
+	if (RFCOMM_TEST_EA(length))
+		mcc.length = (uint16_t) GET_LEN8(length);
+	else {
+		if (!l2cap_frame_get_u8(frame, &ex_length))
+			return false;
+		mcc.length = ((uint16_t) length << 8) | ex_length;
+		mcc.length = GET_LEN16(mcc.length);
+	}
+
+	type = RFCOMM_GET_MCC_TYPE(mcc.type);
+
+	for (i = 0; mcc_table[i].str; i++) {
+		if (mcc_table[i].type == type) {
+			mcc_data = &mcc_table[i];
+			break;
+		}
+	}
+
+	if (mcc_data)
+		type_str = mcc_data->str;
+	else
+		type_str = "Unknown";
+
+	print_field("%*cMCC Message type: %s %s(0x%2.2x)", indent, ' ',
+				type_str, CR_STR(mcc.type), type);
+
+	print_field("%*cLength: %d", indent+2, ' ', mcc.length);
+
+	rfcomm_frame->mcc = mcc;
+	packet_hexdump(frame->data, frame->size);
+
+	return true;
+}
+
 static bool uih_frame(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 {
 	uint8_t credits;
 	struct l2cap_frame *frame = &rfcomm_frame->l2cap_frame;
 	struct rfcomm_lhdr *hdr = &rfcomm_frame->hdr;
 
-	if (!RFCOMM_GET_CHANNEL(hdr->address)) {
-		/* MCC frame parser implementation */
-		goto done;
-	}
+	if (!RFCOMM_GET_CHANNEL(hdr->address))
+		return mcc_frame(rfcomm_frame, indent);
 
 	/* fetching credits from UIH frame */
 	if (GET_PF(hdr->control)) {
@@ -100,7 +174,6 @@ static bool uih_frame(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 		return true;
 	}
 
-done:
 	packet_hexdump(frame->data, frame->size);
 	return true;
 }
-- 
1.9.1

