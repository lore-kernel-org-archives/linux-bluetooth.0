Return-Path: <cyrus@holtmann.org>
From: "Ilia, Kolominsky" <iliak@ti.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Sun, 22 May 2011 16:28:29 +0200
Subject: [PATCH] AVRCP TG now return REJECTED response
Message-ID: <AC090B9732AB2B4DB7FF476E907FE6600130F70785@dnce02.ent.ti.com>
Content-Type: text/plain; charset="windows-1255"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From 1db53842d930c84d381401e44a9c340adfc5a411 Mon Sep 17 00:00:00 2001
From: Ilia Kolomisnky <iliak@ti.com>
Date: Sun, 22 May 2011 11:49:30 +0300
Subject: [PATCH] AVRCP TG now return REJECTED response
 AVRCP TG now return REJECTED response with error code==Invalid command for command with VENDOR-DEPENDED oper. code ( fix for PTS certification )

---
 audio/control.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 6238007..4adef2f 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -80,6 +80,7 @@
 #define CTYPE_STABLE           0xC
 
 /* opcodes */
+#define OP_VENDORDEP   0x0
 #define OP_UNITINFO            0x30
 #define OP_SUBUNITINFO         0x31
 #define OP_PASSTHROUGH         0x7c
@@ -127,6 +128,16 @@ struct avrcp_header {
 } __attribute__ ((packed));
 #define AVRCP_HEADER_LENGTH 3
 
+struct avrcp_spec_avc_pdu {
+       uint8_t company_id[3];
+       uint8_t pdu_id;
+       uint8_t packet_type:2;
+       uint8_t rsvd:6;
+       uint16_t params_len;
+       uint8_t params[0];
+} __attribute__ ((packed));
+#define AVRCP_SPECAVCPDU_HEADER_LENGTH 7
+
 #elif __BYTE_ORDER == __BIG_ENDIAN
 
 struct avctp_header {
@@ -147,6 +158,16 @@ struct avrcp_header {
 } __attribute__ ((packed));
 #define AVRCP_HEADER_LENGTH 3
 
+struct avrcp_spec_avc_pdu {
+       uint8_t company_id[3];
+       uint8_t pdu_id;
+       uint8_t rsvd:6;
+       uint8_t packet_type:2;
+       uint16_t params_len;
+       uint8_t params[0];
+} __attribute__ ((packed));
+#define AVRCP_SPECAVCPDU_HEADER_LENGTH 7
+
 #else
 #error "Unknown byte order"
 #endif
@@ -493,6 +514,8 @@ static gboolean control_cb(GIOChannel *chan, GIOCondition cond,
        unsigned char buf[1024], *operands;
        struct avctp_header *avctp;
        struct avrcp_header *avrcp;
+       struct avrcp_spec_avc_pdu *pdu_spec;
+
        int ret, packet_size, operand_count, sock;
 
        if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
@@ -569,6 +592,16 @@ static gboolean control_cb(GIOChannel *chan, GIOCondition cond,
                        operands[1] = SUBUNIT_PANEL << 3;
                DBG("reply to %s", avrcp->opcode == OP_UNITINFO ?
                                "OP_UNITINFO" : "OP_SUBUNITINFO");
+       } else if ( avrcp->opcode == OP_VENDORDEP ) {
+               /* reply with REJECT msg with err. code == 0x0 ( Invalid Command ) as defined in AVRCP spec ( 6.15.1 ) */
+               pdu_spec = ( struct avrcp_spec_avc_pdu* ) ( buf + sizeof(struct avctp_header) + sizeof(struct avrcp_header) );
+               pdu_spec->packet_type = 0;
+               pdu_spec->rsvd = 0;
+               pdu_spec->params[0] = 0; /* invalid command */
+               pdu_spec->params_len = htons(1);
+
+               avctp->cr = AVCTP_RESPONSE;
+               avrcp->code = CTYPE_REJECTED;
        } else {
                avctp->cr = AVCTP_RESPONSE;
                avrcp->code = CTYPE_REJECTED;
-- 
1.7.1

Ilia Kolominsky
iliak@ti.com
Direct:  +972(9)7906231
Mobile: +972(54)909009




