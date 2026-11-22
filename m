Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795343719;
	b=jcsaSexDCz7DZ3/4Jw4/ddQHTFacZCUPdVLzpNLESgUnAYpl5MERGi6EPQQhf5jHIHZb
	 RLYZKvH9jRgvghdTZ8Vav3tXbObpVYriwoTP8aT5SmeukeSv+wg/EiYO3SwXlmT/c5oDj
	 wfwB3hbpqQTrOZJGo+kFz9wDriK0jzX+dnUmpFXwv20tZ4JwHws95gtoXP4Mxwd2gx9Ix
	 u+WYC6vTQzr0q1BvxOKYJVn4LaVTf81W1gyYvYOM0ru8B4Nt8QM8/KOhuTXAssHC14ZID
	 G2LWPrNSyxz9AHlbNSPkO7OMa4T2lQt8L4QDbGVMGNgCxB57tKa9+yqNG5BGlDRYOiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795343719;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=tJHb1p2+AfnIHQaZLzHGYAAZ4LLYZuHxSSfcs+use4E=;
	b=wOpIhFAeY74Iwqjxdo7UzjmEhnlGriKz9dtNmgJd46BURqKKSy+C0tTJHvl8+vkw7TYX
	 6RLLL3HA1tgbf+ewcHPSPkboZ6+c3gjcl3DZTF/GQ5ueES4goczIB+MW79Z+dasK7Hy+T
	 cEYXV0UfrYNXAEtqE0Kbvl7A6ND0OQQwfHi3CT+Uaqn3NEQtNp7BR2PWD+xDLI0MuIkRG
	 KKdVKiHqAMiPWvGOFqN/kjsNpGfRmU89I60Hgt4Sj2mjqw83Me7EYfmRiKTi+Moh76Wus
	 yN0KqUsdiG1o+4BMvcWh2BNOh1a1yxEZOR/ZaQfr4NqahGc11DZlQylWq1RfOG43m/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=q08b6R5t;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65638606A320
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65638606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=q08b6R5t
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so17138225e9.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 02:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795343718; x=1795948518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tJHb1p2+AfnIHQaZLzHGYAAZ4LLYZuHxSSfcs+use4E=;
        b=q08b6R5tyuUXZymu+F0bnWMJECWwsNlgJPV/0J0czZcHpabdewOXKW3D+2WUrBWq7k
         VBK1QrBKIQfZubuLpWfcbNKycxNtJZzKzjMSes1hICpm0jXMh0IwaEThpj1lYfHAAhWF
         +0dUuDGs+3Muk7AGG+56Rlee7bjaIARI0FXQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795343718; x=1795948518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tJHb1p2+AfnIHQaZLzHGYAAZ4LLYZuHxSSfcs+use4E=;
        b=S3ODnU3PIflEN9fm1Zm0RaPv6A/KRgKtvBpNaJH3hQtjYNh4woAxOn6eqy8mDZEgTS
         BkTb+ia4HdWQp/C+tJhS8zjZjLun6+3lkASjwy06Bu2pll+6lTxCHuF1oRRvfqScQfzK
         YtN9PfnpJiFYXhFmSvCWNQtfj+ZSVHeeB/aomxiWYvTX+a8BKQuDkw4TDnzDBvGYyhGD
         rgT7M5sfrdIgTwCtED00J3cgQt0eBWTPlPh55TN3WkYW98rpVm3PyfzZlsBRBco92SGa
         2tC3ipD1nTBTtsrILLc8K/ASWdhsMTl/0IQ9yl8lS1M1obt+my9kStxmthTaihvre6nw
         8qTw==
X-Gm-Message-State: APuU4Z/ln4BXOcMlUvn1UBVqhtSa9ddzHwL0D0i9KDfG5Khw7UYyeGSF
	W0f7QqXG6d4VUZDqv5rqhTUXBbq60BF27mIZhwvlBRxqMF5khdNN9ImNzDVn2k663pdQdYhQ0iC
	SkNjn
