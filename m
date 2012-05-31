Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v2] network: Reply to extensions at connection setup
Date: Thu, 31 May 2012 16:21:10 +0300
Message-Id: <1338470470-6874-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

TP/BNEP/CTRL/BV-19-C is about extension in the BNEP_SETUP_CONN_REQ
control message. BNEP_SETUP_CONN_REQ is handled by bluetoothd before
giving control to kernel.  Current bluez do not reply at all if an
extension is added to BNEP_SETUP_CONN_REQ. This patch fixes it by
sending COMMAND_NOT_UNDERSTOOD reply.

The test sends the following message :
> ACL data: handle 11 flags 0x02 dlen 37
  L2CAP(d): cid 0x0040 len 33 [psm 15]
    BNEP: Control(0x01|1)
      Setup Req(0x01) size 0x02 dst 0x1116(NAP) src 0x1115(PANU)
      Ext Control(0x00|1) len 0x07
        Filter NetType Set(0x03) len 0x0004
          0x8600 - 0x86dd
      Ext Control(0x00|0) len 0x0f
        Filter MultAddr Set(0x05) len 0x000c
          03:00:00:20:00:00 - 03:00:00:20:00:00

A reply must be provided to each of the extensions, the patch triggers
the following answer:
< ACL data: handle 12 flags 0x00 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 15]
      BNEP: Control(0x01|0)
        Setup Rsp(0x02) res 0x0000
< ACL data: handle 12 flags 0x00 dlen 7
    L2CAP(d): cid 0x0040 len 3 [psm 15]
      BNEP: Control(0x01|0)
        Not Understood(0x00) type 0x03
< ACL data: handle 12 flags 0x00 dlen 7
    L2CAP(d): cid 0x0040 len 3 [psm 15]
      BNEP: Control(0x01|0)
        Not Understood(0x00) type 0x05

The following command can be used for testing:
printf "\x81\x01\x02\x11\x16\x11\x15\x80\x07\x03\x00\x04\x86\x00"\
"\x86\xdd\x00\x0f\x05\x00\x0c\x03\x00\x00\x20\x00\x00\x03\x00\x00"\
"\x20\x00\x00" > BNEP_CTRL_19.bin
./l2test -n -P 15 bb:dd:aa:dd:dd:rr -B BNEP_CTRL_19.bin -y
---
 network/server.c |   36 ++++++++++++++++++++++++++++++++++--
 1 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/network/server.c b/network/server.c
index e39769a..59f389c 100644
--- a/network/server.c
+++ b/network/server.c
@@ -52,6 +52,8 @@
 
 #define NETWORK_SERVER_INTERFACE "org.bluez.NetworkServer"
 #define SETUP_TIMEOUT		1
+#define BNEP_HEADER(type) ((type) & ~BNEP_EXT_HEADER)
+#define BNEP_EXTENSION(type) ((type) & BNEP_EXT_HEADER)
 
 /* Pending Authorization */
 struct network_session {
@@ -348,6 +350,32 @@ static void setup_destroy(void *user_data)
 	session_free(setup);
 }
 
+static void parse_extensions(uint8_t *packet, unsigned int size, int sk)
+{
+	struct bnep_setup_conn_req *req = (void *) packet;
+	struct bnep_ext_hdr *ehdr;
+	unsigned int l;
+
+	l = sizeof(*req) + 2 * req->uuid_size;
+
+	while (l < size - sizeof(*ehdr)) {
+		uint8_t pkt[3];
+
+		ehdr = (struct bnep_ext_hdr *) (packet + l);
+
+		pkt[0] = BNEP_CONTROL;
+		pkt[1] = BNEP_CMD_NOT_UNDERSTOOD;
+		pkt[2] = ehdr->len;
+
+		send(sk, pkt, sizeof(pkt), 0);
+
+		if (!BNEP_EXTENSION(ehdr->type))
+			return;
+
+		l += sizeof(*ehdr) + ehdr->len;
+	}
+}
+
 static gboolean bnep_setup(GIOChannel *chan,
 			GIOCondition cond, gpointer user_data)
 {
@@ -377,7 +405,7 @@ static gboolean bnep_setup(GIOChannel *chan,
 
 	/* Highest known Control command ID
 	 * is BNEP_FILTER_MULT_ADDR_RSP = 0x06 */
-	if (req->type == BNEP_CONTROL &&
+	if (BNEP_HEADER(req->type) == BNEP_CONTROL &&
 				req->ctrl > BNEP_FILTER_MULT_ADDR_RSP) {
 		uint8_t pkt[3];
 
@@ -390,7 +418,8 @@ static gboolean bnep_setup(GIOChannel *chan,
 		return FALSE;
 	}
 
-	if (req->type != BNEP_CONTROL || req->ctrl != BNEP_SETUP_CONN_REQ)
+	if (BNEP_HEADER(req->type) != BNEP_CONTROL ||
+				req->ctrl != BNEP_SETUP_CONN_REQ)
 		return FALSE;
 
 	rsp = bnep_setup_decode(req, &dst_role, &src_role);
@@ -427,6 +456,9 @@ static gboolean bnep_setup(GIOChannel *chan,
 reply:
 	send_bnep_ctrl_rsp(sk, rsp);
 
+	if (BNEP_EXTENSION(req->type))
+		parse_extensions(packet, n, sk);
+
 	return FALSE;
 }
 
-- 
1.7.5.4

