Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211D31FAC4E
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jan 2025 12:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736339129; cv=none; b=c7RMJpsziCLAGBwjjUZFJgh9AlT2CF8AiddDXms++hrns1pfs5UlA/P28S3J6QKIfN53ykLPsiHAedQluk2fj2v3AZc4uXqiqf5S8DIUMRZifKHrcRRhZH/jTY9XJ0Enyjlne4tsibJ2g1sfrDF1aL/KtAOr76ft4vVgpcm34Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736339129; c=relaxed/simple;
	bh=nZxpjJ/MQMz7UeVifcYxugkqRqXjDu4IXM3a8zA6CqM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UUggWMpjpAXeStmDRoD29XKDtIxkufVeKwiWHPQiYywqBdywt4dNEzlrYs5teqC3WmmWyObPL5UIl+JgaGLUnYiiruJKsslS/2ocT8kJOIrAVO6ftoR+HRm8rfoWS4LfaMqIautStadLC12JlACUXSaZGTfB68wCD9b1INQgc54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z/eJyoc/; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z/eJyoc/"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21640607349so41180165ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2025 04:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736339127; x=1736943927; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6yNVXfCwdoP+4MHu/lCdAKBDpiX/J7QbJAY7Rrh1z/I=;
        b=z/eJyoc/k5SqPJNLH9P3B8S5fJW/v5jeOg1LxVHtFpW/F/43Y9qv/3UiwOajJDSC/c
         aaUvSJaAVHucc0A53dJXs/uTLXfeZAgYBEwjHVgGjwzNPIf1W1nuGUbjBfG6bbZMaPI0
         Blh8Ax8WBfZxx0rQp2yw1zpehIQUo5GKrlNE74L+yRb3XggvgWRkUuKOkjBv4J05QF0a
         MI3DHziKVJruHkQ22IqA5+HS5umVCnuCAjbhV/MXPU6aWQ6d3+zpUY7dETN9jBabsCtU
         tihpI224MasLbY37cY0sGePzE5qK9xaMDZ87L+ySjufQ6wo8A3y9legJ7fzNq2B/NZdl
         XLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736339127; x=1736943927;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6yNVXfCwdoP+4MHu/lCdAKBDpiX/J7QbJAY7Rrh1z/I=;
        b=eggRb5g3GPCwyOcSrV3Z/rnuMRKFnaUUBVdpvfUqmygKamvFQRdQ9404RWNoXzzX0Q
         CXa7Wsqa0rwqm+fPvZFgp4L0X3PdIKZzYfB+QsUR7b/y8aIxs8sAxzDpy0yQI0ySdi5h
         Ao9hWpUh2ZNNU65dlQ6Fgvnk5eU0XBoMbcUL+8sZbyAlUvUcTd2qGkW4s+plYHaretFd
         4tXwQvowODRfnZfhtjiIS5+HouPl/nlNxz4sjvPqwh4/j8lZpDhaZ31o1j1pZgy6fQz/
         depxLQYjugV7HVHyJqvQ/i+bOsP6TjjHyOc0ryJNoSEsm3SLUfpymHxE5U5ibfP/Uyri
         TnJg==
X-Gm-Message-State: AOJu0YyHw3yBfWZKowafFdQkT2HVO4w6Dq7HwFBSiGKMICM0vroM4qyH
	ihx1fTuIQwS8f7/SI04FTykPDhndIe1Mu6j5egVPR3/0BYVVgiFu0MRmjVuINRvvY25Bb9JAW+t
	rxL7H+6Mq26AvYXJLIgJUDrV6bvlxlTHCxo9x/yHIvTwcoNIJY47VTdhTflJHSKtrDTBBGm6VlD
	DdQdjfh88Pagog2LL8vCceUAObHysWZIrmu/i9zIUzsye7YQRk+Q==
X-Google-Smtp-Source: AGHT+IGVXNfCQ6PoVtm38t9o2GOA1lZIebDOov0cHd2ASio3Y0/F3FGkig4l9mG6dVFm0YumZF5XdpuKWe8C
X-Received: from pgre21.prod.google.com ([2002:a65:6795:0:b0:7fd:5739:a1e2])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1245:b0:216:48f4:4f20
 with SMTP id d9443c01a7336-21a83f56f58mr35853645ad.16.1736339127318; Wed, 08
 Jan 2025 04:25:27 -0800 (PST)
Date: Wed,  8 Jan 2025 20:24:44 +0800
In-Reply-To: <20250108202442.v3.1.I66a83f84dce50455c9f7cc7b7ba8fc9d1d465db9@changeid>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250108202442.v3.1.I66a83f84dce50455c9f7cc7b7ba8fc9d1d465db9@changeid>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250108202442.v3.3.I8342291b757b20cd4cdbbfe658dc58ed5df46565@changeid>
Subject: [PATCH v3 3/3] Bluetooth: Allow reset via sysfs
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

(no changes since v2)

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

