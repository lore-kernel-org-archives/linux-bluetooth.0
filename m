Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793156475;
	b=inGfzjLRmvt8n5KyZLopfx0BmjqxdFBuG0jcg1iOvfgnqQTCEWo4M5rzmT4D8QOY21Ni
	 /bxQNA1e7sH6XAub66J4iLkA3WXucihhIO82xADOEyhqZBcvw5RTf3EsEexPoB8EOKYkK
	 RVmf6Meeb7a8iDUs0AAqS801OrtOQG5IPwLP3gy7v2o80+DN6kxS5FOTH0Rwdx/yOnDP7
	 TYgqxRYvtuAmt43XorOetT39ynEMhzzE+trhZhqRUehG9AaY8xOcS1weCZa/G0r58uf9F
	 mjvIIq514jHOI4TXQbuGU2GpGFckExxzBveaOm8mEa64gHVWFCg16ZK4xFyIbU7r2xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156475;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=9PnFWzT4ZetD3ik9zsui77LQ52Y8BICw8ljy81KMriw=;
	b=lTuHLqBfRyyXxG2P0eqOy80TY3o67AZeZdY9QeEXsrhrrrGyQ2DiNagv4OYnWbyLReEh
	 qvEIFH4AiuGJgYjWhB3KW9kyDSzdGR8s0q4nu1HNKRCaa2D19wB/2T1ZL1OCdKCQjBMKs
	 7qunRnSUKxRp/ILXBnFh5Y3mbq/zxIUAfmMXvPdvijvRNh96QLz7eyatgtnmcporJmr5d
	 KASrI5s8c/pN0YL/vxbGzUMOkhl7VHUveMadzIYQAr9YwGS1XcyHoN7VQrOTNIlOWxlpq
	 CSk+XWd5GIPz7MEAHrlwxG4MuHbZDvO6RDDcnRKVm49DCUymsiHDvqzHi8rSVb0rcQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=atjFsLOB;
	arc=none smtp.remote-ip=74.125.231.130
