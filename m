Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28937E770
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Feb 2024 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707504764; cv=none; b=Vrl0iXV/l9nKiHTSvrOmwI/6fBeEJW5YQKsTreSNGmtwe8Ci+PGiNdtCryRhjgpefpp6/LwjVqKbCsscI/xw1IoxfeFVdcsTZQ/pq8GmVnmExTlAc2Vhuep9eTmDd8YY0jkHKDSZVGWvwwBA3rXZfFhMExPfiaXSUWCSAf7ji/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707504764; c=relaxed/simple;
	bh=beeQn/gyfJ47So4yCSma52+M11bk3Rx1U42gIB+DhDU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9lqF8KPVXFQznlOpwZTgsnxQtURcKSWkYP5pgJhjV8cYZKuXy3UQ1XANGGi6DjPkDxwY+PQUMnI3QY+1SSvQTj4vQZa6AMZjft1OeC4fdI9cCuo5bcjzyERQufG9auF85MqHzwLhwu1JxOZD6Sx8KlxRucKB+wNGQ8BUTiUTV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmNQ/495; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmNQ/495"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7cedcea89a0so531588241.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Feb 2024 10:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707504761; x=1708109561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qo5zYZ+TMVl73Tg60+3Tg0r7qMMUMusb+RfFhPG0uT8=;
        b=nmNQ/4955cvgU2FAJ8rhO3+pcmQzn9dIvdIP9fWGvNBiLis3IIciXNh5agp6iLeIBD
         KTfnAUoflmhis3Y9hQI9gyuRYP5Pj//UX1yxrcF64XvMciE4pBHEhtTefus2u9Cpkho4
         Iu0LtMP5zWth2xIFs8MQIT8C/djdqGYSW0nCbCBUfeX1baJV/YkYDWaSUawrMw9B43eA
         ASi1UElVcIdLFRBQx9Da/BJDMbftWk/lLNcNNw4JEBH8HsVuA6IhUtMme95nRNNypamQ
         0eRt+CU2OoL6GgcAdkRp/N8WRdz9TALKMJUgRQqD4Gzvp9M5DAwDnVoOPpM7gtO29/Gy
         i3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707504761; x=1708109561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qo5zYZ+TMVl73Tg60+3Tg0r7qMMUMusb+RfFhPG0uT8=;
        b=ro149EysII1Ce/4d5WBeIBW6IImziqibn43EPL7u8OD9PxH35Vlj9G2QdAoFBLjiWR
         HsgAATKIM5D1kKO/oevyLIJidMb+KNWFHyI789yytDZtoAHAFJfiD+wOs3bPTVBKXGm+
         SZlkHwZFiQY0h+fGeTpM4ZYd43iAMnQRIOytzQJ+gwRBsRX5c2rVNbXYDX4l37jLLEtl
         SNt7kmBpxuzy/in7fYXyqd0xh13XlqmXtRRWCAzx3SpsJ0MdzkFc5Pm7gJjcu9bUFB70
         nGBTtmsHcCvzwAU6sLEF4bfma4FOa19yZqeP4zM9548slkj/YejjgMdlLOb+L0oVdXHv
         aw7Q==
X-Gm-Message-State: AOJu0YxC7UVwpdkGBAZMXgn50+7MyUv1LVwuPz7GyDcVs+mEh+1khyfe
	7WSdyGD1zw23nNW10GYNOpE39wZa8X0rQWl454/jNjALok8JyZeEvZFlpgkw
X-Google-Smtp-Source: AGHT+IET7Kcds+046R5B2GYUKEMtMTQMcePCboWKdTYoGppjF4ybIZROG9NgHdXmEhn6FMK5BP93QQ==
X-Received: by 2002:a05:6102:2a61:b0:46d:2443:6ea9 with SMTP id hp1-20020a0561022a6100b0046d24436ea9mr329545vsb.7.1707504760794;
        Fri, 09 Feb 2024 10:52:40 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id p7-20020ab06247000000b007cea1ac338esm116989uao.27.2024.02.09.10.52.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 10:52:39 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/3] input.conf: Make UserspaceHID defaults to true
Date: Fri,  9 Feb 2024 13:52:36 -0500
Message-ID: <20240209185237.3611995-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209185237.3611995-1-luiz.dentz@gmail.com>
References: <20240209185237.3611995-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes UserspaceHID defaults to true so the plugin has more control
over the input device lifetime.
---
 profiles/input/input.conf | 2 +-
 profiles/input/manager.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/input/input.conf b/profiles/input/input.conf
index d8645f3dd664..00a34eb63de1 100644
--- a/profiles/input/input.conf
+++ b/profiles/input/input.conf
@@ -9,7 +9,7 @@
 #IdleTimeout=30
 
 # Enable HID protocol handling in userspace input profile
-# Defaults to false (HIDP handled in HIDP kernel module)
+# Defaults to true (Use UHID instead of kernel HIDP)
 #UserspaceHID=true
 
 # Limit HID connections to bonded devices
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index 92789a003c89..69ed646727d5 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -83,7 +83,7 @@ static int input_init(void)
 	config = load_config_file(CONFIGDIR "/input.conf");
 	if (config) {
 		int idle_timeout;
-		gboolean uhid_enabled, classic_bonded_only, auto_sec;
+		gboolean uhid_enabled = TRUE, classic_bonded_only, auto_sec;
 
 		idle_timeout = g_key_file_get_integer(config, "General",
 							"IdleTimeout", &err);
-- 
2.43.0

