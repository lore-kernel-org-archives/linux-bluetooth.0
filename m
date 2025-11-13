Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C903D2DC762
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 15:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046759; cv=none; b=CSep7jchHFAvvefytiXBGWmceiThV/KiFBdozBNPQrqRKytNj1jD5ekCySc0zVC3fk2+m3Xxndu36T6++WUVE1SqxBVsYvwwww+gzlFL4CSGJ/DEvysdpwAvN2Aa1N2gbDL2s+bIoFmJhfiChOKyECPOQo24tlKg7GmTDkrrPWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046759; c=relaxed/simple;
	bh=CbnYzNmiA1A13RECR37MvHjlM2em5SVB97Z2bx352I0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=p6f1GCtEhLXkNUgaaEHwvCmz53g6ppnj4cyK0w045nyFwS8e9Cx02HRXs/j7/cCnDaAgR1Do9pjxls2izQcVicSc6gyz4teli89iH1jsV5MHwiqaGWq9XPOEmcGYfbJNCazGte360thbJdIK52AqO+mMSnl8YOw5yRzBw0xEHBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFipWXMg; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFipWXMg"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5dbd9c7e468so409486137.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 07:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763046755; x=1763651555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4rbxwC0UlT6udXRqEEofAxQGbQGKnroZuVKFvxKQIN4=;
        b=QFipWXMgNri1hw2C7TlXPZIfvbv9goQyWSxk4uugjwIhA9O6QeWmmoyrZgf+1JfVJQ
         F5+LzQDrhN3WCCoHmwZV5fk7RQayjxctTdvQJXoVztsJkKo0XM5alYamfzAAyvDA/dga
         pj4csC04F/lHpxrcMGqFpjbdhqgXkF9uuZ4n//Ff/B+PYWak62ZBn/ltC4ypr7cW284S
         kbLGj04p7ZpeVpJP7R5Wr1eeiCQKWd5hd0oACy6rDzbpbk+35LMY7T0aBT9F57DvSzJS
         0OhgLI6t5FHQ49/RM51sjK3VNN4zC6SBCSqAJj8g5TEAzrcZFLIpq/q08XPxaYUyBhci
         spQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763046755; x=1763651555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4rbxwC0UlT6udXRqEEofAxQGbQGKnroZuVKFvxKQIN4=;
        b=B1vyFFnrv8f7gid356HDmdhl06BX4TD2N2FCFmpp2tHCs/hfqC6Lrbnc+VKKmQtZuQ
         l4Z893/lfOikhyT1jZYj+wF5V8gVZRXWi1fZm3QgpiMWVtZqfPDK//ToevdcV+IGnP8o
         O5C4DOlPsoYJtc5b3xFo8rBBZ0JJvLa4d37qNcNlw/W4setUJrIINlf+xseRdHX5z2Oe
         WUevaLd433fwQrQNy+hg9f04U7UyWZ9bQ/BIyNQz4eMlOlFqUcghNv1OjdF1a2mGa7Jb
         Urh93dr3wDIy3F8wcQEPka5n1C8wvBRo4dn7/euvoe4kofPhis6hukyA1ySiLSthB0q8
         u2rA==
X-Gm-Message-State: AOJu0YwF7Co1RZl3dzB+Db9PmAh9x+L3p7e6/2Hx8RMCuWCRtSDF3MwZ
	hmiyIMUCMYgDNZxJwnoVS7PVgj1W7FYDkVTA7NbxT5vbFOvHvVsHcoMGn/qCLQ==
X-Gm-Gg: ASbGncv/fdO77do86HrIsgEUNn0ES/UGUm+HYb1m0Qn/4AI/+iNbAQa9mXMWUEUn5Sh
	TFrBB0voylDSzschDWBM3F0x9QF05YlRUKQR2EqYoJ4RkKKZa9lsSiPBp5mqTgpsLEZKKQOHjxT
	IvUEPgBSVOCPlMTHjk3LIm/JlTHBCgUGr/lU3EOuWwh1KvbKdcKQJnw2T6djFda1A89mIQR/Rov
	1YNLpk+9KfXDEajLY24+kvDP8URVOHBbP1gz7AypuhSvEzTvOJ1pbZxWD3dw0kAwBbaE/OZ2KU8
	IAcoX2MOPa4ZgCDz0bs4UsD/3E1kWb5J6Lfw74IkU6IBF0Lpx4mHFhaFB+Hb2QkWh5UdacFZZMo
	rvjqYcHusrtVE3r8FkOwvlSSvKZCR3FfnU1s8mtr8kKdQPQTSy95YKCMUSsgQS1aUNwxiIxr4bD
	mjW2g=
X-Google-Smtp-Source: AGHT+IG973BCsn3hOtRcXF5WzBntagLXhfki0DRbt6/Pa1e2HYzB2LfIdxv7IRGDhbB8cuaWTBe/4Q==
X-Received: by 2002:a05:6102:4b88:b0:5df:c354:18c5 with SMTP id ada2fe7eead31-5dfc3541a4fmr358257137.7.1763046755384;
        Thu, 13 Nov 2025 07:12:35 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-937610ce60bsm664235241.3.2025.11.13.07.12.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 07:12:33 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_core: Fix triggering cmd_timer for HCI_OP_NOP
Date: Thu, 13 Nov 2025 10:12:24 -0500
Message-ID: <20251113151224.2598720-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

HCI_OP_NOP means no command was actually sent so there is no point in
triggering cmd_timer which may cause a hdev->reset in the process since
it is assumed that the controller is stuck processing a command.

Fixes: e2d471b7806b ("Bluetooth: ISO: Fix not using SID from adv report")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3418d7b964a1..9f686e5903a1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4168,6 +4168,12 @@ static void hci_cmd_work(struct work_struct *work)
 
 		hci_send_cmd_sync(hdev, skb);
 
+		/* Don't trigger cmd_timer in case of HCI_OP_NOP since there is
+		 * no command pending.
+		 */
+		if (hci_skb_opcode(skb) == HCI_OP_NOP)
+			return;
+
 		rcu_read_lock();
 		if (test_bit(HCI_RESET, &hdev->flags) ||
 		    hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE))
-- 
2.51.1

