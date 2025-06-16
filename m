Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446612BEFE3
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750081927; cv=none; b=JOwf9FD4LBgANQWVuWbGhKBxwTrsgEs0Jp9Dz2qo7n3CRxxSm3K1N5NJVXyPrtIChvF7niawcg4v1ljoKivHl6AAfgJHgBRES70mngGI9YAitgIa2nHbcZeVpPByVsCNpWwpG/mwQZqn/fMret8Z09H79a1tKQ9fhzSQ5O7SUeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750081927; c=relaxed/simple;
	bh=ArBL+G2CYTqNYOqJ7GZXZmiG26XNwVP9guz8ixyqYoI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NOL5Qt+iOd1pE55NkHyyq8xq/U3nVz4Qb8sNSFG9gkHBVvPfqyQMCi7AdlxYklGlv1JD5vXF6UBBMnIwLP9/EwF/T1v1F0Zw7gTISdVZNcTOL4cAnyJlMYZc3P+cS1h79Ea/FKL/mSnjLgUgQ5S/90goOUSg//kKokt0V5f+QVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4BTmGMN; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4BTmGMN"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-52f22008b6aso1206109e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 06:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750081924; x=1750686724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=h7rkQUnPjc8RxMfupUVKMuIM6Y5uStUOL0T09X44B1M=;
        b=X4BTmGMNk2+TjlPuAnrM2vLz/UPupX7umBGzYk+gC/8xvwCtcIxWhjySKjJrasCMCg
         fYLHPiIxWlZPAajArDU7zkZxRX3+Lndmfrw08sLn2C6xCumg3eOK2cDucI5KZeTwN8Lm
         UK4aFXtM48miaY7jpm3J8nHloy/jOWl1y0khZnh2Ax3MExBS+RXVXonAXGzd+NpUfgvb
         0HdzBSuEvIvbIN3WcEXpUTPOwkBdJW8sslWoVIfzLaTBh6inW1ukHwjv0w8pAdBWRVUy
         z+gznHS0qLIk80ze/qdi3PvT3DbF9FA/XUPIGrWMlLpGp/WW/yfGeZX2vGCiLmFgsY8R
         Em7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750081924; x=1750686724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7rkQUnPjc8RxMfupUVKMuIM6Y5uStUOL0T09X44B1M=;
        b=PhJ95tqAquAyHEoluEEQIvotPoECTC337RQmThNICHH9xKVLMDHpynNjHWgC2afOnP
         eFhUDj1+/UXrwcV/gj61a+aZhDFBQuEKGiz6Ef9nPI9Qeb+4yY+IpLUEJz/FzGyfwHht
         YJakhO4R4Bo3ODaqjNeETU8jiD79dRBjZZn5k+f/bS2tiJ5UYbGU1YUr0n4PW3hqoqX9
         /JYwhOqKgfhj7dmqJ/LlHR2GlDkIz+lniPbcBzsCKZol6K9zAHF552GdI+1BQEm9lDhp
         xFYRU8tpu5RHqqWVN7fhUSXpKmQrgpk8kGpl6lXnSIZGhd0+tfLVr68oewbHWCeYqxnf
         RD1w==
X-Gm-Message-State: AOJu0YxuM66xoDhn5puwl5xLYq1wRWEyF4T+6q+a3cCqdf6WnT8KEDUf
	+n4NhxX0U4miUIWXdwnEJV41yfLmHNlF4PzOnmbmGdfZMHoHqbF5gMXylt89Mw==
X-Gm-Gg: ASbGncsz7pjWIcn+GaWbHX53ipFhlaju2WZYzZ+3Q1fne2AFkbG9KW3mX8zvbWUG0V/
	lrP4Dfxz6GuXaAHe5ny8rWNg4jtDbgv6icfRWj1UWUYjBoED5h75eN5u/8QvQRhXz0svlbSW0vC
	OzGJf29fGkDeKl0EAd+baoZNXAcIoGbHhCrblUk4Zc9886XhaKyIeiM/rCAipN+gezb83icOR5W
	VHRZijtzS0M9XG2EdY694fa3odb1S7172SwBjJXUOtMFJDayy3A38qxpKoSV8Vlp/l//hsjB8r+
	CXYPuY4l5WCipRvRwQZCb1+mtjldjovvbzuzxDT++qmVW/x4+W74G+YQINUK3uW67h/h2rW/GzQ
	L/GB+Vi7SjjVVAgnmECNGjIHOQGFeH0Y=
