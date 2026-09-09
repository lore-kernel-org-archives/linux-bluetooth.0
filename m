Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D053B8BCB
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 18:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788978543; cv=none; b=rS3dE0WyJMKVGCGVHKgKbBQsK5Pu4SqZq4iX354G2fKTjOTpKwIg/yfN/3T8XclJQ98adZP7+pH4RKd7AC++AwTr+WkCdPIRwniwFb3J9kc27mT7VRy/Kt7KX0nK9nXkxqn8FUkg7Xgi+w6BKhwzCAt8CiRa9ppMTncMj5L6yXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788978543; c=relaxed/simple;
	bh=84d5TotyGpV6gCs4Bjfs0CmXwX5D8WUqtkC+C3rtl0c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFv+um7KZfOOXvvV7oaI20Lt4IXPmJBOuSKhQnfHqiSG4DfDeaHClD/bntfUOA5yDjHUp8scClY1GpCUSbdKDM8nBUAZ5+KkkMFYKjIzBLKI6uRYYVy/d1DR/5tUsu3rbv7/XPaqAXwI6BDhcENvYLlx9jbA23G5bhUsn5+4Lv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hK5XV1jO; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hK5XV1jO"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5c82e2d12b0so41448e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2026 11:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788978537; x=1789583337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=K9wsP0JCfQ/Vujt5J9os/J2qq5MLDJ6afBKoa2bn30I=;
        b=hK5XV1jOQev7Zvp0sbt3XLex6/WA/E2oUYX42j0//PoHReo9V4SDys0euWJtZa3SvV
         4Jr7iYUwFUSaE7GGM/o4pR06OAvi29kNqiDSFsta4oYhCm3eGulpVnmCjUumcrDJo/f0
         8ioOjrtQuqDhRuWJWdJ30gYxMZ4cgflpmJNgkcl9qngZzmjjH3wYEUmFvnOFRlEHH8eH
         hfYvlXsWp5/IorHkK8+yw09HlooU9XhrYcRBXx923GXj207jVGDF0heX4DL++0CqzK3k
         iKHG6YYVZSxreVahJC3GvNMDzrYalW3vKK8H4+mjMxyj+9nvyQRb+Uobw/4jULQugpN+
         Hw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788978537; x=1789583337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=K9wsP0JCfQ/Vujt5J9os/J2qq5MLDJ6afBKoa2bn30I=;
        b=SbrD9J/U+vUTVS8q2ObVLqSit2k64ydvXvFvhGBhNnve5obYJAS0sQqqZOFXtwGwuf
         EQ75GoWTKFf2n+NIrK349hiWAqyMr6o3aVowwaaBikNZSPcaqEABRPjokOCHInp3Orff
         Ajuxjm2OJBd6H1ukc+eWOQhhMeAeEdl0d36ub/j88p6zbpOzxTX7V6SpJ0g4OoH4DDXM
         SIbgdY2KQMfk/DB6Iv8J5l3oL/uYo9qI3Z0AaZ2PHtjMt3s3A8CY1K4rbUMz6AVvMoA3
         GsQ7XIS2soZ4vvOiDZVKvxqQ7PRI7fji/P2xmhki+7EzmSJ/71Lz1v3boTXH9uU5BZ+2
         i2Nw==
X-Gm-Message-State: AFuF++lBLpobmABQ7tszV7N6upI6Ez2RG+FR/2ksp1hWFp/Q8ieWuGZe
	L4Qt1gOgCjI8TZ5ZpjOo4Pc3SDikHgxXVw7FrVvaym1v23HxJMMQe7HuRovxI60C
