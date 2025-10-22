Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A252F25F1
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 20:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761163413; cv=none; b=ikmeBiQ6WdalKcCgtyDu1nA2QH4jkJZS3E1V4gtXt6XLW4y6FyyKmOuCsR5aJEqTfLlSsAhIAmP/BErvDnJ78+y4S1OGlyCvW7h/DxHtNBdSsgGxYdhOGpsCEd+a6SVp+7XmVpxoPTJQOLfLs+QqCi1DO84WYoheYMFV9fjBp/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761163413; c=relaxed/simple;
	bh=5IGNJ9XhzfCWxkMBvnoIJDL0C7pZ8ZUoCut1EdvYF1A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YnWKqYtKkxY4OHewACLk0JpATqmYWjv3QaXC25z9X0PQdYd12FA6d7p9Fjed0RKoIJDQgupzGPowYRjllpXHuC11nFmu2CIglj+583JElfgVVLfdtMrDMsMbCwvn0ay6DJWNU065uTqhLckRyqo/eR14sYwNT9QItu4L0BRzpHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ow88qvvw; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ow88qvvw"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-557a56aa93fso7156e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 13:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761163410; x=1761768210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gOGKGXZNbSis78oDvAId+88LAPkbTA/nb9pl2Fe/C8U=;
        b=Ow88qvvwku6507Gd1kn4UYPo/mSXnX63PtpIzdsOsmv64uSnwGU1rpnLhadjeG4wrH
         JI1sWtPs6XKTo3h1LPptd+lZGWvxqkBcUCZ4JZktfIPEcoeDG4G8st9IsACnn7/6KBBm
         01Cs7gyiKja2EE3ndXWdghU+pqmlFohLEPgXNhID7l1HAnjsEKDbUz2Y0tj8Dne1jsmH
         S9MpzVvVw6LckybVWKCBmYWmapWv6fX4tWQLnYSau7J38klxpbLBx7qAewx3RjLeZsoC
         2KTMJLH+yWCPSJkpwE2eJzPTLK9XcaMDujABbNbN7MR9XUL0dJyFatLTqBYcqiKKYm6h
         uWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761163410; x=1761768210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gOGKGXZNbSis78oDvAId+88LAPkbTA/nb9pl2Fe/C8U=;
        b=hbILIiSIGyls2Rd7VnmkAn+CrgM3kvNIb0GKGqYXBfGKtvYMUMBGradvAgmEMD3GGr
         Mqw9TJu7L9zegI64eUt4aGVqvhqbAVQnRZBHfY0PGjggwEwq1Iy+sdpIdfUW/5L2u75e
         fiCjvKjNSj27oUfvU8fsufik8Jy7wXf6BJRC5N3AZTzQ1hm9z1S9wcMu4QOPpN61EtLa
         cy9N4jR6KbgJX3HKynDt1iureh5RSU1PMEJ1wy2wImIwFbX8liMNMMvfepnSpqjmDtIV
         6X2BRo2jhUzoRfyiZopnIWEP17naoC5MyAdPKnOgSKBBg3dlFE9lPrM3y27haAPd7nSc
         Vo/Q==
X-Gm-Message-State: AOJu0Yzlr9VXOnzbasPdzuthrhJg63hn6dVzqsCA2SNiSLcmgHNMJRJl
	/kDElT9jaHoVjNZo21EwxKzSsT/p18BRKICwlk+/vBKrT9kIXQer7VxCnSF1xQ==
