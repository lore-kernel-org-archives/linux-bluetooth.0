Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F2A205E11
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 20:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712865790; cv=none; b=Sm7r47NN0PaA1EzZ2NwOu8hLkcO6FFYRAQIyRZr7sJjxkJiTwFzx4T2+HbT+FQPF7hpAsZH9bOzA2o5HH1H7nFR1JdkepMdO1yTrbWgkb4rRwQXN0+GTO03UOBj1507DpT5BtHB97/b4/YI6Lqt2Ja0217oJl18sQmr6eVpmYvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712865790; c=relaxed/simple;
	bh=2zd2aErHG1lZPkrmYGGNWy8rR9E2GG4suFCJDjI8SaE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=N0HpxaPSVXM63LSzNpD83k/y/i/BW0jA7OQ3An/aPl38e6tCzJad47iMsA04d1NQaLIeFydu2q5lXG5qSuTw/xZF+BiOHhcjuJhz5TPt3/GBdfXWpta2wje7y/Qvy2TGShJjYDe9nbPUPFYmrUbrxFgy2lWNKA+dfH4vXnC4W/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9M7ZKk5; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9M7ZKk5"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c3aeef1385so99937b6e.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 13:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712865787; x=1713470587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+hANOqpWi5mccCXObOolBPcIhoSeVd6fCezYfr1BhRY=;
        b=Q9M7ZKk5DQl6Gm703zjtwpIeCfFnN2j7pzhh1bdGu4DjEm85Nn1m7L5u4ApVnGV3ES
         0VxKAzjm/EYA4K706fbOe0mogxOJr4L0ig118hx3V/tX81IoUVibQL3x8HrBumTfu95/
         uatJIes7ayd/K9/AIOZ299BrdHSF5D8Fi+lcQ5UdlhBUaLDbrPvdBiu3MPfTlR+oKozn
         BS9nYRlCR/vNt8WLTfkHZ0NSB3Uoo1mlaCikBb67Zx4B23h/N3Xb921gtHULsEzWOkJs
         IdrT0xZ434gjfXA8hh7Eumel9vnjbeWvJDQPBcALyjhwuxklmSwYC0ET2vbYrPnu07y9
         bd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712865787; x=1713470587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+hANOqpWi5mccCXObOolBPcIhoSeVd6fCezYfr1BhRY=;
        b=PIhojlzph3eEnAZGDfnpwPxJbZKDSrE8AGUaTBUC5ECdiCI2jYMGvhPoGuzN1T1r0r
         oOhDTAg3N2LYGUfPVobyfsIChl56NfQfKS6ni5R3gaYxhq2zhL9Kh5uVTjcOPOXCPfR+
         9No/B3gFmnttdhktvXPMQx1q3WRpooGcaVX54ZB6+WHObitx4bGosv02NU//Oe+da45S
         CJP8w1sBJ4Om6xhGFA4qeMn1Ckw/zGxjsXoOo+we0euW6/x2x0XjUDR0N36EndgIWhM8
         werJEsjg4q4hZJ8hU4xMz3HLRkd/X15WQrO+iyo1NB2lcjV46RBNn3qX762cm8NU/tfF
         r+0w==
X-Gm-Message-State: AOJu0YwcJWM9UhIjdg799XWmDOCtOF4Ce4lapZ4qnGkwouq8wHlVjF2Z
	68zt+92DZEzIEioORslgwUV76olKVIFFriBMDE7hFh2FMnnmZn8yjCfJDg==
X-Google-Smtp-Source: AGHT+IFtoXe/JDVRycB7lxZydUtF79qRWyzDkTXMg5ERwvzwpZtCdjAOrlvntGQakl0xz7c/FPig4g==
X-Received: by 2002:a05:6808:1b22:b0:3c6:efac:56e8 with SMTP id bx34-20020a0568081b2200b003c6efac56e8mr595371oib.48.1712865787454;
        Thu, 11 Apr 2024 13:03:07 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id da2-20020a056130230200b007e6b31e535asm268110uab.29.2024.04.11.13.03.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 13:03:06 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 1/4] shared/bap: Fix not updating location
Date: Thu, 11 Apr 2024 16:03:02 -0400
Message-ID: <20240411200305.183703-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Fix not updating map.location when selecting.
---
 src/shared/bap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index f553096dfcc6..b452461ac715 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -5163,12 +5163,10 @@ int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 
 			/* Check if there are any channels left to select */
 			map.count &= ~(map.count & rc->count);
-			if (!map.count)
-				break;
-
 			/* Check if there are any locations left to select */
 			map.location &= ~(map.location & rc->location);
-			if (!map.location)
+
+			if (!map.count || !map.location)
 				break;
 
 			/* Check if device require AC*(i) settings */
-- 
2.44.0

