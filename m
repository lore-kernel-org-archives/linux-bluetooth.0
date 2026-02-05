Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777751F461D
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Feb 2026 20:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770322728; cv=none; b=BjpejlVr4Fy/+iSwVrFraOx0PLBKvB0mb8ENAo0yGXlezV/j7lgiNi8hB8Ht7TBBc98EfP/ziOWV+n61EWgW3HS70aC+mxNZTq0ZpHzde5PNqln3fLWpGszuHXI6z82+hXA3YO29B62HBhq4uqwp0Y6HqHLCJY9kcikejVKEINM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770322728; c=relaxed/simple;
	bh=10A0FS2gM0Lylw9uJML6vdpG8Ay5vJgedxVzw9THJwg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FpCs1DrY4/J89UuUQbNZXy2trtx8xZO0CA2gjrd5QEqYV5qCnfaLcNiAQQmmUwwjC7qsvRr/3oaCRWiisA7hvhaFuwudrZpy9AjXv9yLSJaZzZCstq0Ftba5nldN9em7JQlBE3L30edFcNTRSLF+zqsypLfKvw9MA+55Wj7Hy1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJr5OkIv; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJr5OkIv"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5fa3f2b8f82so338389137.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Feb 2026 12:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770322727; x=1770927527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bS7KFqx/v2lDxNnTEx29vzERvXZrKja+qpLEHvdJerc=;
        b=iJr5OkIvWDho8d3+L+dckjGjP1VqUzquFS5MYAXl5ZIjQQadiIO+JOpxAdf2ambMu8
         4h2hXglAajnlvIOy4kWsPZytLoo9T/3yh1TJ5C3h7ZLf6dr/GLVCyILc2S90Pj/qZ2Kv
         ciSqH3OipOfZT+EV4MY2qYiFSshBHhzKuKxZ9ammjOsJMERkUumwDwPPtm61n5CPbyHB
         zUPFNzNhHiE5YJUcdCZUUMU4NM76R/nq3TgbTd3dsfB9wEeD3w3E0zOlKy2uQEXrK/gM
         ggSQ/WjyMHqwyzplj0tV1BH2ARd0H8m4SVxfMOI2GPKxF4VtGRWiqvLYsTPh2Bs6h/C7
         ghZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770322727; x=1770927527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bS7KFqx/v2lDxNnTEx29vzERvXZrKja+qpLEHvdJerc=;
        b=KJw1qnU55bXZiy1X57QuVHEFwPvEtcK1Lp8rNdBKRtgCL+FzVaUzTa2sLKXvaO1Hkp
         iMCXtDN9PMWvkSjJUQS8cjvHB0Sndj6swU3ja7KHU3Mu/kLrNcaAMJtT5B3fX8tg3H6l
         QrSzmp4n5PTPz+9Ka5RWYsy/UblTGZbiDQ9q6hjWFAixflMn0xzWs+kJNC0ZuNKk4a6m
         tvky+1UbDM2OIx03U4YqpwyXlVXKy0XUcC/lIP6K7G01bDGQjvONcyoLE6Fj3e+lrgjR
         dwWsEwy6WomOkkojV85Bp6WUC2bvSes8yptfAWaGHr72GeTv1Kzex4/THqfHqxVa1IgY
         DLpQ==
X-Gm-Message-State: AOJu0YzJV0gG/1/VSy0YFLWaZLNo6840RkG+mvCs3aMZclm8Z5ne/0b/
	fq68lZu04dCJ+iJvlmSaw2akzLX1nGFMWXxFFM/EtqYfncUUMt5WAtHD2VB3OLW/
X-Gm-Gg: AZuq6aJi2ixQOmXXZg9PPDy/RMSNNTRp7XF8gJyNmkXRAKv94r+ByvC3tegTLBSBXJ5
	zTU+9eGHUx2GezkijA3qXtwwePaYKn4oschZBPDzZMr9QetanuGsIOtP4YGKHuBYm7N19Jdhf+w
	6+OLuHjF4MdP9O8GWz9SdtxKAcko4z3pHXV3g/nCWGmA2Y1hD7rI1dxyD2U9M5uqgOPeVKK3Zs6
	I6gSlurqQ2xuTnnB3K0TyWdwGIyVISebHHXX91omj3SW4kUbiTR7/nsWzrgsilkWNQO6f7dw6lG
	knfm0nbKlZh6kEsyrfkr5AUwf9Bw2EuzxUAcasK6uITUvmTmb/RgcjkexKf0uhPSxN/PHFKc827
	r7px2MolG9RS2DpapNiFzc/h3g5CndDsG1zW6AdGLUvMjvPXYkyYgRwt7zfWQwtQoqm+dw0h+OM
	w3HV4ZqFC0tYS7t3oR739fzhQT7xQ082rO9AsnCllkhtKU/pj86H3Ukud2IwgJR9bc5Wq7RWB9d
	3wRuQ==
X-Received: by 2002:a05:6102:cd2:b0:5e5:66c6:d23e with SMTP id ada2fe7eead31-5fae8a18bfbmr71386137.1.1770322727107;
        Thu, 05 Feb 2026 12:18:47 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5fae8ff1d53sm59360137.11.2026.02.05.12.18.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 12:18:46 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: L2CAP: Fix result of L2CAP_ECRED_CONN_RSP when MTU is too short
Date: Thu,  5 Feb 2026 15:18:38 -0500
Message-ID: <20260205201838.58998-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Test L2CAP/ECFC/BV-26-C expect the response to L2CAP_ECRED_CONN_REQ with
and MTU value < L2CAP_ECRED_MIN_MTU (64) to be L2CAP_CR_LE_INVALID_PARAMS
rather than L2CAP_CR_LE_UNACCEPT_PARAMS.

Link: https://github.com/bluez/bluez/issues/1868
Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/l2cap.h | 6 +++---
 net/bluetooth/l2cap_core.c    | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 6f9cf7a05986..010f1a8fd15f 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -284,9 +284,9 @@ struct l2cap_conn_rsp {
 #define L2CAP_CR_LE_BAD_KEY_SIZE	0x0007
 #define L2CAP_CR_LE_ENCRYPTION		0x0008
 #define L2CAP_CR_LE_INVALID_SCID	0x0009
-#define L2CAP_CR_LE_SCID_IN_USE		0X000A
-#define L2CAP_CR_LE_UNACCEPT_PARAMS	0X000B
-#define L2CAP_CR_LE_INVALID_PARAMS	0X000C
+#define L2CAP_CR_LE_SCID_IN_USE		0x000A
+#define L2CAP_CR_LE_UNACCEPT_PARAMS	0x000B
+#define L2CAP_CR_LE_INVALID_PARAMS	0x000C
 
 /* connect/create channel status */
 #define L2CAP_CS_NO_INFO	0x0000
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 81038458be0c..8b04baeac0d3 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5075,7 +5075,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 	mps  = __le16_to_cpu(req->mps);
 
 	if (mtu < L2CAP_ECRED_MIN_MTU || mps < L2CAP_ECRED_MIN_MPS) {
-		result = L2CAP_CR_LE_UNACCEPT_PARAMS;
+		result = L2CAP_CR_LE_INVALID_PARAMS;
 		goto response;
 	}
 
-- 
2.52.0

