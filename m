Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB8429C33F
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749565718; cv=none; b=mSJIr1eq94w9SqmngddP7X+2lXGoCFoGxtdOJTnT/3J99c3CNQD7cQCD/SKq1fqvH42cB96wivuRwi6/Ps6T07toOBitiJj26b9KvfbX8hbkSZXdlEfPMk9gLJ76k27l7Q9jTlkS7Gdfds9Qm4TetgJdOmcYuEb+8lUsf5klHhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749565718; c=relaxed/simple;
	bh=ILKpOSLteB+QyEBfugRCR/oSL4+CWvolAoqLOaFY0wA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MhzS2WuW4s+3P2i7upL5zypb4WrwvxwV8/gyVBJzWHiA5v+3L7lIQabXCa7/AoXJZuZjw6tlCPdLx6je9FefSvl8h/0M6+PNJMGcpPTxix8/HGs9dQF9wVwFEd40gjs+t6bUTqb56DGhUl51dUzX6ZSZ8fsadRChag6hniMq3YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEBD3oeo; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEBD3oeo"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-87ec6ba32feso683835241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 07:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749565715; x=1750170515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2yWAHM8gSV06qPbqjwb9O0w2V7UH2q0KRhax+/bxd20=;
        b=TEBD3oeo+itAQkxWlpH11mvsriLy6HqBaPvpTzJwRIk/eOTkj/xh5UzwdgvwkjebAm
         HGW28lGE/Svdjg9+fBfMLvT0dD3zM3uwSYt+gO4RY1lXZZooI0k5lZ+BdSKwaaGc+6Bj
         ovzyNiieaj6uW1FNHPh9CBwh3OM86llx4+KQyAXMZxWmpnGcO/ymYBkkkvZdNN7cNQ3Z
         EjFy/uNf2EKpSnuvPCv2U1cphXVmorsKVrUXnvpA4+PtkaXR9P/icQFwkyDtkl9AghbO
         EOVyy8JCptLahK83qe9cOn8aZTSAusOxTV4j+QxNnJKtDzvr9qd/I4BAbvKbMgoRIbiB
         vWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749565715; x=1750170515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2yWAHM8gSV06qPbqjwb9O0w2V7UH2q0KRhax+/bxd20=;
        b=k8tLJkf1oRiclMB/KvupEoNuCeeTJ2FmgFG3aDv2oWn59JxvrjnEI4e3SYdqVzuwUY
         hE3JKL/kCH9W/8sFBnX10Eqr/tYkIZ6JAGkbjBsEEUKtmwdhP4u9oB4a8k+w+/umtXCA
         y4HnFSxSsEwRWJQVRBGDmpYsLvU8OMCPMr19qp11QlqxdRXJJ3zODrlzr80lxEkUPOnY
         +wOx99d7PA1n2nV5xAk2FvU7AUbs2xhtMltlxncUGnTvTvkf5CGO36KvQy/kLX6pwIXh
         4+rKoKQedahkJjDrMMhHKZdiHiHSRwMLUHlW5+6m8aQ5N2WJ6edf+noLYsnnz6rW7riK
         abIQ==
X-Gm-Message-State: AOJu0Yw/hxJkmFz/MbowDU/5o1LVKXkFNXM4R2UlZuLuy6lAjxW343aq
	HUJTSs7v8oHqcaQjOETGV9tl2EZ+As6J/pAolcARRB6MPG79Sriycr1v9Dd3lQ==
X-Gm-Gg: ASbGncufYAXTqM9x+2RRowKjlQhUJohcz4xJWrx9DWpjL9AAn0dRBHhhRIDcm/uSZmU
	of3tbTE/Nga0SZCdNjTbW976W2UOsnzH+6ro1htgAY0oTurxmP+O85AiH+Zzlneafdub1HZI+V4
	f7w0amP7EWRtTBEFUBJCfuHZcCpyZNO5kdbG3gNcOXRmY9sPR0y4s+448xgoRw+F4g/lVqTqT19
	pg15pgAh+3kgKsV9R2oE0yTbbC8lWb77X/VdQkui+LFN9k1z/OHFCH994GYHGhSHA+degUXuO3m
	1s23XiEknm2g7IjgrEN5nRbE5LDu/1GUXxuXrzeNq+hyXgiDJLNxX9KAHi8WLYSbiIC7ZiEORTG
	YBHbSmehsIDWys14QL/gXZ9RTB/9dTqM=
