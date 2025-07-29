Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE46D298243
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 16:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753806308; cv=none; b=Rv4X0pOeXYF/GjFz87nHwqIjWwVdncOtkE/jf65M6un/ylywIarcZYYqpHFamsYOBKtAmyAYILcMkpniNfUYYm0+2buGKuF8ciiTL+hpT/KL8j7t18u6IRpRNo2EYq66j7wmBUmbay2scdTx49/aW/V//ny7zEMAGQK4yxij+Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753806308; c=relaxed/simple;
	bh=5a9hYHIS54Xrv27NFj+vSpBmQL5vwJMo2m35ZXCvqk0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LZzt3r7IfqRNQGrCfrDX7LBp7/8K3IofEM205NpHoVqh+8zxjFCLH/hNRpiEE0rZttRg8Aw1xl6Zwfmy+OWW2ciGqj7UnBm0X3K00AWciEoPrxVnb/w/p+kS55IS802mMtSxEWbCZfgk9cmDR1vKqKX/lYR3W/prLKKZbobuqYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRIrq8q0; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRIrq8q0"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-535f0912f1cso2741e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 09:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753806305; x=1754411105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FVGFnbAUskXOsresnYr283tk33aNvOrywmNU6micQV4=;
        b=DRIrq8q0UUdp77COv/fWR82n5K7GcxCPSPGFAOBW9giozrSfGkoKzKtt3I+c6bSMR+
         lZnxbWI9aP0yVuyPTu19cFKy2Iqf9gcQ8nvM6+mWagWeY1PYTQVCkoEoYMboL5tAWH61
         n2G7yr5soH7CIKkwMPP+VJZr2gLGDEk4gECx98D6l0UNLdOt93JCdbfGO0ZjWqddK7gb
         SkyS30cuo1rNrLF/Z/ttDQU54dOhp98XlKdhyob3G7Fqh8DGmLmRN1mpAIYXQ2HFE0Mm
         W4goV3pZ7o3u/Fr3nyjxaXl2JQpy/eSWbGKAAbXpADxk1LBO/5k/ikXyZWkxjvq7a9/N
         MNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753806305; x=1754411105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FVGFnbAUskXOsresnYr283tk33aNvOrywmNU6micQV4=;
        b=dunG1z1KHHuyg4lufUFnRNNV6R91SpDbyl6x3o2dxQ4AxcN7cbfM8Ce5Pi9eOeH40y
         P/srYl9p2tsisxC4EE3CvwsEI4JHJ7s0OJe/gutjVU/DUjJl3GIJ9cKHR0NzBNc//slT
         Ph47Wvy6pggNeVEVsqLcSkJObnsuhzibfXUi1uRtZXdGJckQdp8zUgskX/m6uJPpPHvU
         vzIMAIMpdN9tGgup9hGPrfCfMy7UGpLcqiUpVJNy/bVxO/oYqZMPhxyFI5NFxOeAmiT0
         vCc2zBF1T9u54pFXoiMr4NNaHGCeyVms7bkTpiT2YShiyLXY70hyHAawDxA9b3qFGpe8
         mrHQ==
X-Gm-Message-State: AOJu0YzYN08l7FDwolSq0BHUft3vLkrlBM8kU+LcOOTB0XLidhWbX86T
	7hTcmnooUoUusYRYzQjKk+2zcQ1BItiZZ9pzl0mh1/hhx+FIJjhC+30DgQ0Kwt9X
X-Gm-Gg: ASbGncveXL/dF1CSbdIOcDxN6Lv6GV3C1/Cb7VcN2Qugzfkx6R47LysI/8hjfzDpGJB
	BsIhXp4sR5QqdOlq0jZrPN42sHtW1GuMgizpdkHrO+zagmNWgVOTN8KHhoOssYQaVszXlGV/OY1
	LgdKyvte2PpiGtoRaOBd9ItCMLFkz1JwQ0MMHjUxjsEQmlyU9/ZBM7/ic33sx7ffVCB1ysRqubK
	FxcGW7U5Afu7ZH+nge+AbZZNID/OEvvLo4YTZ1AhVoepJjhd0gK5Pedpm960XImH//zayevWeJn
	AP24Ht2/iWFnK7ee0LrIb/eYJlIXKaMmXBjjAjs/u6+U3UFyq+PfvGkgj7GNkIa6I9GCe5Sad87
	wpNo6K/ev+4r2+pgNzok3xj10ryGB3sEr+/vp3YK5nudaK3Ec9UqXG5AqJDn8r0xx
X-Google-Smtp-Source: AGHT+IHpt5YQDUNrlwG8C9sYBUx8kZWfKkyC+bL2b1m0S3n+H7xSlWcjch9WVF+mAJqkUB7Rc6N66Q==
X-Received: by 2002:a05:6122:17a7:b0:537:3faf:9b43 with SMTP id 71dfb90a1353d-5391d014aa3mr393872e0c.12.1753806304865;
        Tue, 29 Jul 2025 09:25:04 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-538e288700bsm2139773e0c.27.2025.07.29.09.25.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 09:25:03 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/4] Bluetooth: hci_sync: Fix scan state after PA Sync has been established
Date: Tue, 29 Jul 2025 12:24:50 -0400
Message-ID: <20250729162453.221656-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Passive scanning is used to program the address of the peer to be
synchronized, so once HCI_EV_LE_PA_SYNC_ESTABLISHED is received it
needs to be updated after clearing HCI_PA_SYNC then call
hci_update_passive_scan_sync to return it to its original state.

Fixes: 6d0417e4e1cf ("Bluetooth: hci_conn: Fix not setting conn_timeout for Broadcast Receiver")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 7397b6b50ccb..387c128f2ba0 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6985,8 +6985,6 @@ static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 
 	hci_dev_lock(hdev);
 
-	hci_dev_clear_flag(hdev, HCI_PA_SYNC);
-
 	if (!hci_conn_valid(hdev, conn))
 		clear_bit(HCI_CONN_CREATE_PA_SYNC, &conn->flags);
 
@@ -7080,6 +7078,11 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 		__hci_cmd_sync_status(hdev, HCI_OP_LE_PA_CREATE_SYNC_CANCEL,
 				      0, NULL, HCI_CMD_TIMEOUT);
 
+	hci_dev_clear_flag(hdev, HCI_PA_SYNC);
+
+	/* Update passive scan since HCI_PA_SYNC flag has been cleared */
+	hci_update_passive_scan_sync(hdev);
+
 	return err;
 }
 
-- 
2.50.1

