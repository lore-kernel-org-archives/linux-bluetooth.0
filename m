Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793113468;
	b=Q8CsnFtIXWSU0O0kGltAcDMBQZDDCa9SuUKhJxEaMNCl9/Ld5itX14QGD0qYYrt+bbuu
	 PgR4gjS5toJ0+vnqxDmb1zYQwPuiLnGEVfkRMdjWMF/tiu0kxu5xo3Yi/NL/EEzL+EEn4
	 BcTFcylfkyUyjHRrrkN2yakDqSBnTfmjvJS1H80ApFijeI4lPv1f+oE/8I+MheN0/UneP
	 HNOY6r1jljG9A0IFa293k55q87C7zwrRXsufxQXDGb+H9216AyFJ+WfRJQQqeKYjJo2RZ
	 7F+bs1xP8fs7gIL8gLCdQS3pTLP5fTywHahLFB9OscinqLeLEvoZAssyAaBRg4X5VqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793113468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=+XtXpqT5FEcCOgiw9Ofa4pd6QtfZfviQBxyFezmRJqo=;
	b=e41KVW2g8P2IUCixIXfbcbfP6l+CuImssjxTZ4a0Pkg6rtQIXcwFwJWlmYRuXs2upIfz
	 tGpSa5u1pvOXacF013uof6NDT7QCynb0Ly0CSkwO3vxxnrGD9N+hwuIvd08WYFur5aBXW
	 G9qAaU15N5cPRC5PPjmxlabeOjfb+9nEalBfEUH6HimKpBF30OydjQSGf1ZatwTka13jB
	 DfE4VJyqBT1Ju6OgMLQY9o55/qHMRpn5ovvbNcuII0viTKWGlrhKp6zffviTq2hTvxTM/
	 nuJvyhFp/pMs23jB5vmifEqEPI1Plg/u11WgSuhLoyAoPX6lHdH0Bub1yxLtmKnLqtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AQf6+6Bx;
	arc=none smtp.remote-ip=74.125.231.130
Received: from mail-oo2-f2.google.com (mail-oo2-f2.google.com [74.125.231.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3535A60A2604
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 15:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3535A60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AQf6+6Bx
Received: by mail-oo2-f2.google.com with SMTP id 46e09a7af769-824f3901d55so4568509a34.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 08:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793113467; x=1793718267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+XtXpqT5FEcCOgiw9Ofa4pd6QtfZfviQBxyFezmRJqo=;
        b=AQf6+6Bx1UX3xOT7oQVjv5r9sYWhX8WV13c56tZGSKSDRCu4xL1MthyWQoqseGeaku
         ZGRz1e0I+h4JNGJ72AU6zJF+RxjMkKlT8G3ssX4jpj3cakliQCoyr05xhCvF34bzsZts
         u8i06m0lqjLAKpYtdQ0X1n3gG5XRjSa91qE7yvr3mU0fTe8jKMwxHOL4EvFKYOCiG8mD
         rIQv/LeV7Cw57C7JJBh+MU+Tt+bZvN1GgldoPp+OBB3HHpu1amY+bDr2MbFAPLRgn9AI
         +ePvGLlp/j1Z2d9SbsblMdCMKtJqSaBY35Gr6KT1xnJtimxNlfofjrUxKVq3QX2SePCP
         +3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793113467; x=1793718267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+XtXpqT5FEcCOgiw9Ofa4pd6QtfZfviQBxyFezmRJqo=;
        b=z/VtEFxJx3LdVm9doN+UNo0V2cW/IOm7yTssBV7+zOF1SmoiQHbJ/yyh1cyuIouZSl
         jWBTw0Z46xukdQEI06wNfnLRHDKbtxLUKbLVgFPEKFdk92KvmwRxCCamEq7u3yhJEkfI
         2VyKEEtZlBNhhU7LDfv2vOk+nFDAYOY+kSdj6L4zwjECXAa5bbGDB1xpqGbT16SAW49R
         Nwo8DIqzVJ/aS+dzhcjgkQmPA15LVUyZuQL6GwuZjwa8g89wz/fo3bC0LX0tNnxqVqRD
         Vi9/hAf7ToI3zzCRn7TKyuZtHP1FGGyyM1dAo55kegzaVFt0rjEkyntEWfPgnqIZGCtE
         sLGA==
X-Gm-Message-State: AFq9FYJlulwSCHq4TSRZAqEhk+Pq+RFhTpreVToo37l3VHeq3NmsBBhr
	U/zOcBgrsNeJAj4qeuWMdj3MNaLbYJM4SuUWZ+j9f44ftzOMZMfV4B0rMK/6saCebbA=
X-Gm-Gg: AYBFou1jARRWLS+g2zCRe0PxB4HSxi5WUElrxCKm8BqlLIakpWvT/Ixl4LUUcwVKT3r
	cP5CbMViXwiWCwUyORkxDvaM3FRmEtZwtvvbtI5IzllOJVXNHf6i59Exn5VAJ2nGedS91NWT/VS
	BPRGj63y3kWmOPzw5oX4hzjWR3Q5AZNBvCZUQ0nUlOnQerIlQ6/gZdtV0tsFgLEnVGc1s7yZq+C
	CZiiEMarRJfemyjIpNCu58SgaAJEJxJYb1lLGl+D+0Dn8t0Q47F6LbpQ0jm8KR5koHsNKZnOoV5
	tQW2bavqgE4xy+ZoBNqwcx9qotpmGRni3J4E/Zgc8BduKep1Cu0ozJqNlHmmokCd7qc2VXtgaqT
	bHU7Es7gmWLyKw6IIpXD19ZUuY9vNVt0n64dvpepPGnTUGAOm3eARkcppaZU9XKhBeArY3AUdaL
	z3m2wpx0zdyXDeHjBTwF0PUOkWbArAPRg/EfwIbGvabJiXHYt3SoLNE3R97exfUYfHyRjaJEJi9
	PYqtVa60OBZAloYqb596VGNDOm6uQt0nwZA8/NgAY7VgIfGe/mce6aC0gEzcC2lGQDNwiuLXign
	WMhhRq+V+yWwwPNV9w==
X-Received: by 2002:a05:6830:2406:b0:845:7cb:69f7 with SMTP id 46e09a7af769-850fae80212mr8574590a34.3.1793113466823;
        Tue, 27 Oct 2026 08:04:26 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.163])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fbb25f59sm10837058a34.20.2026.10.27.08.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 08:04:25 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH] Bluetooth: L2CAP: fix memory leak from repeated configuration of a connected ERTM channel
