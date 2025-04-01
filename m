Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32462204866
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Apr 2025 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743515350; cv=none; b=fPAtJ9VQKOm5101NqVv9RZcGeZAncqRhBBry5Zlh6G1YdvK2ZgAUfARrjSofXbLSafqptmUWNnCcFNa40esJcPU5sXF0bv6GzQQrtchiK2MmqS/4FSLlNLmROtxjxbMcDiNaUlLITR7KVKqXvBf7Nc0tmrSGpONTsfTxLH3DsLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743515350; c=relaxed/simple;
	bh=u5YvZw6bgIrpaJ4eIwzNDUc5C1303x/iSWxQbLc8Ixk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FhHk4iQ3h+Xn3v0GtP3w+sYZ0Rpj1wXnxlV2tT3jEm5BYcjN8lTWicxDjSvKHcSM+hp0EZEVXB6GRsdbLN+v2ln/nM8Rb3Us2PUEIpWBCFQF9X7AgOtzEe5WTnER79IRshdvAXtejaAJXOK96k7lgPNWJYUUtyXHdzVN2mWTicE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOEbXb3Y; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOEbXb3Y"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-523ed8ac2a3so2598880e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Apr 2025 06:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743515347; x=1744120147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mFzLHkUjJkRyg3tgT4bZkmoCufeSskFmWdkYktiO7D4=;
        b=TOEbXb3YGHqVPmjVoj9hdlH80TyqatautgG8Hme5P2D31IthUj7FoS70iWcKcj+Hcz
         ahXfNsfjP/lOwp0hk9zFbzwW29biqD83ts2Nho1q4NUthEVLQ+UCfAd7dGdhXBwJSG0V
         maGf/GjSMTfA6bEcj0pWSELk1qQDKI85Q9W+7TCrz4zqFbhHeJan5RIg0o9MMvOCTVM6
         kgBmAcz0yyKYvwen+VdU+mHPVrbLm7Fc23vE6B2gPERE45Q15fYNsFqP2zNBbKBBZakf
         UPhhp5usBvXrFBveFheLqf0mgA1dihfpJZo/B3vH8IG0JMwsY5lRx66b/bvbuVfVPA95
         OyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743515347; x=1744120147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mFzLHkUjJkRyg3tgT4bZkmoCufeSskFmWdkYktiO7D4=;
        b=vGJA+O77zDKyZy4eF1Q4LlDiD1gOxQIuXPU49GMy9DD3S2ZDgdkWg/IWOjUYv+c9vJ
         p1HmVF1Y2yn5miiVv9NBHaeAFzvr+d85KraVKUuE70L4LUcnT3XJUiOppp328Wg8DdHj
         J99pFGcN3DstEttgUXEVU3HSugWyT1ajytfGCYbs4RDs3klaC3QBB0cJnfOxoeTfQL75
         SsDqk0PeQrE0Fx7Dp2ggPcymUaP2UyNaKb7N7xyydUZkUhhC4PDVan//yq8vwvGBYxX3
         biYlr+Rw0GCF88I+/LY01VJpGAIF8FNPv1SVaxTEX2DrkE0ZSjs8Xo9hLJFvUIyPtyWu
         lCQA==
X-Gm-Message-State: AOJu0YynZ+dFk5soTQ/4Ir3oqEYv543TrkyW1Y57cX8mVi+W5t9agSAv
	r4yrc5dHf98Sw2cLf2FPnvhEDC1PXVX1ZCkp3nqJrCAL/RQGV3+z7F4/VZlm
X-Gm-Gg: ASbGnctHdW2mpjd2nCZ4XAJIEiseebtPiebsjl/p/CJUqGFUGmmqS+U9Vgmk+JkOoNX
	H+UqBO8g5Mmle10LYGMCLo0DcGw4ylS15ASqRGuBN+BltR5J0zFVOeerF4/t1dH8hPe77UWlORC
	7Dh9eAC621v8lmsnuFYnI96BiSCAo6sriD1hN24NEHvnLyUP6Tb8ewkYoQ5pA4cH+WC8X29aznG
	7RL6gYCZmy+zWnHoEEPFfTyvISkHMl+2haUCQtT4cymAIsdgqfyRWxaQC0GpvVDfWtHv7oAY35X
	B0i3ZdDijBiFjFyxykQWuitgnOX2xjPlF8uKL/XFaq+DgsiB5t1/gNnTYZy7W7RYHZVg5cJHCsH
	Ds0yav4gR23ovJA==
X-Google-Smtp-Source: AGHT+IGCOs+MoZRkn1DQPgJOq0/VGDbySTTmKJlPZz42o1/zO3eOVYPmlVs8bcM+wHjT26dev25EZA==
X-Received: by 2002:a05:6122:2510:b0:518:7ab7:afbb with SMTP id 71dfb90a1353d-5261d4abd25mr6773769e0c.8.1743515347349;
        Tue, 01 Apr 2025 06:49:07 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5260ead785csm2020372e0c.41.2025.04.01.06.49.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 06:49:05 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] dbus: Fix condition for invalidating path
Date: Tue,  1 Apr 2025 09:49:04 -0400
Message-ID: <20250401134904.3721187-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the condition introduced in cdd02afbb7ef
("dbus: Fix add invalid memory during interface removal") which was
reversed while applying the original fix.

Fixes: https://github.com/bluez/bluez/issues/1155
---
 gdbus/object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 54e04b983a98..f8c694aaffdf 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -810,7 +810,7 @@ static struct generic_data *invalidate_parent_data(DBusConnection *conn,
 	if (child == NULL || g_slist_find(data->objects, child) != NULL)
 		goto done;
 
-	if (!g_slist_find(parent->objects, child))
+	if (g_slist_find(parent->objects, child))
 		goto done;
 
 	data->objects = g_slist_prepend(data->objects, child);
-- 
2.48.1

