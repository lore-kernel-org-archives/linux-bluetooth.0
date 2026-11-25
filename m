Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795615190;
	b=PO6xL2Ndq2QW4+Uwp+jmfUs+1ZsdIOikvs3RX9X7SD1GxOpUB5mb8XLzL1AZiWgWG63v
	 MDQw/+v8oxu72OvUs0xNTuqkTcaj7XtnZpqvHcmClGvNgbfm1akLqJVjrEnJFrbVY7E3r
	 cKuh/mBLqQ/k5z0rAgrHKWcawFZWFeV98msHv7wEbvD71V4N9Ve71hT0bKYXijQqe4oZk
	 IGEyHrhsoc1JxGc38w+vd49ic233PSuVb0+/h61OzMjfqGX9930xxEybP41+f0l37sPie
	 vRSstel1aP2KjAwiQqv4Q41Or1beOrASKiYV8pZxl1xFnYN1OI4iu7BSLUVvih9Tfow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yYdOdyh0WowXFIv06NnKcJkbXieih1/fluA9vNsvyFc=;
	b=kNjM/aoI6U6u2MlrcccCPf++o1GgiKIvuNvaANvQJKv1+desJ5PYgL+nY8PxSTmO8a4D
	 uH57JN3L6f7tYQVxKKlvuHI96In4jeTxdYImbHdG/w2ZTtstDPyZfiEiq+hl7s32RyL2f
	 RFnKXAU8XeeqnITjRxQGZ+27HqnVqijE4hDMdt6RHDRmvdBekNnlz9sD77xqhmxRWmn3l
	 VdxUlBCnwxtdbdqwitgJSA+86GaGQRMrHrGHB6JqTdV0MNkWkRwIifxmq0G67nzARJfdy
	 XBnTk0Ze+/BCTQyA5tEEV1G+G+gc+OEVp9+cEbK6NW9c8zThyoFO+GRxv70RZivzLfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WeS5O4oU;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402EA606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 13:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 402EA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WeS5O4oU
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso2988089a91.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 05:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795615189; x=1796219989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yYdOdyh0WowXFIv06NnKcJkbXieih1/fluA9vNsvyFc=;
        b=WeS5O4oUEdmaep+E/3OeChM2n+HaAKQaPWa7CBYGgK7QWgP5ti2pl/bsOBT0ablmqg
         E9VbTOc7DN1DwLCjtanoFrJH4kvCbAySx/u4J6gxjNDVLkIuOS5g+EtZRWKZPOJp/1hr
         BgALJ4V/UUGr337QRZ0ImpZaXUDIqAgnStf/FT6jdyFGc4Buguij6YoVvg8f9W5Eji4c
         ouWpBbTeiTXAyG6r8PDxpzlgfXibfeP52tAgQuUPPtrlwdGdxWUGzvTK6ufh69iRMSPJ
         cF4m0r9Q0RyyMp2YIzesefJ1ZUlpioReK4WaLT3BIS3oqYBMSi64O9KC/9wyQhW9REnL
         EDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795615189; x=1796219989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yYdOdyh0WowXFIv06NnKcJkbXieih1/fluA9vNsvyFc=;
        b=UwwGYp+dHd3Xdzy70b6QEwRJc3nM7wUwUuGtqgeKqypuddMGOsaEyXibIug3l73jVl
         qsw85SwlXTPGrazF4Y/1kSYg1q2h1+pywCG5FfL5QeVJRpN5z8ONy3QxeIteNHA++rTG
         /OIyauXYWGl2ATxmNQ2TP5ARoD0S1rTwEjNxuI8oEo2yT6Ro0RmNWEc5XUXwZxav5/jq
         HToqe+eD/AfJiVgLLuO1424USFConEuEKyq1WyN+NNa5nKVikTBPa5x7ZX52+tDydst5
         IvGPCfT6ClUSNry3/NsbcPd4W5xxm1da0vJk4MHj4g2/RrPg+hMChMSGVtUNbVFMJ9VT
         cVKg==
