Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946845;
	b=ig/YZoFrQkXmGnY0MzRjnDB2vZyduWXuPlwEnncHsrVfthl6RR9xN6STHosN5LiAMIkr
	 txSRCJvvywbZQKdNy5M83fX14KE1QmHr3ELpGRN2QyQb78/dhnJqP6eksUbvz7sFwGMyB
	 8mAZzepAbb8EZ2g1wyAh5eUAVSjj6sQmOxCD9Ee7bZiBM6ZIKRj147lBxDyNrPcVojCWX
	 E85XF0PZzRtHMKEfqiGkHd9qcC9rUPOq1TqttD99Hht0GJRCAionkJkupKgIyhIaMuBPI
	 VNAE7I6TaMiYGJEnVs4TnhmqPhwnc/67/xy0shq4Jmgfjz4uZ8kXS7ije44KHu+YDYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946845;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=t+JeSLhbAjJ4UKH69xAf4pF1rbRDYbY69wlecPbzVlY=;
	b=WR1ctR6i8vDu6PefM3ilx1Iz8LN8H/cbVUegDRHZ6PHtiasJBbDKFyvyk/j5kBnK9ES+
	 kxVbsjz57yn78KwEWPWbPun5rCQhgqAEx9DpYBWhUbTW2MTQfEv38o92e3weiVDPNVx3P
	 sk5Jsbxke0n42VyOKHTWw5YFO8gKk2uJEyWcQ35S4m5g6eyvSE50hHFIJb1vpRlfXVHD/
	 l7bOkY8Hri0hufw28YeS5zSkWfehMi8q3Yagt0iGPMkrn1qk+Npu7f3bY5QrDUTerKV9a
	 keNrYb39ffp8cciA5sxDrhL1rB8+WiZR4GK4qqX5466+0BMgt0G08n6hLHKd6tayf3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xh+7DwHo;
	arc=none smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE58606A333
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 20:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EE58606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xh+7DwHo
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9906a5410f5so1075765241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 12:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794946843; x=1795551643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=t+JeSLhbAjJ4UKH69xAf4pF1rbRDYbY69wlecPbzVlY=;
        b=xh+7DwHoZrmwUn5pZ90v40ZShhqok7zwvDDFCdU3iLsd6s1bU68G8BV6vsZh169zjW
         6wg40KVnzZOn9o7jWJJ1cQa4ghvcAEtWHCtvg/pTCbGs4AqTx144WrnInhknQvMTJFPQ
         8S3PHzwtw+7GaAIAqDn4IX424u95x2JscVubbi/0MnFUrSJWQrPRW2jTnec75Gw7VP8L
         9DdBBilHnvAE8ydzVUuZF5DKknxrOK2CSMCd0tesCnVlz9sDUDSJ0qCv2/GbQOgN+sXk
         iY9vfO2pxWGFH5H8aaTuzfl/w5rKQBi8iZwqp9135C0tCi4WCzhyh3q7Tijy/RyvEfT+
         3vUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794946843; x=1795551643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=t+JeSLhbAjJ4UKH69xAf4pF1rbRDYbY69wlecPbzVlY=;
        b=PwlGHU+aPkTW3qz3e1a4N4E/5Ul0L3QWNpw0Gz23vlTVCfxaVXlep2WMAD/kIAyLgJ
         iOuFPP8s9muNwDVkPoHmWGwo54u6M3+bWk3J8xKRbYW8Zmebn2GJGqf/oE+FLQu+ABPQ
         BG0oGswRjw9sl7OBwLj2qmRznxBCePhW3xe6OaKUcLtIxq1NF1bz2RZTgKh+lIHBdhKl
         Wlb6aGNvN9j3VhULuqthuzkUU7mtSR5l1Sqn+I9vFNGj1hxCXZc3mnwNW6WxLpCDFQ/7
         MuxRokLRl/61XbVjh1UJWp64HjtaywN66EDdOrm2xqO1oAibNeTB7ltner8m92zcldTj
         j2wQ==
X-Gm-Message-State: APuU4Z/ToDDuYI6HElqqrrTjD3j4DRs357PnXCTfDZ7b3TsM/DrrtiHW
	axf25v3h56+V9D4xvvS2bj7OTXfnPjvBP3D/pYTHC+Muq70OefIFVlbwBe2IFA==
