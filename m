Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A7E3932F5
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776425390; cv=none; b=YLaFcXVSZ8A6d65v5VCltEyMKEvFzOjjWVekQe9RCMXfaBpv9geg47iAt3VD/JXSLjQv7o6VCmId2tAb9FJNLVC2VqV+m8iMVpdPAsu66B1TFwItz2bVpNfuxfFQkspschQhcVmtzuk4iBPiS5EuEfMUDHA4a5knG2cug8WPgIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776425390; c=relaxed/simple;
	bh=JVriBb+MkUAIy+g3eBxbSSjdv3XG6Y4cIExQZEE5/IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mv2B7MrhM9nTRf33vsNMHgW7hwBRs3oP3wMiug+7FByPOD1RbgXWapYEEBo9Wh7mlHZ0zp3cJU+dzeslPVS0b7qhcpwtq0XWos7rzAFWaG9DTeolZts9wvKM/aA034Mjted3xY/yKDW0ViUwHapDD7OsFdsyD0RXGsFahIpquXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=0KgqmBc5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="0KgqmBc5"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4888375f735so6777395e9.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 04:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1776425387; x=1777030187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suwxtTKGcoJQ43r95oVqKZu/Q8adAogfrVhbZYo7l/Q=;
        b=0KgqmBc5vJdljV2wZdrNahdWHZdhJF4/QRQHZFQHBtZSzYw9IAH3KmGI0ibVS9pV11
         TikXSzIn5NZyg7afESlLfwCYt69513ge/3EL1R90FjluGftVYt+iDDtEdhcvUhG0zK6w
         xL+DbCgDDd8J+avYKl/0pQZKwY66lf6BWbQ08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776425387; x=1777030187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=suwxtTKGcoJQ43r95oVqKZu/Q8adAogfrVhbZYo7l/Q=;
        b=rdYEjrTeSAgdZOR8Zm5oPCSnG2ZJIaYz1bjzH0ugJk2mzrGdheW5xXMYkSN6syYlpG
         AoV9bxZwGS1cQg74X3yotD9qrgvySE/tybvzPA0xBk0S9DD4yvDUIg5TOJMAyDFTJif9
         ffHaTSb1xeRpjUsBGW0/CWnin3yHQyHgXc13QZoTf55o3m92PYypozps4d3vmHmOWMn3
         diUw4GoX4dTKVJvpUvTA8HNwqD7EIoHrBC74/JPQt7txXARAzM1zjQAzpmXng5/hjZ9q
         PYiQGY0IjvjJ3SrXQj+DnYU6t4amNAAiQeJ/mEfz3Hppo/P5yDwzqSlqteu4bXfib8Uj
         Hh4g==
X-Gm-Message-State: AOJu0YwjGn+tPHcyO97ZbYUAfu+RhRNZ16ANL/jSEYSA11AlGYcU7yvL
	r4PGBUQFkPzjIv0n/ary0Cdjgt8/p4ft93ykHqlviNsX8SvWIZ7fDJ27z8xpGhzkef23fdRHa66
	muM3mDw==
X-Gm-Gg: AeBDieu/V7ZSfddJGn0hRbMKPIGJ/uVkldRTFvttSXdDqcKTcQq17rE9M4u24vnBloa
	JztcYmaxfqb5eQnv/mzJL3Ovx4rNbZh2kmb3EWG69kqmSwdv+VENaUMMMy5C79KsR2R0Vdilod+
	XJcXzvcK36+4ZiBGCNIr3t2/6C/ZIsjvbp2YYHmgIGZd2nxeD6rxAkX74NQDcARlOHLF7jAcirA
	W75e1TJ7QiAReIFb1qqX9RdhMse9hf9SO4txDdrVlex/AXUG3CVY1uThXEIQpGzrr0Nsb0+QNc0
	rdcNxT+FEko6eg8xpdQzZWgifnlBy8qDcvLwbIYQcqlg+VwzGr7bq++HrO7u+Y2wof5xHU3BOv6
	zMW8y5azFtp0FaZWe6HmwR8hu/wEExDtMrLPKlQYX/PR9Sbp8FKE01PWePWu3gmGIJ/GISMQRri
	Ky/6tjRBTTd7v2qPe3EMiFh3ETwKtW7WenY/vQ1e8mSuMMJHoMKEtobQ66QYGWI5ycul6VrUVsB
	LQIS9Dp3o5z8aGi
X-Received: by 2002:a05:600c:34c3:b0:485:41c4:e2e4 with SMTP id 5b1f17b1804b1-488fb792dd0mr36583135e9.23.1776425386678;
        Fri, 17 Apr 2026 04:29:46 -0700 (PDT)
Received: from great-eastern2.home (public-gprs181528.centertel.pl. [46.134.48.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e46898sm3765865f8f.27.2026.04.17.04.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 04:29:46 -0700 (PDT)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ v2 3/4] audio/bap: fill BIG and BIS for receiver
Date: Fri, 17 Apr 2026 13:29:13 +0200
Message-ID: <20260417112914.3752605-4-michal.dzik@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417112914.3752605-1-michal.dzik@streamunlimited.com>
References: <20260417112914.3752605-1-michal.dzik@streamunlimited.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is for some reason a missing feature.
We receive QoS structure from the kernel via BT_ISO_QOS, but BIG and BIS
are not set there. In fact it is even impossible to pass them that way,
as it is only one structure per remote device. That's why we have to parse
BASE data to extract BIS and set it to stream->qos. BIG is not present
explicitly in BASE, but we can use subgroup index with success.

As a result of this commit, MediaTransport1 object has now a valid BIG
and BIS set in QoS property.
---
 profiles/audio/bap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 375026440..5333267f7 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1502,6 +1502,7 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 
 static void create_stream_for_bis(struct bap_data *bap_data,
 				struct bt_bap_pac *lpac, uint8_t sid,
+				uint8_t bis, uint8_t sgrp,
 				struct bt_bap_qos *qos, struct iovec *caps,
 				struct iovec *meta, char *path)
 {
@@ -1512,6 +1513,8 @@ static void create_stream_for_bis(struct bap_data *bap_data,
 
 	/* Create an internal copy for bcode */
 	setup->qos.bcast.bcode = util_iov_dup(qos->bcast.bcode, 1);
+	setup->qos.bcast.big = sgrp;
+	setup->qos.bcast.bis = bis;
 
 	setup->data = bap_data;
 
@@ -1550,7 +1553,8 @@ static void bis_handler(uint8_t sid, uint8_t bis, uint8_t sgrp,
 			sid, bis) < 0)
 		return;
 
-	create_stream_for_bis(data, lpac, sid, qos, caps, meta, path);
+	create_stream_for_bis(data, lpac, sid, bis, sgrp, qos, caps, meta,
+									path);
 }
 
 static gboolean big_info_report_cb(GIOChannel *io, GIOCondition cond,
-- 
2.43.0