Date: Tue, 27 Oct 2026 23:04:17 +0800
Message-ID: <20261027150417.942699-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
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

l2cap_config_req() accepts a CONF_REQ on a channel that is already
BT_CONNECTED (the state check explicitly allows it), and
l2cap_config_rsp() has no state check at all. A misbehaving BR/EDR peer
can therefore drive a connected ERTM channel through the configuration
procedure any number of times:

 1. CONF_REQ on the connected channel re-arms CONF_OUTPUT_DONE
    (l2cap_parse_conf_req() sets it on a successful parse);
 2. CONF_RSP(SUCCESS) sets CONF_INPUT_DONE and, because
    CONF_OUTPUT_DONE is set, calls l2cap_ertm_init() once more.

Every re-entry of l2cap_ertm_init() leaks memory and resets the ERTM
state machine on a live channel:

  - chan->sdu = NULL drops a partially reassembled skb (leak);
  - skb_queue_head_init(&chan->tx_q / &chan->srej_q) detaches every
    queued frame from the lists (leak);
  - l2cap_seq_list_init() overwrites chan->srej_list.list /
    chan->retrans_list.list without freeing the previous arrays (leak
    of two kmalloc arrays per round).

Normally l2cap_chan_ready() clears conf_state so the re-entry cannot
happen; but l2cap_chan_ready() returns early when the channel is
already BT_CONNECTED, so a peer that keeps the channel connected
while replaying CONF_REQ/CONF_RSP pairs bypasses that reset entirely.

Drop BT_CONNECTED from the states that accept a CONF_REQ, and have
l2cap_config_rsp() bail out when the channel is connected, keeping the
configuration procedure strictly pre-connection.

This issue was discovered by Tencent CodeBuddy Security.

Fixes: 96298f640104 ("Bluetooth: L2CAP: handle l2cap config request during open state")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/bluetooth/l2cap_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index aaa2a1cd489a5..ffd771a799510 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4382,8 +4382,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
 		return 0;
 	}
 
-	if (chan->state != BT_CONFIG && chan->state != BT_CONNECT2 &&
-	    chan->state != BT_CONNECTED) {
+	if (chan->state != BT_CONFIG && chan->state != BT_CONNECT2) {
 		cmd_reject_invalid_cid(conn, cmd->ident, chan->scid,
 				       chan->dcid);
 		goto unlock;
@@ -4493,6 +4492,12 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 	if (!chan)
 		return 0;
 
+	if (chan->state == BT_CONNECTED) {
+		l2cap_chan_unlock(chan);
+		l2cap_chan_put(chan);
+		return 0;
+	}
+
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
 		l2cap_conf_rfc_get(chan, rsp->data, len);
-- 
2.43.7
