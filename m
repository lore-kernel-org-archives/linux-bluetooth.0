Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA9F7DA66
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 00:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779321973; cv=none; b=V/GjoE/9qovwtALWjJ0NeGLaoSMpYP7XnFO3252PdkCGvLBHBLLnwbFmUmlRwIji/RY0Yu9sCBVhHCueG+o/mQNhRvzkQ2klPpusaP8jKawI2pC2/aZbpCWoL5OARAYx4WcSeZuJvGUrEYOj3lvHLyepM54/OxS6Va+wBiKp5F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779321973; c=relaxed/simple;
	bh=zahVRzkLToA6oMFieq+LNgXnW2Tf/2BUPcvcXVza/7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjFkU4XJY+jB0nODASXRrGTv+rQhJS9ITP2okJvvQCJ/dAEXDOmZETSah9gfU+LmuRMvJhDdGmem0ONYgVMOCWkdFsxt+MwxvtWPNY1x5Oxmp2p65yjQzNfwdctI5RwiH6xIVlW6/PucE+/APut7+TP3Cs6ouh14f9fyrRTOzS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdKfB16T; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdKfB16T"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-902deb2412fso681330285a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 17:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779321970; x=1779926770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZNvk1BovRx97OnCimNnt74dFamxA5DuthwM7CtyImQ=;
        b=ZdKfB16TSYpDIZbZ0DLkuPoClmrOk0o8zUySVIJcBkr6zLq/QhJUEBU9xrmh1/TppG
         B4iIpo5WdElfingawitMeD8dNulFNSCEa2Ez8QSD5f9eMkEVeyI7a6C3vKAHZJahpMhm
         V6amTfRI74lQaQ62d0TqoIMlRAM2X82na8FfeRWcQPLCsV3WlRkWcifhiy9RJ76EOoBG
         NGUpEoOO8jhqDmimROmmsYX5ZvqZ3mWnhHH1RiG5ZKjqHTO0EItwpo63UavzGd6/o5or
         0dXXbvdl7XAddPdUwFl5v2VM2K5K2dplVs7bW4s/WJRWgEa4mETWc8Vf+OLG7HukpdIS
         YZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779321970; x=1779926770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2ZNvk1BovRx97OnCimNnt74dFamxA5DuthwM7CtyImQ=;
        b=fYdZsW2xegznHjgi8EF/s7pQmQghh1gA8WiWcwuOXh0nYiT5UqlbbYr8xUfNZbZeM4
         r0xUBIY4XAS21cGG7YbCLYavmCBNUev3h06v6NzcRyEi4yMr3H/RjWtHGrf95NH4NKbc
         +5+fhJJZijLpwDeMNRc4oDlqRP/1FFAFRDX4CTUkUTwPGFexFNO5AxZe9y0AXA75hfJb
         BJ25KptKo66hUr2sdrT5rgxpRYC8JL1+Q/zeryFXq8XPXLuEWSVZ7qtUUqzM0+zxXRs0
         NzYdC09/4S1QQ20wjRULKYBv/kFCg57/V5qKX7dV0udzHZ+e3P2eLRd310TpCSs6uUOn
         JkNg==
X-Forwarded-Encrypted: i=1; AFNElJ/InMoxBQl/OJF9sHoUqBRHbI/r8HEe7fK6JdAeGpWEGxtiiEHSCulJ3noIqOluGlutzrGl3hSmes0kSA8Unw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU4+gcYF3st0/tfHMxcJfxrN6HWkdn528It+GHq6LIr13DI9C8
	qGyp+mYzHR1V70D3AGfEXRSNfsIkZnsHNVk8eDf2EyOe2rslNp++SJ1l
