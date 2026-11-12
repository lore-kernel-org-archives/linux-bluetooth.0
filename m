Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515616;
	b=npksrt89vjXlzzDVNkErzhQ/onofAzlcHKEYCtlr7VdcOf6XETACAvRylu57F7i42qHT
	 6co5yRAlMtsFluEl/Q9+demIC9RIeTHiqbLvFqaoWuXvNQe15F5nL1VDUF34sgZ3o3Dob
	 NRj72ZqNw0gvhmhQXY/S1VwgcS4y9KVeJFVEt9wEry6B+9pMG2k/Dbp8a13MeNouk2657
	 hGmp+C/W7iGOwx/Tq1G+rwnYrZ6pNRb+UJi6MZ0xyqtBRDI1sYmK5TL4gBA9AH5ecsRLb
	 MmQO+IeN5SsEP1euwIrTbF1ohjDiusZWPfwauo6HqlBK+t5iY5OQaVzFd4VLTVNihxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515616;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5V07kZtTPYabGRmB0J7JQ2iH4jJxJYzlNAm5oMkeypE=;
	b=SwYsjqO33rScmNxMfO6m+kQcAuXvLXNKSN1m2cij4xfrkMsAUo9iQP6U1C9jNwDKeTIL
	 wUSbt3yx/WGTI/OPecXEAZLSxefC+of9EMc5OOqX35BrnyuyMY3ybck1r/DcTu3XTfi2/
	 oqiD9aRvc9n202ezd0SZtl595kWp38/UpWiJBxJ6IcRHr8E8O033aq9O0n0csYjxK5+6r
	 W36IHZB3ybi4vszlaeyT/X2iWn5hls11Q0iO/i+ZAvLp9mLdexCaS/O1QxzO9B8yhw7nP
	 W0V/kCgACCdk8pvAa6orsQGYYLnUm09ad/gPbsoKi/h4K96zQHcarneWvIxeE7Utuqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cWVswG2y;
	arc=none smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5728F606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 20:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5728F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cWVswG2y
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-990fbae94f5so257401241.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 12:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794515615; x=1795120415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5V07kZtTPYabGRmB0J7JQ2iH4jJxJYzlNAm5oMkeypE=;
        b=cWVswG2yjnQ1eDCjWwrZcRWx33+4l+WSDLMtnRBCPBqAx+amKP6bjt0UN/mVzTTNiE
         8PeetvYTIfV5Kvb6foJjZ5csUs3soGc5L2MjqUj5pAVj0q9ya/t9olWqk+ZQ2vmNvikB
         cxYtvvieDIS5SzBUQZCxhsEkkz1bZjrh3djSNgJwIEAHAbkFxf1inEpxGZeTrWzL1P0k
         GV1+4z8gQSJcnVJ5O10JRFivwKALu6/FzLqfygv//HrcGSzOat5OeOUNfaroCz1AzgrN
         FVF9yOEtY/CruV2Wvyp/7eEjHfCKN4N8GgutHs70+zVXx94oQcny6JD3A/5EJGcCWEi+
         mihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794515615; x=1795120415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5V07kZtTPYabGRmB0J7JQ2iH4jJxJYzlNAm5oMkeypE=;
        b=LfHPFHQxQbmwPkvlHZMBYxI/rmMQEvZ/D41ZPF8dYkue0ED5Wlu6ypI7No8gNFGA1k
         jA+MueS/zJN5vKWJRPXiv0P9lkfZev2oRmyhJ/qzYYw2+Qc4/0YmL+Q+6/yE/mwSDT0e
         rV1SFaRNaxXdYlmULko2ekFDOQpmbbV4gleNHU8p/x11sKn9NawvXFnc/RID9fxryTYV
         JrPovXl/hsExvUIl1YM0jl0loI4N+wH3Pm62+sSzOC6nSgQkOjcwkigeGXn2qTDEl45E
         Yf4t+HSbGPNBibQBUxXlZhNpM4fr3zuCLZjA3Xu9SPo6h6vpxwWRemJamNcFK8piYcd0
         AL9w==
X-Gm-Message-State: APuU4Z9nhBOAkw5vjvEm/VeZ/wZNyW2x1DXyrftsHpJfe7tuCDMBude2
	tvAB0A/U7b+94VrYljBlK8j0OGyuI+CscLv/dFCP6v1qg3JKstujB+do42zbBQ==
X-Gm-Gg: AYBFou3RjIE4U6PL13uVWmRdG7XimKufPll32zzxMxng9FEvimQScNq4u/NMRSQE6VY
	hnZipzdmUmEX/HFNKKLzHEDTGzWG/EOtfJfxrQ27p/Sk3Sg7NMuutVeQR/RV4U7t8g+eqnRKXwe
	9Hcq9P2vSEMyzHRyw4OVx7rLQpDxvCTbbRGBk5FkyWUjllF2wdjGNDQ4D27av9p/0aPpac3CBAD
	F2ZEx0DVyJJ+9VwLciWoRaGNP0S4Q5F9miT6owsGEJYl9rXsyd6jrXUovY0HQbXQMKXyujeegJ0
	d61uNqkbhMDZWg4hIfVnHAjccNrfRtIf30PTMrqf6q91I8GuBYQmiv5akddN97fWE1gfcYJZt46
	wtEL0jX7HywgOgT+F4rHCLayKwc3XCwo2s6DFcmnCwH8Lu5bhFWBN3WxfPBLrNSXfeE+TUVwxfp
	H4a+YZbZ32p8oDkWPdhB7pC5g81qL4bUH6YUPGq7KDqelkPB6fEncf/4UTYHvuoc+fh48sqQK4O
	RRpbGpg8M017wIRy6Eju8Os3fKL4mxV4x9Lc7mkgneMNjAiSX+IYGhcKvft7f+QewZsQ0G/IGXd
	dyJcUoibCMVVErX16xvpW0ktxRRF4mkbXDUwR6lenVPw4rCI1pcAVcAg1alLYTOLP18bzHTeeVh
	ClwF0UjtllODebg8KnJTG9mscIVMHO481xmiNpdKhJLAU/U9i3Q3E2cBAbTb9jSYkPPM42Xprbt
	BvwXdBgG0le0VkF8L1NQNm+vgoIA==
X-Received: by 2002:a05:6102:950:b0:7d2:8529:6892 with SMTP id ada2fe7eead31-7d64d6c74f1mr160603137.11.1794515615244;
        Thu, 12 Nov 2026 12:33:35 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c842ac652sm346627241.10.2026.11.12.12.33.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:33:34 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 1/6] shared/bap: Add bt_bap_foreach_stream and bt_bap_stream_get_rpac
Date: Thu, 12 Nov 2026 15:33:27 -0500
Message-ID: <f5fd668c6dc3b7a9044f218935da759b862e54f6.1794515475.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794515475.git.luiz.von.dentz@intel.com>
References: <cover.1794515475.git.luiz.von.dentz@intel.com>
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

