Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Add support to hcidump for parsing Enhanced L2CAP
 configuration options
From: Nathan Holstein <ngh@isomerica.net>
Reply-To: ngh@isomerica.net
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain
Date: Tue, 28 Apr 2009 10:59:09 -0400
Message-Id: <1240930749.3441.5873.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows hcidump to parse the FCS and other options that are used to
negotiate an Enhanced Retransmission or Streaming mode L2CAP connection.
    
I've add an #indef L2CAP_CONF_FCS to the top of the code which mirrors
a change under the kernel headers to allow building on systems without
the modified kernel headers.
---
 l2cap.c |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/parser/l2cap.c b/parser/l2cap.c
index a906f42..64839f5 100644
--- a/parser/l2cap.c
+++ b/parser/l2cap.c
@@ -65,6 +65,10 @@ static cid_info cid_table[2][CID_TABLE_SIZE];
 #define SCID cid_table[0]
 #define DCID cid_table[1]
 
+#ifndef L2CAP_CONF_FCS
+#define L2CAP_CONF_FCS 0x05
+#endif
+
 static struct frame *add_handle(uint16_t handle)
 {
 	register handle_info *t = handle_table;
@@ -306,6 +310,10 @@ static char *mode2str(uint8_t mode)
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
@@ -428,7 +436,7 @@ static void conf_rfc(void *ptr, int len, int in,
uint16_t cid)
 	set_mode(in, cid, mode);
 
 	printf("RFC 0x%02x (%s", mode, mode2str(mode));
-	if (mode == 0x01 || mode == 0x02) {
+	if (mode >= 0x01 && mode <= 0x08) {
 		uint8_t txwin, maxtrans;
 		uint16_t rto, mto, mps;
 		txwin = *((uint8_t *) (ptr + 1));
@@ -478,6 +486,12 @@ static void conf_opt(int level, void *ptr, int len,
int in, uint16_t cid)
 			conf_rfc(h->val, h->len, in, cid);
 			break;
 
+		case L2CAP_CONF_FCS:
+			printf("FCS Option");
+			if (h->len > 0);
+				printf(" 0x%x", get_val(h->val, h->len));
+			break;
+
 		default:
 			printf("Unknown (type %2.2x, len %d)", h->type & 0x7f, h->len);
 			break;
@@ -510,6 +524,9 @@ static void conf_list(int level, uint8_t *list, int
len)
 		case L2CAP_CONF_RFC:
 			printf("RFC ");
 			break;
+		case L2CAP_CONF_FCS:
+			printf("FCS Option");
+			break;
 		default:
 			printf("%2.2x ", list[i] & 0x7f);
 			break;