X-Gm-Gg: Acq92OGLSfHtgCoPhhhKkwf+OqMoTCVS+OX017VVYTOAp4JXsWFM35grdg4BY/dIOG0
	53DTaZeOuNCGMirhIdyYxd7jpapDbKZyj3zooy+BGfT2QGhsm5WYWa6l1kZCKUTZKlhAfzi+/Zl
	kCs8MB9esgtJAGW+tiVCaBs+ao2pLycw86NSeGJE5MMoJh17GnDotY3cvNjQuCdui8ZGECHGm07
	JIoqOV35iYSNT7uqyi7Zp/oYL/4mnmR7tEDGKcJjy7+g5BeLArFwuVMpLP0hBED511R+dUqbBCB
	OkbCKo0DuD72zoLOVE/paJj/8EbyyaotAZENuBxS2sPB+BmG8Ljt31jitxLfB1rNo4DMmdhAazY
	3MDwfhsnVk2sTRmI1pTq/EmCdiHPYytMPPAy+FE1mwiXkgAsobSnb4didiHZkNwhU3pzFFCELpG
	p535A9vFpXMegkuYBdQCNCVpQag3PirzGnFz8uwElL17iWrklIppR6YORqW2m+vHUydr+wx47Jt
	0gjO3HKmOVjWGgrh2OMbJIlz6nVuqc=
X-Received: by 2002:a05:620a:19a0:b0:912:5d2a:4baf with SMTP id af79cd13be357-914a2e507e2mr67313885a.61.1779321969362;
        Wed, 20 May 2026 17:06:09 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf353b9sm2360405085a.35.2026.05.20.17.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 17:06:08 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
Date: Wed, 20 May 2026 20:05:55 -0400
Message-ID: <20260521000555.3712030-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520135034.1060859-1-michael.bommarito@gmail.com>
References: <20260520135034.1060859-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

net/bluetooth/l2cap_core.c:l2cap_sig_channel() accepts BR/EDR
signaling packets up to the channel MTU and dispatches each command
without enforcing the signaling MTU (MTUsig). A Bluetooth BR/EDR peer
within radio range can send a fixed-channel CID 0x0001 packet that is
larger than MTUsig and contains many L2CAP_ECHO_REQ commands before
pairing. In a real-radio stock-kernel run, one 681-byte signaling
packet containing 168 zero-length ECHO_REQ commands made the target
transmit 168 ECHO_RSP frames over about 220 ms.

Impact: a Bluetooth BR/EDR peer within radio range, before pairing, can
force 168 ECHO_RSP frames from one 681-byte fixed-channel signaling
packet containing packed ECHO_REQ commands.

Define Linux's BR/EDR signaling MTU as the spec minimum of 48 bytes and
reject any larger signaling packet with one L2CAP_COMMAND_REJECT_RSP
carrying L2CAP_REJ_MTU_EXCEEDED before any command is dispatched.

The Bluetooth Core spec wording for MTUExceeded says the reject
identifier shall match the first request command in the packet, and
that packets containing only responses shall be silently discarded.
Linux intentionally deviates from that prescription: silently
discarding desynchronizes the peer because the remote stack never
learns its responses were dropped, and locating the first request
command requires walking command headers past MTUsig, i.e. processing
bytes from a packet we have already decided is too large to process.
We therefore always emit one reject and use the identifier from the
first command header (a single fixed-offset byte read), falling back
to zero when the packet is too short to carry a header at all.

The unrestricted BR/EDR signaling parser and ECHO_REQ response path both
trace to the initial git import; no later introducing commit is
available for a Fixes tag.

Cc: stable@vger.kernel.org
Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Link: https://lore.kernel.org/r/20260518002800.1361430-1-michael.bommarito@gmail.com
Link: https://lore.kernel.org/r/20260520135034.1060859-1-michael.bommarito@gmail.com
Assisted-by: Claude:claude-opus-4-7
Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
I reproduced the stock behavior with a real-radio BR/EDR ACL link and a
harness that sends a single fixed-channel signaling packet containing
packed zero-length ECHO_REQ commands, and confirmed on a patched kernel
that the same packet now produces one L2CAP_REJ_MTU_EXCEEDED command
reject and zero ECHO_RSP frames. The patched code builds for
net/bluetooth/l2cap_core.o on x86_64 defconfig with W=1. There are no
in-tree Bluetooth selftests that reference l2cap_sig_channel(),
L2CAP_SIG_MTU, or L2CAP_ECHO_REQ.

Changes in v3:
- Drop l2cap_sig_cmd_is_req() and l2cap_sig_first_req_ident(); the
  reject is now unconditional and uses only the first command
  header's identifier byte at a fixed offset. Per Luiz, the spec's
  "match the first request command identifier" rule would require
  parsing past MTUsig, and the spec's "silently discard if only
  responses" rule desynchronizes the peer.
