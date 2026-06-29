Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA959394780
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742310; cv=none; b=hykHT4AAaDzKAM1X46Tk5D3UtG7PUhlYaw/7MSqvGw+CWQlgbLn89XKFoBV+JcxDmpLGgqffWsgjoY+G0UnBxWG4P3h4Zau/nUnEkidSB3bu4OPMP8qh2CMKO7J7RmhcvJeEU0kNzx56OuJlMyo/AWTzIxIe3XLWZU4WPnbDr6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742310; c=relaxed/simple;
	bh=2F+TH1TM1acXvmLfa2fLN5mrNnqXNYeDm2GaQ5xlfQQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hcBk5TBVofv+MRsZKtLESEvK9nTbUWD5Bs9XXFbUxldxU9uLx17VYN8uHJcLGwc+gGgTg8BusVryK9Tv/pAQ41aRzPmc8oG4vBjCzhPYOry6+we13BnpgCGNwZgOtIiT/xqFUnDCXHJqlHdn05Tokf9LH0+TQO7oKbgoqbiTxPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pi13uKA7; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pi13uKA7"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5bd745cf7c7so1098577e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 07:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782742307; x=1783347107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tDZ2JtdsIg0YMG6AxdlQ7+ijohmZbDaNAfUnxVkAxWk=;
        b=Pi13uKA73SGrcw4hTveIp/LxX0vOeeDkNgmohNJjvLLMShHUk7ef0iK2ZXEEccOJgK
         Z6Nau8BMxAB7RW0K2VNrrr2YhL7QRD4Nc2OFxstJYEavmkhPZnJ3nl2BhMmToEJxywhj
         gnC1vJLN0XCgLB/Np6Br/QwaizBicZ9K3lZuZuYjvDfaVF9wpdnBRBZrSYUK/6C+0ot/
         ZwUO7OvOjrV9Wx3FpwfV2ebMKyA7vGlPV/D2isloZsbO5WAC/JB8vFDiEJHuZrNpSHQR
         C9J3R3raeUpMbFEXUWxdLKxfCAtvS2z4keESk/8KigNWXCt91loz5o06FCUtoqwGApWv
         j+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782742307; x=1783347107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDZ2JtdsIg0YMG6AxdlQ7+ijohmZbDaNAfUnxVkAxWk=;
        b=KDFDqCG9JIPU7Cq/0slFpSpoAC6JRMrL66lcPuSRKjldSv4aHjxMWFXYiVS3JvfP7x
         bo+XmO5ESuS8qA3A2J5I16b1aifBHu7XhKL6Ygff2gIDrs8PHyZBLCQd6mceRF2t/a8Q
         ra0PQyXHh3ILBLRdI4M300FCFI58wXX4bogp0QYcyvM0GJ3C/Isp7O479VL/ntPO+P6c
         EFYejrvm3KqJSiC56o5IVjHdzDIAW0dVyYluKiOJOw3WmFRTQR2m29PMSExjOI1/07Un
         +bYEMX6i8wgFlwbXReMm34mTJ3GXMPpChX6S91ar9h1hIWaNRkUojoHSI5g/WBCONA1w
         mUVQ==
X-Gm-Message-State: AOJu0YwR+dlkRXPi77L8wrrJVNXNass4jd8UofHvguVLtaMIBZn7zBwO
	wcsAeA4oHBF+FcQcrc87PYfIO7S1PEyAdfP3E17PLoc3UEB7ZgH/oBbgj1WiChqP
X-Gm-Gg: AfdE7ckAibg0oP41u7F5L+EJRhZtwuTDmu4De08dl8ccISeoskfUmvuH79JMhvngU69
	s3f5NlnKtQSO00b1zQWS/2utwmVqyHuOfRmyhscFcQygydgXXGAUM33u7RMhfUa/UuRY49hfbyw
	AhTFbnGrGReHkUJ3lZSiGjjN3mWJOzuxw5f99DbECzhFCYCKK2KmnjLbObmvoQZai2SCxdlEuE7
	WA6ZdI+KgwnsmpgsmGiecIEKmqUz40CR44TjFTkQ+jccNHQrWAIUzl7TyThYcLf42p/dPkL5grK
	nPxF9UGcsMHnv4pX6D+N7wGr1Rrwgz/leW9dzdZZmOsMrCFydq3wAzcsGBsyuEELGIUJzSz+F14
	/LqwxJYwCBJMTKuFAGiYi+rGu1HezpqNvkPK+I4JRljdQKDI+C0aSsyxL9NtHScFnktCTzZqMbB
	4FEVKYpJigL0sc9ZfBtglQtYb/9jaZUlB3KOqNtzC+RNhX/yWnZf6JZpFlBdF4sDSDQJYE5ZVOJ
	UDK+cK0Pu9eSZwbig==
X-Received: by 2002:a05:6122:1d0e:b0:59e:372f:6db9 with SMTP id 71dfb90a1353d-5bd69f5a5bbmr7285929e0c.12.1782742306541;
        Mon, 29 Jun 2026 07:11:46 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bd78e999c5sm5756883e0c.6.2026.06.29.07.11.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 07:11:46 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/4] bass: Fix possible crash on bass_update_bis_sync
Date: Mon, 29 Jun 2026 10:11:33 -0400
Message-ID: <20260629141136.947652-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bass_update_bis_sync does use bass_remove_bis which may end up
removing the current entry causing a crash on entry->next, to avoid
that prefetch the next entry.
---
 profiles/audio/bass.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index a5ef80fbc835..533d45babfeb 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -2014,11 +2014,15 @@ static void bass_update_bis_sync(struct bass_delegator *dg,
 	const struct queue_entry *entry;
 
 	/* Check if existing setups if BIS needs to be added/removed */
-	for (entry = queue_get_entries(dg->setups); entry;
-				entry = entry->next) {
+	for (entry = queue_get_entries(dg->setups); entry;) {
 		struct bass_setup *setup = entry->data;
 		uint8_t state;
 
+		/* Prefetch next entry since the likes of bass_remove_bis can
+		 * end up removing the next entry.
+		 */
+		entry = entry->next;
+
 		state = bt_bap_stream_get_state(setup->stream);
 
 		DBG("stream %p: BIS %d state %s(%u)", setup->stream, setup->bis,
-- 
2.54.0

