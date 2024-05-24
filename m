Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211BE3B794
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 04:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716526255; cv=none; b=u9P5Gvk4+v5A+Tr/4HnhgzYKuc7CLzvaBTppfIXJVpg9ccDVem10e6qgo8P1XQE1XhjUFbacLerXVlAwrQ9hseuDfjxQGD+LyRzVBNoMTW3DQebQmy8ZawjChh3u/LLYyA3JLCZxKayv9M2r83/awImSdi4C/EXDkQQCTDq96Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716526255; c=relaxed/simple;
	bh=Mo66zv39Y2XRxVh5/cuJyu9quocjfx/HQ48qJAzK8d0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jon2AVLt3WePFL7CoC9Fdo6woc425sUoaqSV6ed2S98wXCWAJ89K3HsCrTG6xlRuYu+rAMfk8zK6oE0llPzPB0Zd88/F9vfF20uEAc2w2JjBCqGjwJekTxXHu2+oL/tfQdwScDDCdpQ+cTxUzDwIvT02gtqS1Pb8oF47jwIs/To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f9QO/47H; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f9QO/47H"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f5053dc057so4187694b3a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 21:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716526253; x=1717131053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XEzNN+g5GiUGjks7UogaHkGOkvg142fxmAHb/cav82s=;
        b=f9QO/47HlcSdbNsYqPeJfj4HYj58/eCdKKrbydnGSJ5CJWpc3bHjzZA4S/6An09tmy
         Bfp7WQzUFz5owZo8Tqz3LSy2nTx7m4wpmYlN7h4etP2KPLubAO96DBl0l4BnZvHJHI+u
         mrOXvorhfSnOJqiJoGOKE6unEdn5OP7Wnl9s4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716526253; x=1717131053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XEzNN+g5GiUGjks7UogaHkGOkvg142fxmAHb/cav82s=;
        b=fWRBL7Mzt82CNC9Hnm3LWZN4dlg7xuicRjpAVnwBoc1w+olooPqiK0wNz++5ZAozSK
         rGaYElnCDmePLV4ru9a7boUoA37WcVBqv/h6Lyd1sdgIpMBsCLXk3h8/rB5oscwzbPDa
         l/nBFWnETxbhdmAziAy8/71Nkpm/gIpcefRwPkYDa11toTEXIfcyNW+OyzYtgOXMkQ4Z
         qLlHgeOEtgn3lJsGM4q5FZxh62IWrBKD6PRn/7yE3OqFQgM6bq15eWE5vJX5ygmW7l9P
         L3SB56Pns5NDGh8nKC8WbOpH9tpmDXwu6Dp2QQNG2ZI8wY81EbkYKa9mBdp99SVb5ukB
         ElYw==
X-Gm-Message-State: AOJu0YyXpMzq9Od0A3RqCVo7QJq8ulmdVqTKJrnoUe59YAVj8HVlrBda
	eYk3wFNSrY+7eaQltKHv08cnZzu/MQLIOxEf2NGMFtp9W1LU9lN7vbXpiPGFpB2kYH/h+IECB1c
	=
X-Google-Smtp-Source: AGHT+IGfkmaKGVrr3ukrF0157TtE2Yy2BGn73LH8MTbHMB1w5QEj+skFkSENS8Jm055JMQodInkpRA==
X-Received: by 2002:a05:6a21:99b:b0:1b0:66d:1596 with SMTP id adf61e73a8af0-1b212e500bamr1294052637.57.1716526253013;
        Thu, 23 May 2024 21:50:53 -0700 (PDT)
Received: from localhost (60.252.199.104.bc.googleusercontent.com. [104.199.252.60])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-6f8fc05ab4asm398063b3a.59.2024.05.23.21.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 21:50:52 -0700 (PDT)
From: Ying Hsu <yinghsu@chromium.org>
To: linux-bluetooth@vger.kernel.org,
	luiz.dentz@gmail.com,
	pmenzel@molgen.mpg.de,
	horms@kernel.org
Cc: chromeos-bluetooth-upstreaming@chromium.org,
	Ying Hsu <yinghsu@chromium.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v3] Bluetooth: Add vendor-specific packet classification for ISO data
Date: Fri, 24 May 2024 04:50:43 +0000
Message-ID: <20240524045045.3310641-1-yinghsu@chromium.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When HCI raw sockets are opened, the Bluetooth kernel module doesn't
track CIS/BIS connections. User-space applications have to identify
ISO data by maintaining connection information and look up the mapping
for each ACL data packet received. Besides, btsnoop log captured in
kernel couldn't tell ISO data from ACL data in this case.

To avoid additional lookups, this patch introduces vendor-specific
packet classification for Intel BT controllers to distinguish
ISO data packets from ACL data packets.

