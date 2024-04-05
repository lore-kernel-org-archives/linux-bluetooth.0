Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18AB174ED2
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 21:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712351512; cv=none; b=P07hi2jbOhcylq9uIF3u9AVNNXa3jjcmaq9Obsf3C9HMy18TPLzbtB3mugr5uhOHG2357kdd2kkvEMTjBbP6yDTeP+RbI0iAI6l87rXuMVzoiPruiZxa/7JIxn66V6M2w+Uzlzdp78wwk75IlCZMv2XRzwK9/5TB6gQ+q21VpUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712351512; c=relaxed/simple;
	bh=oBYiZuw4EXH6CclXvwVXPz++tRo1ZT9usZqsMq50P3o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBxO/VbVwaGpO5F0mwhhRLRgkscZRCcpx43mHNOt0YZIwdhvnov2A4NINEne31f0Z89fE+kGpHsGqxpI2vO45KLoyQlMCecOP6YeB2PyZyhGHQwt/yao0Pw1O7GJT3T/BwKept1yRkY8yrEnU2QpE3sEerG36ZqvGdDIHG5oBV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mY0P1KDy; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mY0P1KDy"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-479e857876fso61275137.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Apr 2024 14:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712351509; x=1712956309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xhyNVQ9ZSEd+DznykOtJOMpyp8tgw0j029Fgjisiwo=;
        b=mY0P1KDykpBGGqJNrE01PgSfNXqz2Ad2UUAsAHunmKbjaqIQbuB718rvUKxIiEr8es
         PrkuBVDwZ7Mzb+mMhzmdbrlw3U6CtX/OAYY8QWele+3w16K/IoGijwZ+s7vqvn7ToNp4
         OH5oJxNq8kOKcpj+3zLLKiAWDsKz1soAdC4STuNk0UK0DRFXquudkQLrg6CkcU4IMSad
         aqnD6fyRES6qQOz4SNObJyX3cbCcJ3N5sSsXg8TpwP9BKTtr7JzjD322JPA+CDoKXQ9N
         jAKYm/G7ZWdTeYYyEUFfIClvruGE+AO/tSakzXkAyj5813In6bDRfL76PJhTDeELOg0Y
         fWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712351509; x=1712956309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xhyNVQ9ZSEd+DznykOtJOMpyp8tgw0j029Fgjisiwo=;
        b=XJIcgYcqobFUoG30slpK/oRekBLM/wYPGViYZ4LlveTBCqofvPN0Q/wLSO50qLc0oW
         DhxyM3+oXdR2X4hV1YmB+4u3gEjXaU6Tw0JmuB3XX7HT1++L7dtik4sjAxmS3z0wNavN
         nXh8R5+zIByhRsgig/H/JwXZuLmk8PpL70RBWgbz+TTRmz9kyQ6hLgPzE9A7lqmKmZ3R
         XT682wKk3JqJDjmZr6kSbQ2tuqUgORpbpKx6+8LeE8+uBBrIFW6ps3E0ddUz4zTsfjiN
         fXfG6YfUKGpFPTEbh4cJ2+/JB+6YJcN35fq2IdhARWivMiRXUX4VSR1q4qbn08L90VB+
         /Uyw==
X-Gm-Message-State: AOJu0YxMYGBNP81VE0pG/GToP63gLbSgWKENjS6dGi5OGzJhoTfPZPUI
	W5WbZbefdvwF1dUL+Ox/fkzM7SV3dtNrQDLM6VPQu5OjSCy+zyXVRshY/EV3
X-Google-Smtp-Source: AGHT+IEr7oPWl7tbMdMc8+69RnbZb7N/tA1lD7dYKtCXCpbVXYz6jETZ1M/8TRArlX8bqpACBDVY+Q==
X-Received: by 2002:a05:6102:dcc:b0:478:763a:e0cb with SMTP id e12-20020a0561020dcc00b00478763ae0cbmr3410021vst.31.1712351509123;
        Fri, 05 Apr 2024 14:11:49 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id dx26-20020a056130291a00b007e3d1347195sm306723uab.3.2024.04.05.14.11.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 14:11:47 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 2/3] input.conf: Change IdleTimeout unit to be in seconds
Date: Fri,  5 Apr 2024 17:11:44 -0400
Message-ID: <20240405211145.3463154-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405211145.3463154-1-luiz.dentz@gmail.com>
References: <20240405211145.3463154-1-luiz.dentz@gmail.com>
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

