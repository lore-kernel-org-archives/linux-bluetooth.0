Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951062EC56F
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788646; cv=none; b=onowXctSr4QRu8Ksy9kM3KL60oWG2smc0BQnq6o0OK6UKBdr73q1rxi8VG1gddOdisctPUZDfu7Er0qXq/HrN1T6i3QrJ/oLhnSTyDVuY7NYWn9HWTR93NRAqVol8ZnaLvDuJkjXBDpsH+vOMx6EfzDuB6oElfFrC+ootVvPVcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788646; c=relaxed/simple;
	bh=YVaqtFN/nZzqAsYrkLvppdOyawjFUZAa2QCLJsDb2pU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BzA/Ty208Y5JtCASpninZD5MAEqfaIzD4QUycCpZcTQGiD8Gvoxfl2cIVkAetfSpxP7+BmQiUAcftIYhrj28r/fh+ElknkQUk8SDrWKf+eFvHrT23MGmWk49PFVemNLRknTjYFHmIj8wp7XdhrdTLuvq8FjqOkCKT7XuPLuvtLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CafZWm0F; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CafZWm0F"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-30cb38a9247so1511415fac.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 08:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755788643; x=1756393443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=icAIricTM8eLM85bBeMZUr5sFn375tlr0DmefROumeo=;
        b=CafZWm0Fz4r8TZWwacknPXQlWq0M6ExSabtIXpX5pEdN6fUM/892XDcB0RFpOpKSBr
         Q7L/igKD/HhTr6tvfJCAzSdhDMP/hcmZz0EDMHAAG4Ua62fmoWtcb9kt4RbrpLb+3/tR
         NOP0LVnWX76xUuVwJ8QejGnPoboIr6yMZhOS8aLB/xlYQJquIueryBoIx9G9ZheczEjd
         mhiNcP175kHKkvdtV9L2ot3U/3PbXlw3g6LJ6KAoUMFEqMAGRquiKE0QJgwf2oNsd+YS
         JLbwYL4WAw45EPiXJfk1KuyxGf6tEHnoe3TnQokei9mkuMaJUbhHXGZoXd73BMekcJFH
         1dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755788643; x=1756393443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=icAIricTM8eLM85bBeMZUr5sFn375tlr0DmefROumeo=;
        b=hNp/2ihln+Nx+lfrvnPZGl6nMCKKq7egmKxUvsMRlE/hWVGpn440C+C3aAZf7qXAOs
         qeJdlni8X6s567KQr3hg7dpu49PS3LroKfbeMG2uuvQc0oBDEf1unXUcVAeIFD38HRZ0
         mF6//4cB8YqwdLWfw5D2Na/itjlgLhEABUbLNWfHWhdbNyoASot+oKyDPdoB5Tb+bKCl
         omkjTXSAGWm4H4zt8y26OBmij7Eb9td3tUY0TYaHDGyZ+bnVFuMMSkhQLKhgGL4Dj3C8
         kM6fDyF2c/CjGanR+i3X2ksOSXizkZVXfwxsXQr9gDdeC64s3poup2/AZzDdkWSyfyEk
         5qmQ==
X-Gm-Message-State: AOJu0YxkliurvqpdI+kdidgiCjhPuSju7y7zUXaHSdJTmPswb7qlZELf
	i9w+Z1OFzmGNNopJkE9dFyJ8fvRlyc8y2qCaeG35u2Mlgbh74xl/RWmISzSvQBV0
X-Gm-Gg: ASbGncsvN8IukdBJQcYV8h421pCxrAuhlmkXS/F0AOdtRze6w9+hbEhjuNrDudAj0WG
	RdB0N1RCzM65BfCkOIgG6xmzDSNUC0A1grzxUUO5nQcFudl6apaVPyjU+Iv9ZFE48yU9bPgD+G5
	zHVvDYcR/wzCNWr0QaDQ/e+hMmVvmbwro+ZobUbu4N+vJemtlaV5S5lQxG0GmqXCYYxWTlxhyqA
	Mn+FhpncV50QmrJf8Y9/pQa4OkW5HuVGD9GTamL38jBECfXyyBnTYF/88eM0Bjmaa5Ul3EwdQT4
	tY5ZY+yaZrubXvG+5FGPlXzoJeK27U1QS/CzB1tOcEMPfEcd7eWHGiQmXHg+a54xSPyh/9HEXfl
	LCG21d67pJvoRzNur8bQ4zP1mvJsPGa6FSSm3Lp9c2ujK46gWW+N7bFCmyn5jPiiFhOpi/TNM3U
	Y=
X-Google-Smtp-Source: AGHT+IFglcverMY4MksQApaGtuT8rO60zCcbQcapR4bTd5LO3USlb2afprnF1HCwwzWUyZZXmoy0fw==
X-Received: by 2002:a05:6808:2213:b0:434:b43:d4a3 with SMTP id 5614622812f47-4377daf9cf2mr1166913b6e.12.1755788642734;
        Thu, 21 Aug 2025 08:04:02 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8920dd0c67csm791666241.10.2025.08.21.08.04.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:04:01 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] monitor: Print message if the frame information cannot be found
Date: Thu, 21 Aug 2025 11:03:52 -0400
Message-ID: <20250821150352.2043419-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

While processing Number of Packeted Completed event the code attempts to
print the frame information of each frame being acked but if no frame
was sent it didn't print anything, so this changes it to print
:#(frame not found)
---
 monitor/packet.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index ca7eaea21138..d5d906091adf 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -11222,8 +11222,10 @@ static void packet_dequeue_tx(struct timeval *tv, uint16_t handle)
 	}
 
 	frame = queue_pop_head(conn->tx_q);
-	if (!frame)
+	if (!frame) {
+		print_field("#(frame not found)");
 		return;
+	}
 
 	timersub(tv, &frame->tv, &delta);
 
-- 
2.50.1

