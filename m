Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DF550276
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Oct 2025 19:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759434808; cv=none; b=A7tLj9/CAhHRX/ZUrf9Aw0vjG2SoTS4gOvolUv4Ui7/TnG4fGlC+SIccLd4bnLGzXWr1UvPFjrnzKyezS4e2lRbihXK6XhMyj5gj3Ee4GS3P+TIeKnmk+rwbkWlobXs7HKKO1pGcHQ8hriiYSKTw0+xlnxzbd0c5SD1ME9f7ENs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759434808; c=relaxed/simple;
	bh=4Tp1wncSiAV+BbXWmmUzRzBhJun3iPxPGNwlrutFYV0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uT03Sp5V0brZpza6mumtu3kxOsxUCymUS/g7qeOKL2lB7thfKkKhas01VpctOPzFfZ2tcqZn27csKphqELk/i+WLU/hRXbUxs5WupEXw8QRej4KTxTZ7Bypy9iADyJSTLnmLnTSvH1KX8vcms6s6ByvAfactXz18bDYqiWYm4rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCQJTjIi; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCQJTjIi"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-59d576379b9so684461137.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Oct 2025 12:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759434805; x=1760039605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JEUCf9jxi9UEm0ornFtB44RGYZNlty4a7BRKSmP8A8c=;
        b=aCQJTjIiT/USHEhvT6G8OBs4J9GhZNlG0kOiElLCPpCiG/05hEnAZ81YEhKW54vrc3
         4kvSlVt4P0OUBv3CRNTFKBUJoCSgeQRJt8BVPDwX3S2X2hwSX5FMKOI7+a3ygjKbApZc
         BrcgBGhN//VzcD0tlfHs114mh03LQ+9jvpNXT6n4/D15A4TVYZRecLlvgJumRqb1jh5w
         YWG0Sria9JA2Z13iVqibIFMLZW/Ef9f+x52+PXOSjQLB37gBzANimeLWHDta9Zfog2cw
         BL3hKRyza3dln/DW7zXQQrG/67I1FZg07eSlgMcSVCk7nDZSBry2TdVmiIwjlY3KXvze
         Ev8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759434805; x=1760039605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JEUCf9jxi9UEm0ornFtB44RGYZNlty4a7BRKSmP8A8c=;
        b=apuZ7ng3/SJDdItjFhPNwZG3QvsHvI4I+kyvCpTdeaFYSfe3IaUnggnOa/kLIIhPYa
         /L9oUJyg7bTt+ktJ1fakoKj66RAy1ZyLSafWBvITK1cfp9bNIuh9I428MMHNu86eohBK
         VYu4ryg3SoddloSZQSgnNlzM9IUqDuxoezm/7pnx4zlrrHS/IMt+tZefDqme+HI3vsEe
         6gHVTI0wbhfFx67iVBKrRKGG601ZbeATrs3fh1YXjskVopyRQrG7Dw0KlrUAgV94EDAe
         306gS7LFxxmG0s6hKXzIXJ/+0K7bu1+Tyao77UCX8JLky9AWrKbDE/pKx0tqO6ZI2Qi8
         Aljw==
X-Gm-Message-State: AOJu0YyclP2DdApwQvEQV4iNOPlKbcg/wYu7nh4ft5COp2hv4x8t0tis
	IhkUpt4ZTt4pdSA5tA3c0JVi5FInq/B1u2syjtQyn0/wPVrcwEM56hD5LrU8+Caz
