Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D11151A743
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 11:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792065038; cv=none; b=mN6j5xvrQB+KkZWT5k2MZChbfnM2aN83tZj3jjqykyERBWDUCtikHMn8Kms+62K5RsNL7rRiRAyyqjfuWIo4HpnpGS0yb5DX1g3aH4RYLpe/sPGxKGWVirYAy9Zo4HOOkRpy0YBkhz1QMHy0dV1GEHBTo+9DWPbKfotxitsycDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792065038; c=relaxed/simple;
	bh=j03DxL3XsLNKFkUpcWEhtd3/YmWkIta2bwaSXaOK8xE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iYmhIBBP0pe1AXsKCEN1E1p4u8kdGLppkLeBDHrzz71HE5Kk726I+4JNMZ4WbSvo/0hWV1vAZVjn1O7k2I6bTkKS6mj+qY2YlAKD/hLskBn4uufnb+izjPaPAn2y41yOZ9FNvmKwr4G1R3GdunYtlW7zo3IjzSUFtBeFVNiU6uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhlXa8hu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhlXa8hu"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a16c1608faso67647845e9.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 04:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792065033; x=1792669833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xArxQ29OjTOJvjx6A+MRa+FmEhp5CsKWJusxL3JbeZw=;
        b=nhlXa8huQJMSkKKSmJwijInSeNSDyiBPXPBE2lJFpXJUzke7+qWUk7WL40RBdT5EWv
         buXPkDGo2TizKXf1CNVWMzNybPNMwPrUCib8kgVFIhfDKuxJaMGej0sXa+QwfQ+51eoA
         lecUYuRNYoySSbWCWGpkx3u078gT3ba7LEBB4vQcVUcACzvOU87yadadqG0+DHkbfrH0
         lWPHqnU8KPUY5+pLpU2yOT9D9Zf10d6yLd/hTg2bWA1nVZ4K8S5/azipw5iS1F3v0wOC
         F9UkCWvbsJoor80nuCC46Ul+B2h+0tnNoz96odyN67eC5X+8JmQ5UDgdMyDofHltV9uo
         0YYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792065033; x=1792669833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xArxQ29OjTOJvjx6A+MRa+FmEhp5CsKWJusxL3JbeZw=;
        b=iDBfM4hz36E18uzL2SiKiCT/CcZnW3PDqVX1892pRj2HvfnX+HtJMvnc80zhZcA9G0
         Z8T2ruNtUrgj6R/ASmILs1pvbfnW+H7iZvjsGX/QX0bvAtbfHhLboYv/BKktTuhkX56z
         vv9BnUrZgE2oOLPhD2kysS3brLW/BM3eKMAj0x0EZZiW8dC4PiibzxZvE/oz5ARCP9AX
         FPpzYCa9Zcvx1AkF3pGxTn5MQL0+WyDGsP9hYLcUgJoOLz83PFVIbN0lLdAfIofmwHli
         O3mP+VkKUL27LANhK+7v2oephrIxpFoAxHVztviBrykH5gKX1dM3iBGyMuB2fcA58kHT
         L3Eg==
X-Gm-Message-State: AFq9FYKxZ46mQnfp5alhSv6TGmT0kn4PmVkV1Kx4poHuLHwwYJY6KtTz
	n8zqkSraK5WHVPIkiMpFd5Qi/46lYYouOM5wEjoHwcCwDVdksrw8D8gc
