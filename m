Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594C11B29D7
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722434247; cv=none; b=ep2F+GzVCS5nSyTOIV84qWlMbnwfWLex68HFiL7h5EplVm1ASCY/plTRtSQvacty9BSFv9MSKZjS+3RT5ZF8lBS1MebWoLwRW/aNvSr8jfXDPn1MKAppqdL1IBNJ1MLI8hzAuhIYmfhIezgqizwjAm4zZmvt81dojhQs7PWlGN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722434247; c=relaxed/simple;
	bh=NhSwMsjZg89Aw5OlQmXm7xwkq9viY2RnmqKDqkAKR9c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oeq5Vp1/Wp9zNE3AAVl8Tg9jlIApcvru/Id/MhDqiK8a6f+yNn6OiQkZkUWgIZ1LJ4JP5pS2NqZx8w6xGDYlX/HIWyQB0lh5L8YHl96z7ecyOZxS2BDLn1uYr3JtFyQ7s8X5EdXpVkZ97xfS0dvD7eUXN/Rd7vZRgL3Fui/9+Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcDXLvfk; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcDXLvfk"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso541001666b.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 06:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722434244; x=1723039044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/0o7wK6f7my5NzT3+kEHNbYAQwaybfRVmaM0eb2Q2Zo=;
        b=IcDXLvfkGsakiCnmKuRZo4JL0MiDYzuXhoF1xmGpARvNWTmaemGQuBkh7GsKAY4xHT
         sKRR2aLSjZSHP1h8hX9XtvC2tpliXiROZp9CDPq7V0Wxp4EH+c2QtQZLywVcO0nHt7ZJ
         sq2w/lqWYMlCFF6Duh5eWoPr9ee/Zaf8QMbkVAtr3LPWqpefJ/z7CJ5UvlhCB8YO6b1g
         3pAyXWCyhGJdLMsPNFwZPK483emxikeAZA+DxUciPJ5qEvmGxChWpGRxTEkod9QiR6sT
         C6a78Z/B7BKvpPtk1o75Mb6TVDHpnqO0fMV3fyiYgz6D8mTz0A3NwJPIhlW5zJRjrgM2
         6AWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722434244; x=1723039044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0o7wK6f7my5NzT3+kEHNbYAQwaybfRVmaM0eb2Q2Zo=;
        b=bk1i+cT9l0zgTi+un2SrZsGrTZLpqZQXq+niEheQDllCkkR4ciW3Eyp+DH8F+KMp6+
         OQt/F5zjwrQiyoYTgwd4lEenBXzP8MI7ZnU7WqMnjg8nUWU2rntEK0VIQzX68c0vusG1
         +9HMDZGeHsEVORZeye1Cist9JCwNFwyw98h7ObDQIHEcT0jMPoSWlfJfqXY4uMrGDa1J
         RspnMg15QJe4hJzWhI79iu5g4i4C/9w2AjS6CoEW4rNewQuW4b/zdoYxGWTvlVXYRpUr
         eKq5ISt+JfTtIOgKeFbQ+IRQyK6iv8PyY2DXgm4TCgiNQPIQ+jl/Xx9DlyKqntb4cylh
         xXQA==
X-Gm-Message-State: AOJu0YzvgXWJI6RWBmpHU9EX+Rk3lUTslPJvMMewUr79DFMLU3vqeG+B
	PaFQtDvZ4EZRBJ7KUhckzKYPEshX9692tsrDrvZSkhHWn+oqLHX3BHjmXQ6r
X-Google-Smtp-Source: AGHT+IEqrNwTSvBP2CCQhzcAkAiHCvuxddiKWxDitxxj4ibl/SkMo1VMblBBmpHdAXJxOg34swrrmw==
X-Received: by 2002:a17:907:96a0:b0:a72:7da4:267c with SMTP id a640c23a62f3a-a7d3ffa612bmr1165489966b.12.1722434243900;
        Wed, 31 Jul 2024 06:57:23 -0700 (PDT)
Received: from lvondent-mobl3.wlan.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad91041sm779143666b.174.2024.07.31.06.57.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:57:23 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/4] shared/bap: Fix not setting metadata
Date: Wed, 31 Jul 2024 14:57:17 +0100
Message-ID: <20240731135718.429604-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240731135718.429604-1-luiz.dentz@gmail.com>
References: <20240731135718.429604-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bt_bap_stream_metatada shall not send Update Metadata if the states
don't allow it, instead it shall store it so it can be send later when
enabling the stream.
---
 src/shared/bap.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 499e740c9..a7217b417 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1971,8 +1971,17 @@ static unsigned int bap_ucast_metadata(struct bt_bap_stream *stream,
 		return 0;
 	}
 
-	return bap_stream_metadata(stream, BT_ASCS_METADATA, data, func,
-					user_data);
+	switch (bt_bap_stream_get_state(stream)) {
+	/* Valid only if ASE_State field = 0x03 (Enabling) */
+	case BT_BAP_STREAM_STATE_ENABLING:
+	 /* or 0x04 (Streaming) */
+	case BT_BAP_STREAM_STATE_STREAMING:
+		return bap_stream_metadata(stream, BT_ASCS_METADATA, data, func,
+						user_data);
+	}
+
+	stream_metadata(stream, data, NULL);
+	return 0;
 }
 
 static uint8_t stream_release(struct bt_bap_stream *stream, struct iovec *rsp)
-- 
2.45.0

