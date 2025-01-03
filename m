Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048B714F10F
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jan 2025 03:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735874481; cv=none; b=dOLs2eODRmN0IUONy/5VB+9W4i13QC0Ps/TOwxT3Ai6w8aRv2pWXHXmXOJg8x3OQKW3YMrbWLg5bMqbXRlXuy+HjAUkVjLLVstuzhvTF7shDJ39Ta1qOPZ4S1usjQFGZxH4wNBvn3e7D5EFsuDAvCEoUp+/gOHZVr+VCQcNlxEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735874481; c=relaxed/simple;
	bh=4490ddk971BZIYv7FTPadG7s3bYeDMjqJFhckGVNhjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L+7+83/gE7XCB4lRukBZMcmLiPOIe7BMHKM9VsmZTiDiaqHekuWpWzs3hyCDye+vpO99Z8pVqYm6G0jsnPf9AV88k/aGMB+lEoL2N8ahcxQbmsjtOvQZXP9Rmbw1GyhCM9Y6LS8rr77AvMQCvX4BvcDKQ9JI7XSRkdm4MxuKFo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XUW7U+ox; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XUW7U+ox"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so14820239a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jan 2025 19:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1735874479; x=1736479279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v40FqecaBhk32xUYBG9DvGHL8ukV7iAlvsnqHgzgs+o=;
        b=XUW7U+oxifdeLB4Bwz8fQfE/qYdzEd7RVeLBqWxGE0XGQFsZD6rNoUpCplw0teTSr/
         YfHM07f5SrHEgf5H+lovEUQ6NtZDHtY5yHOhbboX28kV9/PLtRK3gbySGPFTEjni9bDF
         RLMhObAzehGbT0D9pupzB655ulEhRa2/eAODo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735874479; x=1736479279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v40FqecaBhk32xUYBG9DvGHL8ukV7iAlvsnqHgzgs+o=;
        b=jotK7bXc4rSN6CZhLX3+XslV18j7nLCQDxGLrcoX3HxAld7caSd2f3CH655/sk1rVn
         uKwHfFcPLNEuluwzICcADjxoT/OBJWMvyNPROvWzGEe4HbavVYsPniYXNk4mzu7vLd39
         GutiyIq2Zf2XRE9LUeNIU/ihiLkX2oY4J/LsioJ9dTE1rBVRV1ehWf5h+WlrZdjXKJ+9
         k2M2plfGGhcQTqhqYRV1YhjDp53aE/48rGXhkuXxIz8lhebqLLwviFiwwb1RxCRXgTWy
         Ggnag0VIp9bygXIcpYO5KtXgTTmC9aHGFNjeWQENmgVuteMNEvo7fZ1roFLVfjfk1vWQ
         vxlw==
X-Gm-Message-State: AOJu0YykPzv28X13iVmxZ7OSpBgOCflRfx/MSk3zLVQrr8ARoARZTzkY
	x//NV2NpSvunGxbg5nFLbVjHDLhLp/aCMe6d+GcITZLFeVI2JZ/RbSr2yhBuHFN9ilu8IHxZDyc
	=
X-Gm-Gg: ASbGnctztBXZwj0HMXKtykaZIqhrX4Fnx4nZG7OOhwSyufBkXqdAq3YWlaWyFKo4OCZ
	UYOqIgmENlcA7NRNLIyUdaSIN8BDVkJa9YZCYszeN6PE8/bahIJnpBDmV9vPAM3AmM/LWmokDf5
	XfqTU8xcP+0Y1F8vJBxgu+bwZ7aTJLZ/7+0mnpdzm+d6uPB9YDz/oeI1z1YymLXUqO6Go7ApwlD
	bJXRI39rmWogVJ1x5BtoDk3SMf7JlmTXcaDQz3ZZbXk325UWXi5O24ABTHfjzBKPwvvuFDLxAmt
	+lOJNw7KW5uou4oxJoCtN0lFKfb3qR2tRJ7oq1Xl7Tyf
