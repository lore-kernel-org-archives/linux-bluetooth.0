Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AED3672AA
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742312; cv=none; b=rJmY5EsWneI98/XJJuV0pWvuFV3wpJQmMOeyEPmSUOnQ5q+VaZ/OFRXXL/6RWPY8LLTiOKzgg+zBtH6up84vAEbbOKRQrW8mp5u2STfShFLsGt9N/a25t2eYRPIOKoQ3TW4n2Xm5xQR7Bg4eXDhPf/8XahWdPKeD8gujYamEGxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742312; c=relaxed/simple;
	bh=s6hsVPwczfvrarbW9msptPZgE8A7UGv/z7WRX7ac7vE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jLojavmxEwXzi4Dw/dXARvrbjcRGncZoKwF3B0HNTrcpDiH2iUZ91BM4/6LvmG0OOeHbSbLAVxrHIf2jVXOYm9vGkcPkv/5OqwYXyIWROpADPS3oBAe9JpKRhMc2T/B4vAlL+I0XxBFW2d7NKrlNwI0uFcp3wXh79LSiL1scQ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXIlIo0l; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXIlIo0l"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5bbc6c99b5cso1227657e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 07:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782742308; x=1783347108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I6xYwL84HKHKXCjzdLtK0via8XkXYBIUjSj6kSdnFLA=;
        b=IXIlIo0laCZD8aHK6TdoyTpTCvXNPGX1zQpqiuPNGo6h1TNuw/dEhxuxb54OZFKXMu
         FHX2VhZj9BZxVORHzhf+PhiX8BHGX37L3HaNe01ypDSLghSF7Go4ccXor/mEwMxMdylt
         Evh7LBFdERTDlsanqnXNoAItbHlwDghzKJrS5VPrdHj/5KhQhk5UEhh+ohYYd326B62F
         VSgJrFj56HMdp+5wYFnEuDd3JoepeImgBlgXG4uC2MKkiYB/h84DXBybKTM3CjL8pjCh
         6or3nrtWc+OANo1KGJVcVEVQvw43hbQCu/A9Pubg2oO7f69c1eNYwDO//zzMumPl8pna
         vf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782742308; x=1783347108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I6xYwL84HKHKXCjzdLtK0via8XkXYBIUjSj6kSdnFLA=;
        b=G7VrT70siWW8Ezs+geXEs5FOFkzaP8Vqhxhknca1LcxMajJAi24k23xSkcuFef4Bib
         52caSkm+OXQWtcP49Ouq3+t/wEuVpKtMnmaWO1hyRWXD7DBxEILa9ZU1Xir/WNAf5ITI
         KDxEgSfhmgUmNu+msrWhPC4EjUSHuE+o9smOhBWhZ3AtW/aiYXYFZu/PNdfvPWDCCrr9
         euK94QmB+LuThlnlHX7hs7gLBuyGMws3qSPs52FULtyHS2mfACCrwH7hCl4g/Qtkiv+v
         RGlqPrRRFBOndJegAffPoW49DoIOQbGe9GZ+HcOuIon1Tu0VZt2JHZoaJxo7L+DjU885
         7G9Q==
X-Gm-Message-State: AOJu0YwMMTDuYqKw4Cqox3L+LDI0gS565GLWuL8DYCebNxSqbf9iEHbu
	8Re0DrrTtg1u7d7uqsDcW5/RaCSw1z0VSo83BKWRL20/vWzRz546aAypIqjyiyKQ
X-Gm-Gg: AfdE7cm7MQ0vqOWfpop/wJwYLoxQqPiW7fqtdgOMNt+pTeivzWErFt7U1zeRSjSSceb
	fSTBppXPDY5BGXEm3Vy8LAysM0uzEGJMs8hB59O1zPo9YHYJR+dMrxFu7fZ+4TLVgI9TxIn2iti
	OB1p42U6A6IM8nivUmRy9ialibpwSzSi3c2BY6nH19zZsBhtpwm3nIn9lx69PXXqfmRQ8XiSr3z
	iXAo9SMMpZ3XG/IFxShwpdPp8f2fvR8zzJQ3Jm2yPxIj2dg0T5WXwKmddoAxXtTqD2yzAWaBcw/
	EDdAP55LdpUy5Pm1p0rjVbrZuhkNpfXp1XMgP0wPF5yvWBLL7hTf2soDKGVNlP/+hA3dguDyox/
	gPwpoPunPJXMF1/B8nAo1iWevighFr7VCYQ0KkkacJkNT+IQziA9RLVp/9eV1QvdGDxD8VWiRSh
	iQq2GQIewve/iyHkSd7Og8kkZbpoiEgD0HALkkjPRr1Knr45Gj29L/JM/R9XqtBFx56kW6xFb3c
	c9S8PXEsfWXWv+ZYQ==
X-Received: by 2002:a05:6122:469f:b0:5bd:b27c:bacc with SMTP id 71dfb90a1353d-5bdb27cc07cmr961310e0c.1.1782742308116;
        Mon, 29 Jun 2026 07:11:48 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bd78e999c5sm5756883e0c.6.2026.06.29.07.11.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 07:11:47 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/4] shared/bap: Check if stream is valid before attempting to release
Date: Mon, 29 Jun 2026 10:11:34 -0400
Message-ID: <20260629141136.947652-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629141136.947652-1-luiz.dentz@gmail.com>
References: <20260629141136.947652-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bt_bap_stream_release shall check if the stream is still valid before
attempting to release it just as done with other operations.
---
 src/shared/bap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 6f2f4fc11f7c..9dd07bc5f2e2 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6727,6 +6727,9 @@ unsigned int bt_bap_stream_release(struct bt_bap_stream *stream,
 	unsigned int id;
 	struct bt_bap *bap;
 
+	if (!bap_stream_valid(stream))
+		return 0;
+
 	if (!stream || !stream->ops || !stream->ops->release)
 		return 0;
 
-- 
2.54.0

