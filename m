Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8542DF14D
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Nov 2025 23:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470543; cv=none; b=gi4QhomAB8Jx2rY/LodSh+K5VANOCEGowU3tWgIulgiKpD6RO8xXOifOjC+0xjGHL+OCxRtAQarcSFmJt05N1ynt7oWlz5NHVZCfL41tgSwXlzCYDKWEbf5118a8J1tSXytc4i3JXA8ujag/WQJwf2elnjEoPo1tAPTkFZbQViM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470543; c=relaxed/simple;
	bh=nrZ2+sfM/8mvq8UhVfAiALAxd50FrWPZ5wfNbVv9Yn8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FZosROSshFZntc7eB0jG63ZWQVOQZOOaQEuAbl/GT6/9xtRWUHqs5nXjySGouDIA0V2zZ5g3YHipwzuS9elu20fZ8LHus2bgPz9d8hmYW2Dm6EiJ2yYpy5tZRpFTT2I9QTfylPmixC9R3MhBK17JyGTrAcPFJU/E1EV1W6CyDXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAGvweAw; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAGvweAw"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5599688d06dso54248e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Nov 2025 15:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762470539; x=1763075339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AceIl1v7YDj7rIDNCY4H3px5jYYlGCXc5A8cJ+biyWo=;
        b=JAGvweAwgR5eO3r4BQMvvaB/Kk+JOJ3Gmmel53UNryu7JSyki7VMWq7YvvYod16Ofu
         hAe+4yqDtZqiBjqSgF7GZCxMuKCuHUKUmC+wLnH4rgn0nyy4ka8cYvSxRXK3Y70gEj8X
         +C1FMCpDZOdwbzLs7/21sv9HqggA5NnQQLQGN//nQdopk9MVEiq7VoNTG6onC5OSUnwW
         TcIFGt8yIf0EdzXT/hPe7vB83baGfN18SWdj3NLxE17mqd9n7/YNv1SddDDgqUZvJSav
         UhwW7e8JSJt8tOAU0ofqipmCHuRi5zCy+DAH16bTrUK+RVNtcZQ5TRjRPM0L++0t9f2F
         VBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762470539; x=1763075339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AceIl1v7YDj7rIDNCY4H3px5jYYlGCXc5A8cJ+biyWo=;
        b=NzEC7xuXAEbD2yyCovBX5AuKNSxjMzSzcLCY6F5HSfV0il2riOgqzJcPBUcLGYL9rc
         kllMTY/BzMDVe0tajUrZ/KtTOTO9rYzTGheXmBw3e4xGbvpWrIvT8Ejho8ekGI9i7ApE
         alpZbotj15PwBmSppfJKEv3DYdGcqeNVBpEMbgRzxeQaDKzwbrL1LLrtTfZ0zshGdiU/
         7bwbK/66rJHV9LrGgPWHJgBUKBAJMOD7H64DewVfXfbsiqx0rH1T1aN7i3azXcIdlB6T
         ND+wHmZC1UXojcYqUePetkNV1XjU6GLsFr3zRaCLD+b1RZjqq4Hf++mUIBNGqMbOPUjp
         vuCw==
X-Gm-Message-State: AOJu0YwYthkepGIPxiiOBP/NDu5l7/e7WtjSVYlyE+MNMllJvHL1IvAs
	naVavSbq0gXWzqxGLqWPBVpg388a4pK/wC1psbrehU00crIifJdGz8hNxiMyZw==
