Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C4C3209
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740582828; cv=none; b=HoGRTKQulxzrDPppboe0sNjRo69pC1CtBXfAPJPk2dZQdslJMw7tAHz1Gld+6AwktO8U1IzMEqN5aa4It0Y6zhHQcjneaNM3SzzqubjHqqUtJOKc5dBIYf8FembVr91ATYEfkR+uwsRn/9QXPKK/TRJtIiMTa+oo0ZUjwswGkfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740582828; c=relaxed/simple;
	bh=QBKWzLlg5ybg4kuviM+ZE2wnlfbHqNFx1yCR29nvm1c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gIs9TknotZbWN5uASNs1Q1P2AdfIlJAx2ZTP6T4HhJcmS8Y+iUDbVgnH8r2hjrzElc5zh1kShtkRAhzSotAPx4juNQ9hSldF2icAFb6kQvQGUZfujDmoBv61XzVKIOD82RDwpBsbbmwyy1EYEAej/rjO+fSj3wNYo4MT13WttpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aFZdwchZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aFZdwchZ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43996e95114so46497785e9.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 07:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740582824; x=1741187624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1c4RXhKBOA9lNulEftAsFL6XNqCtDyXzw3LG0W0Talw=;
        b=aFZdwchZIWyX2LMyJeBp9MzQQ5YyobS81MJvr4RY8gkj8GYWjwWd9hhGgw3vxnMLr2
         3jZrrjbEF1ppQWlIpuJ4S54lstuQXJNsibmS5KE9+lrV9ZUIZ66DqiiKtf+Yn7YDc2HY
         Y5nrEmVdFurGH7zZWLJJz2oCTi9OQPH0deFCf6LvdKKIL0L/GghieYkf5iiAQE+FxmmV
         3BUC5QDOS/tNPjMjOEWN9AZ9bxbbNqXgAnzISb50l760w7C6NeXcFeETYKRjU5pdQMER
         xaPuH/BiF6YLDkzWJCdV720ya82MVN0iCaqPp/KdwJRAJpiACeAfNQpNp/oQBr2mQdZ2
         GRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740582824; x=1741187624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1c4RXhKBOA9lNulEftAsFL6XNqCtDyXzw3LG0W0Talw=;
        b=SDl94ncIaCaxJQicEzVreQBWRX9+IhY4zBcHkqqvLr+Rv4ogwi+aHiqSppp1HDCJw5
         tEs1axGeMDY3eGqqD9SK5Nkya91fW/+/b/fbuhq6LflnSSsFHhJ7sg0M8YxFhmntRziD
         JXQuaTvObVbPrlCqd4tJyb+Welg0guzDFaiApaGtYqk7dwgT5JTXU5ARuSA37lmU5e0l
         R6JczqMm6JLkk9DIfg2hZKLxIXHZZfGidu3OALc37Wc6NY2fVpr3cglTeTmCb9Wf44S2
         SlZYdpUUefGdMGemhw879YM12lJIAENSl0w1NLKczDuFZ7N7v82snM1PkECYDnWClllu
         7IaA==
X-Forwarded-Encrypted: i=1; AJvYcCWwpyCrqsY/aj7qteWZEjWAO93aVu0t5fMvQ0JUb+DDpoD1Sm6m6DCISfttTbWsw0zK1oiwWqIlRuYSLo3xSkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjsgNv79tAzYRkjz++sCvjMVtPCQb77REFakID8i+wMv46oqgp
	LXC1UPE2Wp7EGEY1Mh0WbSfIdNHZUKWOzCVMHaguWn4TvbfuDqKwqpseS6yYKm0=
X-Gm-Gg: ASbGncv4c3mSbwmAoR4ndhRIBB+Mjs4YYTSzPl7NQqkTQJG+2Uadt30UTWFHQb1e+kf
	8edVpIHwBMOhUhIeSCAEmEUD8z1I9MuT6xdrM2knm4aizcvOushsHHRT9TJsB+24+MDQbTDZSGI
	4Aa22CURhWHBMnzJagOKtqdykvFkXB80v9h941mQHMf5qTPws9HLs3mnu0NfRH476/ZV87nFncT
	ssul8N1+kRCaLF9DO3uALUcVT+9Hgmxb6PkCQuhLIYGXiazRZnsW6AZCQv8aQTUgBcmdBtyCy2h
	1/sBkkuPZgxgKvfVUs4ELYAzyWwPwk5b5ykdFvxclI3z
