Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515867;
	b=aPCgOHZJepHHVPd7F0G0v4S1sErDeH8Lvy0HcjEJYGiVhbexNytOgsdGXCwnl6gLKgai
	 Q3e5K/snlA0u3txEvIhKagnmCpdU4hF4MHJXtQ8pD+SXSVRoNwevXO9Yeffc77LWS/hMM
	 iM+fzxVXwBbm4lbW9AV8meSqgpUDRx7oWUgukgSlElUfUhkrZYdVNAABBvpvzPUKSgbYl
	 JME+lILOj1TKzUjbvYhRhu0FGtUkFl/sXKOqWCbEwHmIWkh83JP03/IR3KLjj9dM62Eua
	 OuU15imXk3p7xVOZDUdjm+AOv/NEiGCsWbkko2coQqLTkxgayhGV07OMBFzF93zY1uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515867;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5V07kZtTPYabGRmB0J7JQ2iH4jJxJYzlNAm5oMkeypE=;
	b=2LsFJdfb8JybYNb+Q/r1RNH9PXt7kPUtU8H/f8CgiaiENuOZESDKrND+/HfLJIz8sFMl
	 VtHXpUTMg9wwtwBPg0pH/hv0z84knJxxegm8ZEg6rlDJXCjRF+6syUWDRzZgrlvXQ8h+8
	 1fuIKxCsf4BIj74Oc6ChIWZPZ84H3GQJQRa/RhaWtQ0gyG3QXFKEwMBE8Xr/OP6Odyf49
	 vchMzVVIeT1imo0nH/THrHtxrUYrWc+FK1gjFbdcvZpfBlT+BoksCgR/R42XPglhMA5lL
	 ZKofbc/QqM5pQ9cj6D0stSAQcmzdWacUZPyc9wa03se0fGIL67nOH+NOPqwZw3rIcDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KXEr0AFH;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC23A606A32D
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 20:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC23A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KXEr0AFH
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5ec6f271883so269438e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 12:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794515866; x=1795120666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5V07kZtTPYabGRmB0J7JQ2iH4jJxJYzlNAm5oMkeypE=;
        b=KXEr0AFHLOEShbrz6ZMZgXp0BPyJHWwFzAL+nUCqSdk3EWDmhyDjiFeYKUgUuXERsO
         V99KSVqkGhVA2g+AHtDXyueqHujfmQh6ctFrucHV6PMNOpbKX7+OJJDSWFph8muruHVA
         QC/tf2bkceTCFBYvJ9zY399bptfrIDqAkpY5Pa2+oaNvbthX8mZuupBqtOAypCihXNQ7
         ipyEmKuoCg9rPPS7GMgYfc9nPMqw3OppZIRt+iCLZy0FwPubDNEi0IiK43lGBokpOZLP
         J3Ry+Zw9KE5THqIG3Bu1lptX+Io4zQarXZOZN6x3N1zUxUZ7Kw8nGNH0bGfnSeV5wzZV
         Qtgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794515866; x=1795120666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5V07kZtTPYabGRmB0J7JQ2iH4jJxJYzlNAm5oMkeypE=;
        b=T309CLF3b1llG0YQ3yM4zinB2dQ/xKZVIcjJZU9cyGWZPdyfZDviXL4YHNSvDKxbzg
         UK0JURN2WoQV3OVHqY1G4Us3IZoMnOfnCmRnLAp70Ob846NGNOjSCoUX99YxuJYJJvB/
         wXmwhA0YBqOqLn7kji24EmzYYvSwt9VIkM15eSofGke7IYp5Ycm8h6o3PEUHhu+7EVyd
         i64yPST0gzF3kpKDznYmZoz8879qxA+8psp5TxrKSck9Mg0yq6+xqr8p/p3VVYeRnd91
         pYery4j+r80FmR5pmpadH4n34/6UlgZXIO4ZtGL3NztiEgSfE8uJAGNbB2A9/uySkkVr
         m8Jw==
X-Gm-Message-State: APuU4Z+Gv9RAcvd3Jvvv8Q/C+/xSpQQANejHm/IJ+GduJ4w4W0XO9UvQ
	tl2bnrlVpAvwGtwbxqlvHjWtlSSYqa91WZ1mu5Z6LfbLAyaPeeAU3PU5qxq/Xw==
X-Gm-Gg: AYBFou3HLS77LAedrH7ht4vb0XryUQNsVl/QSrfMjQFPGCIKG1bUEpxKjkgQZCdMPV6
	OWX06s74lrFh2WGv820AUMRxt5EAdtImNAOzzZg4LArxioW+d3T6GGBroGM/fGQrDexON1dkZ9q
	WXygsYLIrPtrP+rmBIQXNBtaMEYovmMkH2Xk/b9+EYdc2Pv3bRdCrx3ADTzuaVwSRLIomekStqc
	ENhd0ZQcuo2QKAOdHP1DEfp+1npCVkfCoxP1+QJq3EUfmeUYeR7jvXQllDCGcpPt3yahsXROoZp
	Gcw0WvlPTVONPV3e1Tm4nNQQb59j/dnIww61+go2suDJreK6lhDyiUdiEwzQWGUG7M2X8SCwEbk
	wDdgHH0ncfJJgXplf41pRWxw9U1aHLHmfQtixDOA12xgZs3CXirMfDkP1vL4hcEWmlW4sKhZS2c
	ZgwjkodBrkWOCK8i1SK8FzrCbp6fsgAkLtfHwklT7oRNWoPB99MRjJAZdEcmqNGQGEgRcgNX8je
	VNmUzn4D61h7SVhoxzVTdE0Afff1XxXi1rl9cC2ZprhXB3ews13KpJ1GfvziO6BZv/rUH1wHgtY
	huRu9Aklw4bHhxagyHCQ7T4wtqYybFR7TTLhPwsa7lgT3azGvJibTLwiBGQYkTelglAyBnMMQLq
	YxGT4NXj58kwEp9ttNpMYSdWFU2KIdWSD9OzCyfYKJQrpnvizy37spvHIyyG0NqT5KUvQ6GyXSu
	SEACU=
X-Received: by 2002:a05:6122:1d0d:b0:5ea:b991:d489 with SMTP id 71dfb90a1353d-5ee34a9d59bmr131220e0c.13.1794515865641;
        Thu, 12 Nov 2026 12:37:45 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34bff0d2sm145765e0c.0.2026.11.12.12.37.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:37:45 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 1/6] shared/bap: Add bt_bap_foreach_stream and bt_bap_stream_get_rpac
Date: Thu, 12 Nov 2026 15:37:38 -0500
Message-ID: <f5fd668c6dc3b7a9044f218935da759b862e54f6.1794515788.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794515788.git.luiz.von.dentz@intel.com>
References: <cover.1794515788.git.luiz.von.dentz@intel.com>
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

