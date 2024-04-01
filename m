Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119C34EB24
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Apr 2024 18:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711997896; cv=none; b=pcjMpe++3v6FxHxJvib+7nmB6ogp2xdvMK2XtuCXJYC2kHF5YSDby8ExmZ5eIVg0yt98+1MS3ftKaDW1OES6lyDZbFSjO25GeOarZkADw/n7J9IFoQ06UekQUZW/na6mz556YiZRK4Ql1rWgA+nvrDbfwRHby+hIjNUIYoXQzvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711997896; c=relaxed/simple;
	bh=oBYiZuw4EXH6CclXvwVXPz++tRo1ZT9usZqsMq50P3o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+jHbPPDGda4dVYJB+zhVeQwDNrCeimtikHvY9CY8+TgeTfrQuSqnAajJwDZRKhI8WDRjxwfOl3uS9INCLaSHZkC5mRkEvwgLjRO+6ikAx+NfYQjGYawpWWAH9Ft+/TCyFpexEbzskib5+WVXVTH9Koq/4fiLvlU5pCdUnNIdAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WK0+NXLX; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WK0+NXLX"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso3366080276.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Apr 2024 11:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711997893; x=1712602693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xhyNVQ9ZSEd+DznykOtJOMpyp8tgw0j029Fgjisiwo=;
        b=WK0+NXLXdnNeKWkMkSqs6oUwHJ+SY6b2Uc4v2obqGrIYWeKysQk9hm6WknOHdXnai+
         wXPknpVLu81I4RSfsgGFvJnxeaFfjqQJIvLYFrp6mTfrYd+XBrmVt3349XC0Dy4JL0BH
         E+S/GcbyQjee5X/AHcKiwoX23MqJLB0dodwanuYFFk0dtAduoY0Cf0CPKD4urDbO/+N1
         ZJVTavwk8nJ/WfkWypNDJs6FkiaLvDDL6OoraboLRixfJN3HKrb9kNHfjpSv51epTLQB
         vs4SeP4dH95LY9XyejsWe5Ch9il5V+kvz1DPxxB9Dgm6agfhJsDF/yyYQ0PraAC01WMZ
         7DGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711997893; x=1712602693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xhyNVQ9ZSEd+DznykOtJOMpyp8tgw0j029Fgjisiwo=;
        b=m/D2X7PGI1BoKSyYWgkoCg6YRIo/5NtuYfAHgv9Gqf3R1bVFFYpcT7RijKH4DRZews
         /nkeTsFCfd12ucAFwWcRSVGvZFW/k0qU4HdX8JjtpYZ2e0uKAibl/0UYWp3pWTusW3hV
         n2zVi067UtvO2fcn+GqfadWOySQIApvaAPXl30eHjGKmeAaUtZC9auUGmxGpLLSk+4CW
         O2zPgut5I9rBOZouDm0G5+s0fUYp/ZUO9hPpUwUrysRgYb+Lz9IwTXtA2S4lW2VkTrkJ
         WpHqWwYKk/bzev+s04oQOMP568BkEUsB/tUekEC4TSKd/RbNyT1je8/lGGt6MrDWhAxJ
         ITew==
X-Gm-Message-State: AOJu0Yx28PsvCDGzamFC50iiQQPSvJXwvb14bWO+m1XnF9ekYTUXGGiP
	nu5xi4HLexdarY8avq7b9Yo2pir+o/EwlFps7dc17+sXhRjgsBygDgZtx/Mq
X-Google-Smtp-Source: AGHT+IGRRK97d1wbPKPqlHKvj1RE5Pgu+KUt+pca5JKxOCZoWwWBLvRIad3LOhOYia1iuQRLEkTi5w==
X-Received: by 2002:a25:ade0:0:b0:dcf:bf81:5f28 with SMTP id d32-20020a25ade0000000b00dcfbf815f28mr10192375ybe.0.1711997893281;
        Mon, 01 Apr 2024 11:58:13 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id o9-20020a25ea49000000b00dcc234241c4sm2153739ybe.55.2024.04.01.11.58.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 11:58:11 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 2/3] input.conf: Change IdleTimeout unit to be in seconds
Date: Mon,  1 Apr 2024 14:58:07 -0400
Message-ID: <20240401185808.2520694-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401185808.2520694-1-luiz.dentz@gmail.com>
References: <20240401185808.2520694-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This changes IdleTimeout unit to be in seconds instead of in minutes
which offer better granularity.
---
 profiles/input/input.conf | 5 +++--
 profiles/input/manager.c  | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/profiles/input/input.conf b/profiles/input/input.conf
index fc20c58b6b32..273e15bc9c80 100644
--- a/profiles/input/input.conf
+++ b/profiles/input/input.conf
@@ -4,8 +4,9 @@
 # particular interface
 [General]
 
-# Set idle timeout (in minutes) before the connection will
-# be disconnect (defaults to 0 for no timeout)
+# Set idle timeout (in seconds) before the connection will be disconnect and
+# the input device is removed.
+# Defaults: 0 (disabled)
 #IdleTimeout=0
 
 # Enable HID protocol handling in userspace input profile
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index 92789a003c89..f4598bcd4e47 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -89,7 +89,7 @@ static int input_init(void)
 							"IdleTimeout", &err);
 		if (!err) {
 			DBG("input.conf: IdleTimeout=%d", idle_timeout);
-			input_set_idle_timeout(idle_timeout * 60);
+			input_set_idle_timeout(idle_timeout);
 		} else
 			g_clear_error(&err);
 
-- 
2.44.0

