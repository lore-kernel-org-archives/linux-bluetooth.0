Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51501CDA3F
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Aug 2024 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724345496; cv=none; b=mFE++iOWcgpEHtL5/aKWIB2THeoipjLVKjtOXXo3ZWyWLHYAIzY2zJUTrJOUCx+1Lh2VGmnOW3TW2DwhVI+VrqfP6AzI0jK13TVPbMnkfLpxrgX2i+ZBfESCBS+eM4036fKL2MQcerf0mPvAiqGcus+tq5Sg04+FMtvHLgxH3ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724345496; c=relaxed/simple;
	bh=v10iMEY+xyRcHossuUTsOxN3ukvgPO+1e1PoZBmxpYw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ajRiTRnRd6BKR5qIrJxvnOLXgUiTDWRSF57gYzrM2aGL3xMukAAwG3ROw+vaZAZHSy9PUvC5QDp6CPaqoBy9lwIathpryTD6W7CoEZtTTmzZyVGrrsR7p5wviEi4c+I4D2rnI7H+CJ3w1K0f5Lqar3D6dzj08IxEscTdh5eXZq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erOC2I5T; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erOC2I5T"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-498f08339c6so42728137.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Aug 2024 09:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724345492; x=1724950292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fguTafjqdf93m58hP8L0hQ6VCMD7V/albFYFIfBHy78=;
        b=erOC2I5TTpjKd86i6BdTWvMHktTuGblUgYs5GeUvGTb5L0wYouzAPYMIKp+VotS3Ek
         bd03JF1lF9ASOjiosb14xiKAX5E0tYw7kvDeDYhU75gPhxMyln9Nxz19WuoYxgtt8yqo
         r3hkwaIp80Nc36/M2cE8erhIM6q00d59xTBxc24Zt8fYUKc5Xyya7PCvqH0md6s1YyBI
         AsH3QyOfFIYNb7NALzLomxMXYzZg28eKeTUnaJMLEvFdIHsbSPDhMlBcffRjXugZ5pog
         omLRfvdq16HS+t6HGtX/IuUKMZwjU8e00jtYDhwkn+9FIaFsB7tSapymX4WqPYZdpKN7
         u+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724345492; x=1724950292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fguTafjqdf93m58hP8L0hQ6VCMD7V/albFYFIfBHy78=;
        b=UP6uhnb1yFi1rWcNcbi8napn5WaH8MX01UZLwrgWBlIVvNNZ1UUX1i/eqFLtR+L9HY
         W7rXiSrR/giujzyfYBZu+bv+XIzgg+NAdRC/Rr8ptv8jMtcI4LtiFTNt9ct9L7kJq3lN
         dqK0uLtOOdyhPnWyfEoXZmUODTv9Zg7PMAooJ7yhNNd283+Z8jmqESkNXGPfq9/gFdtr
         G+blwIs6BgjUglelxhbFt1V3PARZ/g7WRVRSrf0XEhvA0eCKgDzVwSnSXLIDWwwsQdkB
         qgzAKwx51rt+TEn4ZcML/btFJgkQZkuQR82LZ6NmdtwTjRVbEA7ODe4AiyD7IYf2Q819
         CFgA==
X-Gm-Message-State: AOJu0YyqCtuF5f7oh65CJpWsJKTTyKFWvugMGJidv6LgC5KklFYAwoCd
	DVOxNQB9dO/poChcZyOHQg9xRRVQ7YEbFOUMMjd/hLEXJ92CLXQMz87BNw==
X-Google-Smtp-Source: AGHT+IFxOW0aNV8ClWOtvj+3RA1x8BR1LQcLG0flXunjku3szHy3/Td9Gt5ieFimZxwzl3u9oipriA==
X-Received: by 2002:a05:6102:3f49:b0:492:aa32:81c4 with SMTP id ada2fe7eead31-498d2ed2db1mr8822943137.7.1724345491812;
        Thu, 22 Aug 2024 09:51:31 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-844ce50ae57sm231795241.21.2024.08.22.09.51.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 09:51:31 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: MGMT: Fix not generating command complete for MGMT_OP_DISCONNECT
Date: Thu, 22 Aug 2024 12:51:29 -0400
Message-ID: <20240822165129.540101-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

MGMT_OP_DISCONNECT can be called while mgmt_device_connected has not
been called yet, which will cause the connection procedure to be
aborted, so mgmt_device_disconnected shall still respond with command
complete to MGMT_OP_DISCONNECT and just not emit
MGMT_EV_DEVICE_DISCONNECTED since MGMT_EV_DEVICE_CONNECTED was never
sent.

Link: https://github.com/bluez/bluez/issues/932
Fixes: 12d4a3b2ccb3 ("Bluetooth: Move check for MGMT_CONNECTED flag into mgmt.c")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 25979f4283a6..fdfe9675535d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9738,9 +9738,6 @@ void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	struct mgmt_ev_device_disconnected ev;
 	struct sock *sk = NULL;
 
-	if (!mgmt_connected)
-		return;
-
 	if (link_type != ACL_LINK && link_type != LE_LINK)
 		return;
 
@@ -9754,7 +9751,12 @@ void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	if (hdev->suspended)
 		ev.reason = MGMT_DEV_DISCONN_LOCAL_HOST_SUSPEND;
 
-	mgmt_event(MGMT_EV_DEVICE_DISCONNECTED, hdev, &ev, sizeof(ev), sk);
+	/* Only report MGMT_EV_DEVICE_DISCONNECTED if device is considered
+	 * connected.
+	 */
+	if (mgmt_connected)
+		mgmt_event(MGMT_EV_DEVICE_DISCONNECTED, hdev, &ev, sizeof(ev),
+			   sk);
 
 	if (sk)
 		sock_put(sk);
-- 
2.46.0