- Replace the v2 walk with a verbose comment quoting the relevant
  Bluetooth Core section and documenting why Linux deviates.

Changes in v2:
- Replace the per-PDU echo-count cap with the MTUsig direction from
  review.
- Reject the whole over-MTUsig signaling packet with one
  L2CAP_REJ_MTU_EXCEEDED command reject.
- Add L2CAP_SIG_MTU and drop over-MTUsig packets when no valid request
  command identifier is found.

v1: https://lore.kernel.org/r/20260518002800.1361430-1-michael.bommarito@gmail.com
v2: https://lore.kernel.org/r/20260520135034.1060859-1-michael.bommarito@gmail.com
---
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_core.c    | 47 +++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 5172afee54943..e0a1f2293679a 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -33,6 +33,7 @@
 /* L2CAP defaults */
 #define L2CAP_DEFAULT_MTU		672
 #define L2CAP_DEFAULT_MIN_MTU		48
+#define L2CAP_SIG_MTU			48	/* BR/EDR signaling MTU */
 #define L2CAP_DEFAULT_FLUSH_TO		0xFFFF
 #define L2CAP_EFS_DEFAULT_FLUSH_TO	0xFFFFFFFF
 #define L2CAP_DEFAULT_TX_WINDOW		63
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7701528f11677..0b1e062057695 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5618,6 +5618,15 @@ static inline void l2cap_sig_send_rej(struct l2cap_conn *conn, u16 ident)
 	l2cap_send_cmd(conn, ident, L2CAP_COMMAND_REJ, sizeof(rej), &rej);
 }
 
+static inline void l2cap_sig_send_mtu_rej(struct l2cap_conn *conn, u8 ident)
+{
+	struct l2cap_cmd_rej_mtu rej;
+
+	rej.reason = cpu_to_le16(L2CAP_REJ_MTU_EXCEEDED);
+	rej.max_mtu = cpu_to_le16(L2CAP_SIG_MTU);
+	l2cap_send_cmd(conn, ident, L2CAP_COMMAND_REJ, sizeof(rej), &rej);
+}
+
 static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 				     struct sk_buff *skb)
 {
@@ -5630,6 +5639,44 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 	if (hcon->type != ACL_LINK)
 		goto drop;
 
+	/*
+	 * Bluetooth Core v5.4, Vol 3, Part A, Section 4: the BR/EDR
+	 * signaling channel has a fixed signaling MTU (MTUsig) whose
+	 * minimum and default is 48 octets.  Section 4.1 says that on
+	 * an MTUExceeded command reject the identifier "shall match
+	 * the first request command in the L2CAP packet" and that
+	 * packets containing only response commands "shall be
+	 * silently discarded".
+	 *
+	 * Linux intentionally deviates from that prescription:
+	 *
+	 *   1. Silently discarding desynchronizes the peer.  The
+	 *      remote stack never learns its responses were dropped,
+	 *      so any state machine waiting on a paired response
+	 *      stalls until its own timer fires.
+	 *
+	 *   2. Locating "the first request command" requires walking
+	 *      command headers past MTUsig, i.e. processing bytes
+	 *      from a packet we have already decided is too large to
+	 *      process.
+	 *
+	 * Reject every over-MTUsig signaling packet with one
+	 * L2CAP_REJ_MTU_EXCEEDED command reject.  The reject's
+	 * reason field is what tells the peer that the whole packet
+	 * was discarded; the identifier value is informational, so
+	 * we use the identifier from the first command header (a
+	 * single fixed-offset byte read) or zero when the packet is
+	 * too short to carry even one header.
+	 */
+	if (skb->len > L2CAP_SIG_MTU) {
+		u8 ident = (skb->len >= L2CAP_CMD_HDR_SIZE) ?
+			   skb->data[1] : 0;
+
+		BT_DBG("signaling packet exceeds MTU");
+		l2cap_sig_send_mtu_rej(conn, ident);
+		goto drop;
+	}
+
 	while (skb->len >= L2CAP_CMD_HDR_SIZE) {
 		u16 len;
 
-- 
2.53.0