X-Gm-Gg: AYBFou1gh9xBTpS3cEKpo/bk3uJtRXamzigjT72hnG155CMX+bddqw09s5KuNHcddG2
	OdUFZzQfrLhfP7iZ1s3UAU/6LNbxHu5G2+gqAc8KTEdTQaj/o1VtehCC9LiBh0TYztpiikTwdeR
	A5gglURTpjrARyY7CqwPcuroH8h/m8MnS8mJL4rL+D2Yb1NSPKyqn8A/qcrBREIoOAlu26h2Gv8
	HK+s6zBokE7eRAQA6RFw/NUNjQpEPkxj+n1VHxDGMj3wDL0aOmFPhoZI6BFRSB4tFjTVZYz0Tav
	O2psvxSlfKqcjucSQXtro1Ix0uVAA7RHgsdUBbzDy7lgu3mGKqpK/St5MvnH6XYA1QLQtkrLbps
	Hb1YPcaKIrnXp72viEQi27p2wUluQiO1QmSorJEaqGgi1RPZp2j2hGzbXQpTB6Bpl65f9PzNkmj
	5nNn1ATX49TINuSIS9RyDo0MmTAr+ZnO8FMJiYA207eWf3S/MrsogC/TDBpDjlp/5Y07eiYKYgf
	foJZmZNyeWlu4sYKARIxYx321dilCXdvwkIo056SJd5B3SRYWTvudk2PAQ6qGXvf9+lN92Z53R4
	mWNDeJwIJg351CssJkQaTTQV/Hwn8aJXFQZXvwoOk5C9m0OvhBQvue4F8MTSECa9aEhG0h0mO5m
	NmeGPJqV0WMmF9XD8s/ui9e0eR1ncvuDdGjzlSSw3oEFe+uY+69kuJpE+wpTozdpt2fhzxUtZ6N
	S8huM=
X-Received: by 2002:a05:6102:6042:b0:7c2:799c:9018 with SMTP id ada2fe7eead31-7d6b9ed8ef3mr51359137.0.1794946843486;
        Tue, 17 Nov 2026 12:20:43 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b935ddf3sm303166137.11.2026.11.17.12.20.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:20:43 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 10/17] Bluetooth: L2CAP: Don't use uninitialized EFS in l2cap_parse_conf_rsp()
Date: Tue, 17 Nov 2026 15:20:25 -0500
Message-ID: <20261117202032.3848411-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117202032.3848411-1-luiz.dentz@gmail.com>
References: <20261117202032.3848411-1-luiz.dentz@gmail.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The local EFS values were copied from an on-stack struct even when the
response carried no EFS option. Track whether it was received.

Reported-by: sashiko.dev (linux-089f015e-6251-4fea-85ef-7d6761e8c457)
Fixes: 66af7aaf9edf ("Bluetooth: EFS: parse L2CAP config response")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 977b41229a7f..6780af1fd4e9 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3892,6 +3892,7 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 	unsigned long val;
 	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
 	struct l2cap_conf_efs efs;
+	bool remote_efs = false;
 
 	BT_DBG("chan %p, rsp %p, len %d, req %p", chan, rsp, len, data);
 
@@ -3947,6 +3948,7 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 			if (olen != sizeof(efs))
 				break;
 			memcpy(&efs, (void *)val, olen);
+			remote_efs = true;
 			if (chan->local_stype != L2CAP_SERV_NOTRAFIC &&
 			    efs.stype != L2CAP_SERV_NOTRAFIC &&
 			    efs.stype != chan->local_stype)
@@ -3985,7 +3987,8 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 				chan->ack_win = min_t(u16, chan->ack_win,
 						      rfc.txwin_size);
 
-			if (test_bit(FLAG_EFS_ENABLE, &chan->flags)) {
+			if (remote_efs &&
+			    test_bit(FLAG_EFS_ENABLE, &chan->flags)) {
 				chan->local_msdu = le16_to_cpu(efs.msdu);
 				chan->local_sdu_itime =
 					le32_to_cpu(efs.sdu_itime);
-- 
2.56.0

