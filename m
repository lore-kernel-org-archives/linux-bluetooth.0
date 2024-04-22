Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD8A13BC10
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 09:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713777651; cv=none; b=cMDbQmoamfpbNEK/d2hPIOiuEWEI42AEj6Euoacv4rjuPEhzEYBFgwunaH7XFgiSoYTO2phK5mqNayy5ZoKsJXFldo4T0xNNBfMV6r/8ejEUlvdUf5jNXReh0p5IP76nSjVwZScpntUnqT8SzwXA3lCb0Z8krCq3EM5NwP09tUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713777651; c=relaxed/simple;
	bh=cRkXSaUBI+idwTIFfGgPlG6dgV5xmDVnjyDMXCOApoA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BG5XyKrrqny7KlRClBsyZ6jCRVDod9ZKcrcVYkABCsnESyOJNVAF/pKSfFrIK1FLa8xBOLOdqczvtAfLcbQjpxaOmfh5rsBY2YmFhMdI5vzeSF8EtsxGuRjSbnHDjmSegDNmxugn6bwFe4g+OW8PP12t2Mnsqt5xI48cV1boqCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vXfHtKf5; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vXfHtKf5"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6ceade361so8420148276.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 02:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713777649; x=1714382449; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kXNn2oCStDkLWi9zDGUPVO6qkGiMAPrsXwlwOtBRK+g=;
        b=vXfHtKf5FzOZJ391G+UcrWw654ZzsYDpK5ehAMQpIRH+FAs/0B074ocFV+Zm1vgWOC
         ONpJN12qbgxH/5DwQMzef9GufZOYpyFg1OWKs5h3rxqFkWeF8Edr7p8PgzzbKrZ1pNMr
         tyJhapCO08g8tyw+IABNLMeeSTA0RD1pEmoVd7zLFI/YOzyBpFpRESSuWxYJg21QnN/R
         /7ZEKWocCuBisn9S4nZ6iMDCBQr7NpdtvMkBXJfNYvUXfuhPMrvnnfQtHQlMT8Ug1cMK
         WXAejJC8gpYZXLkJitqKbbbxEO0DHKptlJysBCoXc7DKfHHW6R6ivAPb/LeqfnVR+D+j
         AyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713777649; x=1714382449;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kXNn2oCStDkLWi9zDGUPVO6qkGiMAPrsXwlwOtBRK+g=;
        b=QQvMvtgGh7tJM43kE17mEYKTEK3n41HOUnSmWGGcyiS7TZTRJmlAX+WGffpmbY//vT
         saOBq37q3zPqoTtLPFTvbGzgVO4w1H6MtmE4UUsLjYpVCWbp8B2lhE1/oWD8iH4faIw1
         9mWXWIsRJHXtNwinEyQjmn1NPoVgHBPiSz8AohGC2IoKRi19tEvousaasVI5UMeaLPx9
         ZjCYdYVZtJ3iO96kuSy/0PPN5lSds6YK38+3fHBIFakv9KxqIuVtKt2S2C2oTTA4+Z1g
         MNdy66QRU9tilxwN6lfMs0BTpzdpiA/+vOH0Uc5qsUAj8v5htHXxCiTCYfJxJBbvROM8
         hBvg==
X-Gm-Message-State: AOJu0YyVHbOxtzrlI+OfMoyTukwOGs4Ert8ML5pGl+vZGf0xjELJDww7
	je70J+8viRMyEvg1xdsIcXyi0KbpTbOS+gQ9xUxIp16CIEG/bIGTSCh8V75yWeDXybXcNrFClJG
	Mt73KEH6SpPlYvPQDDMdIcGexRYuBhV8NgF4MThzcIFRlj0FmwN5CjWGlgQXcBx1ivl1Gr7sXr8
	WL/HrqMjbW/atTCXjwfJTRWuc84Bkimjkm+pigNCXNfNnI9pZRoQ==
X-Google-Smtp-Source: AGHT+IE1kkiDKTCBuFzJnRyFWU0DZ0GmYJcdvmXUZI5xBSsgaPPCUbilRPm6wkB/KjKdt9GMzt/3svbCqmdn
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:17:59d7:73d5:a990:d869])
 (user=apusaka job=sendgmr) by 2002:a05:6902:1548:b0:dc2:398d:a671 with SMTP
 id r8-20020a056902154800b00dc2398da671mr3042773ybu.10.1713777648659; Mon, 22
 Apr 2024 02:20:48 -0700 (PDT)
Date: Mon, 22 Apr 2024 17:20:28 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240422172027.v2.1.Ib96985e197f3db620a127a84aa20f3f3017aaf57@changeid>
Subject: [PATCH v2] Bluetooth: Populate hci_set_hw_info for Intel and Realtek
From: Archie Pusaka <apusaka@google.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>
Cc: CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>, 
	Archie Pusaka <apusaka@chromium.org>, Abhishek Pandit-Subedi <abhishekpandit@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Archie Pusaka <apusaka@chromium.org>

The hardware information surfaced via debugfs might be usable by the
userspace to set some configuration knobs. This patch sets the hw_info
for Intel and Realtek chipsets.

Below are some possible output of the hardware_info debugfs file.
INTEL platform=55 variant=24
RTL lmp_subver=34898 hci_rev=10 hci_ver=11 hci_bus=1

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@google.com>

---

Changes in v2:
* Add some sample output to the commit message

 drivers/bluetooth/btintel.c | 9 +++++++++
 drivers/bluetooth/btrtl.c   | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index a19ebe47bd951..dc48352166a52 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2956,6 +2956,11 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 			err = -EINVAL;
 		}
 
+		hci_set_hw_info(hdev,
+				"INTEL platform=%u variant=%u revision=%u",
+				ver.hw_platform, ver.hw_variant,
+				ver.hw_revision);
+
 		goto exit_error;
 	}
 
@@ -3060,6 +3065,10 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		break;
 	}
 
+	hci_set_hw_info(hdev, "INTEL platform=%u variant=%u",
+			INTEL_HW_PLATFORM(ver_tlv.cnvi_bt),
+			INTEL_HW_VARIANT(ver_tlv.cnvi_bt));
+
 exit_error:
 	kfree_skb(skb);
 
diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index cc50de69e8dc9..4f1e37b4f7802 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1339,6 +1339,13 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
 
 	btrtl_set_quirks(hdev, btrtl_dev);
 
+	hci_set_hw_info(hdev,
+			"RTL lmp_subver=%u hci_rev=%u hci_ver=%u hci_bus=%u",
+			btrtl_dev->ic_info->lmp_subver,
+			btrtl_dev->ic_info->hci_rev,
+			btrtl_dev->ic_info->hci_ver,
+			btrtl_dev->ic_info->hci_bus);
+
 	btrtl_free(btrtl_dev);
 	return ret;
 }
-- 
2.44.0.769.g3c40516874-goog

