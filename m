Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8804F2222C4
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Apr 2025 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056131; cv=none; b=phTCIqlW2D7nEVyy0VK5RfJqKqNIIl6WCuIUQcrT0Fx4ZG6NWAYpL0m8nmFAvREqigjvNrf2izN2p2YwfWoggA6yZB0yKzWsKPxsRk8kqqjzcn7ZIS9QH9atsw6dJQAqSsJBh0KLsEOeBnjWKyCSZxUvOqVzF3Dnc+iW/FAq+FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056131; c=relaxed/simple;
	bh=6IDTVKF2V9igFEgIWeSddA+HgqYPaB8uSQ0WRp4pd4I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dOb58jUNR1oGivrvoNRs3fkm2rAeliFXzhDAXpqkp8606vBsxoxuoswarX2VOxg8o6dCyxwSuRdU+SMTJc4ypSIEePSzLjko8f68sjMqkEA6+R55wmUYOqLC3qGndPFLg6pBl1ZWo+SaPGsJjCeiOOZxI4FbSR29SF0VlQUsMrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtHJP9VY; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtHJP9VY"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5259331b31eso2232430e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Apr 2025 13:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744056128; x=1744660928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R26u60CrrYvf7mC775l8Z8/4e5MyzOnBvrVyYtVW+T4=;
        b=dtHJP9VY+YkLkeYJpiI0bh3CDpzf/MCvt+/QxXp8ePHZSBPAEIWz1QZ2viyq7jeda7
         PekI05Xegj+OE5Atm0XazHTRnXRHyf+DFtj3MSZxzKFi9wc1Ye2ZXZbZIkteK3vZ0Qo3
         AaaJA9YqKMN2FphEgSsSenMFtDhymDrR7V6+1YGUOvG6Lnk/GlqWimLlfWxFpCcF15tw
         nG+SdTgPlJl00uwZh+xl00QSWQetp9k5i+pWOE2ynJWtKLddczoGHyKnYN7koh64gGb7
         SuEHc4NXy89KI5rvfuCmq38yARO9E6MMaHi1O+eHdjDknA4TDAHPyeHf6ovz/VHnaX+F
         AQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744056128; x=1744660928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R26u60CrrYvf7mC775l8Z8/4e5MyzOnBvrVyYtVW+T4=;
        b=QzHZuCgZaoMCk/0D7AzN2poXf+hbRe7qbVVQVWoAGVYrHu7bk4/zNo6cljQ0a80Bf/
         occrUqSx02yfK58lCRuqpTeKbFpZdupukvgZgjNODBysrm//TEa4HEJ11u6tar2O8afJ
         wsn+XkINfTjDyjD9Z5mSjXGtTq7LN7v+EzjtHSEeJIp0x0TVgOQ2hJ4kv8UQSPHQ7T7a
         Yf6JF5Ioo5KeKvzgubenic1acFzWW4BdcvsLmbp3zPo0lbQ4kEJdK+LV+5CwjaXrcfxt
         VTZlINuPwv91y3lVM6/dGVAeb6OETkk3Gs7da+eWOSbLDx4jF4iPZuiyv8z9/nGQ5DJ1
         SVhw==
X-Gm-Message-State: AOJu0YwZLtSiLkPUxS7y5mvAXJcIuICpkD96YRWa4/MbyKtHTp5WuWOR
	6n+qA2/h5VF6xVTYzk30pZjO11+2p+BBc8ySlolzLJPYm+JzpeYknVbpri4a
X-Gm-Gg: ASbGncupDBBCWcZPnlhDJGErQ11VJNUo+LMdMcyufbGNwjwi6tk+wEwYKSK4Ct2EioU
	PQ/UJ0fEzcW62IayEhOtVAtdIXLu101h0bepUSZrTfnf5rKfl/4iXAHFYK3EhqfHOLF0/Pp6vZK
	+6/9UoU0X+Jsz3AViFWwn6f0GZY6puPeRJ2fmCgz+95TYpD8Ru16YDhDxtbcEAdVrU/NurrKyqD
	cHrwsSOKUKoMz1o/yHga6MAsG0M37tFLaP5g5G71gN02g5gtqhyM4wvGFSfOPaL2Jy5v1pC7fFI
	31tmSYExBRZASYvEXD0Fa1nK+IenDefoU91tk/XbpmDPUxOs+HsasnmR9jEzXvuzuwwDNxzgEW/
	PAJm+zS6OTh1qbw==
X-Google-Smtp-Source: AGHT+IH6p9VavrHI0wMfKEoQrvaPFtsxVkGJhYB4qo/D3RoE0XV6IDOmJwQzLj3v/5814DasrK+Bow==
X-Received: by 2002:a05:6122:32cf:b0:519:fcf2:ef51 with SMTP id 71dfb90a1353d-52765c8dffcmr9682767e0c.5.1744056127700;
        Mon, 07 Apr 2025 13:02:07 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5279b691f07sm69140e0c.41.2025.04.07.13.02.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 13:02:06 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 14/15] shared/tester: Fix not detecting NULL packets
Date: Mon,  7 Apr 2025 16:01:20 -0400
Message-ID: <20250407200124.881534-15-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407200124.881534-1-luiz.dentz@gmail.com>
References: <20250407200124.881534-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When receiving packets if the iovec is NULL it means it shall be
skipped.
---
 src/shared/tester.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/tester.c b/src/shared/tester.c
index 56c8cba6f578..371ccacedc66 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -978,6 +978,9 @@ static bool test_io_recv(struct io *io, void *user_data)
 	if (!iov)
 		return true;
 
+	if (test->iovcnt && !iov->iov_base)
+		iov = test_get_iov(test);
+
 	g_assert_cmpint(len, ==, iov->iov_len);
 
 	if (memcmp(buf, iov->iov_base, len))
-- 
2.49.0

