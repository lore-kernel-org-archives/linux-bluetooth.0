Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4E5238D51
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744797322; cv=none; b=eAT56VfwIL72eeizCT2CuWOJmf/8Fw+ow1YdZS2KvSWMh8hBt9wsmlQqnpS3m6hQfrseIb1n+Kfp7Ymxj1KrUBMByrBQ+RJ71AdcgLu8lJRo34BlBy0W5Z7RnaJWrT5zJUMdQZrLlhZgFxbafOFlT3Q9W5CHyhFh4Y8EUP8n6hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744797322; c=relaxed/simple;
	bh=du0ISQ2jMpVJYeI5O3fgur5ISJEKd3KWT2mpAgq/VAk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A++1OC3RB/O7RkBy6quJXcLW5qIVNE5g2vD7ximkilZxYbxvM0dk34TEfM5HeFl0WBJ8LqchN9RZZbWvdqf054ahj8/KdY+XJYW0d3SGEEw2YxlKDlWqgNE/dOlBnKVzGx3WWUkEzUP8eQEdluFrbpqgsKNjVZnBOOrtwZD1pGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CieLY6VN; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CieLY6VN"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2242f3fd213so54152865ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 02:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744797320; x=1745402120; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5El1uasofXV/ksQOcJEEdTBF2hBNQw9pjn5DD5Gms+Q=;
        b=CieLY6VN/PF0dckQFQqZ17i+UYkK+tboQqUPAhMTXrt+8aNDCeDdJLinYLYn1/lwTJ
         GuLCTDxqnzekUC+4Kb7ca9k7THIExUmpp7qpMO4Ps1ud6xPVBdIVctuZSoe+96tdlkkJ
         Mp8qqOsKxN6mDIBBRttwWTq1MHwtkSCTKqya7taqEfJ7x2xqyn+zUOhQ+5w2OFfUv35y
         X0Te/P30E7yBSNR6bbfSUdHKnXdyJBGDwjx8y875TMREil7IRlvf9h1bp33aAZ9MHFxp
         +XySvMypqSSI7vkrQ1p9k94aL//7R+YoXKMFHdpUKYzfNwXb0W2HB1utH4Obw2VK6hx0
         si+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744797320; x=1745402120;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5El1uasofXV/ksQOcJEEdTBF2hBNQw9pjn5DD5Gms+Q=;
        b=h13dJI7H/XGQNid0NWBMug0N7Z93q/zvEui6+dNJJo1+/iSQS5sEZfAq9iWqkutNFP
         rCUOY1970sWN8MXD7dlK4y4iDF5+u6FHHnbgCtmPVEZPg57FQjnLn7DTO95ySocT76K3
         yg474/+Oy7+CnOTqk6xweTqwHyzfga1qCNn9iZJGJDeAFal42brdcxqnSr8ZzQ/EYW8C
         YuLYMkl6BlYghlwSr2r2FuW5j8lA47tquQAV9WTxaKWFi7/qREtwAkfp2VimgWgA+yvJ
         +CJqFMBZPKbI7tm11yCDtKR911jDkxBrVA0vZm/tSBCdEpNOE/KD7RIvAZxQnps35I+L
         XHzw==
X-Forwarded-Encrypted: i=1; AJvYcCWo7RXzQ9C6Fz/+UwUzxOE2f4ZSQEKlRQ/sde4XFBCaV4Ft7H8DYR7B9RO5nLymmMCdPuG8tHaHtUURXxWptjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG4fztt0LI+w8tnnPvBK4wHBz575EsuzlqMispIru1FV7uwwJM
	3Xlk4BE2w+xsx1sSz8jP9VYn4VExewQDaFbZGRUqMk6a8fMzrSBHAkS0ugQkoWe/le4vwLNBKJb
	KD07uYw==
X-Google-Smtp-Source: AGHT+IF5ievEH+KKnQbO4kIrqdvCfWrRj4Hf0G6r0pcPlawzMu2UXlV0k2dizS8ODIi/L+NxBXvbodr/P3+V
X-Received: from plpl8.prod.google.com ([2002:a17:903:3dc8:b0:229:1de5:3212])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19cf:b0:224:a74:28c2
 with SMTP id d9443c01a7336-22c359174c6mr24222685ad.29.1744797320180; Wed, 16
 Apr 2025 02:55:20 -0700 (PDT)