X-Gm-Gg: AYBFou2RX7y8PwMcieSfzgVfdPrIoggpbOgSe4ZyOnVpklTlOlZlP5uMTaAKbUMJuNj
	g1yu1cVbTsoIc3cnI9aTxabVtGR3SBSNRKfsBgR6qcnYaP1EDmoiuTH0ImOBO458YoXH2KQ+4QH
	f0JvKVM8pHh9WNsUXKWK/CdJYaPPrlEfszr2mqkSQCQiWS3iBNHcreElup8i8dlyPAy9a3QiRpR
	LeW2EnniD5EX2Wj8iwlZUyohH5cYlXYaw388020XVCA2b99zEX9oIvn2bsTiGwNroE0JTuNPtvP
	VpWurCFnV/7zZwE3HYrcncK+D4AmbL2BSk/ZpCvh0sYywLq32vSxt+ln+iR5XNddBDActpiL4CW
	PCbe+ox024uir82L/VAha1lGHsQRl4WI7I6B5G1BCARowd8vzkSpqnf9uKJQwwAkJ+ke0hRT/5q
	uJuAuO1IZmcRFJ9de2WMGKFw6xUrVQsDrVQDRdzbqC7sYeR2ZLvnowttZam+GZqUUc/fmSQA07Y
	Gt241h0t6kh3vjzdERD3szZGLRDZuycDXUQc/CX14kpwL7dQ/3l000upAQAcE9NJg==
X-Received: by 2002:a05:6122:32d6:b0:5c7:a3a3:a4bd with SMTP id 71dfb90a1353d-5c7ed3a528fmr19453992e0c.4.1788978536655;
        Wed, 09 Sep 2026 11:28:56 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c81c506f31sm5399388e0c.11.2026.09.09.11.28.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 11:28:56 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 07/10] monitor: Add request tracking for the protocols above HCI
Date: Wed,  9 Sep 2026 14:28:37 -0400
Message-ID: <20260909182840.1289776-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909182840.1289776-1-luiz.dentz@gmail.com>
References: <20260909182840.1289776-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The protocols carried over ACL pair their requests and responses through
an identifier of their own, but a response gives no hint of where its
request was, and the time between the two is only visible by comparing
timestamps by hand.

Track outstanding requests per connection so that a response can name the
frame that carried the request, and use it for L2CAP signalling, where
responses are the request code plus one and a Command Reject may answer
any request:

  L2CAP: Connection Request (0x02) ident 1 len 4
  L2CAP: Connection Response (0x03) ident 1 len 8 #2 (1.000 msec)

None of these layers had access to a timestamp or a frame number, since
neither is passed down from the HCI decoding. Rather than thread both
through every protocol handler, record the packet being decoded and pick
it up in l2cap_frame_init(), which every frame passes through.

Requests are keyed on the channel rather than on the CID, because a CID
names the receiving end and therefore differs between the two directions
of the same channel. Fixed channels keep using the CID, which is already
the same either way.

The model wrote the tracking, which the author reviewed and verified
against traces covering matched and unmatched responses on both fixed and
dynamically allocated channels.

Assisted-by: opencode:claude-opus-5
---
 monitor/l2cap.c  |  76 ++++++++++++++++++++++++++---
 monitor/l2cap.h  |   8 +++
 monitor/packet.c | 124 +++++++++++++++++++++++++++++++++++++++++++++++
 monitor/packet.h |  14 ++++++
 4 files changed, 214 insertions(+), 8 deletions(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index e9a1df824e57..a132bcf397f4 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -283,6 +283,30 @@ static int get_chan_data_index(const struct l2cap_frame *frame)
 	return -1;
 }
 
