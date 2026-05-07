Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BC73ED5C8
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778166802; cv=none; b=d0cp2xnPe60evXBEpwWZ1lEcgzhJMxRK8MmZwuEJWTSSvNBl80WNpQWZbdNGiqFntyAmD+RqjJcdfZMAQXOXEKi6TXOeDoQHM9bcPYgaZdFyq17hJQ1JStRHaQHCaWDGv8+iPHBbMwb6ePk6ykrCXEydUW+N3pLSssU9vivKa7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778166802; c=relaxed/simple;
	bh=eBbC4rOLWN5aQfG6y2cU2iXBByyWUVvx7VigW59gmtM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t96HL5yXY40wk3hvYCmVRfaAJWEGDb/0Zyo/50e87Sms9ABAyfM4W7JLf1sSfxJfRyTrtnJ8v3L6rByjqdmIuh1q98I56NbvNpqa2akka3V20rHqBL7daj4k5Kz59X7BsH/f0qfjFNoyJr76Pr5u/8LZ1wCCZtXtM3jeqEZsgYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jtf1S6us; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jtf1S6us"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5753a289955so332083e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2026 08:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778166800; x=1778771600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/L4+rAdBKl1Eds7sZ3hL+bakZfSB/FndDJYiGTtkV8=;
        b=Jtf1S6usXRnOi6L5P9Fc7BBZ+UdLt4RbvBBb9NJOxrWEkOdVN1g9ka/TGTWRGH3HX5
         f4FXZQXmqB8LY7OWtc1ol1LJtJPSrbSrI/NG9T1xiTHT7FgqDQTXeMgdSB09vYJBvqX8
         ajGV43rcUDsKGrfLWFt6cgpsw90E7oYxSWUcFtReoE5jVcGQN7uN+5Mw/u1VTVoauV9k
         pyca66ASdTLLnyqAaj3duF/7Ivjm22qqJyD1XnPjoslZ9w1Vi/KJ+xL9saTXE1sn2XUY
         UVYQ0wCo7DX6DJ/xJZbEccuDTbRsCKiiOq9hxSaKuEKZXnzLsP/BEMArxit525d2WCWt
         lq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778166800; x=1778771600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5/L4+rAdBKl1Eds7sZ3hL+bakZfSB/FndDJYiGTtkV8=;
        b=kevFrtpwMaV7T6M6mSplM8tyYEz9MV2Di4O9x5BxvHFjHborD7X57nIb61J3BCUsKV
         OrOyOmtFGFBKKKUMrqVhWiqQcmiil22Hq0OZqlHoh+E8wwLaGCyNtqzcdmZrSMyFzT7i
         R5sNML1SQ6e6kFIqAYgZkj1cw/6e85aa86oYGhbkAtg2tZ6j+k3PMpUf3Z3zg1nIUGIP
         eNGR2Xl3gjEEyVjbBSBiuRQP+FABlIs18z1Z/szrgl+ik38VnOD89DZAmkPmbwv91avr
         B93tkVCxoD/3Usww6JQm9Fj0l/6sUKa9xkNWFgocOsaZrA+No87RR4VdaI3xKunyyrkW
         s3BA==
X-Gm-Message-State: AOJu0YxHpeGucBSMXso1P9KThjLwrySXbOhJAkAdUSjqjm3cUCwRGZ7R
	xSjV3X8/h9ljMHtIxpScpYlnJdtPv0/smSZmhVYDoP9hDUAxf4aGsRtP83e9hctX
X-Gm-Gg: AeBDievDrvb5NnmJAk5nJDrfBX7fs3CJWu1SJFyIXvtcJlAL6GfxMBV6j7xl1TzIOI+
	d5JPkcXFv1d5WHBEVy+TdvnaOhmMla3gu9WblBXR7OmxQj5S+VssJrewQ6wqxo5RgR04lnjYjWj
	d3rTc9uWEKSfD82gb/NtxpBGnDpkBfPvrqGMp963iYwuwJYvUuebTIeYqb1hsX3XcdsjawlfH9r
	7OqkE3PcLKxdbN+vpVTQRmCjsRj0Rd0XgtksUbM71epenn5FqzfNZXgo+CEy4YunG0yZ5vy09Vy
	Dnt1LaE6zZXZTXl9mi32Rj13PWB9LcAQ5Sa+JpNDngqZ6FkqcZ/njJDJf9AcJ6uSMhOeMW2C32I
	0wUVe1IL2/WU/tveK2BPryvPwK6caB3/Su6sm8ndt7v/I2FoBr3JIaNlGclPDg4Yc2wznLvQCFO
	tXWzfTDrBstTXIr3bHfiBIXIUcJ3rXkkkFmCeQQpf5FARtf5qnu2tuD5jUFdTprdgEfpr+x06KV
	26rXlozvLEVEFfTOQNxkmp6KPzv
X-Received: by 2002:a05:6122:4b18:b0:575:360e:600a with SMTP id 71dfb90a1353d-575595a9b23mr4796616e0c.8.1778166800208;
        Thu, 07 May 2026 08:13:20 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95d0ac3217dsm7912156241.3.2026.05.07.08.13.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:13:19 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/2] Bluetooth: MGMT: Add SCI setting bit(25)
Date: Thu,  7 May 2026 11:13:09 -0400
Message-ID: <20260507151309.145613-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507151309.145613-1-luiz.dentz@gmail.com>
References: <20260507151309.145613-1-luiz.dentz@gmail.com>
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

