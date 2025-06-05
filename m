Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3701ACED1
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jun 2025 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749137004; cv=none; b=e5HWEdkdrUfbqilaKk0fxfkRaCX6ZkLWXKdHBeVDSM7jqANb+2qM+hGyLzUIRm6UiOD/78MtgN3mIn6EHoMtANVpNxEuWZNFfWyYXiD0OxPVvsEjMheMFu/taPp9rzLDSu1oSJSYM0vWRtrmj+saRVt6cmw7sIY0uVDTfFha56U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749137004; c=relaxed/simple;
	bh=1sXVytO4AgmvvW3FXHX6AiP+MXqIXqXOyqpOcxD4wps=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSbm3X8Axz1ZL0gAUECYn90R1VmLr7LuuP8ekPiqKz7Rb6LQ2O/xKzZBO4tNtdUrOY+U8o0kvJCmtXAYV9TB8AhIGIJaGHZHI/LvbVFBgS4sixLKEI4Np3c/T7RKImFpozX5ECC2eygp0EmgzbAi+p3ciFfucn+qNpbMZm2lSRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNHFmdFJ; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNHFmdFJ"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7cd0a7b672bso81313085a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Jun 2025 08:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749137001; x=1749741801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YXtR5IH4CZVEeszZdxWCc9TBQY7TQNNdMZJJvY4yULw=;
        b=KNHFmdFJiJmcxybyBkwSh8EKVZnaDltOFVGt3ozxA3ioxC82d2BbZlRYxA67d1YP6i
         Set4Ez29ZEOfDgYhx2ztI+q37Idq7gdF1OACMpH3jXu9KU2fiYO3tkqIjWPHnPO0g890
         PkWynn8i/zYFCzftZosrwGZF7YrGe5H1Lx4zpylnXt6CSXKppm3Scm9B/q5uhuDKfC8d
         J1ms+lENxMfxxDIRjWRwfdQYS+go+000VKu8OG82uJtiSnpcj4Gz5mpGSi91xMEvvL1Y
         hJ/TW7b5Rqe+DavGYmv7xEn/nJM3ZFdG+Go8gF6JXeJkttPJxkmwTq+t2NSB+jqQVFsj
         0fWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749137001; x=1749741801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXtR5IH4CZVEeszZdxWCc9TBQY7TQNNdMZJJvY4yULw=;
        b=Z2dkpGP6rBwgdhvkmM1qJ25DR8BGn5DUub6vllpK4uj7qnDGVcxpcOMTdRymSenFNw
         kQSrXpJlmr+lmhgf8SsP2ytg1p9xzBG+i2xKZtLqG4j0Dgru2fZCNKcAp70hUvP1HVeP
         twmOif/JoY/i/ESM2pUK+JuxyWIJK7FMVpXAst5hNGOo4ORll6uru9JsDpeOfAuQ9Cjd
         EEi728EV4gQtagx/q0hSYvq8eMX4t6fxuDItJ25ya2FQDsKUElsw1WPpHZUNPIqx/OLs
         17deOm3c3+Lys/Wj0weefw2yq/MYSvmPN+7J8sowrur1XmRRfqHc8uqsQmj5R+E+Wx0M
         p92g==
X-Gm-Message-State: AOJu0YwqVhgLl+K/xW2ymC9jpSBA7rfVvIRTL9cEpvykrxlv6CsP/83F
	6nUvxNO8/1TCXzAuOHYuZtusooNi9EIWGpMldheqGf2M8BmT1YMoFx/+ksQMdMt3pr8=
