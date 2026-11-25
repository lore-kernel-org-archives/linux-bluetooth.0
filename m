Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795613893;
	b=PDwDPUubh4ftPWeC7f3pnJMbrAPFl3gQHfJv6BWvTVdlDz9KKWNU1VTH4hTJSX/0WyhF
	 98pWSNUmpwOJNEX19OUFAV522eHBzVonPm+kfGfLsBDWiiueDMlncK/Y5WbqbaIcI0b4L
	 /uxE3quRbBST4U4ryOHQeeFQkbEuwnkdRL69WhM4LR08gvlWYrX3+uQBSLyG/Pnew+iad
	 6CIkOvt65nqj5vSdxeZPAFbbLE04HLMNEBeNrL7vdddVaY0BvEERPFEZ7FV3OTANVlzrQ
	 T8YAX51hlm4jRryevOPAaVKP5ks0HUGsrjVcmTxx/5xHpb/d+O4nAUK69r8wMVNe3fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795613893;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=x7ejeRsD7RvBwqtFIIlQrgJWafGAJz5D15H/54TyaEY=;
	b=btaOgNx7dE6+xUDWo4ZyJdihGcVR5uyc9RxgVveLwGPEl8Z1nxXi7qowBc4WJCeYMB1i
	 eWZMhYRLloJgm4+mcNZutgSNjnXJmlXydXDkH977iF+Ye45JZIcp5mgbTazdfRspeMBpB
	 LMRTkpwwbj2FxCL0nGXgNC9zJY9KVLoWkgT+ujUcFdGtlf3ErbelGp7/U1eByv2al/jLe
	 t+2n5itj+1yVe368rZYJbabhZKbS25qThTx+1pL+VDRrOU+1bSw1IsAtjsA6sFx8f7R+V
	 KxGyVHSf+yTn4K1570D6xa6r+17pza7EuQhQP3ZjfEOsm6cbFGWmZTfULO5DifwtGlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=XyG9Oyd3;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686A6606A329
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 13:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 686A6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=XyG9Oyd3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795613889;
	bh=rOnqzF+24CfGstuH56kRTZA4wlD3Ds70b/fgp21yUTs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XyG9Oyd3rSyFrwgIGtoU9G5vxusN+5SykqyAJUkyLST5x3iOcvUHIsU+I5gZRqR5E
	 s73vNWjoGrSYaENgV4/CBvKKB7DPX5LEBESqO87Iez6S2GzdY5qAUZJaoRfISbmg90
	 i7TdTasvJSsslp7bzJfkWI159CJH9Zypuqilrbra04R6JzowBD7qBAr8U+lGt05Emu
	 AcKeVtwWghaHkkZefqiB8aQaSu7WoPYnLa10qU6fLq5bV2fAit2bqajBh6v4OUOvXP
	 ZgBzFKSDEy61f7m/JJHJbwZjr//xrVmTwZqYwbFWWQR/UxETwPMjhw/OusYW1ItobL
	 2ljpk/llCl0+w==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B6D1517E1031
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 14:38:09 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 6/6] monitor: Reassemble OBEX PDUs split across RFCOMM UIH frames
Date: Wed, 25 Nov 2026 14:37:56 +0100
Message-ID: <20261125133756.551659-7-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125133756.551659-1-frederic.danis@collabora.com>
References: <20261125133756.551659-1-frederic.danis@collabora.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The RFCOMM MTU is typically much smaller than the maximum OBEX PDU
length, so a single OBEX PDU can be split across several UIH frames.
uih_frame() decoded each UIH frame's payload independently, so any
OBEX PDU spanning more than one frame failed to parse ('frame too
short').

Buffer UIH information bytes per index/handle/DLCI/direction
(obex_frag_list[]/obex_frag_get()) until a complete PDU (3-byte
opcode+length header plus body) is available, then decode it and
keep any leftover bytes for the next frame. Key this reassembly, and
the OBEX session/request state tracked alongside it, on the full DLCI
rather than just the server channel number, since two concurrent
connections can share a server channel while using distinct DLCIs.

Drop the buffer and session state for a DLCI when it is torn down
(rfcomm_remove_channel(), called alongside obex_remove_channel() on
DISC/DM) so a later renegotiation of the same DLCI doesn't resume
from stale fragments. A DISC/DM on DLCI 0 closes the whole RFCOMM
multiplexer, taking every data channel running over it down with it
without a DISC/DM of its own for each; clear all of their OBEX state
in that case too, via rfcomm_remove_handle() and the new
obex_remove_rfcomm_sessions(), while keeping SDP-learned channel
mappings for a future reconnect.

The RFCOMM L2CAP transport (PSM 0x0003) itself can also close while
the ACL link stays up, leaving the same per-DLCI state stale without
any RFCOMM-level DISC/DM being seen. Detect this in sig_disconn_req()
and clear it the same way.

While a PDU is still incomplete and buffered, show the UIH frame's
own payload so partial OBEX data isn't silently dropped from the
trace, mirroring the L2CAP SAR reassembly path.

sig_disconn_req() tested this with chan_list[key & 0x7fff].psm, but
l2cap_chan_key() only sets the 0x8000 bit itself when it resolves to
a chan_list[] entry; it falls back to the raw CID otherwise, which
isn't restricted to below 0x8000, so an untracked CID could read past
the end of chan_list[]. Add is_rfcomm_chan_key(), bounds-checking the
index against MAX_CHAN before dereferencing.

Assisted-by: Claude:claude-sonnet-5
---
v2->v3: New in v3.
v3->v4:
  - Add rfcomm_remove_handle(), called from the HCI disconnect
    complete handler, to free every fragment buffer still tracked for
    an ACL handle that goes away without an RFCOMM DISC/DM on each of
    its channels.
  - Widen the reassembly buffer's length/position tracking from
    uint16_t to uint32_t, and clamp the amount handed to obex_packet()
    on a malformed declared length to l2cap_frame.size's uint16_t
    range, keeping any excess buffered for the next call instead of
    reporting an incorrect remaining size.
v4->v5:
  - While a PDU is still incomplete and buffered, hexdump the UIH
    frame's own payload instead of showing nothing, mirroring the
    L2CAP SAR reassembly path, so partial OBEX data isn't silently
    dropped from the trace.
  - Key the reassembly buffer and its OBEX session/request state on
    the full DLCI (server channel plus direction bit) instead of just
    the server channel number, since two concurrent connections can
    share a server channel while using distinct DLCIs.
  - Treat a DISC/DM on DLCI 0 as closing the whole RFCOMM multiplexer,
    clearing every data channel's OBEX state via the new
    obex_remove_rfcomm_sessions() and rfcomm_remove_handle(), since no
    per-channel DISC/DM is seen for each of them, while keeping the
    SDP-learned channel mappings for a future reconnect.
  - Detect the RFCOMM L2CAP transport (PSM 0x0003) itself closing
    while the ACL link stays up, in sig_disconn_req(), and clear the
    same per-DLCI state in that case too.
  - Add is_rfcomm_chan_key(), bounds-checking the chan_list[] index
    against MAX_CHAN before dereferencing it in sig_disconn_req():
    l2cap_chan_key() only sets the 0x8000 bit when it resolves to a
    chan_list[] entry, but falls back to the raw CID otherwise, which
    isn't restricted to below 0x8000, risking a read past the end of
    chan_list[].

 monitor/l2cap.c  |  38 +++++++--
 monitor/l2cap.h  |   2 +
 monitor/obex.c   |  83 ++++++++++++++----
 monitor/obex.h   |   2 +
 monitor/packet.c |   1 +
 monitor/rfcomm.c | 215 +++++++++++++++++++++++++++++++++++++++++++++--
 6 files changed, 311 insertions(+), 30 deletions(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index d8d6058d0..ecd0d5940 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -477,6 +477,19 @@ uint16_t l2cap_chan_key(uint16_t index, bool in, uint16_t handle, uint16_t cid)
 	return cid;
 }
 
+/* True if key is a l2cap_chan_key() value resolved to a chan_list[] entry
+ * (as opposed to a raw, unresolved CID) for the RFCOMM transport PSM
+ * (0x0003). The 0x8000 bit alone doesn't guarantee key was resolved, since
+ * a raw dynamic CID may also have it set; the low bits must additionally
+ * be bounds-checked against MAX_CHAN before indexing chan_list[].
+ */
+static bool is_rfcomm_chan_key(uint16_t key)
+{
+	uint16_t i = key & 0x7fff;
+
+	return (key & 0x8000) && i < MAX_CHAN && chan_list[i].psm == 0x0003;
+}
+
 static struct chan_data *get_chan(const struct l2cap_frame *frame)
 {
 	int i;
@@ -1387,6 +1400,7 @@ static void sig_config_rsp(const struct l2cap_frame *frame)
 static void sig_disconn_req(const struct l2cap_frame *frame)
 {
 	const struct bt_l2cap_pdu_disconn_req *pdu = frame->data;
+	uint16_t scid_key, dcid_key;
 
 	print_cid("Destination", pdu->dcid);
 	print_cid("Source", pdu->scid);
@@ -1400,12 +1414,24 @@ static void sig_disconn_req(const struct l2cap_frame *frame)
 	 * DCID is the recipient's own CID, which matches "scid" when the
 	 * request came from the peer (frame->in) - see l2cap_chan_key().
 	 */
-	obex_remove_session(frame->index, frame->handle,
-			l2cap_chan_key(frame->index, !frame->in, frame->handle,
-						le16_to_cpu(pdu->scid)));
-	obex_remove_session(frame->index, frame->handle,
-			l2cap_chan_key(frame->index, frame->in, frame->handle,
-						le16_to_cpu(pdu->dcid)));
+	scid_key = l2cap_chan_key(frame->index, !frame->in, frame->handle,
+						le16_to_cpu(pdu->scid));
+	dcid_key = l2cap_chan_key(frame->index, frame->in, frame->handle,
+						le16_to_cpu(pdu->dcid));
+	obex_remove_session(frame->index, frame->handle, scid_key);
+	obex_remove_session(frame->index, frame->handle, dcid_key);
+
+	/* If the closing channel is the RFCOMM transport (PSM 0x0003),
+	 * the ACL link stays up but every RFCOMM data channel (DLCI)
+	 * multiplexed over it loses its L2CAP transport without a
+	 * per-channel DISC/DM of its own. Drop their OBEX session and
+	 * fragment reassembly state too, keeping the SDP-learned channel
+	 * mappings for a future reconnect.
+	 */
+	if (is_rfcomm_chan_key(scid_key) || is_rfcomm_chan_key(dcid_key)) {
+		obex_remove_rfcomm_sessions(frame->index, frame->handle);
+		rfcomm_remove_handle(frame->index, frame->handle);
+	}
 }
 
 static void sig_disconn_rsp(const struct l2cap_frame *frame)
diff --git a/monitor/l2cap.h b/monitor/l2cap.h
index 1c1f7e609..6cfc25f8c 100644
--- a/monitor/l2cap.h
+++ b/monitor/l2cap.h
@@ -364,4 +364,6 @@ void l2cap_packet(uint16_t index, bool in, uint16_t handle, uint8_t flags,
 
 void rfcomm_packet(const struct l2cap_frame *frame);
 
+void rfcomm_remove_handle(uint16_t index, uint16_t handle);
+
 void l2cap_dequeue_frame(struct timeval *delta, struct packet_conn_data *conn);
diff --git a/monitor/obex.c b/monitor/obex.c
index 14f471c62..be2bbca7d 100644
--- a/monitor/obex.c
+++ b/monitor/obex.c
@@ -269,6 +269,73 @@ void obex_remove_session(uint16_t index, uint16_t handle, uint16_t channel)
 	obex_clear_profile(index, handle, channel);
 }
 
+/* Drop every session's request/profile state for this index/handle,
+ * regardless of channel, used when the whole ACL link is going away
+ * (see obex_disconnect_handle()).
+ */
+void obex_remove_all_sessions(uint16_t index, uint16_t handle)
+{
+	int i;
+
+	for (i = 0; i < MAX_OBEX_REQ; i++) {
+		if (obex_req_list[i].index == index &&
+				obex_req_list[i].handle == handle)
+			memset(&obex_req_list[i], 0, sizeof(obex_req_list[i]));
+	}
+
+	for (i = 0; i < MAX_OBEX_PROFILE; i++) {
+		if (!obex_profile_list[i].channel)
+			continue;
+
+		if (obex_profile_list[i].index == index &&
+				obex_profile_list[i].handle == handle)
+			memset(&obex_profile_list[i], 0,
+					sizeof(obex_profile_list[i]));
+	}
+}
+
+/* RFCOMM DLCIs only use 6 bits (0-63), while channel values used for
+ * direct L2CAP OBEX sessions are either a raw dynamic CID (>= 0x0040)
+ * or an index into l2cap.c's channel table with the 0x8000 bit set
+ * (see l2cap_chan_key()), so this bound reliably tells the two apart.
+ */
+#define MAX_RFCOMM_DLCI 0x3f
+
+/* The RFCOMM multiplexer (DLCI 0) or its underlying L2CAP transport is
+ * being torn down, which takes every RFCOMM data channel multiplexed
+ * over it down with it, even though no per-channel DISC/DM is seen for
+ * each of them. Drop their request/profile state only, same as
+ * obex_remove_channel() would for a single channel, but keep the
+ * SDP-learned channel mappings so a future reconnect on the same ACL
+ * link doesn't need SDP repeated, and leave alone any unrelated direct
+ * L2CAP OBEX session sharing the same ACL handle.
+ */
+void obex_remove_rfcomm_sessions(uint16_t index, uint16_t handle)
+{
+	int i;
+
+	for (i = 0; i < MAX_OBEX_REQ; i++) {
+		if (obex_req_list[i].channel > MAX_RFCOMM_DLCI)
+			continue;
+
+		if (obex_req_list[i].index == index &&
+				obex_req_list[i].handle == handle)
+			memset(&obex_req_list[i], 0, sizeof(obex_req_list[i]));
+	}
+
+	for (i = 0; i < MAX_OBEX_PROFILE; i++) {
+		if (!obex_profile_list[i].channel ||
+				obex_profile_list[i].channel >
+							MAX_RFCOMM_DLCI)
+			continue;
+
+		if (obex_profile_list[i].index == index &&
+				obex_profile_list[i].handle == handle)
+			memset(&obex_profile_list[i], 0,
+					sizeof(obex_profile_list[i]));
+	}
+}
+
 void obex_disconnect_handle(uint16_t index, uint16_t handle)
 {
 	int i;
@@ -283,11 +350,7 @@ void obex_disconnect_handle(uint16_t index, uint16_t handle)
 						sizeof(obex_chan_list[i]));
 	}
 
-	for (i = 0; i < MAX_OBEX_REQ; i++) {
-		if (obex_req_list[i].index == index &&
-				obex_req_list[i].handle == handle)
-			memset(&obex_req_list[i], 0, sizeof(obex_req_list[i]));
-	}
+	obex_remove_all_sessions(index, handle);
 
 	for (i = 0; i < MAX_OBEX_PSM; i++) {
 		if (!obex_psm_list[i].psm)
@@ -298,16 +361,6 @@ void obex_disconnect_handle(uint16_t index, uint16_t handle)
 			memset(&obex_psm_list[i], 0,
 						sizeof(obex_psm_list[i]));
 	}
-
-	for (i = 0; i < MAX_OBEX_PROFILE; i++) {
-		if (!obex_profile_list[i].channel)
-			continue;
-
-		if (obex_profile_list[i].index == index &&
-				obex_profile_list[i].handle == handle)
-			memset(&obex_profile_list[i], 0,
-					sizeof(obex_profile_list[i]));
-	}
 }
 
 static void obex_set_last_request(uint16_t index, uint16_t handle,
diff --git a/monitor/obex.h b/monitor/obex.h
index 019ed6174..7aeb0cae0 100644
--- a/monitor/obex.h
+++ b/monitor/obex.h
@@ -110,6 +110,8 @@ bool obex_channel(uint16_t index, uint16_t handle, uint8_t channel,
 							const char **profile);
 void obex_remove_channel(uint16_t index, uint16_t handle, uint8_t channel);
 void obex_remove_session(uint16_t index, uint16_t handle, uint16_t channel);
+void obex_remove_all_sessions(uint16_t index, uint16_t handle);
+void obex_remove_rfcomm_sessions(uint16_t index, uint16_t handle);
 void obex_disconnect_handle(uint16_t index, uint16_t handle);
 
 void obex_add_psm(uint16_t index, uint16_t handle, uint16_t psm);
diff --git a/monitor/packet.c b/monitor/packet.c
index 7414910c7..ca68c54ae 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -12315,6 +12315,7 @@ static void disconnect_complete_evt(struct timeval *tv, uint16_t index,
 	if (evt->status == 0x00) {
 		release_handle(le16_to_cpu(evt->handle));
 		obex_disconnect_handle(index, le16_to_cpu(evt->handle));
+		rfcomm_remove_handle(index, le16_to_cpu(evt->handle));
 	}
 }
 
diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
index 90ddc3596..1188072ae 100644
--- a/monitor/rfcomm.c
+++ b/monitor/rfcomm.c
@@ -386,12 +386,118 @@ static inline bool mcc_frame(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 	return true;
 }
 
+/* An OBEX PDU may be split across several RFCOMM UIH frames since the
+ * RFCOMM MTU is typically much smaller than the maximum OBEX PDU
+ * length. Information bytes are buffered per index/handle/DLCI and
+ * direction until a complete PDU (3-byte opcode+length header plus
+ * body) is available; complete PDUs are then decoded and any leftover
+ * bytes are kept for the next frame.
+ *
+ * The full DLCI (server channel plus direction bit), not just the
+ * server channel number, identifies the session: two connections to
+ * the same server channel but opened by different initiators use
+ * distinct DLCIs and must not share a reassembly buffer.
+ */
+#define MAX_OBEX_FRAG 64
+
+struct obex_frag_data {
+	uint16_t index;
+	uint16_t handle;
+	uint8_t dlci;
+	bool in;
+	uint8_t *buf;
+	uint32_t len;
+};
+
+static struct obex_frag_data obex_frag_list[MAX_OBEX_FRAG];
+
+static struct obex_frag_data *obex_frag_get(uint16_t index, uint16_t handle,
+						uint8_t dlci, bool in)
+{
+	int i, n = -1;
+
+	for (i = 0; i < MAX_OBEX_FRAG; i++) {
+		if (!obex_frag_list[i].dlci) {
+			if (n < 0)
+				n = i;
+			continue;
+		}
+
+		if (obex_frag_list[i].index == index &&
+				obex_frag_list[i].handle == handle &&
+				obex_frag_list[i].dlci == dlci &&
+				obex_frag_list[i].in == in)
+			return &obex_frag_list[i];
+	}
+
+	if (n < 0)
+		return NULL;
+
+	obex_frag_list[n].index = index;
+	obex_frag_list[n].handle = handle;
+	obex_frag_list[n].dlci = dlci;
+	obex_frag_list[n].in = in;
+	obex_frag_list[n].buf = NULL;
+	obex_frag_list[n].len = 0;
+
+	return &obex_frag_list[n];
+}
+
+static void obex_frag_reset(struct obex_frag_data *frag)
+{
+	free(frag->buf);
+	frag->buf = NULL;
+	frag->len = 0;
+}
+
+static void rfcomm_remove_channel(uint16_t index, uint16_t handle,
+							uint8_t dlci)
+{
+	int i;
+
+	for (i = 0; i < MAX_OBEX_FRAG; i++) {
+		if (obex_frag_list[i].dlci == dlci &&
+				obex_frag_list[i].index == index &&
+				obex_frag_list[i].handle == handle) {
+			obex_frag_reset(&obex_frag_list[i]);
+			memset(&obex_frag_list[i], 0,
+					sizeof(obex_frag_list[i]));
+		}
+	}
+}
+
+/* An ACL handle may be disconnected without an RFCOMM DISC/DM on each
+ * of its channels (e.g. the link is simply dropped), which would
+ * otherwise leave both directions' reassembly buffers and their slots
+ * allocated. Free every fragment buffer still tracked for this handle.
+ */
+void rfcomm_remove_handle(uint16_t index, uint16_t handle)
+{
+	int i;
+
+	for (i = 0; i < MAX_OBEX_FRAG; i++) {
+		if (!obex_frag_list[i].dlci)
+			continue;
+
+		if (obex_frag_list[i].index == index &&
+				obex_frag_list[i].handle == handle) {
+			obex_frag_reset(&obex_frag_list[i]);
+			memset(&obex_frag_list[i], 0,
+					sizeof(obex_frag_list[i]));
+		}
+	}
+}
+
 static bool uih_frame(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 {
 	uint8_t credits;
 	struct l2cap_frame *frame = &rfcomm_frame->l2cap_frame;
 	struct rfcomm_lhdr *hdr = &rfcomm_frame->hdr;
 	uint8_t channel = RFCOMM_GET_CHANNEL(hdr->address);
+	uint8_t dlci = RFCOMM_GET_DLCI(hdr->address);
+	struct obex_frag_data *frag;
+	uint8_t *buf;
+	uint32_t pos;
 
 	if (!channel)
 		return mcc_frame(rfcomm_frame, indent);
@@ -410,11 +516,83 @@ static bool uih_frame(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 	if (!frame->size)
 		return true;
 
-	if (obex_channel(frame->index, frame->handle, channel, NULL))
-		obex_packet(frame, channel, frame->size);
-	else
+	/* The server channel number is only used to resolve the
+	 * SDP-learned mapping; the DLCI (which also encodes which side
+	 * opened the connection) is the actual session/reassembly key,
+	 * since two connections can share a server channel number.
+	 */
+	if (!obex_channel(frame->index, frame->handle, channel, NULL)) {
+		packet_hexdump(frame->data, frame->size);
+		return true;
+	}
+
+	frag = obex_frag_get(frame->index, frame->handle, dlci, frame->in);
+	if (!frag) {
+		obex_packet(frame, dlci, frame->size);
+		return true;
+	}
+
+	buf = realloc(frag->buf, frag->len + frame->size);
+	if (!buf) {
+		obex_frag_reset(frag);
+		obex_packet(frame, dlci, frame->size);
+		return true;
+	}
+
+	memcpy(buf + frag->len, frame->data, frame->size);
+	frag->buf = buf;
+	frag->len += frame->size;
+
+	pos = 0;
+
+	while (frag->len - pos >= 3) {
+		struct l2cap_frame pdu_frame = *frame;
+		uint16_t pdu_len = get_be16(frag->buf + pos + 1);
+
+		if (pdu_len < 3) {
+			/* Malformed declared length: hand over as much of
+			 * the rest of the buffer as fits in l2cap_frame.size
+			 * (uint16_t) and let obex_packet() report the error,
+			 * rather than buffering indefinitely. Any excess
+			 * stays buffered and is retried on the next call.
+			 */
+			uint32_t remaining = frag->len - pos;
+
+			if (remaining > UINT16_MAX)
+				remaining = UINT16_MAX;
+
+			pdu_frame.data = frag->buf + pos;
+			pdu_frame.size = remaining;
+			obex_packet(&pdu_frame, dlci, pdu_frame.size);
+			pos += remaining;
+			break;
+		}
+
+		if (frag->len - pos < pdu_len)
+			break;
+
+		pdu_frame.data = frag->buf + pos;
+		pdu_frame.size = pdu_len;
+		obex_packet(&pdu_frame, dlci, pdu_len);
+
+		pos += pdu_len;
+	}
+
+	if (pos == frag->len) {
+		obex_frag_reset(frag);
+	} else {
+		/* Still waiting for more fragments: show this frame's own
+		 * payload so partial OBEX data isn't silently dropped from
+		 * the trace, mirroring the L2CAP SAR reassembly path.
+		 */
 		packet_hexdump(frame->data, frame->size);
 
+		if (pos) {
+			memmove(frag->buf, frag->buf + pos, frag->len - pos);
+			frag->len -= pos;
+		}
+	}
+
 	return true;
 }
 
@@ -533,12 +711,31 @@ void rfcomm_packet(const struct l2cap_frame *frame)
 		if (!uih_frame(&rfcomm_frame, indent))
 			goto fail;
 	} else if (ctype == 0x43 || ctype == 0x0f) {
-		/* DISC or DM: the RFCOMM channel is being torn down, drop
-		 * any OBEX state tracked for it so a later renegotiation
-		 * of the same channel number isn't misdecoded.
-		 */
-		obex_remove_channel(frame->index, frame->handle,
-					RFCOMM_GET_CHANNEL(hdr.address));
+		uint8_t dlci = RFCOMM_GET_DLCI(hdr.address);
+
+		if (!dlci) {
+			/* DISC or DM on DLCI 0: the whole RFCOMM
+			 * multiplexer is being torn down, taking every
+			 * data channel running over it down with it, even
+			 * though no per-channel DISC/DM is seen for each of
+			 * them. Drop all of their OBEX state, but keep the
+			 * SDP-learned channel mappings so a reconnect on
+			 * the same ACL link doesn't need SDP repeated.
+			 */
+			obex_remove_rfcomm_sessions(frame->index,
+								frame->handle);
+			rfcomm_remove_handle(frame->index, frame->handle);
+		} else {
+			/* DISC or DM: the RFCOMM channel is being torn
+			 * down, drop any OBEX state tracked for it so a
+			 * later renegotiation of the same DLCI isn't
+			 * misdecoded.
+			 */
+			obex_remove_channel(frame->index, frame->handle,
+									dlci);
+			rfcomm_remove_channel(frame->index, frame->handle,
+									dlci);
+		}
 	}
 
 	return;
-- 
2.43.0

