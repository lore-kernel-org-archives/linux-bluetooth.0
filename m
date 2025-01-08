Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BD31F8AF0
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jan 2025 10:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736333321; cv=none; b=cNn7CTKyug/NLeqC2whfqzZ1CVoSgcEJ3oUi5tuBpLwk31woUzX+w/Zmju8v6DHcfijCACwnQfJmD6YEddTXIMuSGhzDFe00VorpwAl62lTdYq+RF1hOmL2VD0UZqDxsJmayEjrmNA24izZjb9kk103M56V+luRjmekU/xBw3HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736333321; c=relaxed/simple;
	bh=18OVqyScu1altG2OPAE65a+CYyw/ZsoyTKeqF6DAre0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SPlae+s9Z1bjGGNYLBea1TkBvWVQ0uEvKc4BTcuG47+iO59MX7hUnFHP3zpk81K45K8HXkfp8Tu1odKVifoluzHenJPJgEbF9IRDmoo0u2B/7frddJjgcJIENBNCivPhue2LonPq3tI8DEBMXlVNMAFB5jAPmIUdreLPTNy7kLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jOhQ0LLn; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jOhQ0LLn"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2163dc0f689so113085595ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2025 02:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736333319; x=1736938119; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bONEd4CMjkOeeBOPhPOC+iA+IYq5PNR8x+RM9R2jxco=;
        b=jOhQ0LLnd4iRQ/nayvMWhCkNIf3xGUegES9B4DDCo2/x+ThmoRwKmDy3P76UQw+Jn/
         0/GNZpCXb0MrD4ujYP2fEP6lXgXpg2tJ4jjl2nPQa6FoWXBkS4/BBkZsw44PcjZH4Xdm
         DUn+HlmK6JQLdxL6vGTPpEfh8P7V8jzcVYeKrk6isdwZSOXzAIpRzWNxFyh3uUYGDqv9
         XzTOeHt+6viIxAN8WXjBteyq2nepRE8zjZaecIuUlpvQZ1bP+z/FyQJjMWUQD/pDfPWW
         CyGjuS0wzSJsWm8Fu2yK/iVMElMP+EYXvF3AuIEoDN6P98j8ax/Gz4BQk/Q0xHmbRhQ0
         wcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736333319; x=1736938119;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bONEd4CMjkOeeBOPhPOC+iA+IYq5PNR8x+RM9R2jxco=;
        b=DnYL/jWF13aVLNEw+62fL+Y9hnJZjPC0D+FcGgwOssT2zQk3ATN29rdhdo8O1JkU4W
         tCuTZqbrq1A4Ru1zlYqqU69B5BdQkDV2nyFrHCFNuE+RTs1tU8+G5adSjfNHC6CQ4nM9
         bwFqxlzjqektqmCJyyV5jHEfnEH2MjG5SgI048b/53msEpEWGisvCMqkJKX2PiYC8h0Q
         0Vmi4KQlU9MJx+sZBsvi565F0mm6gXU4y2LZxRznFgfLD31N2WGaWSU3QEBLbiEE8YUC
         zM40mkS5PwxA5YY7vrmx3MHje89K/k2dmVIqdIabJFWaYwsH2eZ5M7NMjopV735gh6Zw
         SIMA==
X-Gm-Message-State: AOJu0YzJTl++MoNrNUbuTRKu7Y2AhS536UtrQI9wz4YTCNaNWkuawOwt
	ih0mtG26lUqOabkzVxjmls2V0dHq1PekZt4eJqcJwcyjtlcwtlrs1Fp0qAMKJ4LYn8uf4PPLwkV
	fYDzVmvGA6KdoG4PY8jXCBzR6w3N644NWS6uB/4AuGGEhsf1cMk62v3xPyCujHpqbnGdhsNTiqd
	a2YvDGCi2UBViTIsDGEsRyAcVcFXX61SBaBrNBMCXllFwRsn0u0g==
X-Google-Smtp-Source: AGHT+IGgjQdIPwYIYudGgRpSw8K/yuq90upMFqA78b4lAmqx9o4zdLkbPBz0794mYwUrT9dCUQKZxwE26wkT
X-Received: from plbje15.prod.google.com ([2002:a17:903:264f:b0:21a:7e04:7006])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:186:b0:216:42fd:79d2
 with SMTP id d9443c01a7336-21a8401271fmr31317245ad.49.1736333319406; Wed, 08
 Jan 2025 02:48:39 -0800 (PST)
Date: Wed,  8 Jan 2025 18:48:13 +0800
In-Reply-To: <20250108184811.v2.1.I66a83f84dce50455c9f7cc7b7ba8fc9d1d465db9@changeid>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250108184811.v2.1.I66a83f84dce50455c9f7cc7b7ba8fc9d1d465db9@changeid>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250108184811.v2.3.I8342291b757b20cd4cdbbfe658dc58ed5df46565@changeid>
Subject: [PATCH v2 3/3] Bluetooth: Allow reset via sysfs
From: Hsin-chen Chuang <chharry@google.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Hsin-chen Chuang <chharry@chromium.org>

Allow sysfs to trigger hdev reset. This is required to recover devices
that are not responsive from userspace.

Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
---
This commit has been tested on a Chromebook by running
`echo 1 > /sys/class/bluetooth/hci0/reset`

Changes in v2:
- Splitted out the btusb change

 net/bluetooth/hci_sysfs.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 4b54dbbf0729..041ce9adc378 100644
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
+	if (hdev->reset)
+		hdev->reset(hdev);
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

