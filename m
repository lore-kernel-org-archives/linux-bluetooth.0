Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3748529BDB1
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 21:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783979743; cv=none; b=TxFM6VIXneNmn9ze9zAdiT3hrw+u2aTyMFiFtUJtHnIWX9i9NyBLOnghJhCr7BBZ7X8q8fKdSTLTuUEdSjVA/ozii9d0PsyWPZOgrVyPHa8HLdPJSTxIUbVp3jnz3MbCw7ynw2ERvjecdi9VsOemLO3KMd+dsUC04UxT/fhrfVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783979743; c=relaxed/simple;
	bh=v1NX+Q3FNkgFR/Pq7GmcJ+Upiuvbb+baHndc40NfbzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcznyundndx8fb3gbNncz6Sm3N+X5IY9W1stDaJ8HUL8BnlhPSGAOfQQYEe8UQs+3/mvDD0BmoSE6llO2sqJLHpPT2vD0oRgNn9YXdtq6PkoFt5az9VHmde7k61XXIfCmhtvonGIKRq2/IMB4rL2aD581OTff84a5cD0bcztWIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtYv4fJy; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtYv4fJy"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e50c5d14cso214759785a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 14:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783979741; x=1784584541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fsqv3tux7HKb3kRKMNCo5MqBPmwNqApCCQZ3V4rd7ZI=;
        b=TtYv4fJyU8OzhtVQOSfDtWrCviSF9cosQrZG2yj5wm/MTBQe9EpOvovvSnNkK/r6ls
         oOXrpDKbqjJGagT/OFvW6BOxL/ijGW6xLFUyuPQEJk/aVrdxJzeMDFcMWmZzkXu01+ZU
         HKhmIfUnDBC0c6g3SMB0ECahvHXMmKuYxhi1oHvCk/mcCMgaMW8tvAjYu9ho4Y3QPHpm
         0NhPL4U4DeUFu7qRly6QYxEEx5F//LKgQgk55Np2ucVI0aOEsNwonxE1yYECNUzTr9py
         NO7Vtp0dPMDrFZpChJ28KMLlwdSNHOzn9EnXV618kx+98gYS7i6vL3Ls7vmjKRGciqe6
         o4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783979741; x=1784584541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fsqv3tux7HKb3kRKMNCo5MqBPmwNqApCCQZ3V4rd7ZI=;
        b=pKBxYc+EdDdUjc8OU9sHjs5VnJwT2ohDsE2S/GmtruOJgjBZjNUlUUbKq1b1PUiJKL
         sSBl8Pe2hqZjBFGN3htruhND7R5WGrIp4cKsbrhuE1Ft9YN4H2PEwo7GLZUqa8skeZnI
         X3mHsX3eG7XjP5U2kwiy4cNutyVWGVmHK4KAQp2RJ87hmCeTmtG7EZdF+E98NP3b9tmU
         eYzXCUDR534riofC0MJK3Vg2Zm/XRPMPKGv2aVTAeJ2HSLthpMQ6Halcxf72DtFo9j7M
         rU3I5LRj2qEq/oMNAx2b6nUCmjsySZSzRNlkfIBEx3YIxaClQTcUqNB99B27kmRM+8ay
         vYUw==
X-Gm-Message-State: AOJu0YyOA2CivUoQofb4oP2dbjQ5UVfwT96ZYsCgDKqMKV80ky1CJL8X
	22KafacJh4YuNSng826bDvJTGWEu6Gr1ZggVxTftcmTDHX+SzDPQ6FfVZRMmyeUAaOw=
X-Gm-Gg: AfdE7ckq1EsI69B2Mx+oB1tsJgx6XWY6yabMM/7eF3YUmvxpqElibTWA5/6Pz9eRstI
	r8NadljI8NvPOSN5HAZU/o5wRWuIAJjjzjn/1ZVGT4yULhyB8v5UE6qps0Fcd0+HzuZHeqpcYYN
	5Kv6yy5MwClnNYB52qCgIEEN9Pz13O9LkhlJUawtlqvnDxRxJ543ykBrdHT7xzfwg2PZZRuVIPQ
	4qcd7JjtPYdY32rj/EDukLMqfKW+u3/9t/Xm6RUwzWPlfiuk4VOe5lpWb2poETZQaI5kwo+w61z
	Nb6jz4rW+NR454SspsGT0vKXrsxydxGK2K8Np4771UbHDCYGT9cPj7blrUHz4d4pVTEDg1gjg6J
	53p+N4kLdib2dHMGG4kAllPLNx6suyg12jXLOT1Eut1rT5KA6IVYdeakANw6rr44STlCscbMNjh
	T3zpIOGLTKUPKRf+9DsHSLxrAes0dJjFwYfzPuFYlfAKkpbW8=
X-Received: by 2002:a05:620a:a2cd:20b0:92f:196:209a with SMTP id af79cd13be357-93083d41c6emr70710085a.50.1783979740953;
        Mon, 13 Jul 2026 14:55:40 -0700 (PDT)
Received: from pc ([209.202.207.85])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cfacb3sm1206001185a.26.2026.07.13.14.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 14:55:40 -0700 (PDT)
From: Ameen Al-Asady <ameenaladdin@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Ameen Al-Asady <ameenaladdin@gmail.com>
Subject: [PATCH 2/2] Bluetooth: hci_sync: Skip MSFT/AOSP init when controller init failed
Date: Mon, 13 Jul 2026 17:55:37 -0400
Message-ID: <20260713215537.81222-2-ameenaladdin@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713215537.81222-1-ameenaladdin@gmail.com>
References: <20260713215537.81222-1-ameenaladdin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_dev_init_sync() calls msft_do_open() and aosp_do_open()
unconditionally, even when setup or the HCI init sequence has already
failed. Both send vendor commands with __hci_cmd_sync(), so on a dead
or uninitialized controller each of them blocks the power-on sequence
for a full HCI_CMD_TIMEOUT and logs a spurious error.

This is easy to trigger with an Intel USB controller that needs a
firmware upgrade: btintel resets the controller to bootloader mode,
the device drops off the bus and hdev->setup() fails with -EINVAL,
after which msft_do_open() still spends two more seconds waiting for
a response that cannot arrive:

  usb 1-6: USB disconnect, device number 4
  Bluetooth: hci0: FW download error recovery failed (-19)
  Bluetooth: hci0: Failed to read MSFT supported features (-110)
  usb 1-6: new full-speed USB device number 5 using xhci_hcd

Only initialize the MSFT and AOSP extensions when the controller
initialized successfully.

Signed-off-by: Ameen Al-Asady <ameenaladdin@gmail.com>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index b4ca34abe..38158835c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5173,7 +5173,7 @@ static int hci_dev_init_sync(struct hci_dev *hdev)
 	    hci_dev_test_flag(hdev, HCI_VENDOR_DIAG) && hdev->set_diag)
 		ret = hdev->set_diag(hdev, true);
 
-	if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
+	if (!ret && !hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
 		msft_do_open(hdev);
 		aosp_do_open(hdev);
 	}
-- 
2.55.0

