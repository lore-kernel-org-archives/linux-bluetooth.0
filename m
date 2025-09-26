Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63C0242D9A
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Sep 2025 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903619; cv=none; b=boSs7xuDTEIR0zjMoaZIDvJKIdEfC6JcxHSTZN7S5xpUaRLbONnIf3SovAJtXjEoOoLYb/8ac15EvA4IEVPMn+sUtTpK++c3n3UY4rKar9YlOfdGV7MLIlmg3fUGzDimDPS6bpWy5p8NttheDbxxJ3Z7kq9/5mt5q4uL+f/IllM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903619; c=relaxed/simple;
	bh=fAOCf60k9DDJEIBvhvdsdH+kj0ca6BoSyxRpJKZNZW0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFtYr9yVcwy+30zQ33BX62nTTbmNhG1L50BsvlR+DL+DreE6mXwGodjHVwJI4AUJjI2kieQPEYjpAKGdiWTP0l38syOlGnLkZekh4qjmawpyU7vBHrUUHLTp/csutEfdn5SjF80rmvJC8ExdfTA6tm6f58ipHHwDs0g1LJDRY+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qb4QJYIR; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qb4QJYIR"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-892196f0471so933219241.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Sep 2025 09:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758903616; x=1759508416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ejn3PRyOEHNFsUx5Rdh+W7FKUdHJHfo5EeftD9m5G1s=;
        b=Qb4QJYIRz+cHqV3D7UuWFYM+qVzzbDAdG8VyBmw95W3j1/tLoe7Fa/W8s14fh44Kdu
         qoShP7OCZ+Lua+Aiy85ZWLYzkBIf9bwCy9AP1dm6SEgkTTuOqUqkZFsN8CedLVy9+0p0
         4AJtdLVQF4oXmHQxkK1DJmWh/eOvj+jnYk320mP7hbcHZKPDttEsa9L8uAEd0h5W8BsL
         /mMi5o/NkU6tNBWaMuc6PVMBfSurvtynhY1QJVU8LF/19PeyM/IctAJpPvOASTs3WgL4
         k7fBcrwv6CXQSiinfNCjbu6sWf835IaAkueCiaYwyVEhKGNAadPMrPfa4eQI27soFfzn
         wImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758903616; x=1759508416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ejn3PRyOEHNFsUx5Rdh+W7FKUdHJHfo5EeftD9m5G1s=;
        b=PwRydCUKCBo+3x4AC6SyDe785ksh6whRmUCnjJdzf5q5nLx6e3mPRN6R+EfsGE1/Q+
         Eh4QjcRNi1/DvVu8qC6Sbc21Okr+8kVP4dRwQv/i+ypzXeb6Ki2lZjbFoytt7FC+Gz6/
         JiDQDxcUekthvd0T1zX1rFzBhj+PA03Aj3Y8QS9sFRD/8osN86HoI4M+rqKT5B+lYQfQ
         3PjmEimNlPKqb6PVkZBsB6fcAtRQvqTp1eu8R+oygotS5CUozSUwvbB4vP8IvuHLOruF
         Rd18baeiYWqp4c77hOB9qUJTuYQzaosG3lwVZE2/zppSE7yPEYa6z9CEcVCuz9iXKSU1
         /BvQ==
X-Gm-Message-State: AOJu0YxCIDE3t8W43LpSy46fOLVv5uzn2I1QfXYWuJikdAFGC0HepwtL
	s1X4Paa4PHdrUFIdz5P3C0oKygsUQ1y/qRP2P6/FD2QnuB2s308AmQyzyWfB0Q==
X-Gm-Gg: ASbGncvX03E4bQ8tgz++v+oDvuDjjBZ3gvZdnsGhGQp6quX3bfygcfXDZb8XmHrhEN+
	MU7dAEZrhEdGgVpgirdDC0mwQr0Xj7wJD0jFshoh6+QGaAY3uxag36UpReT8yjNVJXAW+9Cvnic
	cpD8jx5Mgt0+5E/qYL6G4uvmLOJj4xJkwVB0hVODKhMCCpg3ZHVbHubq5wPdVU6Nngpmd/+005d
	HyWJqmO97RlFxHv197SsrETvGGpCSjzToD49TN8AyWAjZUnslv4C+5NBAnJf385U9dfw557BDyR
	Z5BiXKAC4hmms71cpm1U+Ii22pcSxZg+fc+dxsceh4NkxfQJL3OkAiXLA6waBbRfUPoPfyqWc7X
	fuJRgmKH6PiLlfLjhKuuwk04NPwBmDUkzCG69B95gP3At9N/an8bvEhn1wP5asipfmw==
X-Google-Smtp-Source: AGHT+IFxqwb7dMizlcYTyXNXyIDOIAAswGGutM4whYKi42ygie59wyJgItEGPHcMiZ4UJ1QDGJzPlg==
X-Received: by 2002:a05:6122:308e:b0:544:9414:105f with SMTP id 71dfb90a1353d-54bea0b83d9mr3336206e0c.2.1758903615853;
        Fri, 26 Sep 2025 09:20:15 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-916dadfe156sm963086241.19.2025.09.26.09.20.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 09:20:15 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] btdev: Fix advertisement state
Date: Fri, 26 Sep 2025 12:20:02 -0400
Message-ID: <20250926162003.754423-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926162003.754423-1-luiz.dentz@gmail.com>
References: <20250926162003.754423-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The LE Advertisement state shall be updated whenever an advertisement
is disabled since if all advertisments sets are disabled it shall be
reflected in le_adv_enable.
---
 emulator/btdev.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 67c932d53d59..1a0f9ef2de58 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -4789,9 +4789,17 @@ static bool match_ext_adv_handle(const void *data, const void *match_data)
 	return ext_adv->handle == handle;
 }
 
+static bool match_ext_adv_enable(const void *data, const void *match_data)
+{
+	const struct le_ext_adv *ext_adv = data;
+
+	return ext_adv->enable;
+}
+
 static void ext_adv_disable(void *data, void *user_data)
 {
 	struct le_ext_adv *ext_adv = data;
+	struct btdev *btdev = ext_adv->dev;
 	uint8_t handle = PTR_TO_UINT(user_data);
 
 	if (handle && ext_adv->handle != handle)
@@ -4807,6 +4815,13 @@ static void ext_adv_disable(void *data, void *user_data)
 	}
 
 	ext_adv->enable = 0x00;
+
+	/* Consider le_adv_enable disabled if all advertising sets are
+	 * disabled.
+	 */
+	ext_adv = queue_find(btdev->le_ext_adv, match_ext_adv_enable, NULL);
+	if (!ext_adv)
+		btdev->le_adv_enable = 0x00;
 }
 
 static bool ext_adv_is_connectable(struct le_ext_adv *ext_adv)
-- 
2.51.0

