Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE5E30E84C
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 19:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750360354; cv=none; b=JOMceWk+OzZPBTh3Iyo2R8vUX7qr7TX1AIfr4oadGd2t26OpJcLaC3SE/pVYw5eHOQPV4NpMQ8hHUKIPchDzDoxM7uelftze+1G/cWva+qwklUWkE5YoEFaL/zwHgFLMe/WtaqUjql9SBtLFUxr/brGLKkB53vey+ogJYVhuoTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750360354; c=relaxed/simple;
	bh=tMaSdFOGxOEUcr7rFqd+HnefSNSCsfOtuAGAxkYx0KY=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Content-Type; b=YQxqRr2K1d5fKko37IKUf9xgxq+zuuh3wtL1p2/jG6XpZ9XYOFzuDmFm2n3sXpAL8o1TLsMawH6yEXle2T/fsjMxh0FK+rv+tAt8ALvzhTd+pEV0DP+09wIpCRrCFuwp0hxIr2wuCI2zY9kGRgcOesyGi4Ekc8u1s/Q19bGUfoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=FcamDWel; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="FcamDWel"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6097d144923so2334450a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 12:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1750360348; x=1750965148; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=prlBQhf/9JqRX5oDGRGiigpjMERzjFFyu6MaOl208WU=;
        b=FcamDWelwpoXgqldHj0fpqeiN1K0sGxj2H+b1nmtlRTWti+fLOrJzX5sCWFWQqubG0
         +J2yMMfsxa17y5MCP0/luB//XIoOZE0bCLDyuyvlSTMZ2iqCk9u/4EmeN+/LCkSW/pIE
         szENDuP7fi8d0adCd0z2ky3FJHmhUqMvEAmzLnwDfvUypbLCPHvl5EDHNbz+Dj41Itcx
         gK3x7cuGhhcQKOOy11FSTIeQBH5fKAT34ckVLcEMWToDZy4azGPTgzZE/jhhZG5vAiGj
         UYI7pvPrW7eMjkYAvwk5B13qXQK1DQsAqd0FjPFbitd/fLYMNGEdycoZ+j5uyU/do/mV
         hfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750360348; x=1750965148;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=prlBQhf/9JqRX5oDGRGiigpjMERzjFFyu6MaOl208WU=;
        b=mN8g2fsPeBE3ZUNKhgpe1zxWKlLQEuBho9uSk+9iNGSBiwwoqvbPBMfvaBqXioJg6q
         BfVysWfkfOZmwqp3vqxGA/IkLQridXv7yweFGR4R2P6TQZvHiB33Ptci6KfbN1ICA6O9
         Ch7WJ6YBlXju1esSmMFAinahYZIrX4XvrV78epozm5auxopR4ZswZLTXCwQFhqqfky3k
         nYl+5SqOnRsZXTQ9xVt9SJxMc5jbs/g7IYYNCzRY1PGu5Qpyci0Obrzp4SSViPCQvbjP
         //shBP+SfkGBt7TQAK3Mlz7iwrmRSHIqL9K3dl8yeU9iFufzUjstSRh1zU1DJedyjjsC
         brug==
X-Gm-Message-State: AOJu0YwNeOmtLxOVMC7FcWgUYj3+LccSQVxO+Md/SLUGFjd5/OQkD19K
	y+pN8U2/yNqsxHlUFH6+afC7q8fcEfGnAS7cJLdy1xVKrxypWTTg9XEJVIB/X5uqwrmc3x0gb32
	wEuFt6TaI8G1S+lBPGybsidCf+6g3fZvcYme6vPuK/lMO99j3NZk=
X-Gm-Gg: ASbGnct1aIZyrzYarfCHjTe0P/sLx+fzXVpvr6cmBp7T7ZDVHiEYiD/NO82s+hDKDyW
	5yA7GGvtr6vBpQkAWCh9H1BCuyU+98y/OPYQc6EeF6APgZlBTxaZRkgoRbQEE3W9U8XQbfgWXT/
	+hlna4xKX1pgsfYKJCItBva5IRaQK2KGQTZ/PO85/fHQ==
