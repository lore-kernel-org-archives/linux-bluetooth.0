Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A879401A12
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780476683; cv=none; b=grQ5nThpzaRJCygr9z07KtjX32Ob1k9xf8BqegevjiDdY8MQcesomlAKc+zN7LNkaXDyAGPPIsJAmtQYWU4qLf5KjwIFgh0YEbsvnT8DstchzMFVfdJ98aIk9c9BuqzzWoyp5qW5MJICtFmXaU2Bef7JIKXQrZsT0uAkeNzPky0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780476683; c=relaxed/simple;
	bh=tvUGcoRZHaYmlzq6quGgVED96dALgjYGPnJygFYg/GI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qDgudIpJfCery7q/owcjdM+mT/dDA9su09nsAhxMLH2a1WVMZIUF55NoQoKyCAKEHKoyXvs0BSaIrJsp39c4z65Qrk+uM/YrtkNawmQGUbdscxZfQS5TzcgN11q49/wHqF9ThdgaVqbhgUNBkWPhu1NczFwn4wr583+Fbw6DCJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pH60SV4f; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pH60SV4f"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-8cce26ee1e9so85192256d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2026 01:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780476679; x=1781081479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kMPZTucAqhZy7zAYS7pA3OmvQDeUPQzXpf1wRurqMYI=;
        b=pH60SV4fU1e2yvuAdNDmRD/x1dKkAIMXAJoAIjqaTr32jjeZGCZHEsLukyLYQl4u2g
         9/jrumKmW8BkXmf6wSHT0tXEv7zKDK5Dyrm9xDTwNypb80E+TsBbVObaJdYxHmoDGPoa
         DFqDaOKwbmQVY4Zdqq3Uquc0czcEq8veIStHd6QTiIFwWiCFDt/vXb92n/JXPh12le5Q
         Anvv6nmWbARllSEjVMGaHOqCTCl5xiblNspyKZekPT6QByoGjAPqyYKdbUWVTDo9qZEC
         YVpQ7fGWVllIEafZxRfNqvMqDHVGPdLVa25V33+SV8bFm9dLbCLxtJCIJMovs1++7hlQ
         5GDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780476679; x=1781081479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kMPZTucAqhZy7zAYS7pA3OmvQDeUPQzXpf1wRurqMYI=;
        b=LMThWrsuORICwCa3AEzHdsSGyqEvFkWVbQNDK3OYlcQFxLCQbdm7FFed/QSgkHZM4k
         m/mX3jxXKiNcNUOOXX/MQOgvylVlalqi4XWuGtJL8/IW9+h1UPhfC6zi8Owt5KDryiYH
         A1f0JQ9KXzMh3aSOFZaWP8aB//0OjVPu+3Olkn+ltqJBg69HTSCZMbDrV9zszegH9GU4
         M8OxhoUSMMHxIn55U/ZBgJFzPV2/zGFrK9/48sKLngAEsvwdu9MAh9tkGcGEQySWPays
         8CeLsCzEzN/4p2vsvNFcfvpyzw3kF8ZQQZoPoEhkQ7gGRy/c9CX3CX1hw2hpNpL3H8kj
         zdag==
X-Gm-Message-State: AOJu0Yx4PlX9OjYrPGM4yWd4+GXIRq7aqGB1Beb2qX+MKQUX7DqlAxfi
	C3jdVV95QgOraghpWvbQ1bQpiKjzPYnnBmmfM1Sw5bMXVhXEEhKFCmPdAUT+cCXVRrWR
X-Gm-Gg: Acq92OFkaApNWyI0fQiNP2Fnacpk/J3E3gtJ6RK3opZgNyKNBCxwEXNqZNvqXBg6o5i
	8j1GG++rr/R6w4a1ZC0JLpQSbqlyJoo7sCGSS0HNpDpeczQWEAMNERya6Bf1E1S2dSCZoocNjXz
	TQ5lQZ5C/EECNtGiahvkkTlSbK+YhxmHn1/N/l5HzTTyhpQqmyELXzknXZ/YMJSC3AbDmj9gXsf
	8r+g3T5CGvPsqSzLbu5poVKiW1rChtJFlV9u0/2QrO2CK6XIoX53aSbKwqcqUWPMVnLKN3O0Eh9
	8FDwvazu3WeuzIW4p/XqhmJoN60kPmO3PdgnuLcuy30hUV25d76YAU6SZU6laarjCaUGC6YuiVN
	3Mk0ZrQy6pfOokWJSNMTA+jN+UVjHdB1HLxou+vbEsUyxqW/u2okrpl/W90ZyZLpQov9lXlY6Xw
	QFQPukx/rpII1Pc/CpcYZYRuIZS1Mi5qSirzI8xz70lI5TmLCMAoPvSIhvvttx7pBZh7hp2K9gm
	Q==
X-Received: by 2002:a05:6214:2301:b0:8ca:1cee:7c58 with SMTP id 6a1803df08f44-8cecde9db82mr29905266d6.19.1780476679538;
        Wed, 03 Jun 2026 01:51:19 -0700 (PDT)
Received: from rainbow (static-68-235-46-233.cust.tzulo.com. [68.235.46.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccdcc968sm15148846d6.22.2026.06.03.01.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 01:51:19 -0700 (PDT)
From: Jordan Walters <jaggyaur@gmail.com>
To: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] Bluetooth: hci_core: Fix UAF in hci_unregister_dev()
Date: Wed,  3 Jun 2026 04:50:47 -0400
Message-ID: <20260603085047.256779-1-jaggyaur@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hci_unregister_dev() does not disable cmd_timer and ncmd_timer
before the hci_dev structure is freed. If a timeout fires
during device teardown, the callback dereferences freed memory
(including the hdev->reset function pointer), leading to a
use-after-free.

Add disable_delayed_work_sync() calls alongside the existing
disable_work_sync() calls to ensure both timers are fully
quiesced before teardown proceeds.

Signed-off-by: Jordan Walters <jaggyaur@gmail.com>
---
v4: v3 accidentally resent older fix using cancel_delayed_work_sync.
    This is the correct version using disable_delayed_work_sync.

 net/bluetooth/hci_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 28d7929dc59..1cbc666527c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2671,6 +2671,8 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	disable_work_sync(&hdev->tx_work);
 	disable_work_sync(&hdev->power_on);
 	disable_work_sync(&hdev->error_reset);
+	disable_delayed_work_sync(&hdev->cmd_timer);
+	disable_delayed_work_sync(&hdev->ncmd_timer);
 
 	hci_cmd_sync_clear(hdev);
 
-- 
2.49.0
