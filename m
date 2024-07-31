Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396F91B3731
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722434249; cv=none; b=r43HBVkNK8c34nH4WF7g1UsJULR6GmrUhHTtqAanHsUp40fgvuB5TciiOwSaxf0rdjxr/ZgPpCzmV0UPLHWbHtcAaOxGTtNIdmb2XRMhGGDuVAn6a6K0fUlPqoOrbV1KTBVqFqaJxfTDbSAIbudt23E7HQCTMe0R2FXjDN3d+RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722434249; c=relaxed/simple;
	bh=0jHhr9gvP75BtOdY1Q0O74hGBxxDcZ+CuAQl2X1+IkA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEw2qlpzcCS5PuE87/aPdThtatUdWwlFckVbk6uryrvIcfNlv6L//VG/nw52ZxFXGQkzCYFQh995HT/mWIz9A11b5sEzWH6nZA63asZvvWx1af20Yh1KVUIWh2PkYDlfxbak8iCsxccowhE0HntjSW1gIvBNwcp+htz7Lti6Nns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INtJlZl3; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INtJlZl3"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa7bso6145253a12.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 06:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722434246; x=1723039046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oaq2svp4XIVCK+k0SdX+3g8mv7npMWryUIo1poDIm5E=;
        b=INtJlZl3RiDj+sgchI0M1y9otnIs1LqON14d7aEueeWrLX0XqmVqUif/gqrZ6KyeHt
         /R92vcEFLnD5rZZFYjAcRWopsF3AK+UYJk8AsFRzIxf4dSb9bEVT9U7EzRZvEWoUhxzk
         +LFnhLo2QeWoZPM1Q8uFWvfzhgAb5pTcWNUnLBKbm80iCX4gzskhXLdsLQ68r40Xx9mT
         mbo0/roBgVV3ERS38WfQzv5AJ6kejLtfgEw0zQb9a0ONIwgaG+v86se1ysUPHB0yB5It
         u4Lhj2lZG2uVjlew6cVk7EAXWzFJ2PeVevoJhjeM3dnHIocxtOYHg7nM6RHPA/iQZOf2
         KVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722434246; x=1723039046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oaq2svp4XIVCK+k0SdX+3g8mv7npMWryUIo1poDIm5E=;
        b=Qn86fR7pbEB5Pue+2YHfHomEdgxoD1TK5B8b1gWoFhr26/Dm0WXZPwLBG9J8dtIndv
         gooa2CvP7wSZ/QWu12O9fQas2WcnjPu3l38t4r+kYiZIY+3EF5kyCzYbMboMsAphcQzd
         FrWlHaGPcuCLr5v2sLm0vhjUcYt1eNzJKIomMKDaGYHBddGynWyI/aLpK+6F8KRnDI8v
         YzlqLdTpuw5T0t5cndWSXrMmQbLtejB4Xjwzzwa+PtVmq6BCgaAUtxjqcREGiJ0AYT38
         atHrzk5g1HMpQrnTytBYab8RkcZWy6JBIeyjwIkWbw7N175m3nBfzOfy5VqxYYQl9L5i
         HI4Q==
X-Gm-Message-State: AOJu0YzJDzVB8PW3ACsTwORAZp+eNVCJJKfpOxOM0bd0FuXt/3sqDCWC
	PRCyyvf8Ldcu75XvkXPGNReU6/YkABWTTGUS2bLsh7Q2f6IykKtjgMTqWnIZ
X-Google-Smtp-Source: AGHT+IFXBqNRqhEx9/isbBzzJl7FJ77/BlkMF2Ek39lSKk4Rrunq3zXxWGzScp5MkPiVMeN7P20oIQ==
X-Received: by 2002:a17:907:9483:b0:a7a:83f8:cfd5 with SMTP id a640c23a62f3a-a7d3ff9f2f8mr985266066b.18.1722434245950;
        Wed, 31 Jul 2024 06:57:25 -0700 (PDT)
Received: from lvondent-mobl3.wlan.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad91041sm779143666b.174.2024.07.31.06.57.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:57:24 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 4/4] bap: Fix not setting metatada
Date: Wed, 31 Jul 2024 14:57:18 +0100
Message-ID: <20240731135718.429604-4-luiz.dentz@gmail.com>
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

Fix not using bt_bap_stream_metadata when configuring a new stream as
the endpoint/client may have set it.
---
 profiles/audio/bap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 53f430d66..a2c5a546d 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1523,6 +1523,10 @@ static void setup_config(void *data, void *user_data)
 		return;
 	}
 
+	if (setup->metadata && setup->metadata->iov_len)
+		bt_bap_stream_metadata(setup->stream, setup->metadata, NULL,
+								NULL);
+
 	bt_bap_stream_set_user_data(setup->stream, ep->path);
 }
 
-- 
2.45.0