X-Gm-Gg: ASbGncsX6TRiduSB2e20SClmtX66N+/0Z2Z6GO1n4nTOEBFpc2Qek038YTmEe9Ir4t0
	pyQE8/Oo4FkOFMjsANOkC/Lp1HZXjhqTqfsrzSnrRxmNP51pKYmc9RfMw0SjCTkIG+ZMUsc3jAO
	s4znR4eRqlQOgqj21nIGg4SMTLOSKCAC67FqMpB1CT+odqK8ohL2AKSONXrHFrMID2NAqB6OgCp
	36hjYo04lsdhiC9su/VLVOALE1+6GfkeUDR5fJ0ysvzZoQfoBTREKKuAgcbyfhkiXeFBjPIr/ig
	6KQJD2/jt2QqhiHBBkzKNP6MF0htgdqqWlOlbowiSK7hzsPdbxWWISeeQpyqmAWDUfTQZq/GXMp
	HQFDYHYC6hizGH/M6CtVb
X-Google-Smtp-Source: AGHT+IHeMBef17GieO/WBu2pzMF4n4JZfriIiswuVSdYUJ9YrrrXC/ebcKMWT05LWT4Z6ccDqrLC9w==
X-Received: by 2002:a05:620a:2a05:b0:7c5:e2a0:4e64 with SMTP id af79cd13be357-7d2198e1b63mr1047389585a.51.1749137000600;
        Thu, 05 Jun 2025 08:23:20 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87ea70e5ac1sm2295592241.17.2025.06.05.08.23.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 08:23:19 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 2/2] Bluetooth: hci_sync: Fix broadcast/PA when using an existing instance
Date: Thu,  5 Jun 2025 11:23:16 -0400
Message-ID: <20250605152316.807664-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605152316.807664-1-luiz.dentz@gmail.com>
References: <20250605152316.807664-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When using and existing adv_info instance for broadcast source it
needs to be updated to periodic first before it can be reused, also in
case the existing instance already have data hci_set_adv_instance_data
cannot be used directly since it would overwrite the existing data so
this reappend the original data after the Broadcast ID, if one was
generated.

Link: https://github.com/bluez/bluez/issues/1117
Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 62d1ff951ebe..54140f4acdb0 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1559,7 +1559,8 @@ static int hci_enable_per_advertising_sync(struct hci_dev *hdev, u8 instance)
 static int hci_adv_bcast_annoucement(struct hci_dev *hdev, struct adv_info *adv)
 {
 	u8 bid[3];
-	u8 ad[4 + 3];
+	u8 ad[HCI_MAX_EXT_AD_LENGTH];
+	u8 len;
 
 	/* Skip if NULL adv as instance 0x00 is used for general purpose
 	 * advertising so it cannot used for the likes of Broadcast Announcement
@@ -1585,7 +1586,8 @@ static int hci_adv_bcast_annoucement(struct hci_dev *hdev, struct adv_info *adv)
 
 	/* Generate Broadcast ID */
 	get_random_bytes(bid, sizeof(bid));
-	eir_append_service_data(ad, 0, 0x1852, bid, sizeof(bid));
+	len = eir_append_service_data(ad, 0, 0x1852, bid, sizeof(bid));
+	memcpy(ad + len, adv->adv_data, adv->adv_data_len);
 	hci_set_adv_instance_data(hdev, adv->instance, sizeof(ad), ad, 0, NULL);
 
 	return hci_update_adv_data_sync(hdev, adv->instance);
@@ -1603,8 +1605,15 @@ int hci_start_per_adv_sync(struct hci_dev *hdev, u8 instance, u8 data_len,
 
 	if (instance) {
 		adv = hci_find_adv_instance(hdev, instance);
-		/* Create an instance if that could not be found */
-		if (!adv) {
+		if (adv) {
+			/* Turn it into periodic advertising */
+			adv->periodic = true;
+			adv->per_adv_data_len = data_len;
+			if (data)
+				memcpy(adv->per_adv_data, data, data_len);
+			adv->flags = flags;
+		} else if (!adv) {
+			/* Create an instance if that could not be found */
 			adv = hci_add_per_instance(hdev, instance, flags,
 						   data_len, data,
 						   sync_interval,
-- 
2.49.0

