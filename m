Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA05938D6A9
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 19:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782242083; cv=none; b=ZyX7PNNZkURxufHs1+HGSFeEBDrwq24YyCezc+hiaehGSaaSALxX/537tOkCWINVgMSFt+mdVj2ikfaJCXsfsjaCo1i3hPjR2wltHJAd96cmWLucs1Mo5OudLwdCd9u5rXfQ4vNqMuOjgCSAXqs9hJpkSpZPLDNfkZmy/dWT+ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782242083; c=relaxed/simple;
	bh=plijgziijp9hhUa5uABfsKnFvq39ih7JQbrkXC9sNkc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdxcNuRTUNn9FQcDp6/ES5m4YJJU3NOxq9aRDK8GFbPWe0h5++71cHwZuORnv0M1gjf8Jeev2kKz33anUWgHjXBgiKYJi+JmY36+HKqA8Uswcnt9DOoaUtPqH9tv20btLgq3I70jWYcLtP7+r3KbPdmf6Dp59BtLtoZUzuxFPvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9Q3yeu9; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9Q3yeu9"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-6c3154fa46dso125757137.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 12:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782242081; x=1782846881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hWgaia2diaamOEoQjYG+qo0oKTLO6sMeVn1sN3nRFw0=;
        b=T9Q3yeu9vTBIFIOMGjrEuE5YxPZR4AjADxp8dTtoxHhi8eMx7cEpGCLi3RELUaS+NW
         SyMoh95+KBjMoFOoqkZ/FVSTW3ze0IMIsDMW0OQZ8ZlDsovXhOZJ7XD50MUOenQ+K5oZ
         6lElbgX2JGnVGxSHLv0q2adu9jfZGxF/09oYIFHG5oD2knlkiQ2Hs3tyRU4YAsYrswj7
         efXlA/L2l26vhg4Q5rRmC2+Ur87Ra2Ag5wXlcXu94oE/AIrEoCkCYNkY2rGXJDLQNIi0
         q/sK57rH56SaZiBt4ItEBdZOLyVXfKKxdUdg7sY7OfiNhdI9kUzPvzmpFnrePGLtzTJH
         +qug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782242081; x=1782846881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hWgaia2diaamOEoQjYG+qo0oKTLO6sMeVn1sN3nRFw0=;
        b=IW3xnAj1X2hdh215KZ1JhTbSk4/lJUH4WZAyAX21DrBUkFEFDhmNxp2KJxftPfyF5H
         4nRmTowQYFlMkGVqeR+xhZQsWxhCgT70l5kldyGMkMiwg6KsJ4QVeXHtPQqltwOsHNE0
         JWmrc6+aVwZdJinz8hT6TgQ9nhCDee6UMnpAW24W9S5qb37lHgbvSjcYUfLGvH7l2Z5f
         Fb+9CIN76koSGca95n8kU20H15b0012p8wc4sB0oowcq60JUApyqkRxCQSgrfWCmsWjz
         Ve7Wjcc+RremoFBddr0VoW8pXptGVotJ2MJEU3wcyGb37PKcHG8j1Rmt1bwDP1fopOj+
         Jg8Q==
X-Gm-Message-State: AOJu0Yzij7ihvVb67PaY99ASYZaYLPLFxY1By6yYOOhRxj5jwZ95EqBm
	AxLURrL38EjhAkrdFhlOCZBOmEsEACo/5j5cD9PML0dhiZ5VsssiU/teyu7NwAxKGkVfbg==
X-Gm-Gg: AfdE7cklQpIKuKGCHB9JtEIf9FTGscPHUFwvM1Att3Y4BjRZ1HMfnjA3TRMJe6828jG
	g7guEhrCWC7RczYifSMh/dSsromJ7dFuc6x17XTuEFpn461C1Te0UkKeCuy3IZ6nQsuKkdD+Cc3
	RWuzyDFYttmKLNTmlXobxWnJv6LYyHlsdHuzUclUUIxnxCiWHpioT3jADK4LrPeMdycBlzi4fE3
	0G5bTfLxv+sDYC5RNUDr9ou1iihJUB8k1eDzyW0LDOGTDqvVJCry3AaaGgWMvv3ObpQnUf0YNrp
	PrGF0Ht59H/fwlxN86GJ8sgJYAU2LYLnb5Wp28GUOznos71PPFMS4poTrgS+O0O02XH11ETIygH
	qV3xxizHB4jUB6UWcaMIjVHmcFVwYp+fV6B0G93Nsl5MHOuxTT2fSA1qld5AIKPCrfcQ8DWsL2a
	NybFBkWzTYUXsQLpFrgikj3p1H0TC5oOfyi/8VgSYZKm7REBtoAR9OZprD51bSe8ySiI2MjaxTc
	+RdPAQ=
X-Received: by 2002:a05:6102:548d:b0:604:f849:462e with SMTP id ada2fe7eead31-72fd815dd92mr2713131137.25.1782242080738;
        Tue, 23 Jun 2026 12:14:40 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9670c0e9590sm8965546241.3.2026.06.23.12.14.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 12:14:40 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/3] shared/bap: Don't transition to IDLE inside bap_bcast_set_state
Date: Tue, 23 Jun 2026 15:14:32 -0400
Message-ID: <20260623191432.270241-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623191432.270241-1-luiz.dentz@gmail.com>
References: <20260623191432.270241-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Remove the recursive stream_set_state(IDLE) call from the RELEASING
case in bap_bcast_set_state. This call re-entered bap_bcast_set_state
while the state_cbs queue was still being iterated, causing a
use-after-free if a callback unregistered itself during notification.
---
 src/shared/bap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 9dd07bc5f2e2..6086924a9cb7 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2436,7 +2436,6 @@ static void bap_bcast_set_state(struct bt_bap_stream *stream, uint8_t state)
 		break;
 	case BT_ASCS_ASE_STATE_RELEASING:
 		bap_stream_io_detach(stream);
-		stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
 		break;
 	case BT_ASCS_ASE_STATE_ENABLING:
 		if (bt_bap_stream_get_io(stream))
@@ -2579,6 +2578,7 @@ static unsigned int bap_bcast_release(struct bt_bap_stream *stream,
 					void *user_data)
 {
 	stream_set_state(stream, BT_BAP_STREAM_STATE_RELEASING);
+	stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
 
 	return 1;
 }
-- 
2.54.0

