Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FE01DBB2E
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756142737; cv=none; b=hts0t9G79JgbCWJlxkN/ypU7tDKzf3nDTsAwNKzNEpZyd4CQhOCYrtN6cGwR3PPduudC2Q8E2Lx3yW2PU8d2hiwcwBSkZ/9lBSbJNQ4BTwn0V2+LTZZPMwO70AK9AYc5igxSbLLHM7lVX1G63p2C3EnFK2iYp4uAQx3k7sS210Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756142737; c=relaxed/simple;
	bh=hC1jCSnbLl0/4r0TqS+JBI9WAkeqea2KCF2hDr/Ev3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N0pRbn8w9Nb5u2BLYG9Dud/x/EHxRfuHptkywQphViSlDoagZwqB2gpqhPljSSFys2rofI/z7zYp6C6Glx6ZYs+2DyViSbQyWSU/GXS3G7vR6ddnVTsNtbrKeRnukop4JW4Au2MrXfBZM5dyYrJLZIEcqjs6T+xNaVfWFK1/mfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E62wqqg6; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E62wqqg6"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb7322da8so748041866b.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 10:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756142733; x=1756747533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+xsSmpb498iMUtJgL0LJ39t/InHvlojJddJUyMIbtGQ=;
        b=E62wqqg6OIctB6Kpn1ibt4AOWvq/ZQD5yQhOLlbX/ktT9F7mnYee/IeX/T0k+sAFGf
         6mxt9dCrmNyknLsW45SjpUPhyzL6bh35AJwRqHR68gba8om0h11K5V8SroDK0gEbyAJa
         shCEnqlGKzXpj5VikT4q9mkqZKtvjcqEBOptfBWg04hsPwfaFIMoW5ydvaMEmzoAbx4F
         6ZJ3FexRTtZl2p6hp6PC826vbKL7Sn325n3iKXr6v/HxD0DpYCxnqcLtLuzH+xGmWwso
         SKXDcCAT+vJuaswKbojeuyMf/cfqbX5S3lFCKFulTswEKC/Z7B5AGTXBUAfnewOxJSu0
         Ka5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756142733; x=1756747533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+xsSmpb498iMUtJgL0LJ39t/InHvlojJddJUyMIbtGQ=;
        b=a9lv+OUEHbPs+Q5+bGP3seHOrWYZOKOPyK+DFNX0un7k9M8wUleRFKETvvW9C5spNa
         Vb3mEGTx4NXGW7dYWnS5pv9unGbiDy5hOGDCI+shejtra6G8SgOx0iOt2AJr6bc3CLXZ
         38H2qpWfGPpotsTXjPa8KENDSSSQTc3pWJ1lrQFBHeFBLurDcclKu62p42jHQAJqNZS0
         0G3NkuBbWfx3TnhxEoGqN+jdtEBoJuHlljrRTsD8bJ/wZuOCyzORwjAt7WMzjVYlfDS2
         kA5JM0LYrvm4LdlLb7i4QXDZfVu79l3LEmY7mLIq3OnWwBYtxiyOSKwYoyeDNB7FDJCI
         837Q==
X-Gm-Message-State: AOJu0YxvsBdhjozYGGlhoC/ko2c8paQqaGdZrbbKVWk55uIgOKgSE7Xz
	b6YA85CwMcUEFPxXtmwy0sAXdfUz1okhxM/xRW2V3ydR8Zu3lEH19Fw/cnsktjUE
X-Gm-Gg: ASbGnctcOPaEOvSnecIsR9l4mhTaeQPjZMTtrbW4RhG8t7GYueI/UT6QIJAl2Egv5p9
	D+dzI/zEg+U0GccVOdpa6+74sj/fJt5LlpTGbuR/SzULG9e6dH6RKLYWNmPkSDYLxryaO9KM24I
	Uq5XLt23XrIJUScoLgWqEw9MkNTKVbEtq2gBmLDoylB2RdMz3hJ8gnsm9tG0ULYjLhbnH2BbP9g
	QOvSds8jJP+GUDJscMOcDHxlz46DJ/MEsXBA71sHrVAHA03SADcQ+2mIzhBNPF09kbTEGTqtdob
	lRx8UeKoWY5hPI2Mg0wPmQVXf8U4AaUk8+exS8jXYCK6aOZi3/+P4QmoM3TY5O2n0Df5FW5fxUJ
	bjfGEMgBXcQL4CWl0aSiXEZ5a7eacSeQrbsyQfoa31mutDd7+ip7fQt8WSjd9puHUFE4eynz7cx
	17CIanhG5IkOS7wnBH6Q==
X-Google-Smtp-Source: AGHT+IGfvTYup8NpiHQzyrCK0cwdjeYetYJVvnRz1HTv11CIn/Jot2MWeY3VZ24nQ5umKvR+akWiBg==
X-Received: by 2002:a17:907:3c89:b0:af9:6c74:9612 with SMTP id a640c23a62f3a-afe28ffc17dmr1079392466b.8.1756142733002;
        Mon, 25 Aug 2025 10:25:33 -0700 (PDT)
