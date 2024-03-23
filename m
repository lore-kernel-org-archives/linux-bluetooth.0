Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2BD6107
	for <linux-bluetooth@vger.kernel.org>; Sat, 23 Mar 2024 07:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711178641; cv=none; b=LNZCLsT/CxXlmd5LJ9BGD8Flll71oYzS0fsqwzbl6eJ1W86olLsczAAplZUve49Fymua4K6daGp+sB8uFalcMNbEvnWjo3gwkI03AdUYNCvOKwaQnMm5zGH4Pws6mSOvUXtRtiQLt4ckQwht1CGH0UC9YmOyojH9yjOPOu2YmMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711178641; c=relaxed/simple;
	bh=QetD8+5d4k8mXiaeOq7zKN8wKYA+QYRdFcnf/G2iX10=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LMMiLa8ejgZllt+dunU5wJnwYSJ7BEpDgjd5+R95TfVBt1m8MXm4BId8YjF3RASQkRinIjCGSzGJN2ABO+XgKWEWzqE0jPkw2q8K3hDY9obgTqh48piPNKjS39UO2CnyHKU8175YZNQRw58jUBF4vopJlabUBhwsfgzkyhU6/mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHtqlZcj; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHtqlZcj"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e6c0098328so1987467b3a.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 23 Mar 2024 00:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711178639; x=1711783439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8lZcyViqohwRpSL9/YtS03ON7npc8G5UKKqDYdik99I=;
        b=WHtqlZcjN6m6zQ7a68+zV8gyOvjM2xycoydyQEQjGhNqEvKimT0OOdFDDbp3uWUA2R
         BuTDUxfNDaC1o9E2IBoZLkILF41EDHyhht+dpEOA1GsJkrZe/63yKKViN4j+vzpIMFIs
         AY+P5fzV2po45V0TCTipSfJMoUAJfColhK15OtaV4swY3uHcvv6eSEuU9BGV9krjbs9S
         nq2OWXOsFU9hXmiVCuImJn88nsR41bkrs2hvWo4TC4YUQcKgbIGsqXalmr+CFBPZup71
         9OLgai0idE73y4mvLomSuuI1nQ9WbObOjody05gJ+fTiObB/lOn14glUqvVYsvLf0hys
         oLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711178639; x=1711783439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8lZcyViqohwRpSL9/YtS03ON7npc8G5UKKqDYdik99I=;
        b=FxF1LOwiE4lwKmU1JgsxCik+OrWklflctwFpTWbnpbLHS4GcCP35jzalYRbhlnbq1Z
         BURy4jOI+NMYKuBMCU/g9wtDT2yLu7d7hzlB7DUjdz0F3slRwmxCTojgqyOtiyPf9xXi
         bRaLQLZ4El9ui7Fm9yyM8gjBq066XKWV1o+SDHhChSM/P6SJIqdJ1WJKtxGMAGWgoKsK
         8B0euhX5fm3eme809Up6Bwo/N3ftgTfcSNV0Ln8WetZTokvmNOxYFG+28oYdVu9Sfpac
         VIim7T1yikkgpwq+/D/uUyA4mZ6yBpZaVki/WKfuqpGooTyIt/ymnA7rPNGab/O0FS8W
         O8zw==
X-Forwarded-Encrypted: i=1; AJvYcCVj0ZZpycUVjhGQ8XaxgtvwKvr1os8VDEAfexhnYYF5YRik2NEgg/Vv56pMaG2XvOf2Vpr0CfV7XmAtjOKyerascxcGKNNFVb7uyWvy4DCV
X-Gm-Message-State: AOJu0YwA+hU0wlP7kKAov72nmfc8zESJGpsXN/Nz4uDB/tfADjX3tdS+
	EgUU8Pju/1mCCtdHKNmkyTcwk61GXz/bMAoBHhJlU0H6qUMibB/H
X-Google-Smtp-Source: AGHT+IETzo6IdYpnXFzAF9uzbuYVuBHRDD0+oRmljGS6AyFfEAUvc7OEYdZCme1JD0KzN/1AFqdpKA==
X-Received: by 2002:a05:6a20:9483:b0:1a3:6144:7537 with SMTP id hs3-20020a056a20948300b001a361447537mr1356363pzb.14.1711178639070;
        Sat, 23 Mar 2024 00:23:59 -0700 (PDT)
Received: from bharathsm-Virtual-Machine.. ([131.107.147.61])
        by smtp.googlemail.com with ESMTPSA id eu16-20020a17090af95000b0029fbfb620cdsm3024636pjb.28.2024.03.23.00.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 00:23:58 -0700 (PDT)
From: Bharath SM <bharathsm.hsk@gmail.com>
X-Google-Original-From: Bharath SM <bharathsm@microsoft.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.von.dentz@intel.com,
	linux-bluetooth@vger.kernel.org
Cc: Bharath SM <bharathsm@microsoft.com>
Subject: [PATCH] Bluetooth: Fix unused value warning in sco_sock_connect
Date: Sat, 23 Mar 2024 12:52:53 +0530
Message-Id: <20240323072253.40816-1-bharathsm@microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coverity complains of an unused value:

CID 1528147: (#1 of 1): Unused value (UNUSED_VALUE)
assigned_value: Assigning value -22 to err here, but that stored
value is overwritten before it can be used.
	err = -EINVAL;

Fix it by removing the assignment.

Signed-off-by: Bharath SM <bharathsm@microsoft.com>
---
 net/bluetooth/sco.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 43daf965a01e..e74bce4e1d6c 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -581,9 +581,6 @@ static int sco_sock_connect(struct socket *sock, struct sockaddr *addr, int alen
 	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND)
 		return -EBADFD;
 
-	if (sk->sk_type != SOCK_SEQPACKET)
-		err = -EINVAL;
-
 	lock_sock(sk);
 	/* Set destination address and psm */
 	bacpy(&sco_pi(sk)->dst, &sa->sco_bdaddr);
-- 
2.34.1

