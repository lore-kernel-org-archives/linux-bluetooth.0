Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A3638F9C
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Sep 2025 20:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759262873; cv=none; b=WykeXNtuJ0nuJwbMsohB3cp/3rkh7Kyk/ALaiDLoXh6kKmjrPVWiDLvB1aWsHiJ/Kz6gFJ3+ArPgVtDgl5kUvMLbPJ98yYiwYlyI0fWJa4cOTSO2VtOw40fMcwzZqe1PilGFRyeCxR3P93sRBIS1jogFEzL/Rt+wb65pgNmuugw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759262873; c=relaxed/simple;
	bh=8eGhL15vROQRLYfhD84LwpptX0FfsRqGb9itQ+7BbGY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ARHVx0kMbpa2nVJBROyaKbbWfwXVbcsBlbfs4TbZJpHrTLKIF8/sTrH9KrMESvBUcmHce0kdQtgxJu6ZzR2gTG8HAgoA72eFM+B69fquR6FInyf+PK0RsGK/zy3iClumnlk9KThIIC84CyyFQhhkc3E77fKqctLOlQ9rl5hKSpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKAggAf7; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKAggAf7"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5b59694136bso3227581137.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Sep 2025 13:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759262870; x=1759867670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EcgkW9vLOfXIeXQ8s1qIiQoi7e2YzoXK7HqMm8OfNnc=;
        b=OKAggAf7ifxjX5Fx1WpXOurVpuprbPNIchUOjriIB76QPTzCuJX6ANzqn2QdWNTEEX
         6DD1whHBh/fcjgMXy8SkzyfCygnclc9f2uKKwL8uV1eea0OyBZy3fKWFUeSWWYgEE2He
         OxgOX3allMHtTMotCDKGiQbBQfaxmEwBgMnOtyAurV2936NYE8vh81v5d0f9pcE02Pcu
         UvY3cF/xrvF+0zbF9JGSipGvYT6QbVl4wphcrWyqNy1oXFLvTQ5Bpgz+lDDzBuh6PvB0
         X/H6iWa7oEUrS534ty4EKZhZUNswRKpXamB93DBYXgi9viWxX2aDV+uEEpSgoAiWuEAs
         0l/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759262870; x=1759867670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EcgkW9vLOfXIeXQ8s1qIiQoi7e2YzoXK7HqMm8OfNnc=;
        b=N6f2hCtGJvWIAVT1iW7tNiyCpVtFHRaxiXheuLO0xKmaB/0dZaG8iy3HaFBq0jZ3Qv
         PqJm3KJR6E0I3CGsc54cXjrK/0tCbD4Wt6n/yb7eRYSUgct1tZ/ccqWt8c6q53JLMZsS
         n/DyqFh7v8aIUTrsDTuIxQ4MiIuX3thP8CbTWOcjCl0tPBuQ7BtLzagmJp3KXEkH/SpX
         rBZ8ntaJfAmpeJcEOICGi6xigHKoG5SpzsTYiIj5U9Rk41o0xVKqMYAKQU6KJ4tr1Pfp
         KN3QtaCk6MgcTVbRgbZCI0LlD7YnnrZHJHn14ZaETWUUaHyer5sVwv7e82K2uSAcd2CO
         0xTA==
X-Gm-Message-State: AOJu0YwGfQsgBK/IgQxModbyJGNgkNQF5toJKXsu+Fk3CHllhdAFnWuP
	Ymhykk8QUKJ+0ZpjjUymi3apUgzemO1vvzZBRinytRT2JOrlIdo88PW7qdsJcg==
