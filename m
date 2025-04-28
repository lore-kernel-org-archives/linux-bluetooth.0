Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D14F289363
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 19:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745869890; cv=none; b=DgBk4gcXvovLtI9PWuIZGpzMmP5w1zL7T+ZaxEV3yPJowYELgBA/qy5dKJ2L6bFYsZfN6r/Bwiv2aygEMg8P5NBYmUX/IOgN9NsfTQiNOWUi9wNjqF4VgefS5dcf1VZ33fnTlj3k9b0DByEzHCgwa/UB01huBZfomGSlMJHRw44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745869890; c=relaxed/simple;
	bh=QnIKf7xKqRPVGiJSyTw0TZO9X8KjEvOqzRHkBAj1+I8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NIZ2ZA5se0iXfUNFiNtUjaSGrlVrwd89GBvZo4VJ/W/ydUeNa5nHJM2jxQznQzcewKvCm2kUsLqJCtKAiYFdQy68BMrv9QgHXiMqu5+OQfsaCExvtt6fsCADxi1GVbVyMPSR47hPy5MTfUBjf210BO0lM/SM2n3mZVytGuqCXqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSPg3vgD; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSPg3vgD"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5259327a93bso1950994e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 12:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745869887; x=1746474687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rg2NnFMoAzLfNnPHsUIspeomj4aeRRPa5M7MDPpUqG8=;
        b=BSPg3vgD47rrOVXQ8ruy6tUvVMmFmZKruViZqfoGhquCqczSNwkZelsJyNPo9rbJ9g
         FG30jaUjrakIlVyuuc4NrHCwLaEkrSwfv0tRYa+F+zkOoGc8YfchVwQiEAivgiyWrx4N
         uhoilFamEHQfFp4CO/POgeg4W6uT3NCUkY//oRqclFu29JJMXp6PM25ICXJdsMJIINEq
         gqjTwwsdPPT5i2LOHJn9zE1Xjw5jVDrafoTB1Vy/SD4bTI/DEIFoZWFdk5CZfZXLeqQi
         03H9WmQq6RY/Elm8kbYB9WMKOPj6JH5VAoQ7SLtVu90FNvjNdIJGExeEFdC1rJ3ydrZF
         GCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745869887; x=1746474687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rg2NnFMoAzLfNnPHsUIspeomj4aeRRPa5M7MDPpUqG8=;
        b=LoAjluVBgSRVia0Oj/a5pPuKpQzHqcqq0nRQVGcnL7iUegoyrQXzU1uPza2A7TrbLT
         7/YmcoELmzQdpIz3PeJPcf3USewPai2aRKzuATv3Y3ueDdmZPzMYlEAt+jAI10QOow3n
         tUprBf5otykCWUCrqSqyUxFbmubFDhmQjOnRlTimgRiE9t0Sha2OmLBjbRbLNcKPQ+Eh
         lxfvWklft/ojV8yiU31iyA8xfBM52FJx5OpIz8CT3FUY9/hvMk3YwZsVGDArLAFM6yJw
         thIjW+U7LjFU2GB46Ltb7+EBVNaMRzqo95IW7lGEOcZeetz4BijlZXuHJ3uXpnKCIRtE
         co7Q==
X-Gm-Message-State: AOJu0YwzI7BpJEmAwFJu90kbhtODaHd4j1Ja9sWjGH8yMAtu/OyDDFZa
	P4bpGtxH+XW/ypTooD5fcqqx9LNEVo7WtIgZjcLJqLyLybOUlaiofc1dhUd0PGE=
X-Gm-Gg: ASbGncv89168rgaa/zaCBWUxLhY0Z8sESqA0z0II1dpZckYEkGpKOQ61J1PzYMQ4jf3
	GRpy4khRltpneORllZMPO8MisvbJuqC2t+xMxFARm+rDwLt+wTSI1HQQDyFRM0GYuFboj7GnZbI
	0LvLWez4avd1HENP67FC83vV0HYZ7OEssBdT98AnKg1H1MGZZvvmUq9UyV1eg5PKZErkpuhRR/W
	/HbsN7nQhvV23qtYoUpBSU6YVHEMA99XaCK2KsOFYmFvEHWOSipXG5LDQCq3Pto+JwN1tEDCK9q
	Nj4yQDRkeO4gY5sPhmUh1ZnOxekm3ZC1+SNLTNZO32qmBkR33eNcQN/6ork2XcfAXpSceGaiRNz
	+HAXvRIilZg==
X-Google-Smtp-Source: AGHT+IHK4px9bFHIfvtPZmSNQUDeQJWQQ9pW+ZspMRF0hE91mEb3ZrOaRqksR4eXgyKkN8Nn8fwJ7A==
X-Received: by 2002:a05:6122:d04:b0:529:b2:ea5e with SMTP id 71dfb90a1353d-52abf0421e8mr607727e0c.2.1745869887288;
        Mon, 28 Apr 2025 12:51:27 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52a99279c2dsm1067669e0c.27.2025.04.28.12.51.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 12:51:26 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/5] main: Fix comparison of narrow type with wide type in loop condition
Date: Mon, 28 Apr 2025 15:51:18 -0400
Message-ID: <20250428195122.2000808-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In a loop condition, comparison of a value of a narrow type with a
value of a wide type may result in unexpected behavior if the wider
value is sufficiently large (or small).

Fixes: https://github.com/bluez/bluez/issues/1213
---
 src/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/main.c b/src/main.c
index 6a682e9b921f..3c51a0092425 100644
--- a/src/main.c
+++ b/src/main.c
@@ -501,7 +501,7 @@ static void parse_mode_config(GKeyFile *config, const char *group,
 				const struct config_param *params,
 				size_t params_len)
 {
-	uint16_t i;
+	size_t i;
 
 	if (!config)
 		return;
-- 
2.49.0