X-Gm-Message-State: APuU4Z8N5zLsm3JuW4vzHiEwPR9zaOwKT/q1H4ZMkJ3rODKudqBtAqNs
	2btbmDCqyDEQxX8stXO/TMmQZIeheN0visgKvXdfpahGyP05v00K6Hom
X-Gm-Gg: AZFdTZcwW5h+cYZx35yePiynT9DXbHr2temPfQ0PfpgwOp8yfqRIFAaDFkhZ2keUIaC
	IXOXnRB+ieCmo+nqRp4BMvShU9Bn2Rii5a83EZUDv0Z8rPgSZmxdGKVPdKdFbZn8pjMUm7pNRzX
	Whgr6bkGjAi0e78W7XApJHWFDot5cNmbqQx2Xp1h/q7pDUcvwqfZoyBS7aLc05aVkKu2mTntNg8
	YwX9V+MyhjQyVapu+IH4zP/U6vpu3/tVTK1Sv7dFRZILuMkoWEHD/bDH6/41mSfBI0fUA9GZXuz
	gjtUChUiuwBfoIioapVZIEFclJHJIp7Vf+B/mWP4zUyKCsH1NtZlbAdaTbscPmTeb5LlDWkk4PX
	aUJ+42xHbgE0+1MV6Qz//qygxUPOpnMcXnKHl10KW68ZjKV7Iz0mf7W/Im15wG4dr2qHLjUasjT
	4VyFQ8z3WaU6P+QcwtRvz/SqTyriXrDX+UWSBGQrj0l3bS9zaMhsqxwtcMn8k/52ZTSn7TKSKRr
	/9VmxBo7Yq0vAs6MVeAX9VhVXlqrszcFXh/ULhq8+JJnBP0jclZdxoGxwnHj7bdu1tTii6tgKYN
	I35QQ0+tiyEES+GrBzegZiC5LRt2N2ekN6qXzOYXv8kwhA==
X-Received: by 2002:a17:90b:1a90:b0:3b0:e388:d9da with SMTP id 98e67ed59e1d1-3b41c92ce29mr15610058a91.29.1795615189361;
        Wed, 25 Nov 2026 05:59:49 -0800 (PST)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cea7c38sm9143860a12.2.2026.11.25.05.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 05:59:49 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 1/2] Bluetooth: L2CAP: Match configuration responses to channel requests
Date: Wed, 25 Nov 2026 21:59:38 +0800
Message-Id: <pm-bluetooth-objects-candidate-0069-v11-7d5800a0c21420dddac0-1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-bluetooth-objects-candidate-0069-v11-7d5800a0c21420dddac0-0@gmail.com>
References: <pm-bluetooth-objects-candidate-0069-v11-7d5800a0c21420dddac0-0@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A peer can delay a BR/EDR Configuration Response until the channel is
deleted. If another channel keeps the ACL connection alive, a new
channel can reuse the SCID. l2cap_config_rsp() selects by SCID without
checking which request the response belongs to:

  Signaling worker                  Local socket
  send CONF_REQ(A, i)
  disconnect and remove A
                                    create B with A's SCID
  send CONF_REQ(B, j)
  receive delayed CONF_RSP(A, i)
    SCID lookup selects B
    update B's options

Record the local identifier at every Configuration Request send and
check it before applying a response. Peer request identifiers must not
overwrite that local identifier. Consume terminal responses before a
retry can publish a new identifier, while retaining it for PENDING and
continuation responses.

Reject zero MPS in RFC response options before publishing it to the
channel. A stale or malformed response must not introduce a zero divisor
to the receive-space calculation. The report below shows the delayed
zero-MPS response racing with receive-space accounting.

The excerpt below retains the headline and stack traces.

