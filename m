Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3515B3624A5
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jan 2026 10:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767866510; cv=none; b=hojEmhyzQiunhhZ7XTzQTB2l3vh+wOKQRcztzrKzlB5VIxxnUSUvGTddAwj9kMDlwwZ15V4sduLB1i0xpZvJUltXcsf3sgLT8tlnAxWRVG1BLrC1JmCzQPI1FqXUKRbcuhEdTaFI6jQcqq12outO+8m66k2PGUoWxT2QfBpmfs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767866510; c=relaxed/simple;
	bh=t5/8nvc2TG0C0BKCJAZSyYfq10XwtltDU1p0P5o1aOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4qTGq4eLz6lZyTH6QlU+ZGixqcdW2MwsEGcD613FC9vJ/Hf77lS2o9rKPZVC3PWVhRG3G40qS6K2afpLSMkKujPsLo8g8j0yJIbSfLP26LaU5mt5hI2xlKXF7hep543928dWXFyY7cfRd8ittScx9nmYwXl3LRc3xidDFkAeO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZreI0yA; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZreI0yA"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b73a9592fb8so329715266b.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Jan 2026 02:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767866505; x=1768471305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnsnWV5nkwH7chc/fwj6LSKS/VbT9TDD/OhnKLg55Is=;
        b=AZreI0yAFWYKk+RVcVzsWNYwo4fHFM0MWtX2f2Z1SJlLqrQl4qqTJFaUgkhlKAcI/q
         77nAKWWD+3zPe9tvf3yFKt8//IVWnRB8+CUT/IhNch2+lzUnESqhXF+32OjhzQxp5Cjc
         Jztr11pSRkTVTsf7ZnMkNXb5Su6+PnbPfw4/Jz4QvD50mvC3x0D7N+gEH13Wyg5+ke02
         ahUUMsFwKcHbV5mxp/UXl8Ac73z1cqf1Bl85Ft0gUiIeiG+zlji+JGFEJ4u8WrRVt/Ma
         hPTJwor/CT7BsKAL42Ip+7mUdDGHeroT05CVVJEHGmAc34akNLk1e6JzHm9zJn5opmY7
         hshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767866505; x=1768471305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NnsnWV5nkwH7chc/fwj6LSKS/VbT9TDD/OhnKLg55Is=;
        b=iiMM+VV5FRhzm4GoFh/uIpZ/I9D+5OJqpXcjaLufUPjijOMWsx/n0OMacrmzuWU9XY
         AwNa0z7KLRUZF+ucHgngNpodgWdHE+BwXUmzl2viwxNqZzQ8LJcdR67dBuW8zyWwIGSG
         rFNz9GM8JkoDWERmV/7PK8Pf88ItOvSy2bIdM1ZC/52jPtzJMN97IiRKXBZwaBhludnq
         6llyU1tahH0GkmTNFddLKAWmqRCx9iIDdJ5apFbfYMZLtf+QpCulf1H1nKci071FGMzU
         OaUTO7zqBtijLxcTdn3xwywzvGR9vDCJWCAzg1iGhlsXiBTfElS7UVljdSFswBH2SupG
         J8MQ==
X-Gm-Message-State: AOJu0YyzU51Siy9IwMb+7rWYggWPvDvMQ8Obpvx8ccVNx2hER+ak8hyb
	/1RN7oQROPRkGo7tLhZr7U/wvn+hg6a+3x0IfUKsflEHjekz3p4WT4GhgvSYvg==
X-Gm-Gg: AY/fxX4+ncx3KpLRaGfxKBIM6UO0jZZO/OdSjT5ahPGLDf1eWHSGpncDj2YliYhJkhx
	YfkwFiOwvSws6UOka1LU6SawxUbsHrG0kDOmR6KDIDZin3Xbadyz5YgOeJT5TPji2Jc1pqzuU2I
	yYZqggiGMqTSw7GqZvT2+MCtT5WRUHLOZCNNU98jjnRdnTnPFp33e6x0XqfzlRCjZ58/stfDSpI
	G/VDWFACqgJkQIlKav9c2Lmbuy2JS+lSOfmdDFTL0JcTaXIq/pFoBpW1HX38clwrvRkbQ0VdQFI
	addKyxzBVHLJkRGG0B8wo3d+xf1VwxPGBbG3On+Lo3tAj6QotRtHKh6Jg7nxTlLKi4DGOOBtmLO
	QdabRqTEWxGytk4RfpfKceXD2pG8Soy3CN7NEK01KWhEuaFj5rE4zWpaH4eqt/WzzOX2mdEw0Jm
	puKnO1K9A6aKCpsLJJwIMul0x2BshbdRmVj8w42su5xZQ=
X-Google-Smtp-Source: AGHT+IGFnam4aNIXlL+LobBZp6yWLkCQwuOfd9hAzNwxzFJPFOcCTl/7Z+jfHEi/hcDe7yvkoZCHzw==
X-Received: by 2002:a17:907:802b:b0:b7a:1bc5:14c9 with SMTP id a640c23a62f3a-b8429b9c13dmr691321366b.32.1767866504580;
        Thu, 08 Jan 2026 02:01:44 -0800 (PST)
Received: from yaaklasse0 (80.209.45.210.static.fibianet.dk. [80.209.45.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4cfe6bsm746254266b.34.2026.01.08.02.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:01:44 -0800 (PST)
From: Lasse Dalegaard <dalegaard@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lasse Dalegaard <dalegaard@gmail.com>
Subject: [PATCH BlueZ 2/2] device: fix memory leak
Date: Thu,  8 Jan 2026 11:01:36 +0100
Message-ID: <20260108100136.486675-2-dalegaard@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108100136.486675-1-dalegaard@gmail.com>
References: <20260108100136.486675-1-dalegaard@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

device_add_eir_uuids creates a list of added UUIDs, but it was never
freed.
---
 src/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/device.c b/src/device.c
index c8aaf042f..0842becde 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2453,6 +2453,7 @@ void device_add_eir_uuids(struct btd_device *dev, GSList *uuids)
 	}
 
 	device_probe_profiles(dev, added);
+	g_slist_free(added);
 }
 
 static void add_manufacturer_data(void *data, void *user_data)
-- 
2.52.0