X-Gm-Gg: AZFdTZdI2BJHSHs8aKWrEZb8MoYD1lIqbe29T7Vx6LCrseuW7xTsrpvDgx8+vvTldTd
	Lwfz7NI/LTJ+kNhzDOpajwsMj0jXrxvkt51A/L5wB0mjexpQ6VXSbAGOYd+qvQUSg9vf649NUgD
	17xC5nngnp9zs3cra2j/8D06rflsulZ73zQGrxQdex7Q8m6diEKGjHuIgNDm6VrEoBH+Y+JaiU5
	mCi3lGQFZLUpV4U08ibaKPIwWESE6dqxFkWgLJ+bBj6bNlY9Dbe7QKJXRms//7C8MnDNCtTh8a0
	n0UVBhrilz0mXhJ63Vpk9cFOdgf6BPY6Y3lPqkZ/c/i0DsZUjX/SbKh45DiH5QMvIIdzMh0JjGP
	UWKKLrztzc1xeaIHiLtedy7Bq8Nc3SKEoT5Ltho4jLWvgduNDQlO2I3EuvYWHGH0Bms7OESnfYT
	1N2m8ygWhuOjgn1GcKVHs7yG6PPhwZ4gotErsBGkS8KCHq1eSMwSYrc9OxCLiXxF5OE/gWCsx8Z
	9lqjiekHFDPK6C26Zrk8rk8+sfJ6fh0gvbd1Upx+F6VK9XJcw4tvOsFpNsB9TO1wHab5rKGo+DT
	sRY8/CoeDfKfJg5pOKx1bqoldnM72aFo+vwsuhbMKqHuuT+7Bw==
X-Received: by 2002:a05:600c:530e:b0:4ba:eb:eb9b with SMTP id 5b1f17b1804b1-4bb8880aba2mr179782425e9.8.1795343717607;
        Sun, 22 Nov 2026 02:35:17 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm394728695e9.13.2026.11.22.02.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 02:35:17 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ] shared/att: Confirm indications without a registered handler
Date: Sun, 22 Nov 2026 11:35:11 +0100
Message-ID: <20261122103511.647388-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
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

When no GATT client is attached to the bearer nothing registers for
Handle Value Indication, so handle_notify() answers it with an Error
Response. That is not a valid reply to an indication (Core Vol 3,
Part F, 3.4.7.2 allows only a Handle Value Confirmation): the peer
keeps waiting for the confirmation and drops the link when its 30
second ATT transaction timeout expires.

This happens on incoming connections when ReverseServiceDiscovery or
[GATT] Client is disabled in main.conf. iOS sends Service Changed as
the first PDU on every bonded reconnect:

> ACL Data RX: Handle 64 flags 0x02 dlen 11
      ATT: Handle Value Indication (0x1d) len 6
        Handle: 0x0008
          Data: 0a00ffff
< ACL Data TX: Handle 64 flags 0x00 dlen 9
      ATT: Error Response (0x01) len 4
        Handle Value Indication (0x1d)
        Handle: 0x0000
        Error: Request Not Supported (0x06)
...
> HCI Event: Disconnect Complete (0x05) plen 4      #113 34.912832
        Status: Success (0x00)
        Handle: 64
        Reason: Remote User Terminated Connection (0x13)

Send the confirmation on the bearer the indication arrived on when no
handler is registered. With a GATT client attached it confirms as
before.

Assisted-by: Claude:claude-opus-5-5
---
 src/shared/att.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 366ee83d8..bf869cc81 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -1086,12 +1086,19 @@ static void handle_notify(struct bt_att_chan *chan, uint8_t *pdu,
 	}
 
 not_supported:
-	/*
-	 * If this was not a command and no handler was registered for it,
-	 * respond with "Not Supported"
-	 */
-	if (!found && get_op_type(opcode) != ATT_OP_TYPE_CMD)
-		respond_not_supported(att, opcode);
+	if (!found) {
+		/*
+		 * An indication can only be answered with a confirmation, an
+		 * Error Response leaves the peer waiting until its ATT
+		 * transaction times out. If this was not a command and no
+		 * handler was registered for it, respond with "Not Supported".
+		 */
+		if (opcode == BT_ATT_OP_HANDLE_IND)
+			bt_att_chan_send(chan, BT_ATT_OP_HANDLE_CONF, NULL, 0,
+								NULL, NULL, NULL);
+		else if (get_op_type(opcode) != ATT_OP_TYPE_CMD)
+			respond_not_supported(att, opcode);
+	}
 
 	bt_att_unref(att);
 }

base-commit: 1adfe662efeff12997df9ddd0960dbd0de9c8ea7
-- 
2.43.0

