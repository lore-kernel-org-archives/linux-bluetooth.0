Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A631B6D1D
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jan 2025 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737369602; cv=none; b=eHZxqeYwubWMlXdSTGmIbseoFMEkKKgmih3u6YSF4cQsDOKuO2XNCg8nG968r7JBCVkjGK6v9TeF9esbEljCS8fGBHytQ5q+uYFeTSogEev0/dU1rxMhTsjYPsgTx8BfRiV6jltV0u+lpGsHUztvTKytM0+BlL7/IQNy9gqfkJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737369602; c=relaxed/simple;
	bh=XcgNwMp10JHwibgeOZhvDs0Gmaqgy94M2VvdH+agwL0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=i4wOxaOFft+hMH4C8R+EhSohINOGmCgWzqCNbLXzql8W0uYkW6/wTOJ16vU1EmQX4ZXMUi2bO7d5LFG+YHURw3uZ+4agD6uwgr2ghIyQ+adisLpLj0cAxB4Ba/oxijB5gEmAKPttLVZJzw5U4ioQdKqzZNUlNx6I2nENHB/1Fug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xsUKvO6Q; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xsUKvO6Q"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2162f80040aso78769765ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jan 2025 02:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737369600; x=1737974400; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XRrBzBVaNpwpNiwK2IV+zWpm3Cq8QrTlem3X61FtsSs=;
        b=xsUKvO6QM01vPPFnhPlP+MZlvmrb04GJw49YKTwziwybN6o+6HJYyojty/KEFit8+L
         02VS+MF3Vs/Yo31XReJF3IswtjEdN+bUJGd0/zkxWAyMr3MkoAjyzgWsuSJ19Q07WN7H
         nrnXpdI4LAggaG/U0OaKADo32hK1DT+ROHQPk6dWsrON4KL3DwxNuOePqwdEkCKbhP+z
         +/gbK+CgvvfZ9/sm7YRVpbDjQX0CLa/vizKerhyQRhm3orUfRkm+/OVAx1y3B/unAC9G
         4dgI+NyLommMa1DRQcQ3J9/2FJX1wBP9sFcuUVyAf/1r1cJb7+ilxXlS5w435MhVKXkv
         0ghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737369600; x=1737974400;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XRrBzBVaNpwpNiwK2IV+zWpm3Cq8QrTlem3X61FtsSs=;
        b=bQsSfrMbzH2+cxJDEvN/5ehu71s4ej+HC5BBrEv9uIqIvngLcEY5zD3Vg0lNIbxo8T
         KuovGCvtOCV87155CWNW6XgXwZPVql6xXk2r62EulvulkmRCnQYHKUyvf423s2AJIm4o
         9zhJskyVtim9D8tpOSFeZ+d4Dt8L3CvsYhlqvsWTecu7y6b9IAjPAbW1nWCqZQISyw78
         jWrafdkXQhgzuKStdxEakPyisxjBEqoW7rcNlHz5ZtpvldvOwlbGOnV5lYmZ5cZFLacu
         sMftgcdO8R2xcqe/6B+fOCKnn8SajE1a25t2/4M7y51yfezsyR/XL6byAwUKX+pF0pN2
         nGZQ==
X-Gm-Message-State: AOJu0YwU/l0GVsR6nyNkTMn2+yLj3n7IZaLuzk1DZTKycomzf9CbfI4n
	9Q75V4Swc8fibvphJZMKVPCJfjcDQXXz4mJ/YS3K37DtIGMRVeVIaYk28hQTwei27r4UsaMdSPr
	dvog2etSldXqCG7r4iUngRbQo5Z3FQ0xCR4kpx+qpn70+YkZxh1A8Odsmubey8FKxp02zGm0n5N
	UVM0SaENY0dQr7kU7sCanZKyHw7BytTj+hg+ghSGFS1z84WZJTpg==
X-Google-Smtp-Source: AGHT+IEphaVcP2I9D7AZzp0aN0FxNKwEPPVHBsukJypLUCvNXQ2QZ6JrS/PUb0ozIv14mVFh3tO6R0XDE2Sx
X-Received: from pfbby8.prod.google.com ([2002:a05:6a00:4008:b0:725:dec7:dd47])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a14:b0:1e0:cfc0:df34
 with SMTP id adf61e73a8af0-1eb2149467cmr17611731637.16.1737369600398; Mon, 20
 Jan 2025 02:40:00 -0800 (PST)
Date: Mon, 20 Jan 2025 18:39:39 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250120183938.1.I77eb26ac40229001ac90a70cb877c902456721b7@changeid>
Subject: [PATCH] Bluetooth: Fix possible infinite recursion of btusb_reset
From: Hsin-chen Chuang <chharry@google.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Hsin-chen Chuang <chharry@chromium.org>

The function enters infinite recursion if the HCI device doesn't support
GPIO reset: btusb_reset -> hdev->reset -> vendor_reset -> btusb_reset...

btusb_reset shouldn't call hdev->reset after commit f07d478090b0
("Bluetooth: Get rid of cmd_timeout and use the reset callback")

Fixes: f07d478090b0 ("Bluetooth: Get rid of cmd_timeout and use the reset callback")
Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
---

 drivers/bluetooth/btusb.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9aa018d4f6f5..526c1926a407 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -899,11 +899,6 @@ static void btusb_reset(struct hci_dev *hdev)
 	struct btusb_data *data;
 	int err;
 
-	if (hdev->reset) {
-		hdev->reset(hdev);
-		return;
-	}
-
 	data = hci_get_drvdata(hdev);
 	/* This is not an unbalanced PM reference since the device will reset */
 	err = usb_autopm_get_interface(data->intf);
-- 
2.48.0.rc2.279.g1de40edade-goog

