Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DCC17D368
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Aug 2024 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723475087; cv=none; b=MNliVNfShFA9XygVdfIFzqtslac4JIsSjbfWxZ2umZa2wg658P+e6/LYUh5P+06phpIscMsMQ97gTIMZJAGa4DiN+nkjxBTn6A/1FQ5H68ZOGfKErAiVvbDSomlzpNJkj8egd7zIx6M6LUHJpogu5ou/6w4bRdD+Mxp5H4X6Wsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723475087; c=relaxed/simple;
	bh=8nWoK2jDNtY1NPoYkGe3Ozx0Nm3IahkFgHyRn7OhWmc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfVeg0mxFKoxtVDfHeEKhrUiaXMfhXZUYIPcfSJSvFPTq6uJovr0yFmcExqcye+hqzhpDO8l0WzNWeVtYLjfhf+5CSdbG/FY6y8AVm18lNc550hpNyomVau5abR/xQltEuGnIZJYzxz5n4jC58obj+5SYfm6lvqDSvC9v3c3kE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtZNS3d8; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtZNS3d8"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-44fea44f725so2054301cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Aug 2024 08:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723475084; x=1724079884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gyk2LOnQrwP+MZem9tnjjfrWgEXxZwcCVbiI2B2MGHI=;
        b=ZtZNS3d8k6XhR1vi413yqXP6Je2f8l/jEC1SjTFdSS6DNbAoip6TtgpCXX599UhCO3
         qpsBWxecN87rCuR+vvvKSYdu8QhI9LhqhEAbHMoP06aMybUFj90hw86NSMJ/Ybyr4xgr
         WCi5B2eE7rJ0EMKg8TcetwI0J5lFuPe13uvzJq4kQh4P/N5/cV1qlCxalvMIIdIEVF3P
         0DTRc/Yr/U6cOFcPygTnXBAWMGyETpFpBCGDi0TQ9X/JtDcoXvXvH5IaGH9de9dOA1DL
         pbXp7RX14gUV+LIDHlkhzraJ3nSSEGzlkJjYIQ8WPeSbr0thHR6YfhnJyGssmqT4IM26
         JbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723475084; x=1724079884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gyk2LOnQrwP+MZem9tnjjfrWgEXxZwcCVbiI2B2MGHI=;
        b=BJnP+hlu74YEhqAFzeOMxTb21DT500ge5hl85c7P7C3jIrg8TdvThVjcCnNwQ9RKuB
         3X6L+sGmetw8Ru582gdFd1RPriB4Wi3gOnvOV9+hJMYAPniceZHzQFFfs0dIV6h0q3Vb
         1zHtLTRvC5HzzaXIesGRjz6UDK6ch0HR9s/ATinQJMhL03gK16fCBWdyWgPmbLLwXlxl
         SeBCJ7XX5XXDB12bfdexh0IRxL/YixZQMQZ+8FEp939SmX+6fuKffRst0Oycm6lwAkvz
         yV8JrXxbXcNIBuFNl3mgNiK6p2Xyrp63TAA4Xk+tm4R1HQJ/g6C1CJl8IJDztFqfzq85
         Ea6w==
X-Gm-Message-State: AOJu0YxTwHXVnQt/HEsZNdx4vAOrBHsvAmcHK3xO7I5yqFD3SqZw+yiq
	y29TEjqBgrF/UeGF7R85bjBQkoRJ4v/gdQKl0D4mRSJwCnhgmilgJ6Ks8A==
X-Google-Smtp-Source: AGHT+IHN0a2+Edr5iCn878tOlGuyj/rlp6KckdEV4nkSUd+jeIOgWYt01tqoY75tFHE8kf/OZ8vxVw==
X-Received: by 2002:a05:622a:13c8:b0:447:f8b1:aeb9 with SMTP id d75a77b69052e-4534a34d9admr7130851cf.16.1723475083564;
        Mon, 12 Aug 2024 08:04:43 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-841367e2ef6sm694970241.38.2024.08.12.08.04.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:04:42 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: btusb: Invert LE State flag to set invalid rather then valid
Date: Mon, 12 Aug 2024 11:04:39 -0400
Message-ID: <20240812150439.283920-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812150439.283920-1-luiz.dentz@gmail.com>
References: <20240812150439.283920-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This inverts the LE State flag so by default we assume the controllers
would report valid states rather than invalid so it is inline with the
respective quirk (HCI_QUIRK_BROKEN_LE_STATES).

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 226 +++++++++++++-------------------------
 1 file changed, 76 insertions(+), 150 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d3514def9828..42c867b2e42c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -59,7 +59,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_CW6622			BIT(19)
 #define BTUSB_MEDIATEK			BIT(20)
 #define BTUSB_WIDEBAND_SPEECH		BIT(21)
