Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5D4332EB1
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 19:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778096525; cv=none; b=YEkNx6esto/B5HgdXpjudGrVhi3fBTir7ug+F5wC3uTxt/Ej/bJ9NGY8J1xe9a6+DfsidiwVgxqCg20t8L1sv3h7Rpe4z52u1Q6uCYRayGm/QmZlSJ4ocigexCIuwlavHTi43sXOPrNjMmI4TxlttJV3PURnhSk/4TDWwOXsq+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778096525; c=relaxed/simple;
	bh=YqBK64fK3KWHzXtE6DEZrZGTPZID2urMSciRmGddgO8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1yxmhkBONE7Gf9xdkn/OhTdsN9Gjb4wgAET5XzY+6yFSgB+CbbtpJS5WmaA0s5rlBRennVDfJ6DXDEMbVDWWOnTLAMS2jWN3kXTa5O893ihM0EnpDXBSRGnIoz9KfRs96n7Q31cqbPrknCqjHY++00FdaohskVXEgU7y4G2r5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pSgsCLtx; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pSgsCLtx"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-95d0476492eso11606241.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2026 12:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778096523; x=1778701323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/KnxhcxJSw4uTbkshHAWOk8X5O9ty6vG50N0HMgubvE=;
        b=pSgsCLtxdz/+GZ/kinwQIEAFIjCmWrnFkvvM9rs4O27LTZfPTtlVTZ52XFf+1jbHg4
         tdcmVB8vyta9VnYpsA0IZ/uD+j+99MVumt5OX33kIEJFGdhirUwF6kHbLyzyEmFxyX1j
         YT6ORiFVYgPzZKfoLgRPfmO5iuwfzoGjEHRZyhxnHtjy5ESO0ESaF+SfIqG3RTq1zuvr
         dOdnDw7FDzQWHeZsztWPkpG85HmdS7+ECRz8nmPNkOcnKCRoOrGapk9yIIK7eLDvV+oG
         Sp1Y1JV+u4JBeeHpE1oGJkCxqh6yzrJx9Z7VdB/RaWQ8h5jMH0xxTW/qvssUBGreYhoP
         RJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778096523; x=1778701323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/KnxhcxJSw4uTbkshHAWOk8X5O9ty6vG50N0HMgubvE=;
        b=ihumg1XPoVl5HWHfqKwiSQAcnFc1LOBTa3ClDva0VLF/jrDySdPTt48PLEWlKuHGVF
         bpJvCPQuInaU4k3m4H+6CKHx4iyTV2JBxQ71Lltf2O2lvIMM2LKFgN9z8nXpgtL5afUz
         aG6i4J9Bbnqg3OYu81NY1Vb4bEv5j0/L6ikZQKpZj6awQEFU33u1qYY8pr5+syviT2qZ
         gC9LIUJDYwr+GKCtTROtWcSipy/9E5mVO/Xkr9W0KFv36pOyHnrb77ltGqRzwDakeOnS
         OPEvJtPszKMWigjZFMo5g/6UHYWjDz3SeZEZndFuJk2l9aj30k64nVwcJtVm7w//mFm5
         +1ow==
X-Gm-Message-State: AOJu0Ywu/2nnga7SWeV5qUg8UNMV6ZN3olSVAjQunq+L2PSsjy2BIkYa
	1iojtYet7MRHRDXUuFMZBjC2rdtSJ4+lGJ+X0qlv2FGVt1UALu9fAvFl8pSS4WOL
X-Gm-Gg: AeBDiescb4RCfeJPscmVOVqDDQEyKXXYnWRZqX4XmC6025FcPyxz9TVnSXGFZtBUbiC
	2sx996B5NqLQKW7DhAJ2bLoHbsPK4F9PVOX54pktp9IrNlWoM65fRQKfS0VcQ0I++KD9gKDkb8R
	f8kPkElphpjH4Hz77NleiJI2HvL1nxKaLHEavUCmoJ7AW8WK2IQSO/X2/9iJq2kxR7uykdGT0A+
	xFQzoliRSTtIWqLQHQhJK8w1F4UA3gVOGwjmFnekgRgCtPA3PTkFNBa/JwviqmDOeNVy3aWj1iW
	nv4B7qah8y3l197xON27ucb8dQ42ai78Xzag4mv0ZXhiF5h2w6Wz+WWZR83GRPFYavNATH7rjUg
	ZN9THefXtoTP86U+rHJKcmDSAw1KBt7eptsJLwQlSQfXbvTD494egXIiy9NB/HZktWPAhRgFeb9
	mqmMFyWm/RE2CsaxAaqhrThYzOOJllzkDtm8EOf2TH1JqmgJKaLe9TVuXMc++NZ20U7xW2cS5dM
	SN1nf7PmWhdI9ezIp4m+D0AwCKu