Date: Wed, 16 Apr 2025 09:53:37 +0000
In-Reply-To: <20250416095505.769906-1-chharry@google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250416095505.769906-1-chharry@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250416095505.769906-3-chharry@google.com>
Subject: [PATCH v2 3/4] Revert "Bluetooth: btusb: Configure altsetting for HCI_USER_CHANNEL"
From: Hsin-chen Chuang <chharry@google.com>
To: luiz.dentz@gmail.com
Cc: Hsin-chen Chuang <chharry@chromium.org>, chromeos-bluetooth-upstreaming@chromium.org, 
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Hsin-chen Chuang <chharry@chromium.org>

This reverts commit 75ddcd5ad40ecd9fbc9f5a7a2ed0e1e74921db3c.

This patch doesn't work quite well - It's observed that with this patch
HFP is flaky on most of the existing USB Bluetooth controllers: Intel
chips sometimes send out no packet for Transparent codec; MTK chips may
generate SCO data with a wrong handle for CVSD codec; RTK could split
the data with a wrong packet size for Transparent codec; ... etc.

Cc: chromeos-bluetooth-upstreaming@chromium.org
Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
---

(no changes since v1)

 drivers/bluetooth/Kconfig | 12 ------------
 drivers/bluetooth/btusb.c | 41 ---------------------------------------
 2 files changed, 53 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 7771edf54fb3..4ab32abf0f48 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -56,18 +56,6 @@ config BT_HCIBTUSB_POLL_SYNC
 	  Say Y here to enable USB poll_sync for Bluetooth USB devices by
 	  default.
 
-config BT_HCIBTUSB_AUTO_ISOC_ALT
-	bool "Automatically adjust alternate setting for Isoc endpoints"
-	depends on BT_HCIBTUSB
-	default y if CHROME_PLATFORMS
-	help
-	  Say Y here to automatically adjusting the alternate setting for
-	  HCI_USER_CHANNEL whenever a SCO link is established.
-
-	  When enabled, btusb intercepts the HCI_EV_SYNC_CONN_COMPLETE packets
-	  and configures isoc endpoint alternate setting automatically when
-	  HCI_USER_CHANNEL is in use.
-
 config BT_HCIBTUSB_BCM
 	bool "Broadcom protocol support"
 	depends on BT_HCIBTUSB
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a16ca3128ac7..937d69684df8 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -35,7 +35,6 @@ static bool force_scofix;
 static bool enable_autosuspend = IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTOSUSPEND);
 static bool enable_poll_sync = IS_ENABLED(CONFIG_BT_HCIBTUSB_POLL_SYNC);
 static bool reset = true;
-static bool auto_isoc_alt = IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTO_ISOC_ALT);
 
 static struct usb_driver btusb_driver;
 
@@ -1121,42 +1120,6 @@ static inline void btusb_free_frags(struct btusb_data *data)
 	spin_unlock_irqrestore(&data->rxlock, flags);
 }
 
-static void btusb_sco_connected(struct btusb_data *data, struct sk_buff *skb)
-{
-	struct hci_event_hdr *hdr = (void *) skb->data;
-	struct hci_ev_sync_conn_complete *ev =
-		(void *) skb->data + sizeof(*hdr);
-	struct hci_dev *hdev = data->hdev;
-	unsigned int notify_air_mode;
-
-	if (hci_skb_pkt_type(skb) != HCI_EVENT_PKT)
-		return;
-
-	if (skb->len < sizeof(*hdr) || hdr->evt != HCI_EV_SYNC_CONN_COMPLETE)
-		return;
-
-	if (skb->len != sizeof(*hdr) + sizeof(*ev) || ev->status)
-		return;
-
-	switch (ev->air_mode) {
-	case BT_CODEC_CVSD:
-		notify_air_mode = HCI_NOTIFY_ENABLE_SCO_CVSD;
-		break;
-
-	case BT_CODEC_TRANSPARENT:
-		notify_air_mode = HCI_NOTIFY_ENABLE_SCO_TRANSP;
-		break;
-
-	default:
-		return;
-	}
-
-	bt_dev_info(hdev, "enabling SCO with air mode %u", ev->air_mode);
-	data->sco_num = 1;
-	data->air_mode = notify_air_mode;
-	schedule_work(&data->work);
-}
-
 static int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb)
 {
 	if (data->intr_interval) {
@@ -1164,10 +1127,6 @@ static int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb)
 		schedule_delayed_work(&data->rx_work, 0);
 	}
 
-	/* Configure altsetting for HCI_USER_CHANNEL on SCO connected */
-	if (auto_isoc_alt && hci_dev_test_flag(data->hdev, HCI_USER_CHANNEL))
-		btusb_sco_connected(data, skb);
-
 	return data->recv_event(data->hdev, skb);
 }
 
-- 
2.49.0.604.gff1f9ca942-goog