X-Gm-Gg: ASbGnctMRU0k/bp7gN4l17RWzgbEDGvlG3Gx7sUbzoDcociuVfp2xEni+XEEcKmDY1z
	reugFYUADS+LSkh8p1ROEr+vLli4pQ6skP6oE3XVj1gfv07ToXOVz9AnaUrVpyZoT9X3feDvN91
	eV9PofOEezd+rvZgrvPLmfTtAMO5HKCb1Ka+jopjDUuzSwZ/YBQ5PsS5gDfP56iwQr6LN1sDlqd
	hr/QAf4mjgOAqg39/+atkgt1FIZwZ/od/y05csTQzOdSf5pfownWWSiFOLTu9xkVK3l8pWM0b1t
	YSAo6l1tiZIE/DvMO1kvZHhovoh+eZWEDbXKqRCOmF4JrJwlP10RnHCmv8ftL5odNzGVom4VmDH
	/0/O2IjsRVcW4yOmmAXS+RhTWzOBVjRW/LU0UZN7SuIvHaPOmJvXrdw9tGBl1T5lq3dllLxfoxB
	zKZghzIkJzokp7bQ==
X-Google-Smtp-Source: AGHT+IFmzPtgYf9yxU6c4IltXR/cw7Vcq6NXcTACt06cdh0hB+j58C3J/zZt1fkcqgZmjkrl1KGlZw==
X-Received: by 2002:a05:6122:2a12:b0:559:5dbe:fe12 with SMTP id 71dfb90a1353d-559a3c01342mr590069e0c.14.1762470539214;
        Thu, 06 Nov 2025 15:08:59 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55995863f11sm2129873e0c.24.2025.11.06.15.08.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 15:08:57 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] emulator: Generate PA Sync Lost
Date: Thu,  6 Nov 2025 18:08:48 -0500
Message-ID: <20251106230848.876764-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to generate a PA Sync Lost whenever a PA is disabled and
there is a remote synced to it.
---
 emulator/btdev.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 839b4941ca05..c133248b2c7d 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -116,10 +116,12 @@ struct le_ext_adv {
 
 struct le_per_adv {
 	struct btdev *dev;
+	struct btdev *remote;
 	uint8_t addr_type;
 	uint8_t addr[6];
 	uint8_t sid;
 	uint16_t sync_handle;
+	struct queue *syncs;
 };
 
 struct le_big {
@@ -5514,6 +5516,7 @@ static void le_pa_sync_estabilished(struct btdev *dev, struct btdev *remote,
 		sync_handle++;
 
 	per_adv->sync_handle = sync_handle;
+	per_adv->remote = remote;
 
 	ev.handle = cpu_to_le16(per_adv->sync_handle);
 	ev.sid = per_adv->sid;
@@ -5527,6 +5530,24 @@ static void le_pa_sync_estabilished(struct btdev *dev, struct btdev *remote,
 	send_pa(dev, remote, 0, per_adv->sync_handle);
 }
 
+static void le_pa_sync_lost(struct le_per_adv *pa)
+{
+	struct bt_hci_evt_le_per_sync_lost ev;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.handle = cpu_to_le16(pa->sync_handle);
+	le_meta_event(pa->dev, BT_HCI_EVT_LE_PA_SYNC_LOST, &ev, sizeof(ev));
+	free(pa);
+}
+
+static bool match_remote(const void *data, const void *match_data)
+{
+	const struct le_per_adv *pa = data;
+	const struct btdev *remote = match_data;
+
+	return pa->remote == remote;
+}
+
 static int cmd_set_pa_enable(struct btdev *dev, const void *data, uint8_t len)
 {
 	const struct bt_hci_cmd_le_set_pa_enable *cmd = data;
@@ -5554,6 +5575,14 @@ static int cmd_set_pa_enable(struct btdev *dev, const void *data, uint8_t len)
 			UINT_TO_PTR(INV_HANDLE)))
 			le_pa_sync_estabilished(remote, dev,
 							BT_HCI_ERR_SUCCESS);
+		else if (!remote->le_pa_enable) {
+			struct le_per_adv *pa;
+
+			pa = queue_remove_if(remote->le_per_adv, match_remote,
+						dev);
+			if (pa)
+				le_pa_sync_lost(pa);
+		}
 	}
 
 	return 0;
-- 
2.51.0

