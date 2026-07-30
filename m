Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE584119FC
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 11:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410758; cv=none; b=dkRTEW7O8MIVpwhcO/sUU7R2YVMi99Hm5PvfS84HDqDMFJUpyJ4SF2knW6o4metbuF5HYV6baVpFWbpi7hjeCs7a4o+9Ru2ZCBwpaZrtrk8MCAkkKc0o2z/cVXUFhJJltQEcrz4lEBbONLqjqLtg8rAPuSYpxOMsjMxe1pJhjTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410758; c=relaxed/simple;
	bh=gRx1CiJmOGUyXwfLz5e+YxxQVxRoET7cBFYAUzsNIfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pXP3EUnbZtqvpvZs/cKCrcnLoW7Q3mlztq6wLk68x/2/JpnGoQDJ8L6KnbBEshJXQbpX+s5OD3AdmwWIWhkHu8JLxwFbOlmZWaDSlMIlonqxxQKCjjA1jJNNkyaJjZY3N6dyLWGvfmWdBmVjgRyHCWjycej7zAucGgtYAOQpxIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeNbxlDg; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeNbxlDg"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so1702590a91.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 04:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785410755; x=1786015555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/OxsOhh2TxKdW72mOsfXzYWaYqbneErDghJFAn2iUZE=;
        b=GeNbxlDgaYDv8kfLh2XJUSE3hUjyM2J0B4GGQjksrBj4SKF6OnUVm362SoD+YPtGj1
         rdrEoLg7/HKpxoYZn3/dJLpbYqUvqY5XapFhh4s7+ikmzguUkXdlyd5XsUKv0IzIevQp
         9MZR+QK2IUwBvYK9VQLSBXv1wzdIBfWH/kIpN3I/9CE27Lf5WYRPkQYB6GJxer/o22HX
         Mmu1QtKWTHbuFHPSVlwv+eqzg+qBqmLFyvwLXJdxb5aU9JEA5gGUQhxxPm1wWT85SYL8
         RVpQccMpxb6KQROpmUicPWsrclXoU4qbj4FrfNgcLNIz2lshG5QlcvuGd1k9PsLiseeM
         ISsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785410755; x=1786015555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/OxsOhh2TxKdW72mOsfXzYWaYqbneErDghJFAn2iUZE=;
        b=r5XP8COFM0kc+FY/3eyQxpM/NV5/Kxbzl4mcVK6n2v15domRHpe4842of1IYgcgdG+
         5EZnJFnhjYkAZ75vpKd9ACpaqo25oF8G+csrnXMDpOyNBHpCpeD9tXFehQxA3YWPdlTx
         Eb/4bmamx6JKbjknt14xKV+n8z05z6FV9bK2ocg8cPUqKobLPoSuK2bJzusWEQUvWMCF
         DpcOGfXdCWTtmob6W9dI+ZRqk8vFUqB10VuvVm2Q5vnyErY7Vt2O907nulKSso+2GUy1
         Bu5IjSl8bu6oZlDJEWS5JgArhBOeqUCGaUho9zVOjOHyQzzXnKOAzSTkRtt60YUnxAFX
         yEQw==
X-Gm-Message-State: AOJu0YzUvX9dhIza9cn7XqOqqwbGPfxOTPPMaaOWXt/ghGy8gZtjnDVz
	r47savZSm4/l1d1rtl8yw2uyFpzL5g96CGiPjs3eMTZ4PXYdaTED/UmI
X-Gm-Gg: AR+sD12osvyTjPNgTVGaVfffabHHPupY4MuNY7HC6Av/Lkz/Bd/A+LGY8rc5SsZMgAr
	1xo5ncrzcIWNfzoD/R4bI0cS0xABOYQ7jCm84EyxZ1Dq3GLgfU0d5VMzLaltfMIukwiuLlce2G5
	kBQYR0Pp4sUooxNZZZEhJo69cmcvmFqX5OX68x2L4fx+GCO553SL0Zf6lFeqpJWpJXmovwMfTNn
	Nlum1k/9Mv84LcXhlQhj9j5wRCvcOuOkVXzpAuYZdSjJAzyQZoN98X7U8+AOn7rdSMLTPfoR+cT
	EUrxm1XXJP04eSc1dPBF5bw6ZX7t+KoHACf4Y/r3ZdnhM9GrvXAnO2/flEYjpp1ns09mVDp3L2L
	Ml2UWxg9I3BjZQ94YK9iN43YMVXbR9cUPRWUJIeH8SrnZ7/t7oVUmvuyJm1L4oz9U9rV6/sdM+h
	eMeIZfZN1O1ThBsDuRMVJnSNB6OaGYhLOYIYVvnG3ODNWQSFzMGWn18lFLe3sPIW+MoR1nvGMda
	70A2YDdMWfhdn3tkDuZevqneTgJol+I
X-Received: by 2002:a17:90b:2583:b0:37f:c69d:ce69 with SMTP id 98e67ed59e1d1-38f9bd83fa1mr2072964a91.10.1785410755120;
        Thu, 30 Jul 2026 04:25:55 -0700 (PDT)
Received: from oshada-HP-250-15-6-inch-G10-Notebook-PC ([124.43.23.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e7275973dsm17869670c88.15.2026.07.30.04.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 04:25:54 -0700 (PDT)
From: oshada imalka <developerimalka@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	oshada imalka <developerimalka@gmail.com>
Subject: [PATCH] Bluetooth: hcli_ldisc: Remove reduntant braces
Date: Thu, 30 Jul 2026 16:55:09 +0530
Message-ID: <20260730112509.72623-1-developerimalka@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removed a redundant braces for a single if statement

Signed-off-by: Oshada Imalka <developerimalka@gmail.com>
---
 drivers/bluetooth/hci_ldisc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 2ad42c3bbaac..e7de8a278edd 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -756,9 +756,9 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
 	hu->proto = p;
 
 	err = hci_uart_register_dev(hu);
-	if (err) {
+	if (err)
 		return err;
-	}
+
 
 	set_bit(HCI_UART_PROTO_READY, &hu->flags);
 	clear_bit(HCI_UART_PROTO_INIT, &hu->flags);
-- 
2.53.0

