Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B0C1E522
	for <linux-bluetooth@vger.kernel.org>; Sun,  7 Jul 2024 13:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720360025; cv=none; b=mXW25USQ42ppmjSdp2eae5EseM/wPQdz24PBePL5dwigDct6jeneZGAzPoTgi2DLkxNeqvMVovM3r0lINrdrqhFtqdDYTU3ey0oJFjcNYvdYqEJ0ZzJsw5GlSpxL592INvqcaBJUhr1Q0JVRDOjOsGCjpzHe8JTTkzmyITaYhRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720360025; c=relaxed/simple;
	bh=HCaJVbPDfDPr+17CfG7kGpFqlXea+KH37MyH/TxSMF8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oybG5FRkO/guzniy+xcgQhq1B4AfUwP8xAkiflJ7kKXqcRetcQx9ajsh9p6cemun8wz1NRX81vS/gmca//KrTqTj96AtOnjS5BYjRq1viKGqd4RZIOgU3Z25kbtatLX6jbfBwwhTMz4Zr2eBk/bhHlKQ68RlxgY7K3xv6En2Qqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0d5B9hp; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0d5B9hp"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4255fa23f7bso20485805e9.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Jul 2024 06:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720360022; x=1720964822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3bdta1Cn+bEiBYlZHMJey7qXZgSUHD4fIgNehr/tQ3o=;
        b=X0d5B9hpbOj9AmPvg45lpac8pGSkvlRt69s9kSD+C0t2TsXnY4fmCtyl95jf2k1BAP
         1/VFbaFFcMV64VudzArgo1IjX5DKTP6nub3ymzZKe5ejB8iI4dVjwIPJXzswUzf0tTnG
         hAD2p6vxQLKzE4uCBMuBniTtjF+0Y5x8Vl22Lx0PkwdZDn+OrEiI3r5GmAnNwaWbeEf4
         uKgBhTwhlXqAx+Q1ukkCS+0i+tXcHbiPT+y4fSGJvMRZorZxuhO6WpwGltOrCraRkBVy
         g6AvVBKRFlp+GxdCmpHk1ZAcustYIJfo+Ver7DuC8HZG3EYhOtWBKhvwa347Ca7SQjwv
         Cf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720360022; x=1720964822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3bdta1Cn+bEiBYlZHMJey7qXZgSUHD4fIgNehr/tQ3o=;
        b=ZCOy4n+NpsQdVXeFl3bVyPBrzePWvWijMv2cA0B/YcxiMo2TDjkh/viKaPOpBJiQ+q
         I6M1z84s+H0pInxoXEVfr9FgPErasXbjUhHx2tWmypbZRO0aQHAVYG/PMG1M4N1VF9lp
         kwN0lXV1qdSsqidpKN2qY6rcgd1ycTJWPKwHvW07aDLlkUmAtKR8p9vte7ried7jadjt
         3FTe2YzEJ07KOuLNed9UteGyv9qU4frqj7cUfuhnY8YEM4UUkwz9Nn2azRQ5CAkHEkBY
         hp/sTtF3niPNt4qeehnlUovR/PUEqHatCAysUEIIe9lka385nZ72Q01irS0mjwTsdIJF
         TT0w==
X-Gm-Message-State: AOJu0YwAIJSr6FgKUz1aOCT2oXHD+VRPpU2dqlQQ/dhYVgNnyeOTWBI5
	OprzaugH9xuTr8DOC9upJpsudanrXUwrFdQO1KSEVTF8G9jBOzS8SKJh7w==
X-Google-Smtp-Source: AGHT+IE1POKZOEkBAbEYpQELop8oq9fMO62IgNC3Xcekig39CLppkjIdRBmYJAF8txziDnjSodhVog==
X-Received: by 2002:a05:600c:3393:b0:426:597d:d8d7 with SMTP id 5b1f17b1804b1-426597ddc5cmr43489495e9.1.1720360021362;
        Sun, 07 Jul 2024 06:47:01 -0700 (PDT)
Received: from gudni-virtual-machine.localdomain ([81.15.100.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d1668sm130081355e9.1.2024.07.07.06.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 06:47:00 -0700 (PDT)
From: =?UTF-8?q?Gu=C3=B0ni=20M=C3=A1r=20Gilbert?= <gudni.m.g@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Gu=C3=B0ni=20M=C3=A1r=20Gilbert?= <gudni.m.g@gmail.com>
Subject: [PATCH BlueZ v2] client/player: fix incompatible pointer type
Date: Sun,  7 Jul 2024 13:46:41 +0000
Message-Id: <20240707134641.2906295-1-gudni.m.g@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In function 'cmd_send_transport':
error: passing argument 2 of 'getpeername' from incompatible pointer
type [-Wincompatible-pointer-types]

err = getpeername(transport->sk, &addr, &optlen);
|       |                        ^~~~~
|       |                        |
|       |                        struct sockaddr_iso *

note: expected 'struct sockaddr * restrict' but argument is of
type 'struct sockaddr_iso *'

To resolve the compiler warnings, cast the pointer with
(struct sockaddr *).
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

