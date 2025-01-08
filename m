Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF8C1F76CD
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jan 2025 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736339119; cv=none; b=J5YZ4/TfTHOSwmPtd7ytJIxe7gxUQNwRFiyd/VAKq/B0kihemSyCtrAs1SXx/zQMgZ5ecFsVkrndGALCTKiJHVJoQveLpSPLwbMugCQN9yX84ioXAuobezVb32sQuaTVfppfEpTuR+HnFaz9NEZ/mmmxgPXcgt3CpLl/GKYDv6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736339119; c=relaxed/simple;
	bh=sL4PiDoeSKmCsRsIVH0hxi3F/3kO7logYC7qPb8s5iY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hEJFzytvNkRJEmVkGmqDeZxBJ94XK66xTbqPVaRZLNhRsDJsO7jTY3YHA0HGuTOX2ZHhWJ8fqnVWLFZGYNYq8cPnKKHvn8LMXtAeRhOIYoeUIR0tKXDUwbLRhP44o8hG/CPo5/bRSqaMD0rSPmgeVmdarFZhT4HvSV6ToZBfpkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x7FlSZ+k; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x7FlSZ+k"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2efc4196ca0so24025050a91.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2025 04:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736339117; x=1736943917; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZNwf8P+j8EnGQl24maUdTNciXnMv1elXkFSPAxdl8WE=;
        b=x7FlSZ+kfTpeD+9vXniO1lMfoCme0igzAGiKKtmt8RvsPzL1zxDQR0aNRsgIqB3Zod
         FnVOqyyY/sss3oczSu3PUwHoH9tMrhng/8eeRaIsr8s1i+hsWQvCol0LVEmjhISJV8SI
         Mv3IwIoPsxPkalglbgU1ejQZFwtx5aj7Zrij9kZMQ7NgTqsy3vFmBUnw7FoIzrRfXveP
         QF4vdROPkxlBY3AJklIxjYNCk8h8sIR1o+SiPAGzWxG90+0sOInN9VRhDsDU795ACOPL
         15/MMzdo2PlsMk88+/IvYf/Mk0RrgRHKS0Yph2DTodKvWNBFj8ppuzqUQJHZ6FJyp8Y0
         ErVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736339117; x=1736943917;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZNwf8P+j8EnGQl24maUdTNciXnMv1elXkFSPAxdl8WE=;
        b=k40+0MZsu4PiEtYD56aXnVOLmUoxrgLwQDezzZ/TaA9X3RrFafOpWYVcG+AGQCIngk
         q4L0lweR5K2PEddj4cX1HUeOeWjaYf+YMKlVS6xxLsjuPOd2xtEAynt4nP/MO3aAl2f7
         CMOg2ZZzSxE0irF3ER6YeoOSZRVc1SuPZz8JJDxbPwbltiISge9b2ZWFlXBRIe3z4Jiq
         E7eESEhaftF2Qa6oi3UWQSXxIj4I2/GGvD0UsqtfKWg7iUnAwj+FRH2n0t78/ZEcjWIO
         qF3BYj0rFIEKVpdZ3Q7pTuwERF8f7FGSCDQGFqz8MpNGeQWkn9lX9tRfOHFwAGZUYqWN
         g+Pw==
X-Gm-Message-State: AOJu0YwxSMF1ebP6p79xShBvKM1bnb4WT9neiVHz578gfspgDavthFwA
	02ukQtc494hVGfECGCywF/RJb4cGVfrkvRlxrIKbpU1BBUfOYeb9bH2o6gkpV9fImiIz8lOUk5X
	Xp2bDRGDBtwhke0U3MwBChelq+UmaPBrrKIFnZ3LPjtfKKyW04O8ZN3W+0wE8HH252F4odrx07i
	UR/eBwRKbL3ufalRL//tARDuDzJx71mIGuxoH5s+Zlue2qev8bOA==
X-Google-Smtp-Source: AGHT+IFH/MmR1xGXEJZTjJeHP+S+BPXflgBI9yfQPDnsgqHkZukq090qarmbythGrK7mXdLue0uqyn6GgKZS
X-Received: from pjuj3.prod.google.com ([2002:a17:90a:d003:b0:2ef:d136:17fc])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5446:b0:2ee:44ec:e524
 with SMTP id 98e67ed59e1d1-2f548f7d212mr3877084a91.35.1736339117503; Wed, 08
 Jan 2025 04:25:17 -0800 (PST)
Date: Wed,  8 Jan 2025 20:24:42 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250108202442.v3.1.I66a83f84dce50455c9f7cc7b7ba8fc9d1d465db9@changeid>
Subject: [PATCH v3 1/3] Bluetooth: Remove the cmd timeout count in btusb
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

