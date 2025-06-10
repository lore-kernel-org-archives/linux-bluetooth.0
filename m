Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231BD23506A
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568303; cv=none; b=mycPr7XJGaGqtPwVjdzq3aVVIsVAZQIpZ45BLYBWelCaKujkqN6LLN105PjNaWMDLAS3NdutHAsbMFpS2u0lp0KINO6w+ItQv2Aj1jMlt98Uz7HWozsPpwvN3kSFwfuPH+jbq141THNDU7jfkNMJSQhKoGfRc74qayYVHGBdh4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568303; c=relaxed/simple;
	bh=ZGB5/ZHBPZVq6+s40kz3AjcV02ecxTnMz4YXCqbE/+0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ARxaYBWXp1lkU+gBF+UI8ZULxUHSznCIPUO0wWTV6SKURsV71NVO76NO4jsBd8RCIzVL+1L1LdIp87dUiT4pNWF2gfQbFsP/jVLoqlqSXY1DKEmTMIUlVP7wCnOCvp2Ibdeu+wBS5tIJrkMUu8e4h6zTdrr3o58J2dwPvhcKap4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cK61mRTO; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cK61mRTO"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5311c549351so157782e0c.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 08:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749568300; x=1750173100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xK55lX6wQjpY0G/7TIjKaopwioQXptL7w2UYKYrrTHs=;
        b=cK61mRTOUM57rOh7lnFenZ+a8ge1GnmNxlsjHos0+gYPnGqcGyriYoFZ0y5YFt4FDh
         +ZHWHq6fPgem1OAp0UL73pkhJFPOnB6kk0yEvVKY7jp9AOxPW3pAjVvgnBXBGI3QfeF0
         VtpSP2tjFYNwaeJM1qT+O+sLL+XjsNA4SKfJHGtIAaqROjAwEyGMNVzlKl5XMqV2a0cA
         Y1V1iuiSq2MNZgJkCnNqS4rLWT07Sx+oKcPsSK4ku6CTgBsKD91Vj0Kc5uksLh01nE2D
         xoDzB2Bl8Hg0Mk4K68OKQTztefNUx8wfrbFAaLbXWqzKX2YUn7wXDQ4/QGvSnOdzi5jS
         HmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749568300; x=1750173100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xK55lX6wQjpY0G/7TIjKaopwioQXptL7w2UYKYrrTHs=;
        b=RhyKq8IpcRbFnliUMDSbDQOGAHjPGM9RvMj2sAr6pIRbV72eXjKFVJwuEzTs9EgRWT
         A0Jp477k3GEvTUwZk7akZiJlrTfpV5P+612VMYxy6gIn3sZJhDWowSvPSrQMh0VBf3i3
         RHsMMjxgqUmxSW8qPGMacGd0W1Zek7AA59lVKluWPPXRZb4ma0V92wQh9ndIX6UECrTr
         rrskpmwssoQPfFIDMVFMYVr8cVbFkDMpm8aenBP+ryKnSugiiCl4fDxoUBapGd6eH0eY
         bKHGv0qIUMfpwh42MxSDKoztpXFFnflIt3EleTbppoT2R3ctOOuGSyDxOnzawDihCru7
         pJtA==
X-Gm-Message-State: AOJu0YxyeSgm6AYXmVNMFGRcSBijxZC3VwvbKwUrS6San7wK3gMVCmzP
	2y2iuxaxCZqWoI1k0vZjinDuUEjoDwoIDoBmi0uYe+sstF2qXQQDzpDRq7WmIQ==
X-Gm-Gg: ASbGnctTNuBJPv7dr7cbVfnviDHL4AVLk919DEaggV9f/kwHU9UHspE4hxP7uP82Q9p
	KsRERcwYqes53Vt6MgTKXQefhmtvTQx2qNJKEz2Tfq6QKD6GZjtjBZEQlmyQOxvAru5CSN7A/Fr
	6MWulWUlTv/yOCoWihthb0p8xkqeMjj5nWA3zO/WF1Teet7R3fHIiRLtoZabja/qv/+H1mxC6JC
	7hwTmaaVZz2V4yOz/wySd9bDtbOeIz//D3ntPuIqfevx5wTZZVcgHjdwAirgcWTZj4ZFtZSI/Dy
	oliWq2Ul0OzXHeE++EBHMKvN8qDcCskBXVDrawqz7wVp2kdGDCox8JYPFlx1wgqdU3Iu7FAIEof
	BP1SOnutUYxaqR6v1SWeZ5sqqSZGKX4Y=
X-Google-Smtp-Source: AGHT+IGsLCkK6dXV1mDInGK5K0fGOKI+xE2vj/qCqtcFJBBmLQOUK9IfKJxWOp+1qQ6G64Uc1bQMPg==
X-Received: by 2002:a05:6122:506:b0:530:6dc2:ba90 with SMTP id 71dfb90a1353d-530e47ae80fmr16303596e0c.2.1749568300229;
        Tue, 10 Jun 2025 08:11:40 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5311e245dd8sm520897e0c.34.2025.06.10.08.11.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 08:11:39 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] btdev: Fix not setting sid on BT_HCI_EVT_LE_PA_SYNC_ESTABLISHED
Date: Tue, 10 Jun 2025 11:11:37 -0400
Message-ID: <20250610151138.1093270-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The event BT_HCI_EVT_LE_PA_SYNC_ESTABLISHED shall set the SID accourding
to the value set in the periodic advertisement it is synchronized since
the kernel will use that to complete the connection and notify the
socket.
---
 emulator/btdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 2c62dc711d98..555f55e52772 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5479,6 +5479,7 @@ static void le_pa_sync_estabilished(struct btdev *dev, struct btdev *remote,
 	per_adv->sync_handle = sync_handle;
 
 	ev.handle = cpu_to_le16(per_adv->sync_handle);
+	ev.sid = per_adv->sid;
 	ev.addr_type = per_adv->addr_type;
 	memcpy(ev.addr, per_adv->addr, sizeof(ev.addr));
 	ev.phy = 0x01;
-- 
2.49.0

