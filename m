Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414343;
	b=O8Gu259CNl4w74dBOo80oioP7JBK1KDieoRI/MlVCEQDssmpHVvHSFATtWYsnpX4OUbQ
	 ejUlMY5Szmm+1bZsVQ1XEHkOF+QQvZhZ/H89kJnyUoF5XzOVWMDwdiNw6wFI3cw5EGzcW
	 7Nch2aNIGsvYPowqD+R+6OS0UbDV98ZDQBEia8skWVnUIZml51wkGBnZvUpNtzWIWFMzE
	 H/52uKRYZsOzk18Zr+R+7gWs2nrk+W9nHEQ0FtpLqaG83BGxPwow/5tfFkKUYuGlq9/Td
	 V4ZiQpIUuekQqGydq9lKSZ9LwS15F8ubcse52cWUjvdMthDcVbWs9OtUqwSr4sJt9iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5V07kZtTPYabGRmB0J7JQ2iH4jJxJYzlNAm5oMkeypE=;
	b=X/sfBYczh9LbILxhUo6aPtSfyRCRjbV+gdzeokWLugX0Xled1fxo5zzUd3fY+FLVtx1e
	 w69NXT+U20LbPvDbvUv8K6IFUGiXH+zt0JrFqqep9F/0cd2qJPj4aOrOkgZpgRq+R4vgZ
	 1pJsTWMd1OWCCWE+JK7P9dWU9uf2t3sHqKb7UV7Bwj7JMkAL72r7CU1JMahIf58fNU4CS
	 2D904CtK3lv0WQxv7ofWKH3Cp4cZJA1v5PBP+tYXg/bCCG3xSlFQZOsNHsgLx2tsPOTft
	 vk2nNcEirxtHfo1+Zd3yOZ7e9l3mXlsoXT+GPaXEiVf6MUJdKaPc/Fv82xIKt4wA79A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f6qd+Anm;
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D8B606A330
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6D8B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f6qd+Anm
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5ea969fafeeso1163019e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794414341; x=1795019141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5V07kZtTPYabGRmB0J7JQ2iH4jJxJYzlNAm5oMkeypE=;
        b=f6qd+Anm7NNzr5AEne22Cf7c7ZFpt5On4M3osCIcLpuRa9ZKyUSUwF7Wzk10eNMJG3
         grQarID+WYyqsiec+tzzsw8dow/WBRYi5y5jzPBV4myFufXQGcw8mnsT4S7rjgjKu4+7
         CAnAVeN80SUcaA13E+gxhxzy87t6UI3d9bjjuvJZ0veEv5vyVGdTZuU8dwYe1MoZxZDm
         OCOwnMY5vtpwEf2hyf2YLfuGex0OjOTUCnmPciQCmiM2PEw4wmUdnOYr9JGt6OQb5VKE
         bIdOXrrYAGzXDfOBXvis95CGClQaHK712i+U3dNmpQxrEafK/GXi0hJ8U2hDZqyr2p8J
         6ktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794414341; x=1795019141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5V07kZtTPYabGRmB0J7JQ2iH4jJxJYzlNAm5oMkeypE=;
        b=D02c5VEGsLg3LgP5ptQ4OsN6OAT5mD5k37dV43/ZuQceETXSktFQTfOBT23F21RVyH
         UbZ7L9a41K6RMbuyBssH0GRdzH8Ha8Lp21vkXb4HrhJgwYDKONwDtfaZ7VsavN5QhBFt
         A1HJzsiZu3JvQN1pTXmFnC/4kQwLxyjzb1lFuHTKjrSg7ACfLUuqGF+/Pp7MHReKAdFI
         5WFa2wO5pyla52vjMvjr5Rsoid6PiPEuU7fNFJN5QLf8l0PiXfaEZFGPeEs8y6lNgNwN
         nvLDXtBOw2HEzvjdq/P3Y4OXpVHIHw3Cc/cHG381+HpkxjuxigEgS11acdlG5xFvkrbr
         MDgA==
X-Gm-Message-State: APuU4Z8lN/6u2dm0az1f1k2i2TVpACtNbxkr2IbTqArsvjxffT9e3uP8
	QhmzFNw/Hj3eX58M3/BRC2OXTNJfW8MhmXkipN4RyBHy9rtJqronOnFElnd5+g==
X-Gm-Gg: AYBFou09TgAq2gpWD+zvU01AeAZC8oM5s6ayadodK+fGweJMM09Ze3KvqT062OD+cvX
	0bgT/jsgaWddZpCurgqtMNXeQ/27ehIGw6SChIoqpfrPwlL4vVjmJuXBYzgyrbHaqmUIi2ZE/9Q
	T232qS8KevLSf5raHrX7UqQs87EzAEgFNoQF1xSGY292/rWwAnDdh+nTD6yoGgOY2Lx4av2cs8a
	Kf4qiKI87DbiuBki+GGaXh7FxoqvSd16MQ0WPbNxT9adAAtUfEqlo7qDmWNi33l92KiWSZSa5yO
	n1K2sp1Y3MV/IiQ51BGVmuYcLjtsDgSXQ8rjY3fFoSHrctieuiJMd6GeFGeYy+YbKZSWPsX83fj
	1rDueeUbQE/tY6XuCR/+KGPr+aswE2dVBMEb6aidvrzH9JiuTxxWPhcfoewoKOOh/Uh5cohp945
	wyU1pYpTucGBKKA+VJvfIMxQaRktUdEc1NgnqUXIbw2WPeiZWG4AmMIkiY1BEZ+YShfUzfy9n/5
	t+LdjmPmMREW3Xeu8r2za2hESPP4D5+smNWSD1tIG5DGglyEb/ingzV5Edar32cGCwMYGqnfSl+
	M9VRr3B3c7EHRc7hw4m84XP2qHXQtsEs7v+WosIyrGpxlTHoyVsgs7h8SByUExHpgy1CUh0DxR3
	bwk8BghTtRrRTJ7lcIobJeVUnh4l1ccKQAyIDEXCOSP1Xf2CmJzFBHl2Heikn80pKdrSmioBQkO
	QLunvS
X-Received: by 2002:a05:6102:c8f:b0:7c1:b55d:373c with SMTP id ada2fe7eead31-7d5061b81damr1114513137.31.1794414341526;
        Wed, 11 Nov 2026 08:25:41 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c200004e7sm4269659241.3.2026.11.11.08.25.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:25:40 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/6] shared/bap: Add bt_bap_foreach_stream and bt_bap_stream_get_rpac
Date: Wed, 11 Nov 2026 11:25:17 -0500
Message-ID: <f5fd668c6dc3b7a9044f218935da759b862e54f6.1794413813.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794413813.git.luiz.von.dentz@intel.com>
References: <cover.1794413813.git.luiz.von.dentz@intel.com>
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

