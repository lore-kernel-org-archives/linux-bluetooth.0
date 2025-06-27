Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562F11C8610
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041900; cv=none; b=WlxcWhEKjH3iTcEz8ETm9gXdtDuxFGDhKG5XUs6uQhWRSiG6Mm7U+Ak2irzmUVyLgs8qUdZjQECiiZ6LFQFKCmx1m3ybLgd+0XKXFJOPUUkmZc/doYrAjPKjHexDJ7H2kb0dboNXPLkWdTPKeAy+Y9tzxeEydH7Wq4yglyzIYmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041900; c=relaxed/simple;
	bh=/85KL4ImGbZviomsFG+TOrThUiC2D+yWFkrcKh1Nj3M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FeUf62Hjx1cxW/H5he2qSPIs20P4UFCFvaflqPO1ch2Yqsf+0NqYnl3xqBaU2mhyv5PS5GG3bstfSjMg85m6CajW7vCfOY2jn4Y3kWFITLPKhkOcC5pXyMbF+xseBrdvBhmS4oRnwSlA+o3IzXhBVivRbgIQhP1UX57FPdK/X4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cD6ALvNd; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cD6ALvNd"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-51eb1a714bfso1387739e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 09:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751041897; x=1751646697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1tYKn0fuShqbgXr9EJoDQ0YXHZwtLE19V7iD4avubAs=;
        b=cD6ALvNd/5UTaRCYvyofmlBHM05zzeKiqk/zEBhnk1Bha7nViWbyYYAGWpZ6h5Rhkg
         FMN3y6wVJMaRQRyy6IcgOrSnCVMMH47T4gpCzv2oyBjtUke1DCsajmNSmMaDybgp3r+f
         QG/jrggkJreP6QgrZTAjmMussSg6boUdHRpwW6hY+Y29BGg6EE+MO96dgsTpYc0eCnTJ
         shnWrR/ibuu78SOpkhhyF4rBBal+JCWTh9aaAdx8tpVIRghIbJizomWOIm+/JUXmb8FZ
         PYwGH7tBMUcCsbGadP6XOs4kTWeDPO5q5q97FR2NErxIm0U5n0yh3gex8b3DnkVClROL
         yvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751041897; x=1751646697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1tYKn0fuShqbgXr9EJoDQ0YXHZwtLE19V7iD4avubAs=;
        b=NuF5mcs9ClvMEbYaXaFiM7uBLUx8LsMxmjOeyDdSIQj2QX/mUGPS75J31x266qbl6V
         t1qQwuGXpbgMHDFsDS7T4yLu8pVaMDraqz1G2QncfOU2hfxIDTaCrlpLGDzuMLvEb8nL
         O54MPlFPXQA9aRSVpADZ+pYhTEJaUNMaBRmgs1YQ1ynmLst5XXWkvTF1vLUFzNfz8Ct2
         0nvZm7praHrJY2ZW7/GSBGIKrEypFnWOzpSwEtKZpb/3cxlVzg8kBbOqpWLYm8StWSzN
         KUNeGpDZG9YO4TyGwoSPsLCo4WzikwOj6Ng/LKBuXKz9FadRq/Nbj4IjHCgA9UDEx4Vm
         k+Hg==
X-Gm-Message-State: AOJu0YzBqV6W+MxjSBzYkwHK09AO1ajJDO9ILyMocodK6ISiBZ7HTFFn
	POXu8LGuHXwmrqn/MGVVX3PalNvVwwhFSvq+c01NKiqlwdZvkPB7KwxuYeAXoOwA
X-Gm-Gg: ASbGncsGms+tgbCFRsAg5FtssZRr236ohltac5nt8oC8JEOzw8cw2RX6zKIke5KsNVR
	P/ooQzTf4a24h5ZRZz+Khumx/t5fX0JhS0ORH1OEJJOxiCTvfQJLvrNm/6YU6Mkx+Z2xnpHo+5C
	uYs83j2Q0NSkYjAMUq/3DD1tvhsiWAB671fyddEqAujgD0L1Wqo5I743luPvWADsTjgdmi4HVwr
	TYeqRKJ3Ws7j1vGRiU0mJoGCeT+5mzlUY6wULcwIdt98/SLKPVeoQJljxMoWTSUs45K/EBu8Dkq
	efpWQEeoQzSDf+gofqNoTfVC3ebae+bwQCvTjaiEiM8KC/b9RxUPDCEasnAIey20ZBTeQoXkoLn
	QTCOhdE0AJxcmP6v1FbZqFCXig8hekbU=
X-Google-Smtp-Source: AGHT+IG70kJaocvknW0DUMlnvicdHg8ANW0DNkA8mGwtoafPyIPNXXm96FzKTrp4wzSSvkzpqxDpGg==
X-Received: by 2002:a05:6122:2027:b0:531:3a00:211b with SMTP id 71dfb90a1353d-5330bfb42c1mr3448228e0c.7.1751041895391;
        Fri, 27 Jun 2025 09:31:35 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-533091f00a4sm413598e0c.37.2025.06.27.09.31.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 09:31:34 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_sync: Fix not disabling advertising instance
Date: Fri, 27 Jun 2025 12:31:33 -0400
Message-ID: <20250627163133.430614-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

As the code comments on hci_setup_ext_adv_instance_sync suggests the
advertising instance needs to be disabled in order to update its
parameters, but it was wrongly checking that !adv->pending.

Fixes: cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 2e0e532384c3..13ebd1a380fd 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1228,7 +1228,7 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 	 * Command Disallowed error, so we must first disable the
 	 * instance if it is active.
 	 */
-	if (adv && !adv->pending) {
+	if (adv) {
 		err = hci_disable_ext_adv_instance_sync(hdev, instance);
 		if (err)
 			return err;
-- 
2.49.0

