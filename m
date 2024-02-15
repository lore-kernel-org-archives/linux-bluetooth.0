Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8DF433B9
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008753; cv=none; b=hCfabtraJTtCYAhOUABcywa9/CDEQ1/aiBLR3Ivzri4KMA5p/oBkgbfFLK4JhnVBndyKE1AI2s0pjI9UpFBFshoTZTr+ULYbYbRHYf4WDnuwWFKnMyBdtRr0OhFqM5f2GtEweJNwjAgl2Wv0jtKTnKoBd5fFcPcN06e1XhSkFCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008753; c=relaxed/simple;
	bh=cgjR6eMGXss5LPeJh4Lmu99K8/2KOOUnlcinQ2hNkHY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Ud7iQ4Txdh/miLzRBgl+fojvh6oHJmOyZ6AfjHexmQDXVzeEI0jeXBC7dHT25IEsa6dhA8O6ZGxsbO1CBkIajXcS3NAoMceUxD3XYzcq5Lk1eCREn+Xrh96iC734Ax1kJHKJHEhxnkf7gIWAPb1fK9D1MYBWXc/w0FA5kP4bQTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPFcF12c; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPFcF12c"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7cedcea89a0so618415241.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 06:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708008750; x=1708613550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+zqlyj89c+b77avkp8e3ee2tSDCXe6StZO0D2g7F0pQ=;
        b=VPFcF12cn+pWyM+QESykR15fkMIZT9RD89c+sl2HXk1cMlCdAusgdA/b7c40z4TVGy
         JWq8SVu3AAdyjTtObLn8I2Pkb6BpnVqC6V4xOeMftLWrZJKz9PznGYT3oUGBwihQNgT1
         6sxhXKRCkIpUPsAwXoTQyq+/0GDT+ieI1kF0jUdttlIS9XBd4/KIw8C3M3NGiDW3ZKBI
         1mMmSrctPmJ9FoDRa8Fv5/2dSl6nTOmGKN5ntvEyCloq723zThC/IQ7rDZkAe5M9U4+J
         GYGskcwXmilKCz0Hs5MuwqmOJaOFtT71WeFct5t7BbNF6fPJxEDq/5ZykZ85WqbVLNQN
         jAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708008750; x=1708613550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zqlyj89c+b77avkp8e3ee2tSDCXe6StZO0D2g7F0pQ=;
        b=lX1eHQ5GNFGhx+pKkGSva8irokynDwyoN3G2E2D1wEuoZdwEGRiUezO0p1JiwlCAxc
         U7I8YxnG3AgcCtXrvas4xC/y4RAfTbuaXMgB9y4+h8oO80dO5uNitt0j9knZs0HGoLQn
         gQsUv+4dBObFQse5TN4ADHttnzw2TthD0yIcHWnVEXwVhXf7QQkMNfQLdpOY5eHwEJkb
         Ji7evPDbCv/QquMRYAhEmrpAHsB5Rsw+ws7wz5V02cE+sQHm6gr/BiWt8WTDrzT9+rg3
         uN3TqbCRNsB25SYU8AVmBOqAXqgKmwWH9/oPuNkwl1GVCnxdwPJuCH/7KI5/P/D0IlxI
         Phug==
X-Gm-Message-State: AOJu0YzqklORomHjFSGjojVFBxW5ZX+W+TwnQ7icny3b8ib4oJqRL+uK
	GVou0rFvX6gbrix5vU17fJILN4iGUr3c3JOY+9qQINfZJxOMOvepDwv2UDTQ
X-Google-Smtp-Source: AGHT+IFM0YuK7auidO73f0aYzJ2pKtjJktSc5rxVIy9oT2pE920eHC9YwBaZnjWSctxsrtVCBlMcLQ==
X-Received: by 2002:a05:6102:6cc:b0:46e:c427:7f2a with SMTP id m12-20020a05610206cc00b0046ec4277f2amr2433104vsg.11.1708008750059;
        Thu, 15 Feb 2024 06:52:30 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id a21-20020a05610222d500b0046d200fe950sm192806vsh.18.2024.02.15.06.52.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 06:52:29 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] btdev: Fix crash on page_timeout
Date: Thu, 15 Feb 2024 09:52:26 -0500
Message-ID: <20240215145227.782554-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If remote device cannot be found after page_timeout then the code shall
not proceed to call pending_conn_del.
---
 emulator/btdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 4c9f5d1811d4..139ab69b4029 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -1248,6 +1248,9 @@ static void conn_complete(struct btdev *btdev,
 	struct bt_hci_evt_conn_complete cc;
 	struct btdev *remote = find_btdev_by_bdaddr(bdaddr);
 
+	if (!remote)
+		return;
+
 	if (!status) {
 		struct btdev_conn *conn;
 
-- 
2.43.0

