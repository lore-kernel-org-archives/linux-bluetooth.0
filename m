Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010730;
	b=FCWLl2C18SqW6LvZh9BG4eBvfgRBwICzmReePIjmsDOBE5a9hQaxdcs+nHOdZfK+XhM0
	 rGDGK6ayeL4O7vMmdbXrzFZG/9lU+aknaRU9K58fOMDnS0Gaqsspqv+TLs6VGcoVVfJwN
	 3NviQAnfrDPjE5aRQoJShLXa4l5lZZq93PUoMA9ncWlrLkV/ZgIIwPPXfg+oiDkZVoFdF
	 YsFeq0ZOCiU4U4uMVz/FUYP4YoItidd42iwAWL+xJtsZ8t3CVLX35q6kMluzfXFiTXMF+
	 R1cm43l3TTyBL2y9A23/IWYlPYSo+1Z+U4QMnCXnoldseRT6VuJq9XIpd7t6bXsfMQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=t+JeSLhbAjJ4UKH69xAf4pF1rbRDYbY69wlecPbzVlY=;
	b=Ueb0YfqX2Upvx54FOwajp2rCqBf79nLcOmuwGhE46PihAMb5d9WMRQxqttKJehVXqJx+
	 OdC0ZSEdjV4uJWzM9Gnu5SFaojQmOW6BDwKbt28NGTqP491kmzKZfdBALdeOhiMzLnztp
	 OzVa0V+5gLGX/cnclqMvlgd9Hjmt2Bv/RiFB21ZhMo4f2dd+5OF6SihhibTImRtu2WXj1
	 z8DAaWr7bqGA2h/JHLRqU0hRFEPMoG31M5cI6eusjPX/bAQNghYV78J80vg36/akrGgrm
	 aFnhSmLynTbuHAWD98L2nxEFnQf/qrJHlpOJ6UZ/EkdngslJOh1sOubSeqJmNRxdKhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BNmFii5u;
	arc=none smtp.remote-ip=209.85.217.50
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFDA60A260C
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 14:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EFDA60A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BNmFii5u
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7d2dc1ac787so303709137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 06:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795010729; x=1795615529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=t+JeSLhbAjJ4UKH69xAf4pF1rbRDYbY69wlecPbzVlY=;
        b=BNmFii5ut1waASbRUBKF0N8a22PlR8Rb2iAvmYvTPI3WmBj05HIrRkEbL4cANY1m8z
         KAgjHUqLmbFZzyVSBuC34Xv6pNJ4HhV5up9xGAOUogJtmj74JqL4BLtFwMIdAp8JF5+j
         h3MUs53tYGOCbb4pCPS1D4zmuCdbvZCbPQFKYEEaW61e/Ta+hbJhRjQEZqcBSaK+oXK/
         /YK+BzIIc09n5zFVQjls9lmu2JkfnqMAzklGEM52i+adM7dbZnx/pA+qbhEQhARwjaVT
         FJy50r9OUX7oFh2Q8ByUsiGXo4TjDWX7BIO8K3/nS+Dmq9c8F0StQlj7+0HHcnq20aNE
         Udgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010729; x=1795615529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=t+JeSLhbAjJ4UKH69xAf4pF1rbRDYbY69wlecPbzVlY=;
        b=HpdzswgbLtlUn0EYFYgR22LnJGEH60o2vBhXG8wAaoHFrfsqdhj6REnh6rlQ2hk2wW
         nizxEbRMqEixDBB7xa3o1/4U1ORwwk+oAFZyDVPqk2BXLYM0JcTxagxNY7Vah+/lmEYv
         3ZzYopUFh7oHb7+yZuAiXURTIfhf+HSQoWzQTyi62OdeGpC+ti5kDXsIXiV7rY2wp7tC
         aospCpP7c/HxLYGZnhGANeud35Xi0o9I97IRfEzqj0cDDHcrjc9NXs17Njz1hLU/vgv0
         PYazb/xmqdrQ9cVWwzgeaX7vJ895LigewHi0jywp79d+sKDy4rBJvy8azEwU/xTyZnQ+
         CztQ==
X-Gm-Message-State: APuU4Z/5OaLPHy/Yk8Nqxm287vUzQqxN8E1EmzlhC92CF6cJy3Bq54L2
	twNQTqAn8/x6RsRkmX3Za9N5Z4UIgNcJZyrKJwZPyROsEqJhyANDwDr4/eOhUgVP
X-Gm-Gg: AYBFou3o5oLHycycacV9IEut9pa0b4BSJL31fenVhiSVw30m+i33g40g3ktIC44TL7M
	IkUJyHhPY9/lpEazpXHzuzdr4SRJhTkvatoM4kxGNUeFC4YUoz3Tlgk6rQVRp+if6XLFWlJYvpd
	ePgIfZxPUgvQs2g7zyd/Jz7VHU4uPYG8ZXnM760q7yOZrHB7linWZEgtHyjMomLTR1TalUJWRV6
	SMG4UOM8GUPSgF/qgWuw0jthKbdXGB7W7rmCA90B2vXDaoMhKE7/AE0MWG6JMEcJZJ/c1BbJQJ0
	Is1x+NQ7ioblBrYP+1F++Qo5xsCaKkbY2Ku826nRNFdvVP5xG9o114uPVz64OMySoEsqv0tATlH
	LobTyAHABM32p1upZWEIzgYG8JbZ1BlK93jhtBIZwm2yQGTGl1ArVfJBwLb1qJpc1AcFspZzlmE
	TMdVi2+IXWhQ+VuoORvIssrKSr1mve9elpsdL9Ci0pKPs+bi/pxe7+CeoWKCYvt4Rtu6wJSU1tM
	5Al70bsHnTsv7NiA1mRcnaC3cjs11QgcroErWyb/rfzEZ2y1Qw+4WnYLMhnJh0ZNS9YFdfXqGmK
	ri63BiW7kX93Riebnfz8e1sdTmrjxOeDdeJclDNyOOcgxESzfDbiRKIQ23xdZtP2ylfet9ncIy6
	ZF/gPP9gqlC41I5pLbNQvLX2S51vc/36jzJbW3WIQS4xzec9Im2xgw8ZY8ugCxN4jag==
X-Received: by 2002:a67:e7c9:0:b0:7cc:2152:4f72 with SMTP id ada2fe7eead31-7d6ba1c56e6mr751939137.1.1795010728716;
        Wed, 18 Nov 2026 06:05:28 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b914e10esm1697639137.3.2026.11.18.06.05.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:05:28 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 10/17] Bluetooth: L2CAP: Don't use uninitialized EFS in l2cap_parse_conf_rsp()
Date: Wed, 18 Nov 2026 09:05:11 -0500
Message-ID: <20261118140518.59878-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118140518.59878-1-luiz.dentz@gmail.com>
References: <20261118140518.59878-1-luiz.dentz@gmail.com>
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

