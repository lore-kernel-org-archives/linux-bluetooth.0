Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD8723B628
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 20:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753390393; cv=none; b=E01rKSal8WwoBuP37aetZbVVwkFLZauV1KWerUh7/pIFKgMYCCCftsl8/7ynzzZkZ3J1ihdjP/or1RTpHvnj1OmItEQ8n+8MUI7mc8618JJlp7gfvHvduCkHRp/levDCnAyUso9EFG9Ek19I043zQWEzuf9ImDL/eArPULfMj3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753390393; c=relaxed/simple;
	bh=5m8Di2jD4jeL8fmoOcPYjNUOaNVnUdnMvqqpNo8TO2I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZecoEqyI/vzPzgrlfISO5JFNPMb/vy+n4j0ubyXmimYBHqweWs77H3b/IgcNxK+ag6RQIBhIdnVNAC/3lhWq1n7HIZFIS+ZQ3UzzGerQVIMiRQQxDNWabNIQfrLeaGJg4hL2N+VsJx+rMa2x+LyuEPNCkJ8J2t5e8F/3iWaufgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuRYC+6u; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuRYC+6u"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-535f0912f1cso447975e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 13:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753390390; x=1753995190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Aye5Mrfkh9a0VC5X/To1UMzasgjfumSsPFqNeTOWcB0=;
        b=BuRYC+6umSFS22eaO9vuCnv8pkDKHKYti36vx1uaC77iRJ7jMbQQ3AuoHCV9eTZoy3
         9s8OW4aJ5X1Kp6IzXA5hpM9GWzfTKEz9Huk4fwsJC28DJ7L6FOqx8bXRsDPRyFZq/hcO
         fqu6hODi2CUBrOrfizjWV23B9yD1bibOekhnPfgoGe71t6cEtdgXHAhDUDk3PrFFIY42
         +ZpEw775nnKmxXRZKYK4Jloyq7Xn3DHiiz2o7HKGJR+BHAaV1Eb0VV625Dt+AngLkc/2
         5hvkXAMpSkAob45AJ9aAKn39uK6V7ydDq6Bp+uMuq5IZX3ing+jVHxNhRGSDDfHL533N
         ukPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753390390; x=1753995190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aye5Mrfkh9a0VC5X/To1UMzasgjfumSsPFqNeTOWcB0=;
        b=qrE3AU/dzn7KGrWgqUg3Glr28UPG0cl+Rg+kjzgNycdLWG8zeehxTKPsW4T0aElOtH
         TCaSdATeFw06ohXnFw94U5tj5FkIxqd5oFCuzF2gkR7TQoYH/Wc+7LKiHYhNbCaa3e3i
         RbRM+lYB6nyHt6TN9WQ3fP23dw1GXqr5e/RDB26V7sQgmibPkxK27Ysl0xTr3e/bkjJD
         w2JiYrwx2FTz58hOJ1VVriuq8j6a+/miqzXbMB7Uytm5R3cf7hBXe0CafJqljiJk9ub3
         pbiA6OrLkzAonGiPM7jt+9/bffuXp2SEgbSJXcQ+DX+TnOdKrE6PJQPO1r1NH1ID317p
         TZmA==
X-Gm-Message-State: AOJu0YyHItJfU+vTHMDwL0RuxM4iO+3m97WhMFE8lCxzWuT8Qzyh9hZ9
	dZoNrErX5VlPm6B7O38GGTi4hjx0Nm3yfuuWZ/kvc2H+DL0MVlHwPs2ww7QTFA==
X-Gm-Gg: ASbGncvz5UHwMOlhZNca/i5EO60Z0e7HU3qJMWMDXid6BxQd3CGrsZPU0nZW3UObgoW
	TGiDyHicE7GljKhv4+gka1k6BA9xzYnOyO3KIC9V702s5TB+Jf0Jv24+bDgafuwCb0IJ5wVFs0D
	hxBk3E1Z9WZihP53mHZhvtLcCokfUo3GkqNUS1V4UB2yoKT59Xucv9dmhCO8B06we7vyb6/DudI
	96Q8OCaALSE1AvI7pr/0jgXaog5LfoJxUJ2E+S8iUklrUlvu3Nb8gUy//makKkm1hxdFeqSHy6W
	4KLLJbESUiRkdmCsUKLgokBFSRHcpnqxSslgwBx8me3o9kcRAYFFL2fUNLpP53JIu3sQ01qx/Jx
	WywsUe9gk1oW8QOcYuxChSuZx4gcfvbUmEn7DHLn/OLx7XNTTHIv8P+V1U/v1wkJ2
X-Google-Smtp-Source: AGHT+IEyZnpCZGnSAFdVr0oucCsJJDf5KS81OPd+etsRRMZ0aqK5hQ9B672FYhHRO0YnHPrd6fgmVA==
X-Received: by 2002:a05:6122:251f:b0:535:e789:6ccc with SMTP id 71dfb90a1353d-537af4489a5mr4675690e0c.3.1753390389722;
        Thu, 24 Jul 2025 13:53:09 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-537bf66adb7sm612774e0c.19.2025.07.24.13.53.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 13:53:09 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_sync: Fix scan state after PA Sync has been established
Date: Thu, 24 Jul 2025 16:52:58 -0400
Message-ID: <20250724205259.13273-1-luiz.dentz@gmail.com>
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
index 2b4f21fbf9c1..ae165e693533 100644
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

