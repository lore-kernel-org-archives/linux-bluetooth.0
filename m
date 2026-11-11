Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429472;
	b=xJU8F120odyRJAUtplynQ8OHpH1bV+cJlM9Hdw/IJ6CF0Uug+do31vZocQSbqhAXUMl3
	 3Zf7Qjrp2Jhe7MFDBp+gUGdSmEhZhKe+GG8TP5ypg2X9hPmIL8vO5a5F8QmlnHdZYEqAR
	 cLG9onuIlY+pnhSsNrzdTsOJeL+7PdgYORt52HWrG/nqzeybI16Gy9UYB5nFjRn/0ibln
	 S8rrERQdFiM1CPBrs/wli/3uojNrF0XTk0BVUz9lM+Xd46VYPX28p96ldJIHri3SYPfQQ
	 u/8ppBlX7sDZb1RWH6v78UcsqZ21UhWbQTM2CIkYzc+zDqWGynrqB42aA9G/BYyu1qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429472;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5V07kZtTPYabGRmB0J7JQ2iH4jJxJYzlNAm5oMkeypE=;
	b=egUjemfoZow2TmTLi8RkrpyaoOdJuOMTbtbO+Uv8Y0g4Z+4sQ2sKSXyg9PGaN/LJRkuz
	 HI+oQFdhB15uQgBv9IfxOJyzADr9G920qYjV+ui+xPXApiIvRt6/xEL6l/gI+bcPAlIdJ
	 xrhvOiMubArMU78a8Vrt0lJjRD5FUV1qB3xKjPEqEOTw3lFDQ387zZVaqUqNiABkZ8l/C
	 wvuStYcaVwXw/AKENtXeEpIhWA6IfWP2ym40x4YWuwaBpQKttRKeELUXLikkojl21htyh
	 TjT8k1YYuGGb+weVBWFqlEALUIA8ygREG1ZbnI75pNCCq2FOb4Ta+maPwLGgSNfotsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bQ2iuOAd;
	arc=none smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4995F60A260B
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4995F60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bQ2iuOAd
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-74ab99038afso2741667137.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794429471; x=1795034271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5V07kZtTPYabGRmB0J7JQ2iH4jJxJYzlNAm5oMkeypE=;
        b=bQ2iuOAd/OOXKCnoKWz0MdxbAUtaMdolkkdCZfyUhwGzo42Nwm63rX+zscdSt1Yokv
         GJwrh11Vqzh5e3nE58hYOxpTaDR0jd/vxH/L3cP7vdMFKgmOa5lhK38fDj0jjE6nK8Fx
         o3J0699Zsr1R81hMAdhl9ooWxN1/2P7dkOJPjB4Go0xVSjQW1jFWT9lG+3amVeCqxzMn
         /cLYmZ8mNKY2B3O9K/vMy0Tkw9/BGjDPXtfJGL/MyXopQSTHsonKBqPmcohAAj1tpMli
         xkE8cHIhI3ngBCgCLyzoy/XsobdsfLoG3ai1ZVyWOl4UkBkhSLk67ZFN5y+yAxk2Wd1E
         40Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429471; x=1795034271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5V07kZtTPYabGRmB0J7JQ2iH4jJxJYzlNAm5oMkeypE=;
        b=LKmNQYN1U5Yic7JKTblnwwTHfg7NbhDKdNfXbuo9/XNItFpCqO7u7GTZcp0lU2JVy9
         58OvSZk2cub2I3/pGvCjWEnYjKwT4uaYRktcrJId3ZbzGsYk4qaK7eM22ehbfeezO73L
         yt8LzNr8fbMRZaBSncoJCid4evWc+Wof0KOLn4x08ddPRmPkMx3jcVBhDKJOkB6vcGsc
         yUQct0HdPKZRy8voEiVFukma1zHZ1VmpRHUlPlbR9XCGVUF1mMPNB4v0QtIRJBFi8X6W
         5Jd7LSvNmoXpWU0p3kCt2w6P6BHE316PbguHJ5659Hkn26HsVI4/7I/vQV+Bhn8Q/kSB
         fRhg==
X-Gm-Message-State: APuU4Z8GIQzXPJ8gg7EA3E9/gn4uZx/0nBagNNJcy/GiDynUtY/Q4tY9
	z9bjweL1JsE4h7wR0S+0qJp2l/7NmUiTu5sml50OVmDmIfaTWSvs7MVJlZtwUQ==
