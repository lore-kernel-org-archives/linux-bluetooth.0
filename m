Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794507276;
	b=lGmvnpfK4b8rQqp97ImD/Q6Z7GAxzyrx3vyUSKBtAgb/3Gj78wQNq2PRItHyTSCzO8ZX
	 kIqh40NULFNdKZFMQWEOMhWigis7OBRUiXgGs0as8sdUX6PvzKoJZXDzce56cvt1eKDh3
	 eHt0btBhFRBEeNLH2meunLSDgdUaro1sdFI6LqRU95licoEARK6ijACudRB3M13WVj6hb
	 MKm1aDt7KOyR+RnKDmrydpvJPV0BZcx//egxTFopC8a9+0hksCBGEaw8gpyQXhtKkD5T9
	 oHGjNTZZEVz/EjjQKT7Slkil9/kLDdXxTa8imqk92PmUdR0vnb22yfKtuEkDn6mCm3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794507276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5V07kZtTPYabGRmB0J7JQ2iH4jJxJYzlNAm5oMkeypE=;
	b=e8+Pb2Z+HqfA7NQS+UnyzzYS6QlRnkngmG2gXSXU+sV41+4KAUNXkyfBgQeRRwPhwuT/
	 u1cakDqAqwzl/EXM009B/WMLnFY9EK7Ns7x3AdDhhZpXp6becyd5S+Q1w0EXXSB8od6LE
	 6Nt2yHm6YNOkcyFKP1xs2KgwhuYzjYsNFbu03fjAgJz++ZevnLZpoDKYUdIPUTY0+k8h2
	 G2LU2jSLOemdRONNh77yH6rzaYZbHEyvokkIAzbVRgaVG/MlbG4HV3DEpSKe9rlUyM1CF
	 tvvQ1V/7Uwbu6danUevNODacURBpkwGX9ZyPg/0bid6DYmLkP+1GUOzRY4XRPA++fzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qDMWNBgW;
	arc=none smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B06606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 18:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79B06606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qDMWNBgW
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-9908c849564so53293241.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 10:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794507275; x=1795112075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5V07kZtTPYabGRmB0J7JQ2iH4jJxJYzlNAm5oMkeypE=;
        b=qDMWNBgWdCGeGWFALq7vwmWjjTltZPgPySU4Cv+G3WNPHN5hcY39CGZAZYaJnqnIrV
         ManwWYBmtzabj/AflC5FeodXoo92gILUyVfpifnOp/Acs5zSuuJWrPolLEeTkfsOY1St
         j+OOIJBDYqWlsYkr2M5GkMpex3H2Fzo5JrmGtbYzQ5stvLcMboUFuc/zWWzC0DhbIsyr
         +ZDpEwuySM8Pq901il3wNos16jUq0ysF9PO+vPyYphSQ+bCXe83gXYSv+qiC++q1QkS2
         OTKJZU8MfCPqUCEPfVSwlWNL2hHDSP5Ljkruj49hsYuCGZBHmkuBmrTJdxdXcCdKCCHW
         1rKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794507275; x=1795112075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5V07kZtTPYabGRmB0J7JQ2iH4jJxJYzlNAm5oMkeypE=;
        b=f3w/M/oSAea8LZxOK8XV+S+V+oVloMlzu0UwOjRyagIYXKJq9MpP+s2RoGIWP39Sfw
         i/LkZtTT3QVj2R0MmFmqCUsUJQ4qjSvFORgYfuP0tNk0tKPAZ/j7/tm6NNd4uQBZZU0o
         ozW5oxeo5pOSFzWNVIqmhAiMPdh+lfLPQ+c9HHCIL2USndT8MW05a2X+XXR1spYO8R7M
         p0aGvuiBOrvrR9dHDKUjxUHStBIN+sZCbkNFnYb1RG9ntBSj9LS3LP+DzmD5gvSlyLaE
         fcV9F256KzJGeLyZkrT7hkz9BsdWhxni9tW1oQPpoP6ybsO7BK3wWEJ5aGBcA7Cb1W9W
         bzpw==
X-Gm-Message-State: APuU4Z8tAO0d7IiZOZXoDm5ddpGeg68yEchryNc3EAWdyFTDhL/wGQGX
	5Awp1nAQ1rCMbVD3PYg/I8sXtRsXS3KYDyLfF5hcvhMthJ/CH6AyOw1pG1ZGdQ==
X-Gm-Gg: AYBFou0GQwVlIaOQxvWaHRuJzV5l67X15Y4PpSt8d8hiON3vb/CUj8T4jDTfqi4grx2
	fcQcwUEDPvyCq9LsB3Nwd/If8CkgJAc1NqjiGJ11RcUYbbz42STPAD6d9rHLfXLJ+zHOAOVPnxU
	x3uQISmBpWQp1f3QoiMNuOlhF6723Pndzja93GK9b3Xu5Q7o90uEjWa2jXoqIs6Z8zX9Iu5c0wM
	p6HbUEYnSPtmzW3wtXAVkjuShKlVM/mIUqvJ60ZU5HBdscoc0gBhfLaejL4YuzbPUthy31l9CB9
	SjHic9FjxqVGVTeM//edMDkn3dQB8LM+LILWhQaxhhnhlIb+WMOdx6I243IQ/vk7MVd1KUrfnFF
	3ELOTM+hTLjJt3wbOCt0TL3DVfgjOS+qpT8tmRcUcse6upb6Eh5cHihFUmsbeoNu8CZbAHcQzkm
	+7G01iwYw000cwThHYTO26lC3Sii+IGv5yKZ1PlPZ+Pa5ldeL6oiUcIYGX3JiwCyL+97q7Q4hyu
	24wgUHW/9L8J/cEpV4Q/2vkSsWsrw5s5GkpUNQHH8zXwTWTwTKGaQdIXs89vF1J2r6BjCwX4YPX
	Gi8sknijfwcj8sBSqizrrjNTQgdxxDCaYfcBOlTnXlBNs88NpxYq6xIVcWudruoZo4K7OZqj/Vx
	mc7w9woRAkrJDzN8AEyFbreTg61mEZ+pxfNYxNOA7IeQ+BcG/tATXIlUW2ElteQ5jDOet8h6PkE
	lQhSE=
X-Received: by 2002:a67:e711:0:b0:7c8:18a2:f769 with SMTP id ada2fe7eead31-7d64d11df82mr48731137.0.1794507275326;
        Thu, 12 Nov 2026 10:14:35 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d64c1b33eesm178749137.2.2026.11.12.10.14.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:14:34 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 1/6] shared/bap: Add bt_bap_foreach_stream and bt_bap_stream_get_rpac
Date: Thu, 12 Nov 2026 13:14:26 -0500
Message-ID: <f5fd668c6dc3b7a9044f218935da759b862e54f6.1794504552.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794504552.git.luiz.von.dentz@intel.com>
References: <cover.1794504552.git.luiz.von.dentz@intel.com>
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

