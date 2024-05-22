Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5BB82C88
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 May 2024 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716376308; cv=none; b=FG8iX/6E9dT2RsPspnocLScB37dI3tCnz3sW/8LGyCAXy02ggElAmqx62LNTVhEVnJDdKSdScoFnLcnqoJk0xtFHruYE8TCVyHEo5ChxOnkKGpbZlK6J9dOvgktJ+ZIYbeVg9xQ64qibvOEUyqDbHR/PUN/qJouzR8TSxMN28H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716376308; c=relaxed/simple;
	bh=Ow3Tprf5J79b5FpVc2oISMYxIiNACP/jJXhyCs7qoh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gwRJIznyP4QrhEkirOQIUlVc3bXBEiXPfWLdBKOS+IpNlGGcDGEC37YbW1dXsPv8Ic15kbJ8O6ywDE0C7tpIMkYHg1KYlhnnJuEHIrsskZoWU7Dq+wc0Dn99eJHp42dYSV4di0ia9TIqxiW5c1zSlfLEGrLsl4u3RID7YRHQSj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dUYe7QLH; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dUYe7QLH"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7e201ab539eso301657839f.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 May 2024 04:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716376305; x=1716981105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HGIbu+ypr2d0LLOENVoxzZcXEUbFgFGUeiK4yxl8U00=;
        b=dUYe7QLH5abdjotnhf7Or3sbvFrG0V+mcfblmSJ/1voWuzRVdRzRcDu9NLKehJ2dJf
         L2K9uA423Hfekul6+zhyeNL9ZP96lNchp6V57P9SBD9jcDtDTpKazd6CH2Ewt1smXfR+
         IzH4dVP5LZFk7JDA5PMwvo+fQFj0p1MIAAe7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716376305; x=1716981105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGIbu+ypr2d0LLOENVoxzZcXEUbFgFGUeiK4yxl8U00=;
        b=Rsp22B8QCicA1Zjd0r6HPrm/M9bLEkpeyCNMZwS8Fn2JMx141znREaXq5vQBV1tZ3y
         NwDdULb1iS0rQrc+dKwB99oS+XLIVcBETrgm4w4X6R9LBuOWFSMAE//Td5aNMPeLFHPo
         DPyxPrErrVKyWG+TrKiGOIqdr8Vhue/BPFsKBDMbQtbasL3jtihmfIy5Njqbm/Ku3ufI
         JjphzC6PT3mXhzazaBoBvYhOzRN/jt9oq1Pzxl5k7FQ+D38w2EaZj8NtTu6bGHORuGIX
         LOGx2O48RDlM6qjK6LntS/G0wYvpYPGeFKS1S9tBiyyh/fTsaALtmWdd1WvS2440zWXL
         oNkw==
X-Gm-Message-State: AOJu0YxPlCYnBwYZMtuED9S67UNhjunr+nNRW//OdrEnAwotmR7z4L5m
	YNwtj0fC85zjaU0xqXO4mleElG9HPGHZuYh3YiludAkVNP83Dh75QypqWG6xe9R5GEizn0ln1BM
	=
X-Google-Smtp-Source: AGHT+IFN6Nvak7Dqx/xB9Ivk+mj+bG1LJIAMXGSVPgcr9zqCUjXNVQ2gq65QJFSQbInD3nIzG+3+Pg==
X-Received: by 2002:a05:6602:4b86:b0:7e1:542d:7b09 with SMTP id ca18e2360f4ac-7e360c1566amr175674139f.0.1716376305249;
        Wed, 22 May 2024 04:11:45 -0700 (PDT)
Received: from localhost (60.252.199.104.bc.googleusercontent.com. [104.199.252.60])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-6f4d2b2de1csm23189037b3a.204.2024.05.22.04.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 04:11:44 -0700 (PDT)
From: Ying Hsu <yinghsu@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: chromeos-bluetooth-upstreaming@chromium.org,
	Ying Hsu <yinghsu@chromium.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: vendor specific ISO data packet identification by handle
Date: Wed, 22 May 2024 11:11:37 +0000
Message-ID: <20240522111139.2612601-1-yinghsu@chromium.org>
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
for each ACL data packet received. Besides, btsnoop log catpured in
kernel would couldn't tell ISO data from ACL data in this case.

By differentiating ISO data from ACL data earlier in btusb, we can
eliminate unnecessary lookups and improve btsnoop log clarity.
This patch enables vendor-specific differentiation between ISO and
ACL data packets.

Signed-off-by: Ying Hsu <yinghsu@chromium.org>
---
Tested LE unicast recording on a ChromeOS device with Intel AX211

 drivers/bluetooth/btusb.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 79aefdb3324d..543961b6c671 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -889,6 +889,8 @@ struct btusb_data {
 	int (*recv_acl)(struct hci_dev *hdev, struct sk_buff *skb);
 	int (*recv_bulk)(struct btusb_data *data, void *buffer, int count);
 
+	int (*is_iso_data_pkt)(struct sk_buff *skb);
+
 	int (*setup_on_usb)(struct hci_dev *hdev);
 
 	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
@@ -1229,6 +1231,8 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
 
 		if (!hci_skb_expect(skb)) {
 			/* Complete frame */
+			if (data->is_iso_data_pkt && data->is_iso_data_pkt(skb))
+				hci_skb_pkt_type(skb) = HCI_ISODATA_PKT;
 			btusb_recv_acl(data, skb);
 			skb = NULL;
 		}
@@ -2539,6 +2543,13 @@ static int btusb_recv_bulk_intel(struct btusb_data *data, void *buffer,
 	return btusb_recv_bulk(data, buffer, count);
 }
 
+static int btusb_is_iso_data_pkt_intel(struct sk_buff *skb)
+{
+	__u16 handle = (__le16_to_cpu(hci_acl_hdr(skb)->handle) & 0xfff);
+
+	return (handle >= 0x900);
+}
+
 static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct urb *urb;
@@ -4361,6 +4372,9 @@ static int btusb_probe(struct usb_interface *intf,
 		/* Override the rx handlers */
 		data->recv_event = btintel_recv_event;
 		data->recv_bulk = btusb_recv_bulk_intel;
+
+		/* Override for ISO data packet*/
+		data->is_iso_data_pkt = btusb_is_iso_data_pkt_intel;
 	} else if (id->driver_info & BTUSB_REALTEK) {
 		/* Allocate extra space for Realtek device */
 		priv_size += sizeof(struct btrealtek_data);
-- 
2.45.1.288.g0e0cd299f1-goog

