Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC945D8E1
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 15:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925006; cv=none; b=AnmgHedIprPR1uGk/pCu+nQbR62+yTIyYLbhOp2AVZILH6+ILTGnX/Jtzzw3L5kbfE9vRQBqx8C16f7rBeAWg+FzciTCyW/PZYT9oDXh8clbG9VYzvnmowDycMctpLpF6aqHDTex35ZKUE1YTExGZQek65Ho/rGFI4mczMe6kBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925006; c=relaxed/simple;
	bh=yTWOrmIIgZzN/29R3bZfMVoLcYYVP6d8SUJHNdpNQRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgIsVAQMN/u9Wz18LNwbl92mEIWd7cJSr5EhHN/l8D0T+T0T8z52agSbjHn2qXuIkMDAomSZVvuTvjCezdcHu88QzgZBvl7W0FCdj+hhu+jrTeYUDo18HpqXEpqoqyTIhxo4d5DPQJprVRpsNWTVV9AT8DI6ngCn8lbmVATyHMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl; spf=pass smtp.mailfrom=codecoup.pl; dkim=pass (2048-bit key) header.d=codecoup-pl.20230601.gappssmtp.com header.i=@codecoup-pl.20230601.gappssmtp.com header.b=bBPbeO+E; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codecoup.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20230601.gappssmtp.com header.i=@codecoup-pl.20230601.gappssmtp.com header.b="bBPbeO+E"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a2a17f3217aso724386866b.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 07:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20230601.gappssmtp.com; s=20230601; t=1707925002; x=1708529802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/FMWCjttXSEu4C0rFe6axm+Nj9+GlzkDV9dkDhabrY=;
        b=bBPbeO+EF/2clQh5RSpOJKG/qQ/WCB2LLKI+5dJ8vpX/fG6dsb342fGA/mvZja7OHn
         a0oFdJumlPx36CcEnYRkrSH/UkkkiBmIs+XppHBPr2q3Igz4KOX9aK5jHcnRLKObUgeb
         6cNkYvQ5ixDxgJnNQ1gXND3RL63vrLZJkMi/xKi9yhaU6WF5CtWe95WMV4kburwLjDew
         IGYhUTFij9l4yQwnCMap9v7sO1yFlI9d+dHtBdsEF0Su/G9lCOPpfj7/hZiiFQNdOOvH
         IMVHNRP4n2ui0hJ3s746T5T+HCviH/utvVNVtrfiuwTlSRJEZT88aC92ZYoOIi6OxKLh
         U87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707925002; x=1708529802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/FMWCjttXSEu4C0rFe6axm+Nj9+GlzkDV9dkDhabrY=;
        b=WWq3R9APzW6N24/qQ+aOVcrYP3g9B/uKe1/QlmneYDwG4mfBbHW7NtJwIClJ7HvC5l
         s+JWAdrDpwI67Mcq32TqG6ID7n6xjxQo7V9MILlIt8zfn+Z3UiI4yDRRk+/qNxaYnHup
         +y0Ovo3b2qYXNIWA+1dmaeZinWBnl4PIJkBURLb5tHkm6qySqwdsM0y6gbdw1T0amli+
         rWG6Z7p6rTMwr5gZ6DA+ae9ZZNKg1JPSmSTOVDvVfqCqEBwIGIHKNQ5uU8pupYiziefY
         GMjykTcym0bZsU46vmJP1Rh4RS4mnrchPA/QiPG8leihDuYLrAt7Ci10BjW+CT7ySE0X
         al9g==
X-Gm-Message-State: AOJu0YxvGaE7BMdWzRC8Q2/d8+96kwRBN90Km7CHt8lMX2uxcZMaNMde
	rlQz/Jsr2z9O5EHyWCS43Pq4NsEA0HVtdO/CO2DAzPIDuzQrAHCaZKz/8ubLe4SqCpQHG+LKRmW
	L
X-Google-Smtp-Source: AGHT+IERbirsblPcJFH7+T3+iJPhoz7jGwlhb+TN66aXiuCoT19M8IfsR8ucUMnnbFdBNRkJKZk/Gw==
X-Received: by 2002:a17:906:11d8:b0:a3c:8875:3e46 with SMTP id o24-20020a17090611d800b00a3c88753e46mr2088208eja.7.1707925002347;
        Wed, 14 Feb 2024 07:36:42 -0800 (PST)
Received: from ix.. ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id wp14-20020a170907060e00b00a3d36da3a57sm858872ejb.7.2024.02.14.07.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 07:36:42 -0800 (PST)
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 2/2] bootstrap-configure: Enable external plugins
Date: Wed, 14 Feb 2024 16:36:35 +0100
Message-ID: <20240214153635.156548-2-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214153635.156548-1-szymon.janc@codecoup.pl>
References: <20240214153635.156548-1-szymon.janc@codecoup.pl>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure we build this code while in development mode.
---
 bootstrap-configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bootstrap-configure b/bootstrap-configure
index 8172840d5..1c26909b9 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -34,4 +34,5 @@ fi
 		--enable-cups \
 		--enable-library \
 		--enable-admin \
+		--enable-external-plugins \
 		--disable-datafiles $*
-- 
2.43.0

