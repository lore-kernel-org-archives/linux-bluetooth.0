Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCD9139B
	for <linux-bluetooth@vger.kernel.org>; Sun,  7 Jul 2024 11:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720351515; cv=none; b=NNVE2nntbg1XwbfClipMM0cVgY8rY22XlA4Hs94RKgO2ii44E8r8I80sJ8uiK9gqU8bey05lfKInwwoEsExvg1E4E0VrnhliYpmTAPUqWBF39Ed/RHc8xUAE53eOt/G13YUCo8XwnIbJjH5/EI7oFUE3wrTLR9UXdCYES20zejk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720351515; c=relaxed/simple;
	bh=9P3Y6axvT0Zj2xO4br2O3vDFJIt3CfKfga8AjNLnugE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MwRTuUdb9c6SfQSPtX5OOxeYpu9nRG98S9uoX2cy2hiJCI469XKmRr44GJrUzSbP20HTnnWlJLFlRCIg4esGYuN3bTT3HOrWEbqYQFWY1/NFiCamA/KOBWGjCl2/xjTBvJUd0cYfPsgE2UYzhyQWkQnRBMkzLT27Z4eCEN0H4mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dL6eOv+g; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dL6eOv+g"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-36786081ac8so1837299f8f.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Jul 2024 04:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720351512; x=1720956312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dtraHiMgqsaPtqlsfT/o+fP+8MVJAGdxw40S7ovpEoE=;
        b=dL6eOv+g2zYhl38D8BzkYxBq+1v0gE4evJvEYSgL6nVFi7qSkw3Bv+RnOCKtLI6qTd
         o1N98nkpYEMl61WDyOZyf6knDKWT/ZLbh9IZtGPkbSsyJicezwPK+qGpzHIzGh4s6ygt
         uHo8zzdzTg0lgFM8dRiCYhtmDP/FT7ddtkW4rKEivISkYTZAZXQGeYVaawywK5tRm7vI
         /kFkp8dT2ROUji5H8FdQM2fNAV46bhRidfafI69g6IDpsx0Xv2xY/elaj0LMlXzhyQX2
         YcPmO+EvK16G0lCZ9aacJex1KXlOkTLhSbttXbr3flI7kqy0vJl/SoQQ1msLanfMQRLA
         Ahhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720351512; x=1720956312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dtraHiMgqsaPtqlsfT/o+fP+8MVJAGdxw40S7ovpEoE=;
        b=UxTXtTkxJDnd1daJyIhAryZV4CuKwEoKJJKFqLLFpTdtCOxL5+KtkpcMbQtAIs/qMq
         ZS41tNTcB/pQnd9zzuFKhqoomK7eIsk0xB8JGdOsJAC5U96Fa5GPL1jTpkW4jrV0bu/I
         XZRcG+YXp2amfTKa4dAMppFYCwLw7FwHZAfpX/ZtW3hNhk1cLmNhRXEWhouBEPNKNEGg
         Do0raRYLHU6Jsxbx0EJ3jATivGXx91M3NgzspIrXmaPpIzCOP9FOU3H+FemKcNOlrJw2
         e/Gnb3yxfuwvv/R4c/43EfDtwFwi/Szf9UXd8c5CZc1mGVmOasdvD5wMZ+i4VM6MhLLk
         /kXw==
X-Gm-Message-State: AOJu0Yw9Fwzbp1CvuAnyn+PKBLyGTyXfdtZDD5oMSnd7Fb+5FD/6levI
	2A+CvZ3kdoTfq+V6lYAN2rsXbLwZ0CtHbqyXg0TVlqpG9TgF5XtmhDMmNg==
X-Google-Smtp-Source: AGHT+IESPWA7s2S9g2gvl6y5fjozCRN/gm9MfIXPnPnX5Ab/ZOqPhireH5OkjmdWfZdPEeBjlFf/Pg==
X-Received: by 2002:a5d:540c:0:b0:367:940a:8ac8 with SMTP id ffacd0b85a97d-3679dd2ac2bmr7002984f8f.21.1720351511787;
        Sun, 07 Jul 2024 04:25:11 -0700 (PDT)
Received: from gudni-virtual-machine.localdomain ([81.15.100.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367963fa692sm10317122f8f.85.2024.07.07.04.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 04:25:11 -0700 (PDT)
From: =?UTF-8?q?Gu=C3=B0ni=20M=C3=A1r=20Gilbert?= <gudni.m.g@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Gu=C3=B0ni=20M=C3=A1r=20Gilbert?= <gudni.m.g@gmail.com>
Subject: [PATCH BlueZ] client/player: fix incompatible pointer type
Date: Sun,  7 Jul 2024 11:24:52 +0000
Message-Id: <20240707112452.3522-1-gudni.m.g@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In function 'cmd_send_transport':
error: passing argument 2 of 'getpeername' from incompatible pointer type
[-Wincompatible-pointer-types]

err = getpeername(transport->sk, &addr, &optlen);
|       |                        ^~~~~
|       |                        |
|       |                        struct sockaddr_iso *

note: expected 'struct sockaddr * restrict' but argument is of
type 'struct sockaddr_iso *'
int getpeername (int, struct sockaddr *__restrict, socklen_t *__restrict);

To resolve the compiler warnings, cast the pointer with (struct sockaddr *).
---
 client/player.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/player.c b/client/player.c
index 0d031e4b0..c394c7921 100644
--- a/client/player.c
+++ b/client/player.c
@@ -5147,7 +5147,7 @@ static void cmd_send_transport(int argc, char *argv[])
 			struct sockaddr_iso addr;
 			socklen_t optlen = sizeof(addr);
 
-			err = getpeername(transport->sk, &addr, &optlen);
+			err = getpeername(transport->sk, (struct sockaddr *)&addr, &optlen);
 			if (!err) {
 				if (!(bacmp(&addr.iso_bdaddr, BDADDR_ANY)))
 					err = transport_send(transport, fd,
-- 
2.34.1