Received: from mail-oo2-f2.google.com (mail-oo2-f2.google.com [74.125.231.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBC8606A31A
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 03:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DBC8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=atjFsLOB
Received: by mail-oo2-f2.google.com with SMTP id 46e09a7af769-84abe8ecec8so186697a34.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 20:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793156474; x=1793761274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9PnFWzT4ZetD3ik9zsui77LQ52Y8BICw8ljy81KMriw=;
        b=atjFsLOBuMbhXbFgurTKb5yps9bMzFMF3XR2VfFg1jqtE750QWEliiQXcw3DMlbmFR
         x4Avb5z6Qc8OQO9IQUJXjVdWxEKsPBdqrflWWbQ9HBO9DKAwWlZati+SgAgfE2uNVpph
         K5p172iUgi23y+peyB2Dc0iXaLOjIpCQ6BtgYOc2bFbCbx/3q79y2EEVF2c+PyipG5ox
         NioY+xFNtEZxaP25kxifO6cWoj74+Sqig0DatRlkr5KPwWX6zygP3dX+BJ8P6mylsYFb
         ePd6HCptISXu9Gd4botRqG7RQnsThahG6ebac+A5iFn3ZE+kWJPBDO7napx2PI1tBEd9
         jvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793156474; x=1793761274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9PnFWzT4ZetD3ik9zsui77LQ52Y8BICw8ljy81KMriw=;
        b=FYJgTrRb64GBbnHpXwgI5b2LrLxw+/s5h9acOVTxxosmMjisXorp0GyGzr53uA1Frw
         x5Ts9xXsgXRPP6LL2afpsPYZ6pt33oJ4v3nxaufKbiCFdCJD+Pg66YaSlxHGIS0HO2ew
         hh9xIkj4wul1qqrn1tTLAUKm8jjk8akzI+nbP7yxjH6LrhZQiEE5QbpMwl+ZRdbbO5fB
         2uJXq9HMlHQsAjdxZ6OGfmAsPEDDT8x/evM5qrzDKDDfJ3vnhr9rRzHMN1FW/iHhjNn4
         4GZvRu5A7Z690bmceXLEwDJbEV2TjzGcbQxDnr/mkggYZMXc4p+RyeGDZ8p4eHreCEFJ
         ZqPw==
X-Gm-Message-State: AFq9FYKOLsXKi0ZGtWKm+lfs4doEl19pwwf/Rw7Hs+IMa9xDcUO2AGC6
	BXJleN/OiH6C/3VMwnDrBRYGKPVRWWqhKHyzOwOMAyMJF9L7wYYTPMTC
X-Gm-Gg: AYBFou2Mq0O38SwWpJkUDHe8llu1ikx1ES3mDgBAKG81C5mL5moLQIXJ12YMYLbdtR2
	qgvxfyt7y0t0cyCTGT9lZxuiyOmXXj1a9phc+4RaWRFd94Uy64f2t8U68iZ1sBK1GhQN8KBVrMZ
	0gCk71a2/WpYf+rZfEyz0uzuQqJccQzRnur8Yi7qRlH/EgnFuaiUWvR83jPkLkwu2A5sgqTnUFf
	gbM70BkLR/iVC1cMKjhermhvEcdQZCZeEDaL0hYc4hqPJ0HCGQCOvJ6HhlHcL8zSuA74MFhcUJa
	q414EqW4OU/A3j+3t+jkblU+IkKi4Z6HICuIKpWboxX/KO7q6SCQw03/LQ12ZCnFsxTHHkxZAC2
	PlODlVxQjQ8tuHWjM2FrO10Z3pRkJF2vrIbC/aVkDE91W9qwSgO3uU+I/0sPqlmcg+nmyJPRyge
	qhPq1RjwJeve2HlLyUVUcsSEu3z9p4P8gYKmStRVrNWLLz5212Y2iU4S1XmnG/2ptFZdcObpZP6
	98iXT1lfmg9Jqow/dAMbf3bOszaghC8ZefnKeJmmHvStPJ6PWxnQVuHqYRihQdNMcDB0qpCZFS+
	TQr4kPGXNAWEZNlDDHv674S2ccyZcO6/Wbo/4xbG5XwkMthkgihzuFCEQK89uYaVt44=
X-Received: by 2002:a05:6830:2701:b0:7f4:d1aa:2f32 with SMTP id 46e09a7af769-85ab753d198mr1238284a34.11.1793156473961;
        Tue, 27 Oct 2026 20:01:13 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.180])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216574sm470580a34.20.2026.10.27.20.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 20:01:13 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH v2] Bluetooth: L2CAP: fix memory leak from repeated configuration of a connected ERTM channel
Date: Wed, 28 Oct 2026 11:01:07 +0800
Message-ID: <20261028030107.2213982-1-bsdhenrymartin@gmail.com>
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

v2: Rebase onto current bluetooth-next (the lookup helpers no longer
    take the channel lock, so the config_rsp bail now drops the
    reference with l2cap_chan_put() only, without
    l2cap_chan_unlock()).  Fixes the CI apply failure against
    bluetooth-next HEAD.

---
 net/bluetooth/l2cap_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0000000000000..0000000000000 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4591,8 +4591,7 @@
 
 	lockdep_assert_held(&chan->conn->lock);
 
-	if (chan->state != BT_CONFIG && chan->state != BT_CONNECT2 &&
-	    chan->state != BT_CONNECTED) {
+	if (chan->state != BT_CONFIG && chan->state != BT_CONNECT2) {
 		cmd_reject_invalid_cid(conn, cmd->ident, chan->scid,
 				       chan->dcid);
 		goto unlock;
@@ -4709,6 +4708,11 @@
 	if (!chan)
 		return 0;
 
+	if (chan->state == BT_CONNECTED) {
+		l2cap_chan_put(chan);
+		return 0;
+	}
+
 	l2cap_chan_lock(chan);
 
 	lockdep_assert_held(&chan->conn->lock);
---
-- 
2.43.7
