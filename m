Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E174317A2E0
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 19:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752088428; cv=none; b=Z449ALDwD6QIYi5uSLJmygX859MjPLUHjAxv0HN+34YcKvGstypH43NfVRssEeeaqSIVIJqWmNbiqvmuJEKKOD5iRFx+dRMwcKQXEDXqfJSAeqB8VwvLzKqyodMIfytI9F5mMzOEg5RZ0LEHXziso4m4GUFfnsjXINU3kI0RgPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752088428; c=relaxed/simple;
	bh=MUc3fbgrLDYoS7wWEJi1kj6KmwJCJpdu11xBDq2lKP0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=b2UYcWCYZN0iQC0CRJ6z/Tm8cOjQWQ2ypmI4UgVPDMdhBG/gGPotBN+VO6NZVQ6oDBz/dF1x6zbgJIWu0COSieQQLCkPMAC9dKjq9Hmuwp+V55NTa6OeHvoAGYMnZEWq25W5ShZCbu2it1/iGNecX1y+7F4hibEBhkKfygOFJ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lb20kYoP; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lb20kYoP"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-8815049d0a8so120668241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Jul 2025 12:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752088425; x=1752693225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gzns4v7aDWbEvK++C4AziICnzRiUrGEUwygBgR5DwrU=;
        b=Lb20kYoPvTYNrCUD6mMaWBR+fQJHFIQhxQpLiJYOD17S7h0JqyJhz9iqUPJUQeQh9f
         tVdjWkEzhSSgMKqjv69ORqZdzCdHNh2CJid45iy+Msmfk/0EZslo4b3Eu8k8QXICMEUI
         ELG6kGEtYTS5rHpB+Tqh5WuD/aqlOoBZthan5C/MPsf67qcmnQvNFhMjD5EJqLpdq/Mt
         0x17J0kHvgzsPdydtfsDaYdAWk6Va1aJ/luksrkOPdanZpYbRkvxXUvR1zsn7JHYK1/s
         nWOU3/wYhDRZlKiNYDrkQ858YzGglHXS0DGE9JIbUPhheT3C7zyeAErmHVIpKo+fZEfP
         lu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752088425; x=1752693225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gzns4v7aDWbEvK++C4AziICnzRiUrGEUwygBgR5DwrU=;
        b=lt/PgDQPrJbhAbLOCq0fHJPXXJhlB07mrazJ/A1VeH+JXAq7Fny4Vh20DjPr2E1219
         OlS0amGCrcI4GHApJQ4cpJMwu7He6PeHYZWIJL6h70aH6bFdI+REH+2cWwZ1IHRJ13dR
         uSOS6sjBRbGkDTfy+R/lDSExIKQq+Log1w8exKITiSYOPOjqpsu+SeHXgw4EerkrPpUE
         ztrPoeFHZmxXMpXwOjyJVCTY1RxUdYIV3Ln7lp4NXRksaI6XSOZWUVy2pBcC4aQSf1Ut
         OHuvCU56cEuchooL24phwkdnj5gyHdmsA8+G7jsJLGRT/qZn+Csq8OBkaNo27Ec4XKQM
         Cc5Q==
X-Gm-Message-State: AOJu0YzjP0ZQQy3jooa9Kqbk9IxFoclh/gV9FRJLTMUTq30bzwcqbXou
	uCAglNk8yN2kO2LrCUvlxP/Bba74L8G3qPrbKScCVXqUWrKqfuGh+XgPs6aEM+TP5sc=
X-Gm-Gg: ASbGncvwGfB2SMCPZX+wVzmkqfb8v4O7P0OTQhNXgF/j/ynUZyEgCyebH4WKi9VtWd7
	psxurEUBZclGGLryW5LV3LhZacnZetK64zCmjAoWyySCgN8ddYnVk54Qey0iQJPtJ/5FyfvmpdK
	7mvOshhoeNu06+7YvI4MS9x6q9A4wXefsAna2gkzbUNibrxfiOCVjfKZNwSFiUUfXmU8sMScG1q
	bi7nOioT0/Qr4zp3MdhEEHINTW7PFY/Y9Oy0QEp4YPXzKYtnWPI3ftbt2IKJ9qeWBRqAhaUxgBx
	BVdjczHqoCO5d1xM2Zr+z8jujunu88QnXCsGYyimEjxj/O07TVj5495XVNA7IhYaMsfX53vCV9U
	BGajHf6s3n8m0/am1+MFcgpfJj5Hh
X-Google-Smtp-Source: AGHT+IHdfkWsJQ+L/sAAqSerolljzLiP8xYNqtGRrBvefN2sDK4coMtZLlLvnX2Vhd9W3ZJ1rup8aA==
X-Received: by 2002:a05:6102:6881:b0:4e5:93f5:e834 with SMTP id ada2fe7eead31-4f54aa73468mr3382117137.24.1752088423115;
        Wed, 09 Jul 2025 12:13:43 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-886e925c470sm2429515241.9.2025.07.09.12.13.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 12:13:42 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: btintel: Check if controller is ISO capable on btintel_classify_pkt_type
Date: Wed,  9 Jul 2025 15:13:33 -0400
Message-ID: <20250709191333.3374053-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Due to what seem to be a bug with variant version returned by some
firmwares the code may set hdev->classify_pkt_type with
btintel_classify_pkt_type when in fact the controller doesn't even
support ISO channels feature but may use the handle range expected from
a controllers that does causing the packets to be reclassified as ISO
causing several bugs.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219553
Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2100565
Link: https://github.com/StarLabsLtd/firmware/issues/180
Fixes: f25b7fd36cc3 ("Bluetooth: Add vendor-specific packet classification for ISO data")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btintel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 55cc1652bfe4..06575a0b9aee 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2670,7 +2670,7 @@ static u8 btintel_classify_pkt_type(struct hci_dev *hdev, struct sk_buff *skb)
 	 * Distinguish ISO data packets form ACL data packets
 	 * based on their connection handle value range.
 	 */
-	if (hci_skb_pkt_type(skb) == HCI_ACLDATA_PKT) {
+	if (iso_capable(hdev) && hci_skb_pkt_type(skb) == HCI_ACLDATA_PKT) {
 		__u16 handle = __le16_to_cpu(hci_acl_hdr(skb)->handle);
 
 		if (hci_handle(handle) >= BTINTEL_ISODATA_HANDLE_BASE)
-- 
2.50.0