Received: from localhost.localdomain (46.205.200.232.nat.ftth.dynamic.t-mobile.pl. [46.205.200.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe81ebf53bsm221098066b.15.2025.08.25.10.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 10:25:32 -0700 (PDT)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Fixup quirk for reading ext features on some Barrot controllers
Date: Mon, 25 Aug 2025 19:25:04 +0200
Message-ID: <20250825172504.339117-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apparently, some Barrot based USB Bluetooth dongles erroneously sent one
extra random byte for the HCI_OP_READ_LOCAL_EXT_FEATURES command. The
consequence of that is that the next HCI transfer is misaligned by one
byte causing undefined behavior. In most cases the response event for the
next command fails with random error code.

Since the HCI_OP_READ_LOCAL_EXT_FEATURES command is used during HCI
controller initialization, the initialization fails rendering the USB
dongle not usable.

> [59.464099] usb 1-1.3: new full-speed USB device number 11 using xhci_hcd
> [59.561617] usb 1-1.3: New USB device found, idVendor=33fa, idProduct=0012, bcdDevice=88.91
> [59.561642] usb 1-1.3: New USB device strings: Mfr=0, Product=2, SerialNumber=0
> [59.561656] usb 1-1.3: Product: UGREEN BT6.0 Adapter
> [61.720116] Bluetooth: hci1: command 0x1005 tx timeout
> [61.720167] Bluetooth: hci1: Opcode 0x1005 failed: -110

This patch was not tested with the 33fa:0010 device, however, Internet
search suggest that the cause for the issue with this particular device
is exactly the same, e.g.: https://github.com/bluez/bluez/issues/1326

Signed-off-by: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
---
 drivers/bluetooth/btusb.c   | 30 ++++++++++++++++++++++++++++++
 include/net/bluetooth/hci.h |  9 +++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8085fabad..b89efe482 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -66,6 +66,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_INTEL_BROKEN_INITIAL_NCMD BIT(25)
 #define BTUSB_INTEL_NO_WBS_SUPPORT	BIT(26)
 #define BTUSB_ACTIONS_SEMI		BIT(27)
+#define BTUSB_BARROT			BIT(28)
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -810,6 +811,10 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x0cb5, 0xc547), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
+	/* Barrot Technology Bluetooth devices */
+	{ USB_DEVICE(0x33fa, 0x0010), .driver_info = BTUSB_BARROT },
+	{ USB_DEVICE(0x33fa, 0x0012), .driver_info = BTUSB_BARROT },
+
 	/* Actions Semiconductor ATS2851 based devices */
 	{ USB_DEVICE(0x10d7, 0xb012), .driver_info = BTUSB_ACTIONS_SEMI },
 
@@ -1120,6 +1125,21 @@ static void btusb_qca_reset(struct hci_dev *hdev)
 	btusb_reset(hdev);
 }
 
+static int btusb_barrot_urb_quirk(struct btusb_data *data, struct sk_buff *skb)
+{
+	struct hci_dev *hdev = data->hdev;
+	struct hci_ev_cmd_complete *ev;
+
+	if (hci_test_quirk(hdev, HCI_QUIRK_FIXUP_LOCAL_EXT_FEATURES_URB_BUFFER) &&
+	    hci_event_hdr(skb)->evt == HCI_EV_CMD_COMPLETE) {
+		ev = (struct hci_ev_cmd_complete *)(hci_event_hdr(skb) + 1);
+		if (__le16_to_cpu(ev->opcode) == HCI_OP_READ_LOCAL_EXT_FEATURES)
+			return 1;
+	}
+
+	return 0;
+}
+
 static inline void btusb_free_frags(struct btusb_data *data)
 {
 	unsigned long flags;
@@ -1192,6 +1212,13 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 		}
 
 		if (!hci_skb_expect(skb)) {
+			/* Discard one extra byte sent by some Barrot USB
+			 * controllers. Otherwise, the rest of the transfer
+			 * will be misaligned by one byte.
+			 */
+			if (btusb_barrot_urb_quirk(data, skb) && count == 1)
+				count = 0;
+
 			/* Complete frame */
 			btusb_recv_event(data, skb);
 			skb = NULL;
@@ -4218,6 +4245,9 @@ static int btusb_probe(struct usb_interface *intf,
 		hci_set_quirk(hdev, HCI_QUIRK_BROKEN_WRITE_AUTH_PAYLOAD_TIMEOUT);
 	}
 
+	if (id->driver_info & BTUSB_BARROT)
+		hci_set_quirk(hdev, HCI_QUIRK_FIXUP_LOCAL_EXT_FEATURES_URB_BUFFER);
+
 	if (!reset)
 		hci_set_quirk(hdev, HCI_QUIRK_RESET_ON_CLOSE);
 
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index df1847b74..ec9b47a39 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -351,6 +351,15 @@ enum {
 	 */
 	HCI_QUIRK_BROKEN_READ_ENC_KEY_SIZE,
 
+	/*
+	 * When this quirk is set, the URB buffer with response event for the
+	 * HCI_OP_READ_LOCAL_EXT_FEATURES command needs to be trimmed by one byte.
+	 * This is required for some Barrot controllers which erroneously transfer
+	 * an extra random byte at the end of the buffer which misaligns the rest
+	 * of the HCI communication.
+	 */
+	HCI_QUIRK_FIXUP_LOCAL_EXT_FEATURES_URB_BUFFER,
+
 	/*
 	 * When this quirk is set, the reserved bits of Primary/Secondary_PHY
 	 * inside the LE Extended Advertising Report events are discarded.
-- 
2.47.2