X-Gm-Gg: AYBFou1aIYG2/VgyWvrfj1tNtO1ollq/Xy3vHkSDH7G7wxVWIVeGLxtiIp+rENy/MhC
	nudpplTeFyWJ6/AKbor3ibXrbDaLcTzKBTqFsOwIXlKqNFiiR4caigsSJ1giWG+ZtsTDCsJCqBM
	GeNOcZsG3NQm5pn73D7B4HByn492q6tlWhEcEHQoCI6IuTYRZvKE3lK6xMZMyjnXwA/5LqurJCR
	juL8n2wdVHanl5nAwd62ROhBgnQ4tP3pFVj5nrlVkhomIwPLgmIY9MGe8nDzubpLaY6qYfrMfTw
	3y9MqKhL4WS32S3512Dtj+XUi7g2rqywZ4pqiu2dD4Ft+CqZFjlk1F7nt/iUyFw2Z7pFPrIqhg2
	Ii5wiNE2NIDvaPOpDwNkd/2WrcEorIC2zG8IxrIhKXIEVmnCOQyfIrLUHu6oUbnqGPAEo6mwNHi
	6HLrgHUjspkUXKyWoIJsHAKB9ryVKFDTfioL5E9eOdnRDXblGgwQ==
X-Received: by 2002:a05:600c:a011:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-4a18e447d8bmr368734605e9.2.1792065032686;
        Thu, 15 Oct 2026 04:50:32 -0700 (PDT)
Received: from ton-machine ([2a0d:3344:2058:2100::921])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd6428b3sm60030955e9.1.2026.10.15.04.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 04:50:32 -0700 (PDT)
From: Ton Sharp <66ton99@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Jose Miguel Ochoa <josemiguelo.ochoa@gmail.com>,
	Aditya Garg <gargaditya08@live.com>,
	Ton Sharp <66ton99@gmail.com>
Subject: [PATCH bluetooth-next] Bluetooth: hci_event: strip Broadcom vendor bits from legacy adv report type
Date: Thu, 15 Oct 2026 14:49:01 +0300
Message-ID: <20261015114903.784731-1-66ton99@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Broadcom controllers running ROM firmware on Apple T2 Macs (where no
RAM patchram exists, e.g. BCM4364B3 on MacBookPro16,1) set vendor bits
0x10/0x20/0x80 in the legacy LE Advertising Report Event_Type.

As a result, directed advertisements (ADV_DIRECT_IND) arrive as
0x81/0x91/0xa1 instead of 0x01. Because process_adv_report() drops any
legacy report with type > LE_ADV_SCAN_RSP (0x04) as an unknown advertising
packet type, bonded LE peripherals (such as Apple Magic Mouse/Keyboard)
and Chrome passkey proximity scans fail to discover or reliably reconnect
to the host.

The valid legacy type is always located in the low nibble. Mask the type
field for Broadcom controllers (manufacturer 15) when it is out of range.
Valid legacy reports (0x00-0x04) remain untouched, low nibbles >= 5 remain
out of range and will continue to be dropped, and controllers from other
manufacturers are unaffected.

The fix is based on the initial t2linux patch from Jose Miguel Ochoa.

Link: https://lore.kernel.org/r/3352A23E-EA42-4366-BBAA-459CEAE6F51B@live.com
Suggested-by: Jose Miguel Ochoa <josemiguelo.ochoa@gmail.com>
Signed-off-by: Ton Sharp <66ton99@gmail.com>
---
 net/bluetooth/hci_event.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c055d16cfb8e..a03a33bca095 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6593,6 +6593,17 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, void *data,
 
 		hci_store_wake_reason(hdev, &info->bdaddr, info->bdaddr_type);
 
+		/* Broadcom ROM firmware (BCM4364B3 on Apple T2 Macs, no
+		 * patchram) sets vendor bits in the legacy Event_Type.
+		 */
+		if (hdev->manufacturer == 15 && info->type > LE_ADV_SCAN_RSP) {
+			/* 0x0f masks out upper vendor bits (0x10, 0x20, 0x80),
+			 * extracting the standard legacy advertising type
+			 * (0x00-0x04) stored in the low nibble (bits 0-3).
+			 */
+			info->type &= 0x0f;
+		}
+
 		if (info->length <= max_adv_len(hdev)) {
 			rssi = info->data[info->length];
 			process_adv_report(hdev, info->type, &info->bdaddr,
-- 
2.52.0

