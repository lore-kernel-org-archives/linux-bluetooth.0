Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115BE3ED136
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2026 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688208; cv=none; b=OKfXCg6sHeHISKEaKjJAyphMdmKARepJEyQC1Tlcb2rUEF1EQPI05vx28jY6iAPC80OxwjNeJiRBPdEujLcjV0a6+oP0uGV/zlOrTfMUsj/4RqkisrbJusEL8QZubF41vitvPLn1ovju/uO9dZQAjCeA8LLunzB0C4eH03npi5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688208; c=relaxed/simple;
	bh=GVb0ztjOUXWnrH5NexARCwkrEFPZVrjoVppR3xf+STc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U44doR8aGebc5IOhW8l7HFZcFpmmMC8IxwrkLuCCreSmyM+ma4vse+/IXlb42XTzhtwZGRipEPglzDMbNoydJlFLgB/yQ/f4rBa4s76mTVSG/f6jScZeIzod9/QT4jxA0agWdilh5UXTEW+gFSrNCxcU9cFY63xcu4A2wsnHDBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzy449kX; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzy449kX"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5674d8be45eso1885966e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2026 12:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773688206; x=1774293006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BQimjbrXgpkN01+pztM5a7uiBs+raarAuuNJUaUsAFM=;
        b=dzy449kXxP9BDG+JbQdn0l9SLkKJkFi7ZJ03SnEMFYRC0lA4qtSGY7UKsCQZCX3fAp
         E1taCEROIEYkxDFi5i+SQX8VDg07CmltDFXc+M4JF9ZKlLUffnddlBYl6UImd/CGt8kf
         lY0Colps3lRdb1QAC5OluHFi98pBiJbXoGVA/MWmydvOybKKzljsiit5o6kjZetBgbAm
         O5XdwmEhEg5OJD82TUzmst816bhAVYzvmULrU5Gm6GVS/Z+AMIj9YSHedOJ8SwTr8CzU
         cSX6EdMDiNLXy7uRipZDBA3yJ0OniEa71RUhgewu9esu77ppKeFTqa6vzTL0uq+3JkmU
         BlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773688206; x=1774293006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BQimjbrXgpkN01+pztM5a7uiBs+raarAuuNJUaUsAFM=;
        b=F9z9T09F0K7pvgKBLtksAzGtX1YqIfL6UO2xIZa4BdLtRpGs4YUcVfZ35VfaVyBUhd
         vZr5XPSjoCQe2Ld9UbykmO3V8W52gLnekWdQjqNoKqm662NViis+pMioqlVJWxtL2Mr7
         kY2peJckLnatGrMhKpnpk6e4UXfwyGa1OehpOfiaV8HhIauFMy2jnNP7+docQWoGEfBI
         9XBn8gFlFvwHiIPs/9zk52S2kPsB35Of9WeUBI2ylxCoIZfI884VKUevGVvVR6a/K6QX
         7QaCqEbRVQGQOw2xwn0qNk6wal0IlzyzvdNtWV4fUXvjQyyCRqtFVtfjg+9ACEZgZqA8
         CJrg==
X-Gm-Message-State: AOJu0YwjS8aGvLKsThFKoPrZKhzqY6IOeU/2mBUF+i/66YlQu8x0Z3HN
	9ozeJAyiIsgV2Pl3JjToRI7GT+xl0/Y5f1SY08JteFv7wEejXRarJqo+TLH5ccJu
X-Gm-Gg: ATEYQzzSWLomt8KGzetduzk49Ectg+sSuuSjClbAGLC6eFPTh6QD+kO4JISaicU6XAe
	TKCFPEiTOmcdBPPV/DbXo89IomaqmhbIhs79qAF3hwsMRZgSyYk3naiCc5YERqmFTYziy6CzfMm
	tQ57xbDB1COUeiGpPHAkRO2nyShpZylXUHgF69NkR0Jt1TesiG4y4+qffyA2qmwAmXJXpCyGO0v
	PNm1w+m1V5Edzw7jdOpOkm2c3g+QSnXmWfMbTNvrEBFF/BCY1JtUqsxAeAwvBCRg7F/A+OEfQ42
	6XjVqD+9yx/OiWzBL12I0beh1wtXHasyocJ1IRxEQZPyY1CNSuA9C4C980Nz8llzxDvYxekHvna
	GwtS2GfFIsM4hnYnjgEkowptiGoNHvQprkrEdtlguu4Nsd3lsHJYsmRPfEn5din1UTHVdwEtkLx
	mE/MVkvAehlS8gisTgA9+VZkxdIrFKs+P0z8SM0i2mzt7WM9aN1mJbAHSSmoP4qSvqPQH1a0Uwd
	ZIFP9/ubnxdCn33+3GMJ5VcKAiU
X-Received: by 2002:a05:6122:1d91:b0:56a:f979:a9d1 with SMTP id 71dfb90a1353d-56b627e7ec6mr5188039e0c.1.1773688205644;
        Mon, 16 Mar 2026 12:10:05 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b6bb4191fsm4695082e0c.1.2026.03.16.12.10.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 12:10:05 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 2/2] Bluetooth: MGMT: Fix dangling pointer on mgmt_add_adv_patterns_monitor_complete
Date: Mon, 16 Mar 2026 15:09:57 -0400
Message-ID: <20260316190957.8433-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316190957.8433-1-luiz.dentz@gmail.com>
References: <20260316190957.8433-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the condition checking so mgmt_pending_valid is executed
whenever status != -ECANCELED otherwise Calling mgmt_pending_free(cmd)
would kfree(cmd) without unlinking it from the list first, leaving a
dangling pointer. Any subsequent list traversal (e.g.,
mgmt_pending_foreach during __mgmt_power_off, or another
mgmt_pending_valid call) would dereference freed memory.

Fixes: 302a1f674c00 ("Bluetooth: MGMT: Fix possible UAFs")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d52238ce6a9a..e5f9287fb826 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5355,7 +5355,7 @@ static void mgmt_add_adv_patterns_monitor_complete(struct hci_dev *hdev,
 	 * hci_adv_monitors_clear is about to be called which will take care of
 	 * freeing the adv_monitor instances.
 	 */
-	if (status == -ECANCELED && !mgmt_pending_valid(hdev, cmd))
+	if (status == -ECANCELED || !mgmt_pending_valid(hdev, cmd))
 		return;
 
 	monitor = cmd->user_data;
-- 
2.53.0

