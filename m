Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add support to hcidump for parsing Enhanced L2CAP
 configuration options
From: Nathan Holstein <ngh@isomerica.net>
Reply-To: ngh@isomerica.net
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1240931871.997.15.camel@localhost.localdomain>
References: <1240930749.3441.5873.camel@localhost.localdomain>
	 <1240931871.997.15.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 28 Apr 2009 12:06:38 -0400
Message-Id: <1240934798.3441.5880.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows hcidump to parse the FCS and other options that are used to
negotiate an Enhanced Retransmission or Streaming mode L2CAP connection.

When receiving the MTU option, don't set the mode to Basic.

This patch depends upon headers from libbluetooth which define the
constant L2CAP_CONF_FCS.
---
 l2cap.c |   66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 3 deletions(-)

diff --git a/parser/l2cap.c b/parser/l2cap.c
index a906f42..6286236 100644
--- a/parser/l2cap.c
+++ b/parser/l2cap.c
@@ -56,6 +56,7 @@ typedef struct {
 	uint16_t cid;
 	uint16_t psm;
 	uint16_t num;
+	uint8_t fcs;
 	uint8_t mode;
 } cid_info;
 #define CID_TABLE_SIZE 20
@@ -108,6 +109,7 @@ static void add_cid(int in, uint16_t handle,
uint16_t cid, uint16_t psm)
 		table[pos].cid    = cid;
 		table[pos].psm    = psm;
 		table[pos].num    = num;
+		table[pos].fcs    = 0x01;
 		table[pos].mode   = 0;
 	}
 }
@@ -132,6 +134,7 @@ static void del_cid(int in, uint16_t dcid, uint16_t
scid)
 				cid_table[t][i].cid    = 0;
 				cid_table[t][i].psm    = 0;
 				cid_table[t][i].num    = 0;
+				cid_table[t][i].fcs    = 0;
 				cid_table[t][i].mode   = 0;
 				break;
 			}
@@ -149,11 +152,34 @@ static void del_handle(uint16_t handle)
 				cid_table[t][i].cid    = 0;
 				cid_table[t][i].psm    = 0;
 				cid_table[t][i].num    = 0;
+				cid_table[t][i].fcs    = 0;
 				cid_table[t][i].mode   = 0;
 				break;
 			}
 	}
 }
+
+static void set_fcs(int in, uint16_t cid, uint8_t fcs)
+{
+	register cid_info *table = cid_table[in];
+	register int i;
+
+	for (i = 0; i < CID_TABLE_SIZE; i++)
+		if (table[i].cid == cid)
+			table[i].fcs = fcs;
+}
+
+static uint8_t get_fcs(int in, uint16_t cid)
+{
+	register cid_info *table = cid_table[in];
+	register int i;
+
+	for (i = 0; i < CID_TABLE_SIZE; i++)
+		if (table[i].cid == cid)
+			return table[i].fcs;
+	return 0x01;
+}
+
 static uint16_t get_psm(int in, uint16_t cid)
 {
 	register cid_info *table = cid_table[in];
@@ -271,6 +297,19 @@ static char *confresult2str(uint16_t result)
 		return "Reserved";
 	}
 }
+
+static char *fcs2str(uint8_t fcs)
+{
+        switch (fcs) {
+        case 0x00:
+                return "No FCS";
+        case 0x01:
+                return "16-bit FCS";
+        default:
+                return "Reserved";
+        }
+}
+
 static char *inforesult2str(uint16_t result)
 {
 	switch (result) {
@@ -306,6 +345,10 @@ static char *mode2str(uint8_t mode)
 		return "Retransmission";
 	case 0x02:
 		return "Flow control";
+	case 0x03:
+		return "Enhanced Retransmission";
+	case 0x04:
+		return "Streaming";
 	default:
 		return "Reserved";
 	}
@@ -336,8 +379,9 @@ static char *supervisory2str(uint8_t supervisory)
 	case 0x01:
 		return "Reject (REJ)";
 	case 0x02:
+		return "Receiver Not Ready (RNR)";
 	case 0x03:
-		return "Reserved Supervisory";
+		return "Select Reject (SREJ)";
 	default:
 		return "Bad Supervisory";
 	}
@@ -420,6 +464,16 @@ static inline void conn_rsp(int level, struct frame
*frm)
 		printf("\n");
 }
 
+static void conf_fcs(void *ptr, int len, int in, uint16_t cid)
+{
+        uint8_t fcs;
+
+        fcs = *((uint8_t *) ptr);
+        set_fcs(in, cid, fcs);
+
+        printf("FCS Option 0x%02x (%s)", fcs, fcs2str(fcs));
+}
+
 static void conf_rfc(void *ptr, int len, int in, uint16_t cid)
 {
 	uint8_t mode;
@@ -428,7 +482,7 @@ static void conf_rfc(void *ptr, int len, int in,
uint16_t cid)
 	set_mode(in, cid, mode);
 
 	printf("RFC 0x%02x (%s", mode, mode2str(mode));
-	if (mode == 0x01 || mode == 0x02) {
+	if (mode >= 0x01 && mode <= 0x08) {
 		uint8_t txwin, maxtrans;
 		uint16_t rto, mto, mps;
 		txwin = *((uint8_t *) (ptr + 1));
@@ -456,7 +510,6 @@ static void conf_opt(int level, void *ptr, int len,
int in, uint16_t cid)
 
 		switch (h->type & 0x7f) {
 		case L2CAP_CONF_MTU:
-			set_mode(in, cid, 0x00);
 			printf("MTU");
 			if (h->len > 0)
 				printf(" %d", get_val(h->val, h->len));
@@ -478,6 +531,10 @@ static void conf_opt(int level, void *ptr, int len,
int in, uint16_t cid)
 			conf_rfc(h->val, h->len, in, cid);
 			break;
 
+                case L2CAP_CONF_FCS:
+                        conf_fcs(h->val, h->len, in, cid);
+                        break;
+
 		default:
 			printf("Unknown (type %2.2x, len %d)", h->type & 0x7f, h->len);
 			break;
@@ -510,6 +567,9 @@ static void conf_list(int level, uint8_t *list, int
len)
 		case L2CAP_CONF_RFC:
 			printf("RFC ");
 			break;
+                case L2CAP_CONF_FCS:
+                        printf("FCS Option ");
+                        break;
 		default:
 			printf("%2.2x ", list[i] & 0x7f);
 			break;

