Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B355B213254
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Dec 2025 01:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764986003; cv=none; b=SagnujxDAzEHtH+XTd+yV7zJvpCL5e2XdQZCIEhgIuDpD1rGhnPCE0SSA+a+TC3mcGjvJ0zjY12F6KD6va8lK2nPwQ6tsSsgi0jLcMILI4QoWlkgSejB899wXpwg3eaEsJ0N+bJEYtq3N9z6qhrOBwyttv5u/6T4oZwLW/ufois=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764986003; c=relaxed/simple;
	bh=MYPCA3JldzgLe3VE5/cMRwXS/VPyPWgcb0dsh29uYJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sDh9EEmJ/iiC70hN57sEbjBt7GPIELP0jjnbEHAvlVzTQ2tQxqwitVWMBjLMVIOkSmMcsWxw6q52bfwJFwLuxo3kFIQLLT+mucFn8X7dZ2Sx9dzhRr9TS5xTt2prPSw6Ebtcycezh4tNr9QcG4qkIFoKjMI1A2W9tN7SbIM8cI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6awBgsc; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6awBgsc"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2984dfae0acso50355635ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Dec 2025 17:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764985998; x=1765590798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ggBthcwgClHCG2IyStov20vbYVE4lUWd6TITYlkqWsE=;
        b=Q6awBgscaKhD2nCkPLy6Npgt1jBnQHTMi6Yb+Z7jILRk7uuYGtqwEqeZHIQnsVlJL8
         A2rli8Szr6MPGpRtORXovJdHO7J0HIfO0BuHodcmnaX2jLC+PMQOd7jIQsOoY/OPXWd0
         cOBOK99UMqJC6e/GmIl5VvCw4+aDJE6/Ys0n/vujZdRuv+vRG0tjd4NMALslbg0s8x2d
         Vis1xILjVhIOP4RAk5e2CelHtsErtVDUoLuRwpFyK+pUZTv7kbt/5MLAioD46+qeMzjT
         JIXYLW54rsqInw6YeDENbQ5X41v3JHEnVKwT6k9kEz4Fw6LTa/uKLovpBrkMKR7n1tR3
         fykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764985998; x=1765590798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggBthcwgClHCG2IyStov20vbYVE4lUWd6TITYlkqWsE=;
        b=sjutuO6pQ0s0/DbI1xUrXx9h5oHxc9t6IjsTxZ/VA1vyg51sbg31cW11PTjx/Bjswu
         pBggyryuCx8Q4rTZCZDuND//EJYDr9uOc0iHtx7LXXwWngjtJiahdg0y6BTdNm/4f1XS
         HXycUUgaWIWYjqY2FmWJTQcS2+mCncTQFtWXD3karCDK8Ok+pwDLk6GBBO56kJ6b+LhX
         YM464h0ZbVfPWMSYp7x/LpFi/k8JIAUB7YCrRYq1MMUCQ5a4JTdKZSCfqFrC7qUvzWt9
         Koi6+AjhEtj65bkJsdImKPPTXytiKDnwhNfcdqcqALovb9DS/e7PDiOvhwOB/mKLLq2y
         ndoQ==
X-Gm-Message-State: AOJu0YxECmKX5AZqZusuKJ5bMsMPbvcxgaa7PfrAqEUWs0QlGceKatps
	egT4ctuXV4xNaJdEkblPZB1wsNH7aSYrmDw0I14nCO/xlQ5G8Lluty6X5mHalbGxYDI=
X-Gm-Gg: ASbGncs9KQH8O73UTh+MHuZh7Am9ULWg3CS1QO9M/vklJeYRD3Smg+C6GrXLS2xHuld
	Cbm8tGlYcP6cAj4xCmtMnKk9i6RzmESvikt/ua/VQknj/GA5HwYy7ZJwtuY2kzxxw7/0gTbZ8Uy
	ruYXoOmaztDipTXW3PXCUapekL6x9umbFryiG4BtqT+8Wg5uzX5rfQPH3JXCIM2CDWK7HsCalWd
	7gJCa9eBiG4L/0s8xYxnmIrLg2k77k2UpIFkx2cGpfXOiN1woJmDuOJFsnC4tx7tDZj5GyqBnTI
	B78rbHm0yKYaYh/SrFkZP2Jo/j3V3S6NAm2+6+nfUtWCjKCvipOqDFXfxuQ6z+So8DhbeLCyR4V
	RbYDGeD0cbYTat/vaAfEPDbBnrgbxIqytTuQ3v6cnbMc7jhUOL9rOvspSIntuWLgsukkAr0rPYX
	oXUFgPxBSwUONt3dS902CyTKF/MSGQ
X-Google-Smtp-Source: AGHT+IHZi8ZNlPYvCkatY1OU4JySkfY9ZDd6BFmVdzUO3asmA4ONWfslH0Cdu77WkQwB5eLVN1HJjw==
X-Received: by 2002:a17:903:2f8c:b0:295:3d5d:fe37 with SMTP id d9443c01a7336-29df5deaff6mr6897095ad.41.1764985998367;
        Fri, 05 Dec 2025 17:53:18 -0800 (PST)
Received: from localhost.localdomain ([73.221.165.73])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e29f2ecf89sm6481914b3a.12.2025.12.05.17.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 17:53:16 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH BlueZ] input/device: Fix off by one report descriptor size error
Date: Fri,  5 Dec 2025 17:52:56 -0800
Message-ID: <20251206015257.651144-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to the way we handle SDP strings internally BlueZ ends up
including and artifically added 0x00 into the report descriptor it
passes on to UHID. This results in kernel error messages like

[371225.240843] microsoft 0005:045E:02FD.0019: unknown main item tag 0x0

or

[367200.458679] playstation 0005:054C:0CE6.0014: unknown main item tag 0x0

The error is ignored by the kernel's report parser, so this is benign,
but for the sake of correctness, let's not supply bogus data in the
first place.
---
 profiles/input/device.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 02a9ad43d..6bdc5ee3a 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -863,10 +863,17 @@ static int extract_hid_desc_data(const sdp_record_t *rec,
 	if (!d || !SDP_IS_TEXT_STR(d->dtd))
 		goto invalid_desc;

-	req->rd_data = g_try_malloc0(d->unitSize);
+	/*
+	 * Report descriptor data is parsed by extract_str() which
+	 * will allocate N + 1 bytes for the incoming string to
+	 * include a zero delimiter. Since that zero delimiter isn't a
+	 * part of a report descriptor we adjust the size here to
+	 * account for that.
+	 */
+	req->rd_size = d->unitSize - 1;
+	req->rd_data = g_try_malloc0(req->rd_size);
 	if (req->rd_data) {
-		memcpy(req->rd_data, d->val.str, d->unitSize);
-		req->rd_size = d->unitSize;
+		memcpy(req->rd_data, d->val.str, req->rd_size);
 		epox_endian_quirk(req->rd_data, req->rd_size);
 	}

--
2.43.0
