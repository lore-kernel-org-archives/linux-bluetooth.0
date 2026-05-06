Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349622DEA9D
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 16:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778083635; cv=none; b=h4OBY0B6aDsG0rlq7dMAdPftRESVoFv+26eMTUD58oXZlLve1uLdPHANidMUbpVxYbg/H6si6zbZjF00GP23002Om/ggjHhYX0n7VPgxqLRYhtFGjEHTsKFeJ9uquUfR2cz/Ts99D0EhoDI7BDZHNXP6/GhFO+OxiJ0Sg0NvBsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778083635; c=relaxed/simple;
	bh=eBbC4rOLWN5aQfG6y2cU2iXBByyWUVvx7VigW59gmtM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMUE0oCqd4pC81WSnzWmVZbZw1PB/kfHHhz0OWqYJSY3EBvh4ucksGfU1IDJFni7Yr3IdxGLOc0PD77a+/if8V5o/lIW4DuzLS9REB6fOOHZzDbDpEabTuz5THnyvbdcFE6CD21FH1dZWbSENqETJQwLj5OTW8XkSZFo+o+C0Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOjnWfq5; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOjnWfq5"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-57516bb40b9so2613825e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2026 09:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778083623; x=1778688423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/L4+rAdBKl1Eds7sZ3hL+bakZfSB/FndDJYiGTtkV8=;
        b=TOjnWfq5megcMPdwYouHFyX39phnuKg65qnRfSPtpshxzvjj/nKh1K39Ug39XvL9Mn
         w/yR6P7KdYSmyn43a5wztpQruZcModdY4cUrD9PgIiQnB/OzNOUza23YcFIaZLnRGyBX
         BbJ0tulbrf6mAOO71Z72NBX6Zl0uqZpTKOOzUz0xFzRU2wknNLku8Z6WhhqUqhoj27jG
         H84blFMOsHBd7bLSa6kNRbpOhZZFndda/jt16mpqaEOf6Bje337BQvdNoU0g17zysyC4
         cDkRcBMQPaKOolkR6wzKU5WXck2cm3l/pk41LfpQaM4Ehkhbnqc0VSSksMMCufpMtriM
         AanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778083623; x=1778688423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5/L4+rAdBKl1Eds7sZ3hL+bakZfSB/FndDJYiGTtkV8=;
        b=NA/jDTl43GQmxh1czZufdPntc6obBnBObNvToVtolMKRNjDle59htkA/QT4Zxla6o2
         PW+ctIH5hR1aB67ML6v+tfru2RcitchbU8yfyEE0PyZAj8KBgXLd4cWbPpNuP2wd4ogv
         E5qQvXaF1ogdTgXJKLVL/+Orwn3C/TNa817l2XW/yIbl5Sti6H6c872Ea4s0T8oImR6J
         Rx8qCy3cFWf6KWFhp9YE4mZ3QxyNB01VMDCz0qdCr2174RbT1oTPsOPR8R4nUGarMM70
         LjoAN45Ph8zFTp57F6uc7gpVrs71x4/fUDGw+53mIOEs7BzwhbZEMdqysiUDoXQhxe1l
         BcqQ==
X-Gm-Message-State: AOJu0YxOWCHThpQSqT8HMXQgG3YgINWPZs/MFNTTzX9jhqMjJxFaWBEt
	FnCU+l0u8jUb9yDGKh8cZNOk0UimOf4yNRAfMb5MJsiwV4H7lI087bvPU3jrGPDQ
X-Gm-Gg: AeBDieuw3HQgY4Mf3RQ8Yh19NSN5yU3hhtyuX+IB8bFhzFmW+uD6j2ylqdsHiiVtAIh
	cytYXFNoqJSoTt5Dw6h34QeDwp83omKkkxQk/4CAofSgmnRV6tk05vWaaqdDGxQNpY3nv46IdPM
	Bw24oHMAjlwAxh2x20cx4NVHQWXl2uu4p61COzGtj88CIrya1FepbPzxT+YLMDoun17DOWCTlee
	fZwMgCEea+UV0h0rSAbrbhj4b66FpewXPsHFx0L3DHT0GcSn1FWHBQaRbIWdzD6eW83BxGNbIEh
	2DuOjiVcRRhch231kRkUqNUZ5UbuKuDx6o6j6BK4+S4glU/TShXVgeh4qUXeond6rK6XDhgSDMK
	NVe3bMyF+TGq9P4Wuv6/M4+FPBEE3lQ0434VdBqR+IwM1sUcq2dZ6RmpDa05f9tOZJtmeXcSyg6
	qIAfXoLaYrTWJGS4XhtQgwjMHIbOV6P3tP/2WEta/H2M3Oxjs9GUKT4MeT4oJfsNp6QXPu8+9L1
	SMpx5sYpeS83uO9jc2ek4QMbKq3
X-Received: by 2002:a05:6122:4fa0:b0:56d:31e1:2c9c with SMTP id 71dfb90a1353d-575594f620emr2538946e0c.3.1778083623220;
        Wed, 06 May 2026 09:07:03 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-575585f72c1sm2142241e0c.12.2026.05.06.09.07.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:07:02 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: MGMT: Add SCI setting bit(25)
Date: Wed,  6 May 2026 12:06:51 -0400
Message-ID: <20260506160651.1585012-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506160651.1585012-1-luiz.dentz@gmail.com>
References: <20260506160651.1585012-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds MGMT_SETTING_SCI(25) which indicates that the controller is
support SCI feature.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 2 ++
 include/net/bluetooth/mgmt.h     | 1 +
 net/bluetooth/mgmt.c             | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 61872403fe65..84a1ee798da1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2094,6 +2094,8 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 /* Shorter Connection Intervals support */
 #define le_sci_capable(dev) \
 	((dev)->le_features[9] & HCI_LE_SCI)
+#define le_sci_enabled(dev) \
+	(le_enabled(dev) && le_sci_capable(dev))
 
 void hci_sci_groups_clear(struct hci_dev *hdev);
 
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 8234915854b6..dfd264f0bac7 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -121,6 +121,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_LL_PRIVACY		BIT(22)
 #define MGMT_SETTING_PAST_SENDER	BIT(23)
 #define MGMT_SETTING_PAST_RECEIVER	BIT(24)
+#define MGMT_SETTING_SCI		BIT(25)
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b05bb380e5f8..1ea06ae1efdc 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -864,6 +864,9 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 	if (past_receiver_capable(hdev))
 		settings |= MGMT_SETTING_PAST_RECEIVER;
 
+	if (le_sci_capable(hdev))
+		settings |= MGMT_SETTING_SCI;
+
 	settings |= MGMT_SETTING_PHY_CONFIGURATION;
 
 	return settings;
@@ -955,6 +958,9 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (past_receiver_enabled(hdev))
 		settings |= MGMT_SETTING_PAST_RECEIVER;
 
+	if (le_sci_enabled(hdev))
+		settings |= MGMT_SETTING_SCI;
+
 	return settings;
 }
 
-- 
2.53.0