X-Gm-Gg: ASbGncu9vJbyIo/UIl2jiE7PcscZWIiPvCQr8y/6vgSTdeLInnnUc7dU9BYTARASkgg
	3DexJ/vKQsiwOjnSlLTTjMYgeiniEvLpWgpl3V9VknvHnSh8AJzEIq48vZFKSa3fDVG4Jwiyn9p
	5i9BYXVetPqOZfTaxNhvP0ZEb/sxTUgJCIVLtoOfDs9iECXEl6B3MF343IL19eskwHr3vZz5bEJ
	Uzs+KDB71RFrjRVh7kdLQE/xaaWbvpVUEoRQaLFUmZAlCKmU9py3GQs0qQ4kWCJPOt9wpQetdyO
	Lu+aaxv20DelbtDGtK2/uKBjAisS4kL3LKxnopOZKW0FgFvgty6R3TDVhluBsp3K7KEhvoA4P7i
	vfTjr89QTB68y3AKUUtTOSxdw5DQWVsGft8gKhj5fpAzU8HOnw4ZwvzMKeT2leAqQG6Qj6GIDDe
	Er7ZcAMkWc59LsiQ==
X-Google-Smtp-Source: AGHT+IGjSAPEj5D+cdlv0ytU+wYfpq1P8NcgcYbtWNIblkAqMx/oKYL3s2l7AMQMP/TNfhOKyml8Cw==
X-Received: by 2002:a05:6102:5107:b0:59c:bce0:fcbd with SMTP id ada2fe7eead31-5d41d110cc0mr149635137.22.1759434804829;
        Thu, 02 Oct 2025 12:53:24 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d40c68c542sm835619137.12.2025.10.02.12.53.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 12:53:24 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: HCI: Fix tracking of advertisement set/instance 0x00
Date: Thu,  2 Oct 2025 15:53:13 -0400
Message-ID: <20251002195313.303358-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the state tracking of advertisement set/instance 0x00 which
is considered a legacy instance and is not tracked individually by
adv_instances list, previously it was assumed that hci_dev itself would
track it via HCI_LE_ADV but that is a global state not specifc to
instance 0x00, so to fix it a new flag is introduced that only tracks the
state of instance 0x00.

Fixes: 1488af7b8b5f ("Bluetooth: hci_sync: Fix hci_resume_advertising_sync")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h | 1 +
 net/bluetooth/hci_event.c   | 4 ++++
 net/bluetooth/hci_sync.c    | 5 ++---
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 27395779275b..a998f8edbb53 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -434,6 +434,7 @@ enum {
 	HCI_USER_CHANNEL,
 	HCI_EXT_CONFIGURED,
 	HCI_LE_ADV,
+	HCI_LE_ADV_0,
 	HCI_LE_PER_ADV,
 	HCI_LE_SCAN,
 	HCI_SSP_ENABLED,
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 44b3e936fef2..ba0a7b41611f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1609,6 +1609,8 @@ static u8 hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev, void *data,
 
 		if (adv && !adv->periodic)
 			adv->enabled = true;
+		else if (!set->handle)
+			hci_dev_set_flag(hdev, HCI_LE_ADV_0);
 
 		conn = hci_lookup_le_connect(hdev);
 		if (conn)
@@ -1619,6 +1621,8 @@ static u8 hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev, void *data,
 		if (cp->num_of_sets) {
 			if (adv)
 				adv->enabled = false;
+			else if (!set->handle)
+				hci_dev_clear_flag(hdev, HCI_LE_ADV_0);
 
 			/* If just one instance was disabled check if there are
 			 * any other instance enabled before clearing HCI_LE_ADV
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index eafeaa35d857..2f75a96616c4 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2606,9 +2606,8 @@ static int hci_resume_advertising_sync(struct hci_dev *hdev)
 		/* If current advertising instance is set to instance 0x00
 		 * then we need to re-enable it.
 		 */
-		if (!hdev->cur_adv_instance)
-			err = hci_enable_ext_advertising_sync(hdev,
-							      hdev->cur_adv_instance);
+		if (hci_dev_test_and_clear_flag(hdev, HCI_LE_ADV_0))
+			err = hci_enable_ext_advertising_sync(hdev, 0x00);
 	} else {
 		/* Schedule for most recent instance to be restarted and begin
 		 * the software rotation loop
-- 
2.51.0