+/*
+ * Channel identifier for request and response matching. L2CAP CIDs are
+ * direction specific, so a dynamic channel is identified by its entry,
+ * which is the same for both directions. Fixed channels have no entry and
+ * use the CID, which is already direction independent.
+ */
+uint16_t l2cap_chan_key(uint16_t index, bool in, uint16_t handle, uint16_t cid)
+{
+	struct l2cap_frame frame;
+	int i;
+
+	memset(&frame, 0, sizeof(frame));
+	frame.index = index;
+	frame.in = in;
+	frame.handle = handle;
+	frame.cid = cid;
+
+	i = get_chan_data_index(&frame);
+	if (i >= 0)
+		return 0x8000 | i;
+
+	return cid;
+}
+
 static struct chan_data *get_chan(const struct l2cap_frame *frame)
 {
 	int i;
@@ -1578,6 +1602,32 @@ static const struct sig_opcode_data le_sig_opcode_table[] = {
 	{ },
 };
 
+/*
+ * L2CAP signalling responses use the request code plus one, and a Command
+ * Reject may answer any request. Requests are tracked per identifier, which
+ * is what pairs the two halves of a signalling transaction.
+ */
+static void sig_req_str(const struct l2cap_frame *frame, uint8_t code,
+						char *str, size_t len)
+{
+	uint16_t key;
+
+	str[0] = '\0';
+
+	key = l2cap_chan_key(frame->index, frame->in, frame->handle,
+								frame->cid);
+
+	if (code == BT_L2CAP_PDU_CMD_REJECT || (code & 0x01)) {
+		packet_req_str(frame->handle, key, PACKET_PROTO_L2CAP,
+				frame->ident, (struct timeval *)&frame->tv,
+				str, len);
+		return;
+	}
+
+	packet_req_add(frame->handle, key, PACKET_PROTO_L2CAP, frame->ident,
+			(struct timeval *)&frame->tv, frame->num);
+}
+
 static void l2cap_queue_frame(struct l2cap_frame *frame)
 {
 	struct packet_conn_data *conn;
@@ -1612,6 +1662,8 @@ void l2cap_frame_init(struct l2cap_frame *frame, uint16_t index, bool in,
 	frame->mode    = get_mode(frame);
 	frame->seq_num = psm ? 1 : get_seq_num(frame);
 
+	packet_get_context(&frame->tv, &frame->num);
+
 	if (!in)
 		l2cap_queue_frame(frame);
 }
@@ -1620,6 +1672,7 @@ static void bredr_sig_packet(uint16_t index, bool in, uint16_t handle,
 				uint16_t cid, const void *data, uint16_t size)
 {
 	struct l2cap_frame frame;
+	char req_str[32];
 
 	while (size > 0) {
 		const struct bt_l2cap_hdr_sig *hdr = data;
@@ -1666,10 +1719,15 @@ static void bredr_sig_packet(uint16_t index, bool in, uint16_t handle,
 			opcode_str = "Unknown";
 		}
 
+		l2cap_frame_init(&frame, index, in, handle, hdr->ident, cid,
+								0, data, len);
+		sig_req_str(&frame, hdr->code, req_str, sizeof(req_str));
+
 		print_indent(6, opcode_color, "L2CAP: ", opcode_str,
 					COLOR_OFF,
-					" (0x%2.2x) ident %d len %d",
-					hdr->code, hdr->ident, len);
+					" (0x%2.2x) ident %d len %d%s%s",
+					hdr->code, hdr->ident, len,
+					req_str[0] ? " " : "", req_str);
 
 		if (!opcode_data || !opcode_data->func) {
 			packet_hexdump(data, len);
@@ -1696,8 +1754,6 @@ static void bredr_sig_packet(uint16_t index, bool in, uint16_t handle,
 			}
 		}
 
-		l2cap_frame_init(&frame, index, in, handle, hdr->ident, cid, 0,
-								data, len);
 		opcode_data->func(&frame);
 
 		data += len;
@@ -1711,6 +1767,7 @@ static void le_sig_packet(uint16_t index, bool in, uint16_t handle,
 				uint16_t cid, const void *data, uint16_t size)
 {
 	struct l2cap_frame frame;
+	char req_str[32];
 	const struct bt_l2cap_hdr_sig *hdr = data;
 	const struct sig_opcode_data *opcode_data = NULL;
 	const char *opcode_color, *opcode_str;
@@ -1755,9 +1812,14 @@ static void le_sig_packet(uint16_t index, bool in, uint16_t handle,
 		opcode_str = "Unknown";
 	}
 
+	l2cap_frame_init(&frame, index, in, handle, hdr->ident, cid, 0,
+							data, len);
+	sig_req_str(&frame, hdr->code, req_str, sizeof(req_str));
+
 	print_indent(6, opcode_color, "LE L2CAP: ", opcode_str, COLOR_OFF,
-					" (0x%2.2x) ident %d len %d",
-					hdr->code, hdr->ident, len);
+					" (0x%2.2x) ident %d len %d%s%s",
+					hdr->code, hdr->ident, len,
+					req_str[0] ? " " : "", req_str);
 
 	if (!opcode_data || !opcode_data->func) {
 		packet_hexdump(data, len);
@@ -1778,8 +1840,6 @@ static void le_sig_packet(uint16_t index, bool in, uint16_t handle,
 		}
 	}
 
-	l2cap_frame_init(&frame, index, in, handle, hdr->ident, cid, 0,
-							data, len);
 	opcode_data->func(&frame);
 }
 
diff --git a/monitor/l2cap.h b/monitor/l2cap.h
index b545bf686c05..1c1f7e609cb4 100644
--- a/monitor/l2cap.h
+++ b/monitor/l2cap.h
@@ -11,6 +11,7 @@
 
 #include <stdint.h>
 #include <stdbool.h>
+#include <sys/time.h>
 
 struct l2cap_frame {
 	uint16_t index;
@@ -24,6 +25,8 @@ struct l2cap_frame {
 	uint8_t seq_num;
 	const void *data;
 	uint16_t size;
+	struct timeval tv;	/* Timestamp of the carrying frame */
+	size_t num;		/* Number of the carrying frame */
 };
 
 void l2cap_frame_init(struct l2cap_frame *frame, uint16_t index, bool in,
@@ -46,6 +49,8 @@ static inline void l2cap_frame_clone_size(struct l2cap_frame *frame,
 		frame->mode    = source->mode;
 		frame->data    = source->data;
 		frame->size    = size;
+		frame->tv      = source->tv;
+		frame->num     = source->num;
 	}
 }
 
@@ -351,6 +356,9 @@ static inline bool l2cap_frame_get_be128(struct l2cap_frame *frame,
 void l2cap_frame(uint16_t index, bool in, uint16_t handle, uint16_t cid,
 		uint16_t psm, const void *data, uint16_t size);
 
+uint16_t l2cap_chan_key(uint16_t index, bool in, uint16_t handle,
+							uint16_t cid);
+
 void l2cap_packet(uint16_t index, bool in, uint16_t handle, uint8_t flags,
 					const void *data, uint16_t size);
 
diff --git a/monitor/packet.c b/monitor/packet.c
index 053c1165bf99..e8990f12b385 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -554,6 +554,7 @@ static struct packet_conn_data *release_handle(uint16_t handle)
 
 			queue_destroy(conn->tx_q, free);
 			queue_destroy(conn->chan_q, free);
+			queue_destroy(conn->req_q, free);
 			memset(conn, 0, sizeof(*conn));
 			conn->handle = 0xffff;
 			return conn;
@@ -11913,6 +11914,125 @@ void packet_loss_add(struct packet_loss *loss, uint16_t sn, uint8_t sflags)
 	loss->have_sn = true;
 }
 
+/*
+ * Timestamp and frame number of the packet being decoded. btmon decodes one
+ * packet at a time, so this lets the upper layers reference the frame that
+ * carried a request without threading it through every protocol handler.
+ */
+static struct timeval cur_tv;
+static bool cur_tv_valid;
+static size_t cur_num;
+
+static void packet_set_context(struct timeval *tv, size_t num)
+{
+	cur_tv_valid = tv;
+	if (tv)
+		cur_tv = *tv;
+	cur_num = num;
+}
+
+void packet_get_context(struct timeval *tv, size_t *num)
+{
+	if (tv) {
+		if (cur_tv_valid)
+			*tv = cur_tv;
+		else
+			timerclear(tv);
+	}
+
+	if (num)
+		*num = cur_num;
+}
+
+/*
+ * Requests from the protocols above HCI, so that a response can point back
+ * at the frame that carried the request.
+ */
+struct packet_req {
+	uint16_t cid;
+	uint8_t proto;
+	uint16_t id;
+	size_t num;
+	struct timeval tv;
+};
+
+/* Bound the queue so requests that never get a response cannot pile up */
+#define PACKET_REQ_MAX 64
+
+static bool match_packet_req(const void *data, const void *user_data)
+{
+	const struct packet_req *req = data;
+	const struct packet_req *match = user_data;
+
+	return req->cid == match->cid && req->proto == match->proto &&
+						req->id == match->id;
+}
+
+void packet_req_add(uint16_t handle, uint16_t cid, uint8_t proto, uint16_t id,
+					struct timeval *tv, size_t num)
+{
+	struct packet_conn_data *conn;
+	struct packet_req *req;
+
+	conn = packet_get_conn_data(handle);
+	if (!conn)
+		return;
+
+	if (!conn->req_q)
+		conn->req_q = queue_new();
+
+	if (queue_length(conn->req_q) >= PACKET_REQ_MAX)
+		free(queue_pop_head(conn->req_q));
+
+	req = new0(struct packet_req, 1);
+	req->cid = cid;
+	req->proto = proto;
+	req->id = id;
+	req->num = num;
+	if (tv)
+		req->tv = *tv;
+
+	queue_push_tail(conn->req_q, req);
+}
+
+/*
+ * Format the request reference for a response. Leaves the string empty when
+ * the request was not seen, which is the normal case for a capture started
+ * while a transaction was already in progress.
+ */
+void packet_req_str(uint16_t handle, uint16_t cid, uint8_t proto, uint16_t id,
+			struct timeval *tv, char *str, size_t len)
+{
+	struct packet_conn_data *conn;
+	struct packet_req *req, match;
+	struct timeval delta;
+
+	str[0] = '\0';
+
+	conn = packet_get_conn_data(handle);
+	if (!conn)
+		return;
+
+	match.cid = cid;
+	match.proto = proto;
+	match.id = id;
+
+	req = queue_remove_if(conn->req_q, match_packet_req, &match);
+	if (!req)
+		return;
+
+	if (tv && timerisset(tv) && timerisset(&req->tv)) {
+		timersub(tv, &req->tv, &delta);
+		snprintf(str, len, "#%zu (%lld.%03lld msec)", req->num,
+				(long long)delta.tv_sec * 1000 +
+						delta.tv_usec / 1000,
+				(long long)delta.tv_usec % 1000);
+	} else
+		snprintf(str, len, "#%zu", req->num);
+
+	free(req);
+}
+
 static void packet_dequeue_tx(struct timeval *tv, uint16_t handle)
 {
 	struct packet_conn_data *conn;
@@ -14866,7 +14986,11 @@ void packet_hci_acldata(struct timeval *tv, struct ucred *cred, uint16_t index,
 	if (filter_mask & PACKET_FILTER_SHOW_ACL_DATA)
 		packet_hexdump(data, size);
 
+	packet_set_context(tv, index_list[index].frame);
+
 	l2cap_packet(index, in, acl_handle(handle), flags, data, size);
+
+	packet_set_context(NULL, 0);
 }
 
 void packet_hci_scodata(struct timeval *tv, struct ucred *cred, uint16_t index,
diff --git a/monitor/packet.h b/monitor/packet.h
index 9d1efdf45258..dc6e6c6a7a57 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -45,6 +45,13 @@ struct packet_loss {
 	size_t total;		/* Samples seen, including the lost ones */
 };
 
+/* Protocols tracked for request and response matching */
+#define PACKET_PROTO_L2CAP	0x00
+#define PACKET_PROTO_ATT	0x01
+#define PACKET_PROTO_SDP	0x02
+#define PACKET_PROTO_AVDTP	0x03
+#define PACKET_PROTO_AVCTP	0x04
+
 struct packet_frame {
 	struct timeval tv;
 	size_t num;
@@ -76,6 +83,7 @@ struct packet_conn_data {
 	struct queue *chan_q;
 	struct packet_latency tx_l;
 	struct packet_loss rx_loss;
+	struct queue *req_q;
 	void     *data;
 	void     (*destroy)(struct packet_conn_data *conn, void *data);
 };
@@ -85,6 +93,12 @@ void packet_latency_add(struct packet_latency *latency, struct timeval *delta);
 long long packet_latency_stddev(const struct packet_latency *latency);
 void packet_loss_add(struct packet_loss *loss, uint16_t sn, uint8_t sflags);
 
+void packet_get_context(struct timeval *tv, size_t *num);
+void packet_req_add(uint16_t handle, uint16_t cid, uint8_t proto, uint16_t id,
+					struct timeval *tv, size_t num);
+void packet_req_str(uint16_t handle, uint16_t cid, uint8_t proto, uint16_t id,
+			struct timeval *tv, char *str, size_t len);
+
 bool packet_has_filter(unsigned long filter);
 void packet_set_filter(unsigned long filter);
 void packet_add_filter(unsigned long filter);
-- 
2.55.0

