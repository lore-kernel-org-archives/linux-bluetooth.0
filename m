Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F98199926
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 18:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724265821; cv=none; b=MHftNEMye6UAWnUZlvFszvRs4rHfMdQ15jcA3H9QkP0HsRHKHYLRs3IJMGMMjLj4nLjDbXG3Y8P+nTCwKUpSEUo7dp2ikCM0pu149YlcIbTD2BIsmrtajbCwlnUhZIwedZxHUxIeVKOXyjss7hs5ypjamT2Nzz5LbVAFDGn6+WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724265821; c=relaxed/simple;
	bh=bRZ5cGE/CeNctfFVhbe6bGTQKR+Gcqb7yeoBgYW6+lo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WEDWHFOZ+icEL2ZHc7F7eP0ZyNl0GpsJiIT0lz6v408OY7wcPHNAKprC13e7LQv78qcHuv9BoRCUgEeDf7dTIgripEmlAgzKx3D2xnqiScXoDuibzcRdU4GQdO0nf/fiFpEjND3xCpudBfCmx1Bkrk75osH9cz9nBycNWargIlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/U5WwoP; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/U5WwoP"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4fd01340753so8826e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 11:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724265818; x=1724870618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=B0cas+kYdLXspITOeRYnQdT8VpcvdpVBF/WOSh44e/U=;
        b=G/U5WwoPQRYxsAaJsaZkUDFcViVNjmCtx8BGhrJI0KWnXgn02J72lkYHTVlNvvC4gp
         QbgI+qZeEQlm+l+ix0L57Ake8aK5PF/fM10zPdztpgMMHMFLxJM+jD36NY+zXO3cY1ds
         D3JvbeTHD1MxHMacnYhndE46Jn2fUYW0YBi9iX1QUcc9hfhfcdBqmP/QBie6Lihf4aSq
         hJEWq9rzOLFdWZNd9v0Bzwda5uOtnlvxj9ySl5Wlr8LDPyW22EHpxXiGhMGnBr/VYNEA
         BXqk1brObCkJsqHM/gIT8S0cnEmqleB9hUrKhlHjZezeYTMS/BJOX/UQDO4dInknKTPN
         BZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724265818; x=1724870618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B0cas+kYdLXspITOeRYnQdT8VpcvdpVBF/WOSh44e/U=;
        b=ZKsyLWYxniLWPLbdoF9NLFhpcO72uzmzEiaDyX/1dpk8IqhZMnpdt6MagTeg4wdh/i
         gnTnHZ8/IUUxWvMJpuLkoaPmY7DtTERo6mxN/LOihzV7FRkA/piG7O2JAksnwQsDGEVa
         OAnRjCiBFd+vPcW5DgFPtgZEBImg7E9R21pE/MYZRhBLwpEgxPS/XRsOUaYYUHw+Or1L
         PRBJFvGv4R0bfiENiPhnuHDYTlXx7HQNlcX6ELlD9MWZtFSGn2WVMMzeOWo3qez5l+iA
         aq8oK53MfLbR0fZ9TkC56DGo9wC78qBqbDRT1dVFjdbS9y5s6+K5vVEYKg+QDTKLhJiU
         dTaA==
X-Gm-Message-State: AOJu0YyqPrvj+1VSeH4AchaeyOYgbIHOYmO0iJH9l7wQwlU6I2SKxzSi
	1ch9uZ65exdBL8ulMx1m+CVfUqAxEwqNUhSlzB+XYDtuXZkWukgVejHWRQ==
X-Google-Smtp-Source: AGHT+IGC1g98VQwIR6Hto81GYt1PwVBWl5XgAhFAJt5Ek8rra54r2LPqoC9ZaYcIz7B9LiO5HsAH/g==
X-Received: by 2002:a05:6122:1688:b0:4ec:f7d0:e71c with SMTP id 71dfb90a1353d-4fcf36b895amr3933828e0c.4.1724265818372;
        Wed, 21 Aug 2024 11:43:38 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4fd01fc115dsm106761e0c.33.2024.08.21.11.43.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 11:43:37 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_core: Fix not handling hibernation actions
Date: Wed, 21 Aug 2024 14:43:35 -0400
Message-ID: <20240821184335.386810-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes not handling hibernation actions on suspend notifier so they
are treated in the same way as regular suspend actions.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f25a21f532aa..d6976db02c06 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2406,10 +2406,16 @@ static int hci_suspend_notifier(struct notifier_block *nb, unsigned long action,
 	/* To avoid a potential race with hci_unregister_dev. */
 	hci_dev_hold(hdev);
 
-	if (action == PM_SUSPEND_PREPARE)
+	switch (action) {
+	case PM_HIBERNATION_PREPARE:
+	case PM_SUSPEND_PREPARE:
 		ret = hci_suspend_dev(hdev);
-	else if (action == PM_POST_SUSPEND)
+		break;
+	case PM_POST_HIBERNATION:
+	case PM_POST_SUSPEND:
 		ret = hci_resume_dev(hdev);
+		break;
+	}
 
 	if (ret)
 		bt_dev_err(hdev, "Suspend notifier action (%lu) failed: %d",
-- 
2.46.0