X-Gm-Gg: ASbGncvSmjV8g/ChHAiMgz1rYD+CeR+LDYRzPwLQSYKLOGKl5e2g08UlYjyP4hknARQ
	pXUyW+ge7YlXfRraEtnjn+cxQNcwgpWTC7tImRBU5TZyPQan555ZOYhfiCVcLaiVICmgV6WExDf
	N+3CHLqnETQWKQ+GEOG+ezYourkre/AgPybta+pLhomdtrRTC+k3g4vsCG7Y1a5nKS75HVvg+79
	r/7eIDBqQWyv39Depd2KP5oEHyJuDhPIcXAL9WHLauAOcEypWI/p52rhvK+vMhElz51VCuFXG/3
	GHknnr4ZAaDg7BswYHs9X3dlQvTOVk6unlM85YEBP/rrLx+xpRDEi7e4ZFLtTj+wLt3ifRLTZ7B
	z3rJm8XixbFmX4OsAoly0+yJYusjBlmf2p9gON9BUWsrCWykua9+ZaVCCD8xUfh8fIrGiOYGHqO
	LOmm8=
X-Google-Smtp-Source: AGHT+IHlAnMWgsRxN9qFAHyx4B+KxBL+ysCqqnoZEl95unw9eNxuh5wKU4Od70Zs5XxY9ivGS6MfqQ==
X-Received: by 2002:a05:6122:3a16:b0:557:2551:7e9f with SMTP id 71dfb90a1353d-55725518d19mr846177e0c.14.1761163409578;
        Wed, 22 Oct 2025 13:03:29 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557bef22a6csm10002e0c.26.2025.10.22.13.03.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 13:03:28 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_core: Fix tracking of periodic advertisement
Date: Wed, 22 Oct 2025 16:03:19 -0400
Message-ID: <20251022200319.1529849-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Periodic advertising enabled flag cannot be tracked by the enabled
flag since advertising and periodic advertising each can be
enabled/disabled separately from one another causing the states to be
inconsistent when for example an advertising set is disabled its
enabled flag is set to false which is then used for periodic which has
not being disabled.

Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 1 +
 net/bluetooth/hci_event.c        | 7 +++++--
 net/bluetooth/hci_sync.c         | 4 ++--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a0ad136b2108..18396e36908b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -245,6 +245,7 @@ struct adv_info {
 	bool	enabled;
 	bool	pending;
 	bool	periodic;
+	bool	periodic_enabled;
 	__u8	mesh;
 	__u8	instance;
 	__u8	handle;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ba0a7b41611f..bae8c219341a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1607,7 +1607,7 @@ static u8 hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev, void *data,
 
 		hci_dev_set_flag(hdev, HCI_LE_ADV);
 
-		if (adv && !adv->periodic)
+		if (adv)
 			adv->enabled = true;
 		else if (!set->handle)
 			hci_dev_set_flag(hdev, HCI_LE_ADV_0);
@@ -3964,8 +3964,11 @@ static u8 hci_cc_le_set_per_adv_enable(struct hci_dev *hdev, void *data,
 		hci_dev_set_flag(hdev, HCI_LE_PER_ADV);
 
 		if (adv)
-			adv->enabled = true;
+			adv->periodic_enabled = true;
 	} else {
+		if (adv)
+			adv->periodic_enabled = false;
+
 		/* If just one instance was disabled check if there are
 		 * any other instance enabled before clearing HCI_LE_PER_ADV.
 		 * The current periodic adv instance will be marked as
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 67514159193c..754e411babfb 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1607,7 +1607,7 @@ int hci_disable_per_advertising_sync(struct hci_dev *hdev, u8 instance)
 
 	/* If periodic advertising already disabled there is nothing to do. */
 	adv = hci_find_adv_instance(hdev, instance);
-	if (!adv || !adv->periodic || !adv->enabled)
+	if (!adv || !adv->periodic_enabled)
 		return 0;
 
 	memset(&cp, 0, sizeof(cp));
@@ -1672,7 +1672,7 @@ static int hci_enable_per_advertising_sync(struct hci_dev *hdev, u8 instance)
 
 	/* If periodic advertising already enabled there is nothing to do. */
 	adv = hci_find_adv_instance(hdev, instance);
-	if (adv && adv->periodic && adv->enabled)
+	if (adv && adv->periodic_enabled)
 		return 0;
 
 	memset(&cp, 0, sizeof(cp));
-- 
2.51.0