X-Gm-Gg: ASbGncv15hFKYlOqTNb4Wo4aivhx4AxoKCkfuaM0Z+0wCkzIXgCsYvwBCwrACiWxz7R
	m6TmDanGFKseK8+xxRmvzWHCADVLeZv+CbHuEKe+PTe+S3l4LoKP9p3CbN90W4ySoQyNAAeq3YG
	hVEZvhoL9C1D0YNqEdQw1FxD5Fs9LPMetmaSVW0fDJWHNN2ClDkD7cF7SwnNOtRz3gusJROvelt
	o4WD36TSVVL8imkohU9heUR5PlxbmVzkTAc4itE91Lz4x+CK17XjaF2P+tyUDETZkSM0cJtYbZY
	qbFd6/0mgyZLd1yb2XAahYEtVHo6+wCmaTXG7B2BGmLJX1gO7/kJ8fy0JPHkCz4DTAlxXt1CGoP
	hvlKmN4oAFYh6h2LZgY5N3JM/uR0h5Vn97VXNKyf6s95hDkFUyyWlqpv1YzKGduFgvSR/AWaOkg
	6phC9vxr0rePQfdF3DvrU1EDxp
X-Google-Smtp-Source: AGHT+IFBGejRbfGCDzNLPvSrdKL3PYfhMt+ilFukf83EpCC/Y6wwYyidKx6OidHUpK5WpUMRwV49Ww==
X-Received: by 2002:a05:6102:370b:b0:525:9f17:9e63 with SMTP id ada2fe7eead31-5d3fe6c62e9mr459570137.29.1759262869803;
        Tue, 30 Sep 2025 13:07:49 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-916cff05915sm3198057241.4.2025.09.30.13.07.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 13:07:48 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: HCI: Fix tracking of advertisement set/instance 0x00
Date: Tue, 30 Sep 2025 16:07:39 -0400
Message-ID: <20250930200739.1802189-1-luiz.dentz@gmail.com>
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
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_event.c   | 18 ++++++------------
 net/bluetooth/hci_sync.c    |  7 ++++---
 3 files changed, 11 insertions(+), 15 deletions(-)

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
index 44b3e936fef2..197002f38bfc 100644
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
@@ -2971,13 +2975,8 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, void *data,
 	if (list_empty(&discov->resolve)) {
 		/* When BR/EDR inquiry is active and no LE scanning is in
 		 * progress, then change discovery state to indicate completion.
-		 *
-		 * When running LE scanning and BR/EDR inquiry simultaneously
-		 * and the LE scan already finished, then change the discovery
-		 * state to indicate completion.
 		 */
-		if (!hci_dev_test_flag(hdev, HCI_LE_SCAN) ||
-		    !hci_test_quirk(hdev, HCI_QUIRK_SIMULTANEOUS_DISCOVERY))
+		if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
 			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 		goto unlock;
 	}
@@ -2990,13 +2989,8 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, void *data,
 	} else {
 		/* When BR/EDR inquiry is active and no LE scanning is in
 		 * progress, then change discovery state to indicate completion.
-		 *
-		 * When running LE scanning and BR/EDR inquiry simultaneously
-		 * and the LE scan already finished, then change the discovery
-		 * state to indicate completion.
 		 */
-		if (!hci_dev_test_flag(hdev, HCI_LE_SCAN) ||
-		    !hci_test_quirk(hdev, HCI_QUIRK_SIMULTANEOUS_DISCOVERY))
+		if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
 			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 	}
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index eafeaa35d857..e2db065088f6 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2606,9 +2606,10 @@ static int hci_resume_advertising_sync(struct hci_dev *hdev)
 		/* If current advertising instance is set to instance 0x00
 		 * then we need to re-enable it.
 		 */
-		if (!hdev->cur_adv_instance)
-			err = hci_enable_ext_advertising_sync(hdev,
-							      hdev->cur_adv_instance);
+		if (hci_dev_test_and_clear_flag(hdev, HCI_LE_ADV_0)) {
+			bt_dev_err(hdev, "Re-enabling instance 0x00");
+			err = hci_enable_ext_advertising_sync(hdev, 0x00);
+		}
 	} else {
 		/* Schedule for most recent instance to be restarted and begin
 		 * the software rotation loop
-- 
2.51.0