Signed-off-by: Ying Hsu <yinghsu@chromium.org>
---
Tested LE audio unicast recording on a ChromeOS device with Intel AX211

Changes in v3:
- Move Intel's classify_pkt_type implementation from btusb.c to btintel.c.

Changes in v2:
- Adds vendor-specific packet classificaton in hci_dev.
- Keeps reclassification in hci_recv_frame.

 drivers/bluetooth/btintel.c      | 19 +++++++++++++++++++
 drivers/bluetooth/btintel.h      |  6 ++++++
 drivers/bluetooth/btusb.c        |  1 +
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 16 ++++++++++++++++
 5 files changed, 43 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 27e03951e68b..bf1bd2b13c96 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -3187,6 +3187,25 @@ void btintel_secure_send_result(struct hci_dev *hdev,
 }
 EXPORT_SYMBOL_GPL(btintel_secure_send_result);
 
+#define BTINTEL_ISODATA_HANDLE_BASE 0x900
+
+u8 btintel_classify_pkt_type(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	/*
+	 * Distinguish ISO data packets form ACL data packets
+	 * based on their connection handle value range.
+	 */
+	if (hci_skb_pkt_type(skb) == HCI_ACLDATA_PKT) {
+		__u16 handle = __le16_to_cpu(hci_acl_hdr(skb)->handle);
+
+		if (hci_handle(handle) >= BTINTEL_ISODATA_HANDLE_BASE)
+			return HCI_ISODATA_PKT;
+	}
+
+	return hci_skb_pkt_type(skb);
+}
+EXPORT_SYMBOL_GPL(btintel_classify_pkt_type);
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
 MODULE_VERSION(VERSION);
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 9dbad1a7c47c..4b77eb8d47a8 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -245,6 +245,7 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 int btintel_shutdown_combined(struct hci_dev *hdev);
 void btintel_hw_error(struct hci_dev *hdev, u8 code);
 void btintel_print_fseq_info(struct hci_dev *hdev);
+u8 btintel_classify_pkt_type(struct hci_dev *hdev, struct sk_buff *skb);
 #else
 
 static inline int btintel_check_bdaddr(struct hci_dev *hdev)
@@ -378,4 +379,9 @@ static inline void btintel_hw_error(struct hci_dev *hdev, u8 code)
 static inline void btintel_print_fseq_info(struct hci_dev *hdev)
 {
 }
+
+static inline u8 btintel_classify_pkt_type(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	return hci_skb_pkt_type(skb);
+}
 #endif
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 79aefdb3324d..2ecc6d1140a5 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4451,6 +4451,7 @@ static int btusb_probe(struct usb_interface *intf,
 		/* Transport specific configuration */
 		hdev->send = btusb_send_frame_intel;
 		hdev->cmd_timeout = btusb_intel_cmd_timeout;
+		hdev->classify_pkt_type = btintel_classify_pkt_type;
 
 		if (id->driver_info & BTUSB_INTEL_NO_WBS_SUPPORT)
 			btintel_set_flag(hdev, INTEL_ROM_LEGACY_NO_WBS_SUPPORT);
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9231396fe96f..7b7068a84ff7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -649,6 +649,7 @@ struct hci_dev {
 	int (*get_codec_config_data)(struct hci_dev *hdev, __u8 type,
 				     struct bt_codec *codec, __u8 *vnd_len,
 				     __u8 **vnd_data);
+	u8 (*classify_pkt_type)(struct hci_dev *hdev, struct sk_buff *skb);
 };
 
 #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b3ee9ff17624..8b817a99cefd 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2941,15 +2941,31 @@ int hci_reset_dev(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL(hci_reset_dev);
 
+static u8 hci_dev_classify_pkt_type(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	if (hdev->classify_pkt_type)
+		return hdev->classify_pkt_type(hdev, skb);
+
+	return hci_skb_pkt_type(skb);
+}
+
 /* Receive frame from HCI drivers */
 int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
+	u8 dev_pkt_type;
+
 	if (!hdev || (!test_bit(HCI_UP, &hdev->flags)
 		      && !test_bit(HCI_INIT, &hdev->flags))) {
 		kfree_skb(skb);
 		return -ENXIO;
 	}
 
+	/* Check if the driver agree with packet type classification */
+	dev_pkt_type = hci_dev_classify_pkt_type(hdev, skb);
+	if (hci_skb_pkt_type(skb) != dev_pkt_type) {
+		hci_skb_pkt_type(skb) = dev_pkt_type;
+	}
+
 	switch (hci_skb_pkt_type(skb)) {
 	case HCI_EVENT_PKT:
 		break;
-- 
2.45.1.288.g0e0cd299f1-goog

