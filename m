Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04BB18E1F
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 20:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546724; cv=none; b=Bsi6ghBftKbPIYiH6fPEV2GlrJ2v1HYnGkprbMoQ2GFLzTDlHxYXD64bFuAR6/hYRGPtXzF/EC3r2/YP/MzXgO6i0Pq9q3etAKrchFn7yS58XjWJ5yeWoL3uN0OD/vXkOE+6VlKDwCYeUodpBFZC+hTtJTy9FJ/ZAw7H8m7zbW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546724; c=relaxed/simple;
	bh=A9111DUggdPLyFnwCY/jwNUHpJUOEU64ikoeOQaXuoA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ef4sAOACrJqnjrbj8RWoBlyWzmdZAD+UIUJjlTW6JQxj555fYTlHgqFnYs+r881Efuxd+DvAdS/PKqk/evnTsjsJ78YNf9xsSE3WAjdrlsjDxgPzK3n/6XjVOF14oVMFdz2VBUPHFyVjpxfbMvxctWG7TV5msm6VWmSAxh+t1Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gScnbG4l; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gScnbG4l"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5598b58d816so772822e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Nov 2025 12:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762546721; x=1763151521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71EU8+mMCRCBas/J1N81DTG0AzQF0ZNZ6dYYexH7Wy0=;
        b=gScnbG4lhj4oU+RHtHifIMvKbeEZgjHGj7l5DhPS6WZRhXMvffeF4nvN6yQciv8FEP
         HS8g5Pey6kjA6Ym77g5yzA+0YaJ3Y68CxVhkOiisJ/06RqYzOgfoZaPa8CT5+zS+z1yi
         Zjq8cHDwinEvjwWBLk4F5ZfRAEny+aIovh8dbw9dWzOawGUE3OJiLJTbfIA1fv4G9X6e
         TgRqYar56TrNtidkKTvGz7veFLSD5Dm8anYauOu2Iyt6HpKGBO4MO1smzW0pzPxRaSOq
         vmW4YDGC7xZt6XixTFFZN7ndwlpNfsEXbuMp53yjRFp+vEBL+bPogmjKCJtnEBrNg4MM
         fThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762546721; x=1763151521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=71EU8+mMCRCBas/J1N81DTG0AzQF0ZNZ6dYYexH7Wy0=;
        b=rpFCzaIA8/A18hOYAdKR2BH2m+4lLq6S7jHQyb60nF67hNN4FSUcRW8x9cKGuLY4oW
         SocNWHnYRpD/Yk0ymY+R0KQ7vZ11dEyXT22pZYcvouVex46QoSt23g32EVVxzUB/p6xy
         dFF6ka5B12vhkbrSjfHceCFCUwlnVx120cKdKdp2pkyTha3MIEGDucyJ1HP8ULP9IJ+5
         wJ0sGmnErTkG1qn6bRbnuzR8d+wwnOpkC34gQM9HgBLYhtvTDMAKvnuF8fmndTpFf0mE
         xV2Se6qfSksJ7lcuiLzlUli0fLMOhC1D7ED+MmXGynFXj/EO6v/34m0DkUfwRCWfePdV
         vuAQ==
X-Gm-Message-State: AOJu0YydIRZaamrdgi0iGbS3jvHnmGmw3LtRssz1zQht3wDr95E3+UDf
	OmUrARLQDFROw7tF9inhCG2gsyFhTJx739vL5stjvV+iX1z+JjzrwkWZidyiRg==
X-Gm-Gg: ASbGncsnxkQ1SuMEC1aOxLe9KSWWHCx94umFCRHwayuQ80nT6cNvDhYGrZP8uJu0m+P
	T/K15/7Tlmqhi/86/X2zT62NlI1fOXb8x+ZgfKXg8Wtavr718oG2NO3EO+TVtcZ67iz79EtOv5z
	s3WbRKSa931f4tKEa45mcbarOIC087WF11MK+AmbTxwoqi1Jc6qjpfnvlVJL9IoSckyDNKTIB+c
	WolgifW7dHTGgxgtKm3V7ceHi0YAmH9VEfzdfOKVlsoi1LLneGiPXV1VswGdiIJF0auj4d4H4EX
	tfFfJgeZkWprPfG7DT8lQz3ZKHEwmx4zNxRXGq3AVF6YO2PeZj9pPFnP0nOEu8URO9nS1aIwp2k
	/N6p/nUqGmGgSKC83hmif4pM1jUfzlPQMcOxMr/2FsQV87kysi+KkspICGFetF5qkR3llwn9Brf
	rzzqM=
X-Google-Smtp-Source: AGHT+IGoFR6DVK4mv7tKBlDR0/dk3Hxvk4q9kSKDAuUyGxw5iDI4t8zo4V/rB3rWd2T/O60lAvxLGw==
X-Received: by 2002:a05:6122:4687:b0:559:6092:936c with SMTP id 71dfb90a1353d-559b32c51a6mr405946e0c.12.1762546720714;
        Fri, 07 Nov 2025 12:18:40 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5599582860asm3562921e0c.16.2025.11.07.12.18.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 12:18:38 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/5] bthost: Add support for terminating a BIG
Date: Fri,  7 Nov 2025 15:18:24 -0500
Message-ID: <20251107201827.1235953-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107201827.1235953-1-luiz.dentz@gmail.com>
References: <20251107201827.1235953-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for sending BT_HCI_CMD_LE_TERM_BIG via
bthost_terminate_big.
---
 emulator/bthost.c | 11 +++++++++++
 emulator/bthost.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index faabbaa36a4a..9f9538d0dc2c 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -3780,6 +3780,17 @@ void bthost_create_big(struct bthost *bthost, uint8_t num_bis,
 	send_command(bthost, BT_HCI_CMD_LE_CREATE_BIG, &cp, sizeof(cp));
 }
 
+void bthost_terminate_big(struct bthost *bthost, uint8_t reason)
+{
+	struct bt_hci_cmd_le_term_big cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle = 0x01;
+	cp.reason = reason;
+
+	send_command(bthost, BT_HCI_CMD_LE_TERM_BIG, &cp, sizeof(cp));
+}
+
 bool bthost_search_ext_adv_addr(struct bthost *bthost, const uint8_t *addr)
 {
 	const struct queue_entry *entry;
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 4061c0be5349..ce6bd820fefe 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -128,6 +128,7 @@ void bthost_set_pa_enable(struct bthost *bthost, uint8_t enable);
 void bthost_past_set_info(struct bthost *bthost, uint16_t handle);
 void bthost_create_big(struct bthost *bthost, uint8_t num_bis, uint8_t enc,
 				const uint8_t *bcode);
+void bthost_terminate_big(struct bthost *bthost, uint8_t reason);
 bool bthost_search_ext_adv_addr(struct bthost *bthost, const uint8_t *addr);
 
 void bthost_set_cig_params(struct bthost *bthost, uint8_t cig_id,
-- 
2.51.1