X-Gm-Gg: AYBFou1fYmiRzx5kO3jolOJ5EL2zhyNxfuEbxZ0xUcebKSOaURXb3znW9FspUOjZh/g
	STptMubqLnWu+ShKhFsLWgGyIDWF2v6AOzrVOGdeF5ITJDrSkSbKRkeHwawyvl+GfagEuu3BrMO
	mfoenUUV3M2g9EOILZMcqpAkf/nnqRncy6BV8WpTuZCt3LlyAZ2n+IjIjyby9K/rwCvSrolDcRP
	A+YPZg0yNkNeMZ3cN5ulaehaWMi+xWCBUmzHhHwFUmpAGLQnqq/vm+EKVYjZW5CvvWE/7MH8dnl
	rWzpQWuf5rwe5pXx9Q5e3e3UggP3obQb10/Tgx1WykAxyIHpotBMStSJ6Zxc/VeKzgO+yg9tAmC
	5fNu8PgvKcD9ojAIxYAx98Oo+9oaMrDnsxHkFHrb1fUixr49tHGoDsJFDUbT3b0BMJ08c6WFiDu
	iNxowgzzYQopQq/8dPkAnXHn9PhVBPKixqxp2wHfHF8vUZi+Gni/KWxFMoa3O1aqd4RTIT1euCB
	3302k8D3mpqPZsJ74aupKS33K+Xhee47XBa8mT9lQy8QC3RRzXSAHFpImBnw0gxsI9FYRlvsuf1
	r7I10kLdIHpQm/beIPFemjkfyjR0sDThkenflUqLWfZ6a7yC1TKjfQpA64d8CWABEWPtr+UNAnD
	oR53POwp2Ll5e7j6OKsKMZp/C22cOFtQ2qeEAELs5v0LR9t140vR85BmBtRZTGC79hsor4hNs1E
	7xIas=
X-Received: by 2002:a05:6102:510d:b0:7d2:8dd0:2ed with SMTP id ada2fe7eead31-7d505805567mr1645085137.10.1794429471253;
        Wed, 11 Nov 2026 12:37:51 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d302359221sm4762571137.6.2026.11.11.12.37.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:37:50 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/6] shared/bap: Add bt_bap_foreach_stream and bt_bap_stream_get_rpac
Date: Wed, 11 Nov 2026 15:37:28 -0500
Message-ID: <f5fd668c6dc3b7a9044f218935da759b862e54f6.1794428234.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794428234.git.luiz.von.dentz@intel.com>
References: <cover.1794428234.git.luiz.von.dentz@intel.com>
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

Allow iterating over the streams of a session and getting the remote
PAC of a stream, so streams can be found by their remote endpoint.

Assisted-by: Claude:claude-opus-5-5
---
 src/shared/bap.c | 31 +++++++++++++++++++++++++++++++
 src/shared/bap.h |  8 ++++++++
 2 files changed, 39 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 8cb7fb40f16c..e45d12144acb 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4740,6 +4740,14 @@ bool bt_bap_stream_is_client(struct bt_bap_stream *stream)
 	return stream->client;
 }
 
+struct bt_bap_pac *bt_bap_stream_get_rpac(struct bt_bap_stream *stream)
+{
+	if (!stream)
+		return NULL;
+
+	return stream->rpac;
+}
+
 uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream)
 {
 	if (!stream)
@@ -7020,6 +7028,29 @@ struct bt_bap *bt_bap_stream_get_session(struct bt_bap_stream *stream)
 	return stream->bap;
 }
 
+struct stream_foreach_data {
+	bt_bap_stream_foreach_t func;
+	void *user_data;
+};
+
+static void stream_foreach(void *data, void *user_data)
+{
+	struct stream_foreach_data *d = user_data;
+
+	d->func(data, d->user_data);
+}
+
+void bt_bap_foreach_stream(struct bt_bap *bap, bt_bap_stream_foreach_t func,
+							void *user_data)
+{
+	struct stream_foreach_data d = { func, user_data };
+
+	if (!bap || !func)
+		return;
+
+	queue_foreach(bap->streams, stream_foreach, &d);
+}
+
 uint8_t bt_bap_stream_get_state(struct bt_bap_stream *stream)
 {
 	if (!stream)
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 242bfbb39b30..00b74de0f272 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -124,6 +124,8 @@ uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream);
 
 bool bt_bap_stream_is_client(struct bt_bap_stream *stream);
 
+struct bt_bap_pac *bt_bap_stream_get_rpac(struct bt_bap_stream *stream);
+
 struct bt_bap_stream *bt_bap_pac_get_stream(struct bt_bap_pac *pac);
 
 /* Session related function */
@@ -172,6 +174,12 @@ const char *bt_bap_stream_statestr(uint8_t state);
 void bt_bap_foreach_pac(struct bt_bap *bap, uint8_t type,
 			bt_bap_pac_foreach_t func, void *user_data);
 
+typedef void (*bt_bap_stream_foreach_t)(struct bt_bap_stream *stream,
+							void *user_data);
+
+void bt_bap_foreach_stream(struct bt_bap *bap, bt_bap_stream_foreach_t func,
+							void *user_data);
+
 int bt_bap_pac_get_vendor_codec(struct bt_bap_pac *pac, uint8_t *id,
 				uint16_t *cid, uint16_t *vid,
 				struct iovec **data, struct iovec **metadata);
-- 
2.56.0

