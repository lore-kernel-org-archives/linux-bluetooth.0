Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682944DEC14
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606235; cv=none; b=D+Xpfoc2uOv1cpl/TXkdqQjc2ozDFa6Boj9xysGoYG74M5UE+mv4ZBDm2Tq8WR9HoMRa2r6x+1IrMxmyD0emMqoCc6Cnh/T9jhhl3yQ7qZkk5louZNiZWKi2V0sTdO4GV15JalmWOk0ijBkuJ+j2yi38xTt7mBL8KtTLWwwLJjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606235; c=relaxed/simple;
	bh=2Qd5CT8EGmqw+IvpSGJ6nA9lZT17Gh6gUR/rr3D48Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p7IjlKzxUDMzDLkdYAr7x+al55auJVdIrXlS4VVo94dBsHvQpsVR71HILXsB/wTA1sl9jC4nPeV9/Pe3Of9+7kN5/PqPEX61oaFIUAi4kHU6v7wPlO3cCVhViJCoOAalTpu7Nf2gcrW6p15A7WCqVxA7495sFfo61bKcsHUhoY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYNaCeFD; arc=none smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYNaCeFD"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2dc50c6eccso185822866b.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 07:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790606218; x=1791211018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c9sPjx5tB+sxVesvbOzF1i1jKAKg5eL5TDc0IJC/Flw=;
        b=VYNaCeFDJrPwDaZr1UFMZjbaIS4pdSkAjud2rIpiy4pfIu4X5MyPf2ukh+rQQWuUrK
         w1ZPAKHtWGsTsdRhSAFUvyornvS4knTXX0PWyTG+4kWq46xbUasmQwkV6dnT6X+WdsPd
         ZnqBHVIdmWMtf6ndpyj5uLwk6uDHKUAsgxa7jDXxHlOPLyT1UHkBhiAMUafRiWkJRPD9
         HfLXXWbtNvtSrP0G/DV2g8VnjGjjfGZD2gU7c+XplPSbWSvDno66wnEmiCJX8Soui8hW
         oXIbYHmM5XL6W53y3y0Lzjz34cLYr5YvS+JrsNhRE3hKTs/wWLA7R5HSTOI9NRc6dZus
         dvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790606218; x=1791211018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c9sPjx5tB+sxVesvbOzF1i1jKAKg5eL5TDc0IJC/Flw=;
        b=HAEpBMlwMCBtmI0hmm+L+3UdlNbNDheBjAeGziwwZU92iNesdz1SKx2VQcLbpb+GXn
         WFo0IYDD6d8Y3OeA6aeUw4ZYBGefbaCPnDHsDT0yRxkjGIp9T/qlEmCTmEZcWKAdn/s1
         AgW5TgKwup4fXqFc8AtOjqJicX7DJsy+CkXbdlLgAEaRml9gLIciWIHgiLKpzgpZFpJ7
         Td2vaBzthIbTqG491fQ+2v9Q1HmCPRlQg6gFNJi4pgv4012UQ3b+mrTc6IkzLpG2HTgh
         0izX+eKRYPOfW7qDywSN/7ut9rvVEUZZ9/tyl4xbwC6Vb6Y0lt0RFD8cWsnj7+IzLIpv
         cbQQ==
X-Gm-Message-State: AFuF++kIO9xwucPfzTNsfh4rM0c6mm/NvZpTpYDNYBQdQ6kcLopAplAx
	8Ia0Y36/m5T5BoK8jSr+zoa2xhxy0JHhyuI88xTt2i9qiZnVR1s3cAFQ
X-Gm-Gg: AYBFou3s17VYK7L31Wptg4M36RS/WF7EHbL3oFGQZl5HpfVecT57gPkcfgBBYhAG9n8
	sIMsMI/Q6NZguU/9yLUNrZR1ZrTCL5EcDD1M8q5PpEczu5hjqSzx3fej6Sm+HEj47eZHnVT+6rh
	OZoxjNGU7TughNftR4dzwDXDjXvxf6hV0v+1LOZQJen4Gd0GST9sF5ru5MJ6juq0Jmdk4+tSicm
	P4x2gk+gEL3AbWkFYJwZ4I6r7y/GmmLVB/+XpZ4F4/USnzpnnzlU7DWT4WWq0w98lP6bJVIx+/z
	oaPOBW2PsMa1D/lOBatNSEW3HmV4hf9ktRxga/aJUwkQ5Rqug4sgNjLvixK9zbWGVd+7z7LhQmo
	Vf+xhLoLS1fuUjy0yLdu70SR7g9gHuT7QwMYAwWX1cZ5qpKDUoKX7BrHJOy5Wn+zzT/NmkQjiTx
	ckuj65uDoZwbMmMvL8CQuhKu2Ta8w/Uel+erEw5CTqSanC5crGZ/eWB/Tp7y93ReffZcLjk2RM2
	vE=
X-Received: by 2002:a17:907:e84a:b0:c29:5021:f6f8 with SMTP id a640c23a62f3a-c2ac252bf84mr1111252466b.36.1790606218344;
        Mon, 28 Sep 2026 07:36:58 -0700 (PDT)
Received: from home.powerhub ([2a0a:ef40:1484:7a01:a8cc:a863:c2a1:d5cd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dc7b6f438sm260908666b.2.2026.09.28.07.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:36:57 -0700 (PDT)
From: Quentin Strydom <qstrydom0@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Quentin Strydom <qstrydom0@gmail.com>
Subject: [PATCH] Bluetooth: btusb: add ASUS 0b05:1868 to QCA Rome quirks
Date: Mon, 28 Sep 2026 15:36:55 +0100
Message-ID: <20260928143655.22223-1-qstrydom0@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Bluetooth controller with USB ID 0b05:1868 found on ASUS
systems uses a Qualcomm QCA Rome chipset, but is currently matched
only by the generic Bluetooth USB entry.

Without BTUSB_QCA_ROME, the driver does not load the QCA rampatch and
NVM firmware. BLE scanning also repeatedly reports:

    Bluetooth: hci0: unexpected event for opcode 0x2005

Mark the device as BTUSB_QCA_ROME with wideband speech support, in
line with the other QCA Rome USB IDs.

With the quirk applied, btusb loads:

    qca/rampatch_usb_00000302.bin
    qca/nvm_usb_00000302.bin

and the unexpected LE Set Random Address completion events are no
longer observed.

Tested-on: ASUS USB 0b05:1868, QCA Rome 0x302

Signed-off-by: Quentin Strydom <qstrydom0@gmail.com>
---
 drivers/bluetooth/btusb_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_main.c
index be47ac894b6c..1ede12515bcc 100644
--- a/drivers/bluetooth/btusb_main.c
+++ b/drivers/bluetooth/btusb_main.c
@@ -273,6 +273,8 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x0489, 0xe03c), .driver_info = BTUSB_ATH3012 },
 
 	/* QCA ROME chipset */
+	{ USB_DEVICE(0x0b05, 0x1868), .driver_info = BTUSB_QCA_ROME |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0cf3, 0x535b), .driver_info = BTUSB_QCA_ROME |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0cf3, 0xe007), .driver_info = BTUSB_QCA_ROME |
-- 
2.43.0