X-Google-Smtp-Source: AGHT+IHuErCLqRnvWyWb8l5qcm26MneuCHVCvEUpwsjFZVuOWYqrQbhsSexvYAaKwebcv7DepbrrbQ==
X-Received: by 2002:a05:6a00:2f8b:b0:725:cd8b:d798 with SMTP id d2e1a72fcca58-72aa9addf81mr68572241b3a.9.1735874478949;
        Thu, 02 Jan 2025 19:21:18 -0800 (PST)
Received: from chharry.c.googlers.com.com (60.252.199.104.bc.googleusercontent.com. [104.199.252.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8370e2sm26074539b3a.64.2025.01.02.19.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 19:21:18 -0800 (PST)
From: Hsin-chen Chuang <chharry@chromium.org>
To: linux-bluetooth@vger.kernel.org,
	luiz.dentz@gmail.com
Cc: chromeos-bluetooth-upstreaming@chromium.org,
	Hsin-chen Chuang <chharry@chromium.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: Allow reset via sysfs
Date: Fri,  3 Jan 2025 11:20:20 +0800
Message-ID: <20250103112019.1.I8342291b757b20cd4cdbbfe658dc58ed5df46565@changeid>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow sysfs to trigger reset via the cmd_timeout function in hci device.
This is required to recover devices that are not responsive from
userspace.

Also remove the cmd timeout count in btusb since we only ever allow one
command in flight at a time. We should always reset after a single
command times out.

Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
---
This commit has been tested on a Chromebook by running
`echo 1 > /sys/class/bluetooth/hci0/reset`

 drivers/bluetooth/btusb.c | 10 ----------
 net/bluetooth/hci_sysfs.c | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 279fe6c115fac..a4810c77fa0da 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -879,7 +879,6 @@ struct btusb_data {
 	int (*disconnect)(struct hci_dev *hdev);
 
 	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
-	unsigned cmd_timeout_cnt;
 
 	struct qca_dump_info qca_dump;
 };
@@ -912,9 +911,6 @@ static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
 	struct gpio_desc *reset_gpio = data->reset_gpio;
 	struct btintel_data *intel_data = hci_get_priv(hdev);
 
-	if (++data->cmd_timeout_cnt < 5)
-		return;
-
 	if (intel_data->acpi_reset_method) {
 		if (test_and_set_bit(INTEL_ACPI_RESET_ACTIVE, intel_data->flags)) {
 			bt_dev_err(hdev, "acpi: last reset failed ? Not resetting again");
@@ -997,9 +993,6 @@ static void btusb_rtl_cmd_timeout(struct hci_dev *hdev)
 
 	btusb_rtl_alloc_devcoredump(hdev, &hdr, NULL, 0);
 
-	if (++data->cmd_timeout_cnt < 5)
-		return;
-
 	if (!reset_gpio) {
 		btusb_reset(hdev);
 		return;
@@ -1044,9 +1037,6 @@ static void btusb_qca_cmd_timeout(struct hci_dev *hdev)
 		return;
 	}
 
-	if (++data->cmd_timeout_cnt < 5)
-		return;
-
 	if (reset_gpio) {
 		bt_dev_err(hdev, "Reset qca device via bt_en gpio");
 
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 4b54dbbf0729a..7bf2b10b0a7cf 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -90,9 +90,28 @@ static void bt_host_release(struct device *dev)
 	module_put(THIS_MODULE);
 }
 
+static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct hci_dev *hdev = to_hci_dev(dev);
+
+	if (hdev->cmd_timeout)
+		hdev->cmd_timeout(hdev);
+
+	return count;
+}
+static DEVICE_ATTR_WO(reset);
+
+static struct attribute *bt_host_attrs[] = {
+	&dev_attr_reset.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(bt_host);
+
 static const struct device_type bt_host = {
 	.name    = "host",
 	.release = bt_host_release,
+	.groups = bt_host_groups,
 };
 
 void hci_init_sysfs(struct hci_dev *hdev)
-- 
2.47.1.613.gc27f4b7a9f-goog