X-Google-Smtp-Source: AGHT+IF8XI7hxieNeWZFV3X3zR02e+La6Me/3BtIb3qClLm9JjQDQ9RbbrJEjT6bycEOmqMUw2JOjg==
X-Received: by 2002:a05:6122:3c51:b0:530:81ac:51be with SMTP id 71dfb90a1353d-5314968c4f9mr5087944e0c.8.1750081924285;
        Mon, 16 Jun 2025 06:52:04 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5313dd7a820sm1237042e0c.2.2025.06.16.06.52.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 06:52:03 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/bap: Fix not using metadata set on stream->meta
Date: Mon, 16 Jun 2025 09:52:00 -0400
Message-ID: <20250616135200.2551871-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bt_bap_stream_metadata maybe used before enabling state in which case it
will be store in the stream->meta so when processing
bt_bap_stream_enable if there is no metadata set use the existing one
set in stream->meta.
---
 src/shared/bap.c | 47 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 3fae72d9d8a2..2cc970c0ef91 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2276,6 +2276,17 @@ static unsigned int bap_ucast_qos(struct bt_bap_stream *stream,
 	return req->id;
 }
 
+static void bap_stream_get_context(size_t i, uint8_t l, uint8_t t, uint8_t *v,
+					void *user_data)
+{
+	bool *found = user_data;
+
+	if (!v)
+		return;
+
+	*found = true;
+}
+
 static unsigned int bap_stream_metadata(struct bt_bap_stream *stream,
 					uint8_t op, struct iovec *data,
 					bt_bap_stream_func_t func,
@@ -2284,11 +2295,7 @@ static unsigned int bap_stream_metadata(struct bt_bap_stream *stream,
 	struct iovec iov[2];
 	struct bt_ascs_metadata meta;
 	struct bt_bap_req *req;
-	struct metadata {
-		uint8_t len;
-		uint8_t type;
-		uint8_t data[2];
-	} ctx = LTV(0x02, 0x01, 0x00); /* Context = Unspecified */
+	uint16_t value = cpu_to_le16(0x0001); /* Context = Unspecified */
 
 	memset(&meta, 0, sizeof(meta));
 
@@ -2297,13 +2304,33 @@ static unsigned int bap_stream_metadata(struct bt_bap_stream *stream,
 	iov[0].iov_base = &meta;
 	iov[0].iov_len = sizeof(meta);
 
-	if (data)
-		iov[1] = *data;
-	else {
-		iov[1].iov_base = &ctx;
-		iov[1].iov_len = sizeof(ctx);
+	if (data) {
+		util_iov_free(stream->meta, 1);
+		stream->meta = util_iov_dup(data, 1);
 	}
 
+	/* Check if metadata contains an Audio Context */
+	if (stream->meta) {
+		uint8_t type = 0x02;
+		bool found = false;
+
+		util_ltv_foreach(stream->meta->iov_base,
+				stream->meta->iov_len, &type,
+				bap_stream_get_context, &found);
+		if (!found)
+			util_ltv_push(stream->meta, sizeof(value), type,
+				      &value);
+	}
+
+	/* If metadata doesn't contain an Audio Context, add one */
+	if (!stream->meta) {
+		stream->meta = new0(struct iovec, 1);
+		util_ltv_push(stream->meta, sizeof(value), 0x02, &value);
+	}
+
+	iov[1].iov_base = stream->meta->iov_base;
+	iov[1].iov_len = stream->meta->iov_len;
+
 	meta.len = iov[1].iov_len;
 
 	req = bap_req_new(stream, op, iov, 2, func, user_data);
-- 
2.49.0

