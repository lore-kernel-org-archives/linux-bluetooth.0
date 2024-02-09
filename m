Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969EF80C16
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Feb 2024 18:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707504766; cv=none; b=oNDsOv3+7tvdnwn4Q8lrvFTL++aGjiUjFqYACFA6xcYra2+Ug6hsZYCmqf6wVd+IW1IsU82K3ItpIo4kPX1nQL6ZoIeURk6nVbWYaGj5ieB3Rdq+V6QL5XSntsRbTAbRBbGbMPM+eBC0yhY5cGl65NKQf1bHYcj3ejZrD/0Z828=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707504766; c=relaxed/simple;
	bh=uzbeowmsqMyqR8KQNlK9MHyvUjfxt90fzjcZvxyqjKs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=przAk0xMQbts2LoPm308YSK0wAPNryoSCrdVmZ7uSw+qtT9E8WPXf/JcOeB3Jsr47d6LoUCcbjdt1usolRmaW38TyfbhN6v7wQKhbT6SYLg2jr2ZWc+35ORxlvcI5/AMX9F8QXxAPRmgu3eVH2+HfNwJtRamudrFxfVw4qin+AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtSNDuZh; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtSNDuZh"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-46d11cbd695so119495137.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Feb 2024 10:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707504763; x=1708109563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yGMt13bRWEMviYhVwNqdVkz+Vb+Djz4PNPK+Zs4W+CE=;
        b=OtSNDuZhqi0EOcl3so0C3G/qXcOo5qfUGrWm8D9GRfCKXzb31unciPDrSiga6TI9J0
         ZeFw3YN0r9illq7Jm2mFf2tnWn7tLtGaYWx+R7g8vVc7KjMmVejKDQBbGb2L2IZRWnva
         R58HTiXnSoFkNSh2bik2OYMW+oJiYzK5NgDXKsH2kBOPae/8/OeFjtr3gS0+zgHD7EZg
         yHKiFbKmp5ZWkbTMWpATQdbaAUztsjDGKtI0/n0XIHBKta1CvLuk70z/hfDsWSBb1U+L
         COBUItnCQAu//eNbUq3CCLTdhdZyrpKLiPKQKZqmT6Ha5wQ74k+vHqoYm1Rvo6eYcmCp
         ZI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707504763; x=1708109563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGMt13bRWEMviYhVwNqdVkz+Vb+Djz4PNPK+Zs4W+CE=;
        b=InDFdCEkjxHjcMdFbenFA4+IvbV4+rjr15NOKFw8BxWyx1Ewqf0CimIfVi1YpwONg/
         97D5H86pY6Z1E+vEbCQOU4sG5qFYMRkPuVAJZCr+zRp7NdYiz645T8eGe+sPRwFGZrU2
         1wyBRtEPD8/b5Rk/tEVovevXWcw2ZJ+Bzu6NjREGrG9VzedhXVovMa4qFzblMEDDiUGG
         dJ4nbt/E/GDKj+eBGb3n7LB0eCc22grrqkXaUfjNZ5B+ly95p6d59ybKOIH9MNEps/Vr
         oeY3KSSYZhgH9Dml3+ITSqcVRdloz4VfpaVRAW/vLZ0AYoOkwwU8GwbkCkqOlXMsvBqJ
         aKOA==
X-Gm-Message-State: AOJu0Yy1Zg7nE+fsvAFLz62HfdmG7NX8Fvx6fSbWVi1ILdAxhMk9eVLW
	MJ559f6wnUqjbSyXnmpdRJhrwKHwNMLK+FuRzicNVIHNnnMHzBBfe+hYWA1A
X-Google-Smtp-Source: AGHT+IGIa8zLnnRyceI86Pp4rE+r2UW3T4l9RLnVpTuFEacqDccuwBIAjF2H/mHg1YNna9nEX3mQkw==
X-Received: by 2002:a05:6102:ccc:b0:46d:54f6:736c with SMTP id g12-20020a0561020ccc00b0046d54f6736cmr294737vst.1.1707504762827;
        Fri, 09 Feb 2024 10:52:42 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id p7-20020ab06247000000b007cea1ac338esm116989uao.27.2024.02.09.10.52.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 10:52:41 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/3] input/device: Don't destroy UHID device on disconnect
Date: Fri,  9 Feb 2024 13:52:37 -0500
Message-ID: <20240209185237.3611995-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209185237.3611995-1-luiz.dentz@gmail.com>
References: <20240209185237.3611995-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes classic HID behave like HoG which keeps the UHID device
around while disconnected so it doesn't have to be recreated on every
reconnection.
---
 profiles/input/device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 6c64ff1c1c52..9aea9e48891e 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -985,6 +985,10 @@ static int uhid_disconnect(struct input_device *idev)
 	if (!idev->uhid_created)
 		return 0;
 
+	/* Only destroy the node if virtual cable unplug flag has been set */
+	if (idev->virtual_cable_unplug)
+		return 0;
+
 	bt_uhid_unregister_all(idev->uhid);
 
 	memset(&ev, 0, sizeof(ev));
-- 
2.43.0

