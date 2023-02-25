Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5228C64EC7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Feb 2023 21:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjBYVm5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 25 Feb 2023 16:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBYVm5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 25 Feb 2023 16:42:57 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F03FA5E8
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Feb 2023 13:42:55 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 35FBD240174
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Feb 2023 22:42:53 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PPKxS58TDz9rxB;
        Sat, 25 Feb 2023 22:42:52 +0100 (CET)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/2] bthost: Allow sending ISO packets with sequence number and timestamp
Date:   Sat, 25 Feb 2023 21:42:50 +0000
Message-Id: <b071b484b1b199ad69412ca0b2610c9c75fe7181.1677361002.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Change bthost_send_iso to take packet sequence number and timestamp, and
allow it to send timestamped HCI ISO data packets.

Currently, btdev passes through ISO packets, so this can also be used to
test RX timestamping.
---

Notes:
    This series adds a test case for
    
    https://lore.kernel.org/linux-bluetooth/1fd2d4523c139deda93aab2c31f1508d79c32472.1676921889.git.pav@iki.fi/
    
    Here, it seems simplest if btdev simply passes through the timestamps
    and sequence numbers it receives, instead of modifying them.  One side
    of the "connection" generally is bthost, and it is easier for writing
    tests if nothing modifies the values in between.
    
    Also if dummy ISOAL like timestamping is added to the emulator later, we
    can still consider timestamped input packet as the trigger for enabling
    RX timestamping, or add something like
    hciemu_set_central_iso_timestamping(bool).

 emulator/bthost.c  | 45 ++++++++++++++++++++++++++++++++-------------
 emulator/bthost.h  |  3 ++-
 tools/iso-tester.c |  3 ++-
 3 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 3cce4666c..4671fe17d 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -38,6 +38,8 @@
 #define acl_flags(h)		(h >> 12)
 
 #define iso_flags_pb(f)		(f & 0x0003)
+#define iso_flags_ts(f)		((f >> 2) & 0x0001)
+#define iso_flags_pack(pb, ts)	(((pb) & 0x03) | (((ts) & 0x01) << 2))
 #define iso_data_len_pack(h, f)	((uint16_t) ((h) | ((f) << 14)))
 
 #define L2CAP_FEAT_FIXED_CHAN	0x00000080
@@ -728,41 +730,58 @@ void bthost_send_cid_v(struct bthost *bthost, uint16_t handle, uint16_t cid,
 	send_iov(bthost, handle, cid, iov, iovcnt);
 }
 
-static void send_iso(struct bthost *bthost, uint16_t handle,
+static void send_iso(struct bthost *bthost, uint16_t handle, bool ts,
+					uint16_t sn, uint32_t timestamp,
 					const struct iovec *iov, int iovcnt)
 {
 	struct bt_hci_iso_hdr iso_hdr;
 	struct bt_hci_iso_data_start data_hdr;
 	uint8_t pkt = BT_H4_ISO_PKT;
-	struct iovec pdu[3 + iovcnt];
+	struct iovec pdu[4 + iovcnt];
+	uint16_t flags, dlen;
 	int i, len = 0;
-	static uint16_t sn;
 
 	for (i = 0; i < iovcnt; i++) {
-		pdu[3 + i].iov_base = iov[i].iov_base;
-		pdu[3 + i].iov_len = iov[i].iov_len;
+		pdu[4 + i].iov_base = iov[i].iov_base;
+		pdu[4 + i].iov_len = iov[i].iov_len;
 		len += iov[i].iov_len;
 	}
 
 	pdu[0].iov_base = &pkt;
 	pdu[0].iov_len = sizeof(pkt);
 
-	iso_hdr.handle = acl_handle_pack(handle, 0x02);
-	iso_hdr.dlen = cpu_to_le16(len + sizeof(data_hdr));
+	flags = iso_flags_pack(0x02, ts);
+	dlen = len + sizeof(data_hdr);
+	if (ts)
+		dlen += sizeof(timestamp);
+
+	iso_hdr.handle = acl_handle_pack(handle, flags);
+	iso_hdr.dlen = cpu_to_le16(dlen);
 
 	pdu[1].iov_base = &iso_hdr;
 	pdu[1].iov_len = sizeof(iso_hdr);
 
-	data_hdr.sn = cpu_to_le16(sn++);
+	if (ts) {
+		timestamp = cpu_to_le32(timestamp);
+
+		pdu[2].iov_base = &timestamp;
+		pdu[2].iov_len = sizeof(timestamp);
+	} else {
+		pdu[2].iov_base = NULL;
+		pdu[2].iov_len = 0;
+	}
+
+	data_hdr.sn = cpu_to_le16(sn);
 	data_hdr.slen = cpu_to_le16(iso_data_len_pack(len, 0));
 
-	pdu[2].iov_base = &data_hdr;
-	pdu[2].iov_len = sizeof(data_hdr);
+	pdu[3].iov_base = &data_hdr;
+	pdu[3].iov_len = sizeof(data_hdr);
 
-	send_packet(bthost, pdu, 3 + iovcnt);
+	send_packet(bthost, pdu, 4 + iovcnt);
 }
 
-void bthost_send_iso(struct bthost *bthost, uint16_t handle,
+void bthost_send_iso(struct bthost *bthost, uint16_t handle, bool ts,
+					uint16_t sn, uint32_t timestamp,
 					const struct iovec *iov, int iovcnt)
 {
 	struct btconn *conn;
@@ -771,7 +790,7 @@ void bthost_send_iso(struct bthost *bthost, uint16_t handle,
 	if (!conn)
 		return;
 
-	send_iso(bthost, handle, iov, iovcnt);
+	send_iso(bthost, handle, ts, sn, timestamp, iov, iovcnt);
 }
 
 bool bthost_l2cap_req(struct bthost *bthost, uint16_t handle, uint8_t code,
diff --git a/emulator/bthost.h b/emulator/bthost.h
index c42444476..92182687f 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -79,7 +79,8 @@ void bthost_send_cid(struct bthost *bthost, uint16_t handle, uint16_t cid,
 					const void *data, uint16_t len);
 void bthost_send_cid_v(struct bthost *bthost, uint16_t handle, uint16_t cid,
 					const struct iovec *iov, int iovcnt);
-void bthost_send_iso(struct bthost *bthost, uint16_t handle,
+void bthost_send_iso(struct bthost *bthost, uint16_t handle, bool ts,
+					uint16_t sn, uint32_t timestamp,
 					const struct iovec *iov, int iovcnt);
 
 typedef void (*bthost_l2cap_rsp_cb) (uint8_t code, const void *data,
diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index d790b1556..dcfd6a045 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -1146,6 +1146,7 @@ static void iso_recv(struct test_data *data, GIOChannel *io)
 {
 	const struct iso_client_data *isodata = data->test_data;
 	struct bthost *host;
+	static uint16_t sn;
 
 	tester_print("Receive %zu bytes of data", isodata->recv->iov_len);
 
@@ -1156,7 +1157,7 @@ static void iso_recv(struct test_data *data, GIOChannel *io)
 	}
 
 	host = hciemu_client_get_host(data->hciemu);
-	bthost_send_iso(host, data->handle, isodata->recv, 1);
+	bthost_send_iso(host, data->handle, false, sn++, 0, isodata->recv, 1);
 
 	data->io_id[0] = g_io_add_watch(io, G_IO_IN, iso_recv_data, data);
 }
-- 
2.39.2