Oops report as below:

    Oops: divide error: 0000 [#1] SMP KASAN NOPTI

    RIP: 0010:l2cap_publish_rx_avail+0x159/0x490

    Call Trace:
     <TASK>
     l2cap_sock_recvmsg+0x442/0xa00
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_l2cap_sock_recvmsg+0x10/0x10
     sock_recvmsg+0x1c5/0x210
     __sys_recvfrom+0x1d4/0x2c0
     ? __pfx___sys_recvfrom+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __x64_sys_poll+0x11a/0x430
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? xfd_validate_state+0x24/0x150
     ? __pfx___x64_sys_poll+0x10/0x10
     __x64_sys_recvfrom+0xe5/0x1c0
     ? lockdep_hardirqs_on_prepare+0xea/0x1a0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? trace_hardirqs_on+0x18/0x160
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    RIP: 0033:0x7fd37c082687

     </TASK>

    RIP: 0010:l2cap_publish_rx_avail+0x159/0x490

Fixes: 7b1c0049be3a ("Bluetooth: Read RFC conf option on a successful Conf RSP")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
This patch was written with assistance from Codex (OpenAI).

 net/bluetooth/l2cap_core.c | 50 +++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0d4f3341bd47f..069c0aabae0f1 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1739,7 +1739,8 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 			}
 
 			set_bit(CONF_REQ_SENT, &chan->conf_state);
-			l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
+			chan->ident = l2cap_get_ident(conn);
+			l2cap_send_cmd(conn, chan->ident, L2CAP_CONF_REQ,
 				       l2cap_build_conf_req(chan, buf, sizeof(buf)), buf);
 			chan->num_conf_req++;
 		}
@@ -3973,6 +3974,10 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 	    (chan->mode == L2CAP_MODE_BASIC || chan->state == BT_CONNECTED))
 		return -ECONNREFUSED;
 
+	if ((rfc.mode == L2CAP_MODE_ERTM ||
+	     rfc.mode == L2CAP_MODE_STREAMING) && !rfc.max_pdu_size)
+		return -ECONNREFUSED;
+
 	chan->mode = rfc.mode;
 
 	if (*result == L2CAP_CONF_SUCCESS || *result == L2CAP_CONF_PENDING) {
@@ -4212,12 +4217,13 @@ void __l2cap_connect_rsp_defer(struct l2cap_chan *chan)
 	if (test_and_set_bit(CONF_REQ_SENT, &chan->conf_state))
 		return;
 
-	l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
+	chan->ident = l2cap_get_ident(conn);
+	l2cap_send_cmd(conn, chan->ident, L2CAP_CONF_REQ,
 		       l2cap_build_conf_req(chan, buf, sizeof(buf)), buf);
 	chan->num_conf_req++;
 }
 
-static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
+static int l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
 {
 	int type, olen;
 	unsigned long val;
@@ -4237,7 +4243,7 @@ static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
 	BT_DBG("chan %p, rsp %p, len %d", chan, rsp, len);
 
 	if ((chan->mode != L2CAP_MODE_ERTM) && (chan->mode != L2CAP_MODE_STREAMING))
-		return;
+		return 0;
 
 	while (len >= L2CAP_CONF_OPT_SIZE) {
 		int ret = l2cap_get_conf_opt(&rsp, rsp_end, &type, &olen, &val);
@@ -4260,6 +4266,10 @@ static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
 		}
 	}
 
+	if ((rfc.mode == L2CAP_MODE_ERTM ||
+	     rfc.mode == L2CAP_MODE_STREAMING) && !rfc.max_pdu_size)
+		return -ECONNREFUSED;
+
 	switch (rfc.mode) {
 	case L2CAP_MODE_ERTM:
 		chan->retrans_timeout = le16_to_cpu(rfc.retrans_timeout);
@@ -4274,6 +4284,8 @@ static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
 	case L2CAP_MODE_STREAMING:
 		chan->mps    = le16_to_cpu(rfc.max_pdu_size);
 	}
