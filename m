Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32314606A320
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 14:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32314606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=VLINbZtC
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4a357b1c649so1442031f8f.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 06:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795359301; x=1795964101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NN7j+Whp+uu6bSKhfNBmSODqo0al6Q7oSpDJ5p80Cvk=;
        b=VLINbZtCNhN7EwPGF1hBurUnGxwzTGKlh3mmPUf2lWxEkzcJUV9Rs40wpfPRtg/4Cy
         qx7aj9+sCAAAmdbqlCWbkhL+uWvxefFtnZgX8stX9l6MKP8UhGjSrYwnd6jtPc1pHbzj
         eUwyYfcrzhfjeNY7WcrPjiSIDcNtlgcM9ro+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795359301; x=1795964101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NN7j+Whp+uu6bSKhfNBmSODqo0al6Q7oSpDJ5p80Cvk=;
        b=lK47Y3Q/t9BScuhYNgVaLKhADmgZh5dn1ba8xi8nHGieTs7TAVnTmZ2i84TAOU9RIT
         cFvBlJxIBHX4SZbpclyTyV7ZEFyWdMCRHmA+vnLcZovG+d6r4Cvckxoq7ZPlXW1l81GP
         WHqRrX0L0Cqj7aoe4ZOMvpyNp3lgwZRFWzXCIKs+4IeqwxzwZ5IreCIVriBvssv+qgDV
         ARJABGAYYOfs695Pab0B+OZCfHHb4+cZOJMbGnYqmp5PDwqp9HD857cXUfZs7ixGuZB3
         RRzFLCRbXEhIDhTAWDZzF+mZvsfCfKpi4gUPmixhME3AuYLgCpKUoj1RCIqKapj0pkSf
         MTGQ==
X-Gm-Message-State: APuU4Z9Vk13WbQT4d3DaKTUxSDQM7yV2MsRUhNu2qYIfZNwLzuhnIurM
	2jUdRikZKNUkNzIynyj3lezcd0QdepVV1guoFhtHYXSiAT56nb75kVse3uDRMrfYomf7IUsog33
	DIt0c
X-Gm-Gg: AZFdTZdOjeDIKdBqmSY9cuLaK1LP7Rd4S0bdyXoSAfE+ZJwJcA4qDWCOMKcI/sC9tux
	9VFgu0tOs77vSM31nu/v5v8gMTT9Z+a87jeLlXQWOJyLlCwNcJGsfJUn2aBNVO50K0qOMNTJZBL
	yCduiUOqCelz0K76LZ+exAL8pPSRG+/JEfMZSI7g/wxlNrlnXUWFB+OyXeWdNCFebLmlXuuMka1
	dfGtYCMcfCKQaal6coBXtTYxTgT2DtQGSTjm/zrYpQTU9lnHEN2uycfnXkqgf1Wrn4bElPRFYis
	4A6ntrfFI70vTJ4yUj7BGFT4ubVumW9qY3mib28/5RRf/GnbIPYIOLa9beOkKapUaUH4wI6PKae
	fkULijlRgN4vwFAxWFiPRGC6yKB84HwXRHSHka2qF0tDz28iVwQ1guMXXFkHSok/W4RTk/qiivo
	mrS2YkhRFmtMYhQLehFx80pW0410QZuGF+e6IhU8Z343mDWtVgv/KsKsE6+3hvWcs67621Q0o/r
	opJLPO1n6xpQR/xGvaT+rFdJ94FJ3BVK52L/8vcMGhMmOHCfbyO0b7Pwx4rPfC6K7nplH8ERXGm
	jjdV/SvJk/HeclqXgt56QqEucoCje02sjG/habg9ELLYiq2JX4i4Bix+r44TIxG7m0lpvqA=
X-Received: by 2002:a05:6000:1788:b0:492:3176:3d6f with SMTP id ffacd0b85a97d-4abb400aefcmr16796490f8f.47.1795359301320;
        Sun, 22 Nov 2026 06:55:01 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab65cb4341sm17624002f8f.4.2026.11.22.06.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 06:55:00 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] Bluetooth: hci_sync: Fix start/stop logic of default advertising
Date: Sun, 22 Nov 2026 15:54:28 +0100
Message-ID: <20261122145428.1499940-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Default advertising (instance 0x00) was started even when it shouldn't.
Setup:
* adapter that supports extended commands
* connectable off
* advertising off

Steps to reproduce:
* add advertising with instance 1
* set connectable on

The kernel started advertising with instance 0x00, even when the
advertising property is off. We should only update the default
advertisement when the proper flag is set, and that is HCI_ADVERTISING.

Other advertisements (with instance > 0) have a separate connectable
flag, so we shouldn't update them at all when the connectable property
changes.

Fixes: 37adf701dd87 ("Bluetooth: Add per-instance adv disable/remove")
Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
 net/bluetooth/hci_sync.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 638589f77081..efcca81ce284 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6648,11 +6648,9 @@ int hci_update_connectable_sync(struct hci_dev *hdev)
 		err = hci_update_adv_data_sync(hdev, hdev->cur_adv_instance);
 
 	/* Update the advertising parameters if necessary */
-	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
-	    !list_empty(&hdev->adv_instances)) {
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING)) {
 		if (ext_adv_capable(hdev))
-			err = hci_start_ext_adv_sync(hdev,
-						     hdev->cur_adv_instance);
+			err = hci_start_ext_adv_sync(hdev, 0x00);
 		else
 			err = hci_enable_advertising_sync(hdev);
 

base-commit: 4fe38719e6738feaa90486e36b0790dd5d960a96
-- 
2.43.0