X-Received: by 2002:a05:6102:d8c:b0:62f:406b:1baa with SMTP id ada2fe7eead31-630f8e218f9mr2245363137.0.1778096523033;
        Wed, 06 May 2026 12:42:03 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-62bfb14fbfasm9613805137.1.2026.05.06.12.42.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 12:42:02 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/3] emulator/hciemu: Add hciemu_new_debug/hciemu_new_num_debug
Date: Wed,  6 May 2026 15:41:49 -0400
Message-ID: <20260506194150.1701855-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506194150.1701855-1-luiz.dentz@gmail.com>
References: <20260506194150.1701855-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add new constructors that accept debug callback and user_data parameters,
setting them up immediately after allocation so errors during early
initialization (create_vhci, hciemu_client_new) are captured by the debug
output.
---
 emulator/hciemu.c | 20 +++++++++++++++++++-
 emulator/hciemu.h | 11 +++++++++--
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index 9534d82bac39..15d806a62aa6 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -396,7 +396,9 @@ static struct hciemu_client *hciemu_client_new(struct hciemu *hciemu,
 	return client;
 }
 
-struct hciemu *hciemu_new_num(enum hciemu_type type, uint8_t num)
+struct hciemu *hciemu_new_num_debug(enum hciemu_type type, uint8_t num,
+			hciemu_debug_func_t callback, void *user_data,
+			hciemu_destroy_func_t destroy)
 {
 
 	struct hciemu *hciemu;
@@ -409,6 +411,10 @@ struct hciemu *hciemu_new_num(enum hciemu_type type, uint8_t num)
 	if (!hciemu)
 		return NULL;
 
+	hciemu->debug_callback = callback;
+	hciemu->debug_destroy = destroy;
+	hciemu->debug_data = user_data;
+
 	switch (type) {
 	case HCIEMU_TYPE_BREDRLE:
 		hciemu->btdev_type = BTDEV_TYPE_BREDRLE;
@@ -465,11 +471,23 @@ struct hciemu *hciemu_new_num(enum hciemu_type type, uint8_t num)
 	return hciemu_ref(hciemu);
 }
 
+struct hciemu *hciemu_new_num(enum hciemu_type type, uint8_t num)
+{
+	return hciemu_new_num_debug(type, num, NULL, NULL, NULL);
+}
+
 struct hciemu *hciemu_new(enum hciemu_type type)
 {
 	return hciemu_new_num(type, 1);
 }
 
+struct hciemu *hciemu_new_debug(enum hciemu_type type,
+			hciemu_debug_func_t callback, void *user_data,
+			hciemu_destroy_func_t destroy)
+{
+	return hciemu_new_num_debug(type, 1, callback, user_data, destroy);
+}
+
 struct hciemu *hciemu_ref(struct hciemu *hciemu)
 {
 	if (!hciemu)
diff --git a/emulator/hciemu.h b/emulator/hciemu.h
index 1164be6510a3..e832d6350bb3 100644
--- a/emulator/hciemu.h
+++ b/emulator/hciemu.h
@@ -31,8 +31,17 @@ enum hciemu_hook_type {
 	HCIEMU_HOOK_POST_EVT,
 };
 
+typedef void (*hciemu_debug_func_t)(const char *str, void *user_data);
+typedef void (*hciemu_destroy_func_t)(void *user_data);
+
 struct hciemu *hciemu_new(enum hciemu_type type);
 struct hciemu *hciemu_new_num(enum hciemu_type type, uint8_t num);
+struct hciemu *hciemu_new_debug(enum hciemu_type type,
+			hciemu_debug_func_t callback, void *user_data,
+			hciemu_destroy_func_t destroy);
+struct hciemu *hciemu_new_num_debug(enum hciemu_type type, uint8_t num,
+			hciemu_debug_func_t callback, void *user_data,
+			hciemu_destroy_func_t destroy);
 
 struct hciemu *hciemu_ref(struct hciemu *hciemu);
 void hciemu_unref(struct hciemu *hciemu);
@@ -43,8 +52,6 @@ const uint8_t *hciemu_client_bdaddr(struct hciemu_client *client);
 bool hciemu_set_client_bdaddr(struct hciemu_client *client,
 				const uint8_t *bdaddr);
 
-typedef void (*hciemu_debug_func_t)(const char *str, void *user_data);
-typedef void (*hciemu_destroy_func_t)(void *user_data);
 bool hciemu_set_debug(struct hciemu *hciemu, hciemu_debug_func_t callback,
 			void *user_data, hciemu_destroy_func_t destroy);
 
-- 
2.53.0