+
+	return 0;
 }
 
 static inline int l2cap_command_rej(struct l2cap_conn *conn,
@@ -4467,7 +4479,8 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 	    result == L2CAP_CR_SUCCESS) {
 		u8 buf[128];
 		set_bit(CONF_REQ_SENT, &chan->conf_state);
-		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
+		chan->ident = l2cap_get_ident(conn);
+		l2cap_send_cmd(conn, chan->ident, L2CAP_CONF_REQ,
 			       l2cap_build_conf_req(chan, buf, sizeof(buf)), buf);
 		chan->num_conf_req++;
 	}
@@ -4555,7 +4568,8 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 		if (test_and_set_bit(CONF_REQ_SENT, &chan->conf_state))
 			break;
 
-		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
+		chan->ident = l2cap_get_ident(conn);
+		l2cap_send_cmd(conn, chan->ident, L2CAP_CONF_REQ,
 			       l2cap_build_conf_req(chan, req, sizeof(req)), req);
 		chan->num_conf_req++;
 		break;
@@ -4679,7 +4693,6 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
 		goto unlock;
 	}
 
-	chan->ident = cmd->ident;
 	l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP, len, rsp);
 	if (chan->num_conf_rsp < L2CAP_CONF_MAX_CONF_RSP)
 		chan->num_conf_rsp++;
@@ -4715,7 +4728,8 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
 	if ((chan->state == BT_CONFIG || chan->state == BT_CONNECTED) &&
 	    !test_and_set_bit(CONF_REQ_SENT, &chan->conf_state)) {
 		u8 buf[64];
-		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
+		chan->ident = l2cap_get_ident(conn);
+		l2cap_send_cmd(conn, chan->ident, L2CAP_CONF_REQ,
 			       l2cap_build_conf_req(chan, buf, sizeof(buf)), buf);
 		chan->num_conf_req++;
 	}
@@ -4767,12 +4781,22 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 	lockdep_assert_held(&chan->conn->lock);
 
 	/* Connected channels may also receive reconfiguration responses. */
-	if (chan->state != BT_CONFIG && chan->state != BT_CONNECTED)
+	if ((chan->state != BT_CONFIG && chan->state != BT_CONNECTED) ||
+	    !test_bit(CONF_REQ_SENT, &chan->conf_state) ||
+	    !chan->ident || chan->ident != cmd->ident)
 		goto done;
 
+	/* Consume this request before a retry publishes a new ident. */
+	if (result != L2CAP_CONF_PENDING &&
+	    !(flags & L2CAP_CONF_FLAG_CONTINUATION))
+		chan->ident = 0;
+
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
-		l2cap_conf_rfc_get(chan, rsp->data, len);
+		if (l2cap_conf_rfc_get(chan, rsp->data, len) < 0) {
+			l2cap_send_disconn_req(chan, ECONNRESET);
+			goto done;
+		}
 		clear_bit(CONF_REM_CONF_PEND, &chan->conf_state);
 		break;
 
@@ -4812,7 +4836,8 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 				goto done;
 			}
 
-			l2cap_send_cmd(conn, l2cap_get_ident(conn),
+			chan->ident = l2cap_get_ident(conn);
+			l2cap_send_cmd(conn, chan->ident,
 				       L2CAP_CONF_REQ, len, req);
 			chan->num_conf_req++;
 			if (result != L2CAP_CONF_SUCCESS)
@@ -8171,7 +8196,8 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 			    res == L2CAP_CR_SUCCESS) {
 				char buf[128];
 				set_bit(CONF_REQ_SENT, &chan->conf_state);
-				l2cap_send_cmd(conn, l2cap_get_ident(conn),
+				chan->ident = l2cap_get_ident(conn);
+				l2cap_send_cmd(conn, chan->ident,
 					       L2CAP_CONF_REQ,
 					       l2cap_build_conf_req(chan, buf, sizeof(buf)),
 					       buf);
