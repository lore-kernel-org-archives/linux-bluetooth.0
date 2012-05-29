Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [RFC] network: Reply to extensions at connection setup
Date: Tue, 29 May 2012 13:19:26 +0300
Message-Id: <1338286766-5368-2-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1338286766-5368-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1338286766-5368-1-git-send-email-frederic.dalleau@linux.intel.com>
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
 network/server.c |   34 ++++++++++++++++++++++++++++++++--
 1 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/network/server.c b/network/server.c
index e39769a..d9bdb4f 100644
--- a/network/server.c
+++ b/network/server.c
@@ -355,6 +355,7 @@ static gboolean bnep_setup(GIOChannel *chan,
 	struct network_server *ns;
 	uint8_t packet[BNEP_MTU];
 	struct bnep_setup_conn_req *req = (void *) packet;
+	uint8_t *ext;
 	uint16_t src_role, dst_role, rsp = BNEP_CONN_NOT_ALLOWED;
 	int n, sk;
 
@@ -377,7 +378,7 @@ static gboolean bnep_setup(GIOChannel *chan,
 
 	/* Highest known Control command ID
 	 * is BNEP_FILTER_MULT_ADDR_RSP = 0x06 */
-	if (req->type == BNEP_CONTROL &&
+	if ((req->type & ~BNEP_EXT_HEADER) == BNEP_CONTROL &&
 				req->ctrl > BNEP_FILTER_MULT_ADDR_RSP) {
 		uint8_t pkt[3];
 
@@ -390,7 +391,8 @@ static gboolean bnep_setup(GIOChannel *chan,
 		return FALSE;
 	}
 
-	if (req->type != BNEP_CONTROL || req->ctrl != BNEP_SETUP_CONN_REQ)
+	if ((req->type & ~BNEP_EXT_HEADER) != BNEP_CONTROL ||
+				req->ctrl != BNEP_SETUP_CONN_REQ)
 		return FALSE;
 
 	rsp = bnep_setup_decode(req, &dst_role, &src_role);
@@ -427,6 +429,34 @@ static gboolean bnep_setup(GIOChannel *chan,
 reply:
 	send_bnep_ctrl_rsp(sk, rsp);
 
+	/* Reply to extensions */
+	if (req->type & BNEP_EXT_HEADER) {
+		uint8_t pkt[3];
+		int l;
+
+		l = 3 + 2 * req->uuid_size;
+		ext = packet + l;
+		n -= l;
+
+ext:
+		if (n <= 3)
+			return FALSE;
+
+		pkt[0] = BNEP_CONTROL;
+		pkt[1] = BNEP_CMD_NOT_UNDERSTOOD;
+		pkt[2] = ext[2];
+
+		send(sk, pkt, sizeof(pkt), 0);
+
+		if ((ext[0] & BNEP_EXT_HEADER) == 0)
+			return FALSE;
+
+		l = 2 + ext[1];
+		ext += l;
+		n -= l;
+		goto ext;
+	}
+
 	return FALSE;
 }
 
-- 
1.7.5.4

