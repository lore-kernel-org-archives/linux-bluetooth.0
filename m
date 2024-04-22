Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F26B51C52
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 07:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770678; cv=none; b=LfqUqGtAErEeNrp3dwZRSYBKNyGFt0ojmPZt26VrxAMIW6xxRFa6HkaAHF+EnEWVwUIMLLaVjSOWl3cR2ACXuBa9rwfapkxsa3irda90Q29B/dJUHiua7hEoaaCBbdbXRk9TCgCxgQW87ITwL/ox+vdTgEbOxC7PSOu4XzxdNkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770678; c=relaxed/simple;
	bh=dpgOmQJHRrHOsYFgWaLnsjp9j6Ut9V7hlwOOQWs5FWQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pNgzYdaigqOfX+/WngK2hhibAhMFJ8zvh9wX9GVDGBvCLIjcMKWIZOotF3WT5ctnYYVmH7EEuNAUJNOB/N0FXiITXOArA9pAlvyoL4HhMB20LXVQ+cnMulXRxvBqG3kbcTQfS71G3/xs26Qq5b0MhwRldwjUMmGqTHz3imtO5h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RL8CBo9E; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RL8CBo9E"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de468af2b73so8332327276.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 00:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713770676; x=1714375476; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i9wOGbBfat1hzQwTRQUOOQ0qZfxZpdbfky7UyfMjHY0=;
        b=RL8CBo9ESvvBEBmUy5HVNnW1d1umQxu+ZB4iQ2x3VpRAPEFC9wb8C3/2v4JAnSCHMP
         ZdbrPtXLS+/FemPXQiY2z586oSZ8ayiAkizy6buffwUV7n9HA+Mu2TwmrlPOy+95BHYB
         9lD4T4CsdQPdminAwivWiXZPFumwRnGjMCVF/uUErruhTVg4kO8eUPj75awZb1TlflkX
         2M+Wg8YZKiWXXjmt5yYTifm6JO8gTuKIeWb3+T6qmAj3lAhFRVInCwPnBcuZ0fNYGzns
         QczV1YDs5MbNlD/wMCHgv43vGhJXOqRNnco/NMVinihogTfViaHCzqO32lFda//wqBlq
         yx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713770676; x=1714375476;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i9wOGbBfat1hzQwTRQUOOQ0qZfxZpdbfky7UyfMjHY0=;
        b=BE/pU87lCsra6rrdb/3Qk1Js+sZa1ex9IsG5WzPliRHAfHLC6jx9Ojgu/QltOyLsDd
         EgL7qfQQD2RqsFZDIwbwu2GwMMOTEBLQnoIlOWWnwQLyQe+jhwzbYrKr3gYl4ge5psXl
         +15JVWU3sUpfsk8pL/+7FU26VBN3qxAH5lML9iXBZXvw5zhf3FYiEtGvV5xNYRRw/mXO
         +XqxK8RYABMIT4VttofJ+13tB5iNwogzYnVlJrK9Rm5nIukB5k0bbY+rDZNTusAf61az
         X8kO7qjuzW39hFJYDUhoL9VSjHh/ByVjAAgM9yd79ye+xeRjoiKGjyzm1a/BOMvQcUTW
         sR9Q==
X-Gm-Message-State: AOJu0YyYliFTQ1DoiZPEnzwP5NHQC71+GguET7MD8g7RCa4MrejFmeks
	RHvoiNIpJ7Q2hGEnvXSLYMWG+tuN6EgNAfasX2dtCV2wf1ppmHlO0IqTo1xFFtERZPF9ubanHwj
	p4mtQ9OQKc7peqjHMozQvgKLiA9n8Z2dJsrAPs9wXFOD9zLHg9ngHSmPa8ryHURFMYlca8kEFTJ
	filYsEDaLb+BrwWrKiPixwLRweR0eRtIj5rcgzYJCQWYEUBBGjWw==
X-Google-Smtp-Source: AGHT+IE/hTCb8Slwze2loKhFJ/zmVV1DW7WbkF5OHZy4fac2xvijx0KJZp+i9C6xdb+Gib9KNLezOi0V4aQV
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:17:59d7:73d5:a990:d869])
 (user=apusaka job=sendgmr) by 2002:a05:6902:c0a:b0:de5:2694:45ba with SMTP id
 fs10-20020a0569020c0a00b00de5269445bamr759614ybb.0.1713770676156; Mon, 22 Apr
 2024 00:24:36 -0700 (PDT)
Date: Mon, 22 Apr 2024 15:24:14 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240422152413.1.Ib96985e197f3db620a127a84aa20f3f3017aaf57@changeid>
Subject: [PATCH] Bluetooth: Populate hci_set_hw_info for Intel and Realtek
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

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@google.com>

---

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

