Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626159;
	b=fgKRS2WgUqgTB5p+Huyl6xrCuOCO4GsAxZlgmttEmMN38JvWI8QH9GqYn+9SA6i7be0F
	 QgNCAmu9FKNXWgKv+/SdW9czDL/BrjHokXIYO24jWqSuoO2yMHjgJ1tAqQiUEG32MQVGY
	 adRTe13mup6faQ7X2cRg06IETmJJ3P+UdjDlcm2UuVhfq9Cp8pRBTyKjOCO6slsdiHydo
	 3nQG1O1x2brhDudmHSs1fzrhXJZQKkFqLvDGT91L/XM2AWFOZNXNJ+2La/PuozBd5T+P4
	 uKnZMWoQNaA0mqZAldhwE8ACtqHnn2OLqeVpbHCdzg2p/2jaTWHuVkoqd32T8mebLfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=N+nvHJY/kEJldzH13QQuYrjp/JUMBFAhbLsoPgo4YvA=;
	b=dSnAAQGGzpnsvqp6U1UsRIjlBazt4lA2/Na5ylgrlfLxchgUpSHgJvp5wa9zIV/EyrTt
	 tsQxc+cHWfhaVhts1T0tEvJUoogWcn/sQX0cxnkOEe1t8UWNtRZglfd0bNQ+ZVt9/LC5N
	 DOaFUuiJFUtu7as5dGOgyZ+IUJaCQWEqMx/QPzsWVXF+0ZFR0s7sNM6e3bxqFLwEqc2Xm
	 PJdEbWD0BjRPZiiRmGPMZUb1okDXogBwbcZg60Af1XpIUQjpvEtwuiGaLUtjF2WxFbM5p
	 dVP/hMQ6ujbScsTR6srwKGURKRXJuv8rpT6nglNuYPV5+aZQoF2rMNRs43RANSw96jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=jdUqiLAV;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE68606A321
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 17:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBE68606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=jdUqiLAV
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-490d59c3f0aso2771840f8f.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 09:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795626157; x=1796230957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N+nvHJY/kEJldzH13QQuYrjp/JUMBFAhbLsoPgo4YvA=;
        b=jdUqiLAVvfrH/TYHbhFmOB91dAF0ZIDF/1C5mINHA87UCzdzUyNoJDZDq2J6I+DLwy
         fiHzJJuqTjFxjqsrXAp5ir2EpKQvvywRKXAJeGquLJrICL3BKdFPgS58JA3tL2McktmD
         iYfdrnVrVBPGnReshwzFtMROr3NnsLziL2swo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795626157; x=1796230957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N+nvHJY/kEJldzH13QQuYrjp/JUMBFAhbLsoPgo4YvA=;
        b=S4oN/YkuYd6fX5MfcfUCCo2Shh9ctNKQJpxTZU3l4NGJyj4fLvq7Cuz3xxuOEK62hG
         cq2tx5NqGPzwg3cuoqtbykxrfM7HpZxamjSixDKHvMncV+tva9slT9/NsQN1E6NBezKm
         dniJrHpYVfP19IJWZAWhWcKCmzhaCwkGcXtR7/2AN16feUjguXN/lH9U9iAzUfOv/PfX
         1xEkSKNY+/5XOJMGkgAqAmYOSpcHI1Fsl0URfSVJm8b6U2zjGZo2Z1Yn7OApaMrfC65x
         7G8ooJKqA87tIBJAMQHH7ys86i0dds2wGuM3btzS5QPaPlLUi0ZTwjpv1vLTHpByrPpd
         5WCg==
X-Gm-Message-State: APuU4Z/lRF3+qxC81qIdl741/bWD7OpoVUv7hg2B+td+cr+ygIndBTn4
	M1q9mfADmySTH+QSEmxqPMKWJu/dd8GxfSAFnapxm1cLllG73nDl0YG78SvcJG0vnr6wIB4fP4t
	MQBnz
X-Gm-Gg: AZFdTZdKRaSUQPfmhtmPAZw0aE/xexbltk/WQSUKijix59bfMoJ+L+YIuIPSIRl864E
	mmf4l/MvPH7OqVJbTuITQ/uwo2BQvW2GP4oiUM+EmvPenS1qziOjyjBM9jLqh7fJRwPe8f+Lm5C
	NLDZS5Ff0DS+Tw3snSoIOSdnq234sv+FFnffCho2VlslPKoM1v6SiXQw4UqRuuY15BPlBFLMwDn
	Q/X5xO5jgqzg2vZY/PggpJlwZx5xUOQaB+v9hP2B4D1Mdl4OPWh/mUtgwNjslDgu5UwOoQYB6df
	6KP+JHLmGEY20WX3uxFVnU2lGIZn40rdurebVhcj+r5bslhRjZjNMPSxHQ1pTHfAZdnbZ1Pxrcl
	d4bifJ4t/QOtyGgJ4X53SplHUme6Ulm13a8EjliZp7SAPfpIK6nfxovxFTXzwtAkyXj9muuQNF4
	URx+qO0RsLrOAIQA7RfrxUnKXEAccte2zq4DECxzqKnGtWm3831nloSafbsYwV3isf2PnrFC3SS
	dE/y6jr9Mti/jjRX5ts+E3C/SA1C3uMv5i6ZEkyUwwk6PqYC76sMy1RGqEKfaMY/HinRvyGFITM
	pvn/qhoGn8bZJ4i9vWJG3Uq8E2iTgeHPhEFI7VWHRiDhpQEaOA==
X-Received: by 2002:a05:600c:5309:b0:4bb:62d5:4ab1 with SMTP id 5b1f17b1804b1-4bb88924a5bmr378148665e9.33.1795626157316;
        Wed, 25 Nov 2026 09:02:37 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:641b:80e1:c5fc:b7eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm728785135e9.13.2026.11.25.09.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 09:02:37 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v4 2/4] unit/test-bap: Check that a broadcast sink PAC can be removed
Date: Wed, 25 Nov 2026 18:02:32 +0100
Message-ID: <20261125170234.1648990-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125170234.1648990-1-simon.mikuda@streamunlimited.com>
References: <20261125170234.1648990-1-simon.mikuda@streamunlimited.com>
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

bt_bap_remove_pac() did not find a broadcast sink PAC, which left the
PAC of an unregistered endpoint in use. Check in the teardown of every
test that registers one that its removal succeeds.

Assisted-by: Claude:claude-opus-5-5
---
 unit/test-bap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index bfe98a885..9508c503e 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -1307,7 +1307,10 @@ static void test_teardown(const void *user_data)
 	bt_bap_remove_pac(data->snk);
 	bt_bap_remove_pac(data->src);
 	bt_bap_remove_pac(data->bsrc);
-	bt_bap_remove_pac(data->bsnk);
+
+	if (data->bsnk)
+		g_assert(bt_bap_remove_pac(data->bsnk));
+
 	gatt_db_unref(data->db);
 	bt_gatt_server_unref(data->server);
 	data->server = NULL;
-- 
2.43.0