X-Google-Smtp-Source: AGHT+IH8Ye5j/aDPxMBLV8+t6AcdPoSFKiz+1Wxdjh+aqJcE+Hso+v9hqKndT0GNao6Kp7pUiJsTBbihpfyvVV9+qz8=
X-Received: by 2002:a05:6402:13d0:b0:605:390d:6445 with SMTP id
 4fb4d7f45d1cf-609e3fb5eb3mr4247869a12.6.1750360348184; Thu, 19 Jun 2025
 12:12:28 -0700 (PDT)
Received: from 239600423368 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Jun 2025 19:12:27 +0000
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: Sean Rhodes <sean@starlabs.systems>
Date: Thu, 19 Jun 2025 19:12:27 +0000
X-Gm-Features: Ac12FXw-YMpitgDzyAmQjIA5uM5ozCUnIwOPDgVZ6cB23cxibX-H61jObKj44lI
Message-ID: <CABtds-1fKyFYvU1jL9njmhfphU0XytO+F5mBhARAzQip+CK6cA@mail.gmail.com>
Subject: [PATCH] Bluetooth: Revert vendor-specific ISO classification for
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From 3b5497d0154a58d948ee95900e4c62704399de0a Mon Sep 17 00:00:00 2001
From: Sean Rhodes <sean@starlabs.systems>
Date: Wed, 2 Apr 2025 09:05:17 +0100
Subject: [PATCH] Bluetooth: Revert vendor-specific ISO classification for
 non-offload cards

This reverts commit f25b7fd36cc3a850e006aed686f5bbecd200de1b.

The commit introduces vendor-specific classification of ISO data,
but breaks Bluetooth functionality on certain Intel cards that do
not support audio offload, such as the 9462. Affected devices are
unable to discover new Bluetooth peripherals, and previously paired
devices fail to reconnect.

This issue does not affect newer cards (e.g., AX201+) that support
audio offload. A conditional check using AOLD() could be used in
the future to reintroduce this behavior only on supported hardware.

Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Ying Hsu <yinghsu@chromium.org>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/bluetooth/btintel.c      |  7 ++-----
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_core.c         | 16 ----------------
 3 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 55cc1652bfe4..1a5108cf6517 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -3582,15 +3582,12 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		err = btintel_bootloader_setup(hdev, &ver);
 		btintel_register_devcoredump_support(hdev);
 		break;
-	case 0x18: /* GfP2 */
-	case 0x1c: /* GaP */
-		/* Re-classify packet type for controllers with LE audio */
-		hdev->classify_pkt_type = btintel_classify_pkt_type;
-		fallthrough;
 	case 0x17:
+	case 0x18:
 	case 0x19:
 	case 0x1b:
 	case 0x1d:
+	case 0x1c:
 	case 0x1e:
 	case 0x1f:
 		/* Display version information of TLV type */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2b261e74e2c4..648ee7e2403f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -649,7 +649,6 @@ struct hci_dev {
 	int (*get_codec_config_data)(struct hci_dev *hdev, __u8 type,
 				     struct bt_codec *codec, __u8 *vnd_len,
 				     __u8 **vnd_data);
-	u8 (*classify_pkt_type)(struct hci_dev *hdev, struct sk_buff *skb);
 };

 #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3b49828160b7..64ab7702be81 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2868,31 +2868,15 @@ int hci_reset_dev(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL(hci_reset_dev);

-static u8 hci_dev_classify_pkt_type(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	if (hdev->classify_pkt_type)
-		return hdev->classify_pkt_type(hdev, skb);
-
-	return hci_skb_pkt_type(skb);
-}
-
 /* Receive frame from HCI drivers */
 int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	u8 dev_pkt_type;
-
 	if (!hdev || (!test_bit(HCI_UP, &hdev->flags)
 		      && !test_bit(HCI_INIT, &hdev->flags))) {
 		kfree_skb(skb);
 		return -ENXIO;
 	}

-	/* Check if the driver agree with packet type classification */
-	dev_pkt_type = hci_dev_classify_pkt_type(hdev, skb);
-	if (hci_skb_pkt_type(skb) != dev_pkt_type) {
-		hci_skb_pkt_type(skb) = dev_pkt_type;
-	}
-
 	switch (hci_skb_pkt_type(skb)) {
 	case HCI_EVENT_PKT:
 		break;
-- 
2.48.1
