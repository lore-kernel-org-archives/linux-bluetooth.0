Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD91C2C6A4
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Feb 2024 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052249; cv=none; b=dK9otPIZPf/uf9xTiPVpMPAquMqXnoORfJXnvkxjzmb64tt+Os6lyCYQqIKkl/FNhbqYHhosdpzRNHwC6F9kiNo1WryjLInGZZeYsDwkDP0fUYP8ccUC8IdUb06NsHSg00qQMNyKJn0IOITrrbo8iCcV2siIUUcVnIw/Yt5wtQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052249; c=relaxed/simple;
	bh=wFD/0e+zYEhk/i6GEa+vOAGTQEiwvHmSoOygd75kFiM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=R1DJznCjPx3OxAZyMJkqNSpFlDPElPe3ucfejP7iksLxqMchR3DmC/wGC+PvXveMzVKsgZ9JeOfejWmHMbosd2KsWmIAVwVAy0Pl7E5Ui8B1hm/HnZ+8/Mga7unWe52952uOJDYkDEUhYS35vabWUkagEPFJPtoIfFSlxqz/BE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drf7Oubd; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drf7Oubd"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-470446f19cfso674336137.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Feb 2024 08:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709052245; x=1709657045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oSV8qVBZIYT8/RnPIXC7e6ul1BVe73ZSzmIdXj0MKiI=;
        b=drf7OubdC8lrRNHYcEpMqIwUeLXd0bkv/dIx8NGuofvPNQ9yVWCjcErUzh60ph9mmJ
         Gp8mn32pvVpY9dfzeAl/Pd/KQrONdKEEmOZqsoUYKy4xn88JCIxYc7wSzaomfBbSdet/
         z1+cIwiwade4jss1I2Ra0RD08IUKxz3L7YcM/rWlchVT3YCBz/26Atn+M9Mqzjdukscr
         RrAAIn/hYiI96NO2b4WrrWPiOPTqA4+vQnBxBIhwy81x4tO+LFGXvHWGPj7XwdSPpEg/
         klTNcSQJlfjyHPn1NMr0EgQ0ntSg3h/mBRQrt7yBQe3fP1ayBCl7jBQcnUyLryQ6Esx1
         RfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709052245; x=1709657045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oSV8qVBZIYT8/RnPIXC7e6ul1BVe73ZSzmIdXj0MKiI=;
        b=Q3y0j1aCfbRdMU72sJ/kJnofHFyz8qNyrToZAJyoCa6GE7haFm8QX5V7Ckn5/6p2FO
         j423p2h17JVqSQSlU/Z2Q4pZTfMAN4+BcqGIENglOip/nORhd33hIv1g30wZYMm6CYTA
         JOW+obROK0FyzvCIB2d1TSy8RIF2vGq2OofkwHLInMwDphWw9N1cetXrMx73u3b3ftfC
         kpLu/3UoQpjjtr7uj6sYzmgTj4DmEfC3XdIzbK2YprkjMcOLfDS4gTnzJO5Nf1ky7xWP
         +wAZ6ixNA8BZ9SXxBPH3skV/pKKE46q7Nd3nJF9XGYP/HeZLtbbXb7fTFVEza94/Mu98
         TN3g==
X-Gm-Message-State: AOJu0YxsSAqf/XOHWSnSrMhI63vPUMZPdfwfsg0qM8t6061vpTRsuby3
	kj4LFMfHANKqXR5W3JnCmVXO0gyUfH9ZqWHTxMYetbiaalTaHEGwF/RsNkjJ
X-Google-Smtp-Source: AGHT+IHB7sdlbJ/1VRFIthQGuaj2lrnKY3iq0BUbScJ10RpdsI0wJ7bvvEFjOn2KwYJm0VALQxpWIQ==
X-Received: by 2002:a67:fe4b:0:b0:470:5373:2389 with SMTP id m11-20020a67fe4b000000b0047053732389mr6583237vsr.0.1709052244897;
        Tue, 27 Feb 2024 08:44:04 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id j30-20020a0561023e1e00b0046d28239032sm1378126vsv.5.2024.02.27.08.44.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 08:44:04 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] btdev: Fix not resetting big_handle on HCI_Reset
Date: Tue, 27 Feb 2024 11:44:02 -0500
Message-ID: <20240227164403.1904213-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

HCI_Reset shall cleanup BIG state including if the handle has been set.
---
 emulator/btdev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 3224b73bfc31..0ad6b2793c06 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -577,6 +577,7 @@ static void btdev_reset(struct btdev *btdev)
 	btdev->le_adv_enable		= 0x00;
 	btdev->le_pa_enable		= 0x00;
 	btdev->le_pa_sync_handle	= 0x0000;
+	btdev->big_handle		= 0xff;
 
 	al_clear(btdev);
 	rl_clear(btdev);
@@ -6483,6 +6484,9 @@ static int cmd_big_term_sync(struct btdev *dev, const void *data, uint8_t len)
 	}
 
 done:
+	if (rsp.status == BT_HCI_ERR_SUCCESS)
+		dev->big_handle = 0xff;
+
 	cmd_complete(dev, BT_HCI_CMD_LE_BIG_TERM_SYNC, &rsp, sizeof(rsp));
 
 	return 0;
-- 
2.43.0