X-Google-Smtp-Source: AGHT+IHw8AN79bOVKZ3iw1V+Kv/iu77zDEy/LDtVAB7k4MQLlk+bk3NVBWskmCyCBwsd7ZUi4qFZwg==
X-Received: by 2002:a05:6102:94a:b0:4dd:b9bc:df71 with SMTP id ada2fe7eead31-4e7728ba4f3mr13303165137.10.1749565714932;
        Tue, 10 Jun 2025 07:28:34 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e7b71996a7sm457573137.11.2025.06.10.07.28.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 07:28:34 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: eir: Fix possible crashes on eir_create_adv_data
Date: Tue, 10 Jun 2025 10:28:33 -0400
Message-ID: <20250610142833.1048451-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

eir_create_adv_data may attempt to add EIR_FLAGS and EIR_TX_POWER
without checking if that would fit.

Link: https://github.com/bluez/bluez/issues/1117#issuecomment-2958244066
Fixes: 01ce70b0a274 ("Bluetooth: eir: Move EIR/Adv Data functions to its own file")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/eir.c      | 7 ++++---
 net/bluetooth/eir.h      | 2 +-
 net/bluetooth/hci_sync.c | 5 +++--
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/eir.c b/net/bluetooth/eir.c
index 3e1713673ecc..3f72111ba651 100644
--- a/net/bluetooth/eir.c
+++ b/net/bluetooth/eir.c
@@ -242,7 +242,7 @@ u8 eir_create_per_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 	return ad_len;
 }
 
-u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
+u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr, u8 size)
 {
 	struct adv_info *adv = NULL;
 	u8 ad_len = 0, flags = 0;
@@ -286,7 +286,7 @@ u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 		/* If flags would still be empty, then there is no need to
 		 * include the "Flags" AD field".
 		 */
-		if (flags) {
+		if (flags && (ad_len + eir_precalc_len(1) <= size)) {
 			ptr[0] = 0x02;
 			ptr[1] = EIR_FLAGS;
 			ptr[2] = flags;
@@ -316,7 +316,8 @@ u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 		}
 
 		/* Provide Tx Power only if we can provide a valid value for it */
-		if (adv_tx_power != HCI_TX_POWER_INVALID) {
+		if (adv_tx_power != HCI_TX_POWER_INVALID &&
+		    (ad_len + eir_precalc_len(1) <= size)) {
 			ptr[0] = 0x02;
 			ptr[1] = EIR_TX_POWER;
 			ptr[2] = (u8)adv_tx_power;
diff --git a/net/bluetooth/eir.h b/net/bluetooth/eir.h
index 5c89a05e8b29..9372db83f912 100644
--- a/net/bluetooth/eir.h
+++ b/net/bluetooth/eir.h
@@ -9,7 +9,7 @@
 
 void eir_create(struct hci_dev *hdev, u8 *data);
 
-u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr);
+u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr, u8 size);
 u8 eir_create_scan_rsp(struct hci_dev *hdev, u8 instance, u8 *ptr);
 u8 eir_create_per_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr);
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 5e7eac1c3529..6687f2a4d1eb 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1836,7 +1836,8 @@ static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
 			return 0;
 	}
 
-	len = eir_create_adv_data(hdev, instance, pdu->data);
+	len = eir_create_adv_data(hdev, instance, pdu->data,
+				  HCI_MAX_EXT_AD_LENGTH);
 
 	pdu->length = len;
 	pdu->handle = adv ? adv->handle : instance;
@@ -1867,7 +1868,7 @@ static int hci_set_adv_data_sync(struct hci_dev *hdev, u8 instance)
 
 	memset(&cp, 0, sizeof(cp));
 
-	len = eir_create_adv_data(hdev, instance, cp.data);
+	len = eir_create_adv_data(hdev, instance, cp.data, sizeof(cp.data));
 
 	/* There's nothing to do if the data hasn't changed */
 	if (hdev->adv_data_len == len &&
-- 
2.49.0

