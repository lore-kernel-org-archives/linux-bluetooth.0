Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90CB208994
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Apr 2025 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744921280; cv=none; b=EP5L0z/lnBVboYpyd2EJ386QC+E+MtZjnykdP1VpemhNb08UsLngoOd9y6DbBFga64ysN96qysfR2hnxohh6Zg7buqyivQUWK6jeAFn2s8T7hIFMs6TqykUzgWTt8AeNZsQOXxpMQlx9g5qQQTup9mQBlIg76BLOBms4m9BV5Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744921280; c=relaxed/simple;
	bh=0DX0HFNH/xXT08Q0Ihn5IPBDX3tfts2rz1oj1zZdjdA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mHPBh7pBib2/md5+uOfplExhWx7cp/ZAbo6jr3S/mNfNFVjUHpOwi4RX/rGZ+K4gUTbwdCyEc6q4Bbj17aO3Hhm43I+OVpR2gyx6EPVzlvNafu7fud8wOdx0HzN33aEOlGoDZfWucx5i47YaEVa6L2waTJZ8eI9zbuc23UrjjP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvRWNMJA; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvRWNMJA"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5290be1aedcso1835999e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Apr 2025 13:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744921277; x=1745526077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cr/HPiTL3wrJPWF/vXKujogvqLS9jFTa+yzupkKXVp8=;
        b=DvRWNMJAAiFKfkTCjJnxILOy17GADs5Ry5RMNeaUMVW8GoF3w2x4gBm5yFN2NoCbZr
         VGZxeNW8y6uoHFV8vYPP42NHLCkmkdHmwMck8NsK4fQdGDjgBNU3OLg4XV0q+RTGxc8P
         Jr5wCmCicQ9aC016hH1z02ShetxhV7VQpbATM9lLUnxfoXMzX6o+bNJllbCPCW1Pn2Mi
         xGiE9/rVUBPIdXLJDLDXd2obQ2cH+VZeSTSGlAYmOVnA+rQyyN6ZRUw08jSRKOaIHaqz
         fWBRj+E0jWSjLBUX6VRn8zseGUUfF+zWcwk6wxhSiQMzZ/p+VbkmrNgkpM9dCkAOU/Z4
         Ka9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744921277; x=1745526077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cr/HPiTL3wrJPWF/vXKujogvqLS9jFTa+yzupkKXVp8=;
        b=VtvB6EauAKU0AHl7p5r95yDD0aCy+Bkvr8leQSliBMOAoFpzr9r9J8CoCfywg3CWZw
         qRmjvDc+oVv3p+DpETQDkukLEqY/EfyXtQtnTZ26XY43e7KVJEDFPKYEHrcYC+GcFAY9
         Rgp2w4qMYUuBCzk3dLr8ydgFilAr8h4PJCBvIxduT+V0So0E9VgEAlN1kBOuUdyvlIjk
         rPonn9/iIlDQ8nCKXPpoaYt0RkCl7TK1ph7VCog8FW/68O1VZ+Ma0pWJ/3BKUzYj7bZI
         /Q5fUxhDas6VOQQH2AHVx+JyN+w7jG+TNjbNcivwcMk+vaCfUHZyUhY2oApZtgYwr+S5
         KP4w==
X-Gm-Message-State: AOJu0Ywi7xsqrT3PYZC0My5TjUbPiYYck369GT7CilGvYI91ht1VUsr+
	4pxN41eh3/Ib1U4Jsm2UfjNbVSpS4cMmgI5rZ+VpRIaaD4r5C/iYkAIXnw==
X-Gm-Gg: ASbGncvrJYZBvaL0JLcDavjQknHKOovgACLSSMSMY7vHYWdHLFd+n+TuMwP6gismTrn
	tpsxI3dgK9qZzvBmCf1vP8wGOw3u9C0V3+ai1xbS8toD9Q0W2unBN6J3AgQlaeyOkCtvGeUKlQj
	zuOPMiuQUDwp794bBu2F5wu/uVZuFXhZ4t+846AS3K/uXkm98kV1t/D2dsH4Vf1keFnAscdmQl0
	I4rNphDTihWvzPZBpHuFdm1dZUaIMtjbYCAfO4f16AWG5Biike6K2TK0g6RuEvLSybvV5zzzKfP
	seEoWJ5SVP2AUB/OSPHQdR9DUIvyqozPlKKD2D6V994pDFJWIvT4qZ6IzKf5flSFy26BxNvm2pj
	EWSxokEzNtQ==
X-Google-Smtp-Source: AGHT+IE1KF9Zg/8eqtO0J5OLW3AI6e0Z2Jnb0Nx9knekFMxdM3ROI+JiiYtYdrlLJMXzu03rY18q5Q==
X-Received: by 2002:ac5:cb4b:0:b0:523:771e:8b81 with SMTP id 71dfb90a1353d-52922d0497bmr1627848e0c.7.1744921277026;
        Thu, 17 Apr 2025 13:21:17 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8776468ca4csm106271241.15.2025.04.17.13.21.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 13:21:15 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] shared/shell: Fix build errors in fc42
Date: Thu, 17 Apr 2025 16:21:12 -0400
Message-ID: <20250417202113.80496-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following errors:

src/shared/shell.c: In function 'rl_cleanup':
src/shared/shell.c:1429:20: error: zero-length gnu_printf format string [-Werror=format-zero-length]
 1429 |         rl_message("");
      |                    ^~
---
 src/shared/shell.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index b7784217723c..631a07f35625 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1426,7 +1426,7 @@ static void rl_cleanup(void)
 	if (data.history[0] != '\0')
 		write_history(data.history);
 
-	rl_message("");
+	rl_message("%s", "");
 	rl_callback_handler_remove();
 }
 
-- 
2.49.0

