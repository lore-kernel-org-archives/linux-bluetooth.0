Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D5D33B6E5
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 18:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541683; cv=none; b=mCOnhFFCXeMqcUQAKfu8Wc2FFS3ZyudLnDV+fEd+AqLEcHYMqJmVl1mi6YRI9OLX6tVmqFMu+nkpejXqc3+2+o6nFcqNl4oNqJO4wyySxkpqhCVLDEn98itTgpfbqSFUs+l8lqn/H1NytneklO4Mh0k03tLY/LqPvK/NgstFjqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541683; c=relaxed/simple;
	bh=DG+c2Qw1jNVhq1iCptbyCXmKLE9rwxtdYJbk898FRIk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=luNdD45J2Zu++nT5vu56Yywv5yZJT4OSj5LMzQnIJQCpitCxyOA9Ek6UENGXbNlEo8G93C2iZ5/epMdDwBmdgdDoz6gxE6dw6+AU678aaMjazSHCiVxEUPRROR23ch85h5Qqn76YVvMtQHoDKyaByC0nfyrBg6ZJxHdxUZpjw88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGbRHfBH; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGbRHfBH"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5d967b67003so908973137.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Nov 2025 10:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541680; x=1763146480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=50Yh4jxDHddAk/15E0afA7sOItSkvbFPvA9kA8LS0fY=;
        b=FGbRHfBHq6KYBpyCh9U+DslPTwhKvNbum82MHGy6M4b9KBPgbCq7YcpVK1gouTXl+Y
         7DwrOi+eFC4ICFRhMKtN8IkfLdIO/gS1H9pNVXGdckMRczAma41ki7v/bS1T66X25YZF
         6rMo0bOZTsQFjHMABJa+sow55r4VioEeCeUzt1lDcSsDheWCCyzzCuecJIfTKOL2Xvta
         RvRSogyA5nGFPhiKky1lAYZIxLOI42U+abElgMBDSaRLk0TN6jfYiI33Bw+yHjQWvQAs
         0yikAF+J8zzlmcrEIPa5vsWxvJfmLgRb3/v7wKHDLkld3Zxrl6voYhk1NYPfX+TzUhNr
         knkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541680; x=1763146480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50Yh4jxDHddAk/15E0afA7sOItSkvbFPvA9kA8LS0fY=;
        b=F4HKGLUqNfLaojs9002rzNRCwIonUC46aliI7GsAqqqQifMYGLRC0xmXA4CKps6Xah
         IiHEIO1kMou5RsgfHk3kwZJiRXv4oWA5uo0BtPw24ssapkUAZ1bWZJYvtcSSuXzGQW0o
         O1jHlq3oi0dOhfl10elH4eI+yT9KSbv3xb11iW6tCWtJ3nAoZBY7ExwM3MhozANVqASY
         eiJAACzb3VBwb0cb4bwfLtaj3Ar0R5zXWBBQwTw35Dy7TqWGC7o3d/oGSOwquqFBiXR5
         GSvJPHMLKIP9zPB8FDi91yk/XqkMNUTfmgTSUYfylySy7cdvMCIMxLA6w9S2ZXhozq7O
         sVXg==
X-Gm-Message-State: AOJu0YyaMfEkdnc+DSIvdDOgXtxIA6N0lkkD0VfiFHiNmLyQejDKgVLM
	cwoHAK97CshiXgLtd8ONpXFa2WPLoY4xbAwo2RqmFGgiKP+EzxA6SNE6QkhzPQ==
X-Gm-Gg: ASbGncvs2u5EOkB16M2QpDxKb6umeOzKGIC5xdq70+2ws632dW55gEHoSxfb1FkTV86
	YY7d4YL/ZZ0ZC1JYmQktWCJ3NtGlXr9QvlJUuPYy3BzKrSYLZ42gTrM1rRvQwveufj+hEivtxIe
	fWPKEKZ+76U425ixsi8arokk8tIm1iJxpgWlAfiEnVNFrpXyvce/WZ0YVw6vhb4AXfV8MAsme/F
	YhZ9p3XLD8llfXqbWxQvc6sRMM3Kr5IjHPZs0hH65K0jHAoBcK4j5JOjzgMQtyoSKgsSew3UCyh
	MrxyJNuh+QpwnNge6dkOWhhDLI2ondFAeBhfCufkmcgggReehE86C98DDMW8i1BH3cJX+8PlsL9
	MzmFcjdOsUe4mYhbf/JTZ1RXWM/F9+mvUey+3/+OmXrvanpDU1vn2WphZRuffFAATHESQKmJIRh
	77+I7Qb8BOyFrvxQ==
X-Google-Smtp-Source: AGHT+IEgjxHBaVg3iP6J6x5tczBvo1AXCR+3U/QCdvKdzCmZkoXjcxByL7PR/obusW2qko9Zvg/UUg==
X-Received: by 2002:a05:6102:3713:b0:5db:f424:5b9f with SMTP id ada2fe7eead31-5ddc4751fa8mr250232137.25.1762541680055;
        Fri, 07 Nov 2025 10:54:40 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93708522abcsm2738698241.0.2025.11.07.10.54.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:54:39 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/5] emulator: Generate PA Sync Lost
Date: Fri,  7 Nov 2025 13:54:24 -0500
Message-ID: <20251107185428.1161318-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.1
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
2.51.1

