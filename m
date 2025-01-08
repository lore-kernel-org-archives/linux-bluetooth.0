Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D713E1F63DF
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jan 2025 10:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736333311; cv=none; b=ObSbcUifLEfq7RWyV6iMzI0vgmSw3XPzDAAdjlrGQ0tBACPU4yUrRLW0ypOgnGG73LVAEq38C6plTA6w62bN9MaJWpsWpe+5FUevspN16cONEUi9z3kAk2mKVjFp+5BWiKdNzdCBrHaL3f2at9kYbsFON+PckKN4wRZElLpO3f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736333311; c=relaxed/simple;
	bh=sL4PiDoeSKmCsRsIVH0hxi3F/3kO7logYC7qPb8s5iY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=g1ppoXYOwEY6gl/bgeklWq2tYJBtskQFCX2eP1z2x0VIyJGragjO1BRZTMCpCAnTyJ17G6TvwgoOsF4Au1JMt5OyRbk6IBT9FVsqlx+QA/xHhK9hMaABXVbb7CTiTxTxbJQe8ooMxjBiVXFLa6IKazVT+YV1I9XO/7XDBBA+xsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=otSUZkCe; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="otSUZkCe"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2164861e1feso241208405ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2025 02:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736333309; x=1736938109; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZNwf8P+j8EnGQl24maUdTNciXnMv1elXkFSPAxdl8WE=;
        b=otSUZkCeUqLvGLwgcodzcj2TqfQQY4lHN73RsdSALgT5pSj88al0stgA4MD+NGvVzN
         fDswCXZ121xZvJbA64fDGg240wPDpfv0+2BzAlb62n97c69roip7XyJVcWX4Lh2YHNLd
         CxSVV7SfbNUTSY3Lgbra4YYe3mU6yShhdUL2gIeUaNt1yjPeKqyP5IW0xu+oWbvFv/GI
         dg3EjCx9vuBw8P6431ERPesjsdRdR392ksIdHRArzTGKSXIvH9FPM0xtRNEQ8xtKYNSV
         Ldr5/SuvQR2hrZicHkFyvHzDqmbGR4cDvOh4wDuDS2wfuzGVtygha+ODdpu0GYM0yTcC
         +oZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736333309; x=1736938109;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZNwf8P+j8EnGQl24maUdTNciXnMv1elXkFSPAxdl8WE=;
        b=KHt0bXHKIeHJCYMBwI3Z3VhAJ4XHYDNuj9Hnv6IbpTceGPpsdrOqLDGJSYFBc8fOOH
         otr9nNaVvhAWaz7/nR5h7OCD/A6Bxuc+dFKsuk5o5OOwgmqxb9fGDcgVTIGR9shq2kDV
         URWbqm0We8oMfe0f4pLOynw6mCzTf+d65j/h5CdDiowDvbJNDaJRPa3vWbNrOKbgpqhn
         kRVIQvIxNm7gLXqdTgLIW/5/2D4N3h7qZmCtcAGp/+y4ziOsK631lEJHWJzHKTKDUHce
         YkAHPWMnY1OLo/2QFibEGriFNkwjMkmnIXTq+Iiz4ex4Mf8ryC35CH7s6U7HY4A4aFll
         aXjw==
X-Gm-Message-State: AOJu0YyUVnIgL/tbwAzUxosBulRYIL43DU4J+iNAWkrCGiAe5ilKsxri
	dYO1OwqcVE86RnwhE2Oy10wtlWOjJHwcbon6j/76tZxPklu03isB8NCq/ZYf5y1xRfR3mH5imq7
	KGfIQVnxZ7wXAJihLbmHtHksdVFO4+ljhYoS2bPMNZ8cmUwBjjys9G0eeNHQvhrrfK3UypwxwiL
	8wufHNYo3qlpM1KcCdTFbpfzZXyUvgRYsIVTZdQPIJil3ZHJtunA==
X-Google-Smtp-Source: AGHT+IEWritjAKWRbI0zLVsfSRw2VfhN2MoiZb/KiQPztnJv+dJcsazZLvls0uWIfpuWIbkUYmKi/yCfv0vd
X-Received: from plbkp7.prod.google.com ([2002:a17:903:2807:b0:215:6f59:ff5f])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf0e:b0:216:7c33:8994
 with SMTP id d9443c01a7336-21a84002cf3mr39440535ad.53.1736333308926; Wed, 08
 Jan 2025 02:48:28 -0800 (PST)
Date: Wed,  8 Jan 2025 18:48:11 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250108184811.v2.1.I66a83f84dce50455c9f7cc7b7ba8fc9d1d465db9@changeid>
Subject: [PATCH v2 1/3] Bluetooth: Remove the cmd timeout count in btusb
From: Hsin-chen Chuang <chharry@google.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Hsin-chen Chuang <chharry@chromium.org>

Remove the cmd timeout count in btusb since we only ever allow one
command in flight at a time. We should always reset after a single
command times out.

Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
---

(no changes since v1)

 drivers/bluetooth/btusb.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index de0b4d99fcbf..916e9ec7bc85 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -881,7 +881,6 @@ struct btusb_data {
 	int (*disconnect)(struct hci_dev *hdev);
 
 	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
-	unsigned cmd_timeout_cnt;
 
 	struct qca_dump_info qca_dump;
 };
@@ -914,9 +913,6 @@ static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
 	struct gpio_desc *reset_gpio = data->reset_gpio;
 	struct btintel_data *intel_data = hci_get_priv(hdev);
 
-	if (++data->cmd_timeout_cnt < 5)
-		return;
-
 	if (intel_data->acpi_reset_method) {
 		if (test_and_set_bit(INTEL_ACPI_RESET_ACTIVE, intel_data->flags)) {
 			bt_dev_err(hdev, "acpi: last reset failed ? Not resetting again");
@@ -999,9 +995,6 @@ static void btusb_rtl_cmd_timeout(struct hci_dev *hdev)
 
 	btusb_rtl_alloc_devcoredump(hdev, &hdr, NULL, 0);
 
-	if (++data->cmd_timeout_cnt < 5)
-		return;
-
 	if (!reset_gpio) {
 		btusb_reset(hdev);
 		return;
@@ -1046,9 +1039,6 @@ static void btusb_qca_cmd_timeout(struct hci_dev *hdev)
 		return;
 	}
 
-	if (++data->cmd_timeout_cnt < 5)
-		return;
-
 	if (reset_gpio) {
 		bt_dev_err(hdev, "Reset qca device via bt_en gpio");
 
-- 
2.47.1.613.gc27f4b7a9f-goog