X-Google-Smtp-Source: AGHT+IFeK3NLpWhftsdQ8Ics5/LaD0tcI14QgpK78wUutMkta5sQbX0lgMD3/ZSxv6pg1kYPdIfhBA==
X-Received: by 2002:a05:600c:1d1a:b0:439:a4a5:b86d with SMTP id 5b1f17b1804b1-439aea9be73mr202533325e9.0.1740582824533;
        Wed, 26 Feb 2025 07:13:44 -0800 (PST)
Received: from loic-ThinkPad-T470p.. ([2a01:e0a:82c:5f0:ad62:b2f0:914c:91ae])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5442c0sm24390445e9.32.2025.02.26.07.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:13:44 -0800 (PST)
From: Loic Poulain <loic.poulain@linaro.org>
To: neeraj.sanjaykale@nxp.com,
	marcel@holtmann.org
Cc: amitkumar.karwar@nxp.com,
	linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH] Bluetooth: btnxpuart: Fix baudrate reset on remove
Date: Wed, 26 Feb 2025 16:13:40 +0100
Message-Id: <20250226151340.1017790-1-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trying to reset the baudrate from device remove callback does not
work if HCI dev is down and not running, causing the next device
probing to fail, as host/controller baudrates are then out-of-sync.

To prevent this issue, we ensure the controller's baudrate is always
reset to its initial value in the shutdown callback, during the hdev
close procedure. That guarantees subsequent open procedure to succeed,
regardless of any device removal/binding in between. This also means
we want to reconfigure the baudrate in the next hdev open procedure
via the setup() callback (HCI_QUIRK_NON_PERSISTENT_SETUP required).

In case of removal when the hdev is up and running, we have to call
the shutdown procedure explicitly before unregistering the hdev.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/bluetooth/btnxpuart.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index fc313559c2aa..b1344a9a8925 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1274,6 +1274,9 @@ static int nxp_shutdown(struct hci_dev *hdev)
 			set_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
 		}
 		kfree_skb(skb);
+	} else if (nxpdev->current_baudrate != nxpdev->fw_init_baudrate) {
+		nxpdev->new_baudrate = nxpdev->fw_init_baudrate;
+		nxp_set_baudrate_cmd(hdev, NULL);
 	}
 
 	return 0;
@@ -1578,6 +1581,8 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	hdev->wakeup = nxp_wakeup;
 	SET_HCIDEV_DEV(hdev, &serdev->dev);
 
+	set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
+
 	if (hci_register_dev(hdev) < 0) {
 		dev_err(&serdev->dev, "Can't register HCI device\n");
 		goto probe_fail;
@@ -1603,16 +1608,15 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
 		clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
 		wake_up_interruptible(&nxpdev->check_boot_sign_wait_q);
 		wake_up_interruptible(&nxpdev->fw_dnld_done_wait_q);
-	} else {
-		/* Restore FW baudrate to fw_init_baudrate if changed.
-		 * This will ensure FW baudrate is in sync with
-		 * driver baudrate in case this driver is re-inserted.
+	}
+
+	if (test_bit(HCI_RUNNING, &hdev->flags)) {
+		/* Ensure shutdown callback is executed before unregistering, so
+		 * that baudrate is reset to initial value.
 		 */
-		if (nxpdev->current_baudrate != nxpdev->fw_init_baudrate) {
-			nxpdev->new_baudrate = nxpdev->fw_init_baudrate;
-			nxp_set_baudrate_cmd(hdev, NULL);
-		}
+		nxp_shutdown(hdev);
 	}
+
 	ps_cleanup(nxpdev);
 	hci_unregister_dev(hdev);
 	hci_free_dev(hdev);
-- 
2.34.1

