Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACB9351C09
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374753; cv=none; b=oMdZa9lMC5aqia02kuoK0g3TqVC3ieQQl2NvPSzOiHLVcsLsIsR/cW+DPNAFJ1miYW/zzngr1kr4gCHvVzXZNmPyPTLBZZCPHKyI+T6IwFgRni9A/b3fBjPCel+6i1jWiplAIaURoIYShrJD8/hIOukCkGvaIRZlQvlLHAfS5Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374753; c=relaxed/simple;
	bh=0bHMwVH+RWVHyqoltKgevpbH8rh5/4F/xlbrHwDzn9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VfG2+dklTp5Mw+ZLp3ER0SF/f2BmWsJF7NsFSNlRHNEIxOZCwmLtJV9MyTUcz5xtGzEPj/6G4Cs9Bjc70Xdi3r+f2DZdlGnJfd4LXprnrX3EmOAxHSDH7U+f4/LwQ7LJof/1MpZ61IXbMCee/lUwaQjmelyJnN0SzQ84E8KW9AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frPk68lD; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frPk68lD"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-651c366f7efso6538516d50.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 07:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779374751; x=1779979551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u89HBbRsviyBaYaHagn1+4TNLs1cgeGtYFXO0/GqIng=;
        b=frPk68lDTCIOTjn5jwCJ7NHM83Shxjn3IyflBnAtPjhF/WAMTqXawBo161rKRBGrO7
         zC57Pdip06BaYeNiAJhRcXbul86NXcd4YPUq9KcxM/VEUXa7Df1ePOmE0Go1cjnXVu8A
         KaCgD8z2K6KbyhwGJB4cyseUCvJw9j2VHLjduY2Mj2cLyrMHHPxVYtRniaY0Z6vxK75p
         qQnWILFJfMdj7MB+6kQI9ZxVt5Q3kyiLbgZt0+Ut6Krp60CCx4qtUcC19mHzueq7Qixp
         H98wR8E2rubAviyXNZf6BLB6hxL3g1hYWGXNTLrBJOJVNN8Z/QbKu6m+R6FG5sdpp6Nm
         XtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779374751; x=1779979551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u89HBbRsviyBaYaHagn1+4TNLs1cgeGtYFXO0/GqIng=;
        b=JSXOJ5hyaB3jOSWixDqz9xpJoUMI+Uf2lOfGQM26yJmWR2nxJEHglsmjerWg3NklAJ
         UQFYCpLXf8NP25UDaMmxWSi797Enl16LvlPZWZKv8iH4D0fmoaCtvgqmv/55qbAh/9Zq
         4yE2rtjrjzS8OvZbBxNdpMZyzInS8vCNBL7/5LJWVrwnz8BIox5aSIhiAkBHxeO7Qnzn
         jCBafe324iTuEWkuLyrpMn0Zzk/L501wZErmLw5VwgDdyCW3ZT7v5UOoc1qgvMH9GAUZ
         7gmg1oSzHvdn3IZOXT/vCPULgHFDxZdwEqX33VL2AkO3gPiajpWgci/NNUpDLw23fwfh
         gTaQ==
X-Gm-Message-State: AOJu0Yychxq6poinGWLAANouIyZACHG05n46pCjgBL2evvAGkcUe8Etj
	Jpyqxa61a2/A7Rg5TkA7U971E+oOzKlF5TnUQOHZEmbjC+pH9ZrGsOrN+yQc0rD/zT8=
X-Gm-Gg: Acq92OEX04hn5fE7zURyDGXi5Ujj5KGeIoeDiYRDFrrRPOlAwmSYEnj+RsAON+4ZPw/
	vQIrOpGUPed8knZabHiUXyk6f+B3TpKHKhJsrJxjRSEU86nNVViRJBBZhh1e8PONKNTTuHiymbt
	jAGlN54LLelbv34b/hufuArqdDC4KccUd3b5Zy0ks5ArxOCv1wnqi9GvzQQtNBx0T6uBY0aRw/t
	l+ZqF+jelC3Dk2tcJvJTHnPCINpC5EdLU1/hZ6nvhJDDwA49MgB4gHbgDSZiaCorb4IU/Y/+MQV
	hIMUFQ5sLKahsZtPneUhNXgecEIONbLiem02/T3sQrOz5UVe8TEfmD2e1oWTSIgLu0b4TdjbLjc
	ymoI26WSB4vk1IJyHAzgeFDFSqgIudpoMgeO5eAbqsLE1ItFMP8nyWJ/OyUlXH77V1Yr8dIcbPg
	+aGyCeRyiCymDV3eOaEfwQv7MQer6crp1QJoHgmgBtxJ7KCLG0hKYrNGT0NtceMFtTg49KQbru8
	bjCv9SggSeG9deb6kIb4mIO/ptuUNE=
X-Received: by 2002:a05:690e:140d:b0:653:1c2a:94a5 with SMTP id 956f58d0204a3-65eadf950b1mr2621516d50.8.1779374750612;
        Thu, 21 May 2026 07:45:50 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc768d4ca8sm6676026d6.17.2026.05.21.07.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 07:45:50 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
Date: Thu, 21 May 2026 10:45:17 -0400
Message-ID: <20260521144518.1361335-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521000555.3712030-1-michael.bommarito@gmail.com>
References: <20260521000555.3712030-1-michael.bommarito@gmail.com>
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
first command header, a single fixed-offset byte read.

The unrestricted BR/EDR signaling parser and ECHO_REQ response path both
trace to the initial git import; no later introducing commit is
available for a Fixes tag.

Cc: stable@vger.kernel.org
Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Link: https://lore.kernel.org/r/20260518002800.1361430-1-michael.bommarito@gmail.com
Link: https://lore.kernel.org/r/20260520135034.1060859-1-michael.bommarito@gmail.com
Link: https://lore.kernel.org/r/20260521000555.3712030-1-michael.bommarito@gmail.com
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

Changes in v4:
- Drop the unreachable short-header fallback before reading the first
  command identifier; any packet over L2CAP_SIG_MTU is large enough to
  carry an L2CAP command header.
- Print both skb->len and L2CAP_SIG_MTU in the over-MTUsig debug trace.

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
v3: https://lore.kernel.org/r/20260521000555.3712030-1-michael.bommarito@gmail.com
---
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_core.c    | 46 +++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

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
index 7701528f11677..17ee28a2ee78e 100644
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
@@ -5630,6 +5639,43 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn,
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
+	 * we use the identifier from the first command header, a
+	 * single fixed-offset byte read.
+	 */
+	if (skb->len > L2CAP_SIG_MTU) {
+		u8 ident = skb->data[1];
+
+		BT_DBG("signaling packet exceeds MTU: %u > %u",
+		       skb->len, L2CAP_SIG_MTU);
+		l2cap_sig_send_mtu_rej(conn, ident);
+		goto drop;
+	}
+
 	while (skb->len >= L2CAP_CMD_HDR_SIZE) {
 		u16 len;
 
-- 
2.53.0