-#define BTUSB_VALID_LE_STATES		BIT(22)
+#define BTUSB_INVALID_LE_STATES		BIT(22)
 #define BTUSB_QCA_WCN6855		BIT(23)
 #define BTUSB_INTEL_BROKEN_SHUTDOWN_LED	BIT(24)
 #define BTUSB_INTEL_BROKEN_INITIAL_NCMD BIT(25)
@@ -298,115 +298,79 @@ static const struct usb_device_id quirks_table[] = {
 
 	/* QCA WCN6855 chipset */
 	{ USB_DEVICE(0x0cf3, 0xe600), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe0cc), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe0d6), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe0e3), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x10ab, 0x9309), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x10ab, 0x9409), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe0d0), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x10ab, 0x9108), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x10ab, 0x9109), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x10ab, 0x9208), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x10ab, 0x9209), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x10ab, 0x9308), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x10ab, 0x9408), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x10ab, 0x9508), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x10ab, 0x9509), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x10ab, 0x9608), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x10ab, 0x9609), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x10ab, 0x9f09), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x04ca, 0x3022), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe0c7), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe0c9), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe0ca), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe0cb), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe0ce), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe0de), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe0df), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe0e1), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe0ea), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe0ec), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x04ca, 0x3023), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x04ca, 0x3024), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x04ca, 0x3a22), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x04ca, 0x3a24), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x04ca, 0x3a26), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x04ca, 0x3a27), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* QCA WCN785x chipset */
 	{ USB_DEVICE(0x0cf3, 0xe700), .driver_info = BTUSB_QCA_WCN6855 |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Broadcom BCM2035 */
 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
@@ -571,134 +535,96 @@ static const struct usb_device_id quirks_table[] = {
 	/* MediaTek Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0e8d, 0xe0, 0x01, 0x01),
 	  .driver_info = BTUSB_MEDIATEK |
-			 BTUSB_WIDEBAND_SPEECH |
-			 BTUSB_VALID_LE_STATES },
+			 BTUSB_WIDEBAND_SPEECH },
 
 	/* Additional MediaTek MT7615E Bluetooth devices */
 	{ USB_DEVICE(0x13d3, 0x3560), .driver_info = BTUSB_MEDIATEK},
 
 	/* Additional MediaTek MT7663 Bluetooth devices */
 	{ USB_DEVICE(0x043e, 0x310c), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x04ca, 0x3801), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Additional MediaTek MT7668 Bluetooth devices */
 	{ USB_DEVICE(0x043e, 0x3109), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Additional MediaTek MT7921 Bluetooth devices */
 	{ USB_DEVICE(0x0489, 0xe0c8), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe0cd), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe0e0), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe0f2), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x04ca, 0x3802), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0e8d, 0x0608), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3563), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3564), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3567), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3578), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3583), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3606), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* MediaTek MT7922 Bluetooth devices */
 	{ USB_DEVICE(0x13d3, 0x3585), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* MediaTek MT7922A Bluetooth devices */
 	{ USB_DEVICE(0x0489, 0xe0d8), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe0d9), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe0e2), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe0e4), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe0f1), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe0f2), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe0f5), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe0f6), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe102), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x04ca, 0x3804), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x04ca, 0x38e4), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3568), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3605), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3607), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3614), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3615), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x35f5, 0x7922), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Additional MediaTek MT7925 Bluetooth devices */
 	{ USB_DEVICE(0x0489, 0xe113), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3602), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3603), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3604), .driver_info = BTUSB_MEDIATEK |
-						     BTUSB_WIDEBAND_SPEECH |
-						     BTUSB_VALID_LE_STATES },
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Additional Realtek 8723AE Bluetooth devices */
 	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },
@@ -3959,7 +3885,7 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_WIDEBAND_SPEECH)
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
 
-	if (!(id->driver_info & BTUSB_VALID_LE_STATES))
+	if (id->driver_info & BTUSB_INVALID_LE_STATES)
 		set_bit(HCI_QUIRK_BROKEN_LE_STATES, &hdev->quirks);
 
 	if (id->driver_info & BTUSB_DIGIANSWER) {
-- 
2.46.0

