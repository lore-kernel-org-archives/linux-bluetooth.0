Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JC7m2nTB"
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAEB1A4
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 13:07:31 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6d7e67c169cso138746a34.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 13:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700687250; x=1701292050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=S9L3RVtYohgGGbQz/96kvey3bQHCTTJXpo42ThDVUdw=;
        b=JC7m2nTBiOSflfQpHjHts4svDA66MqFvcx7llMBa+xt1uFhNC1ZLIQmHL0f+cTwp1k
         xB8T7wF8Dss+M36U30yA16ZEI452W4oKp+ZGRcu6/6d9n1T3CrEUMgGSabzkHAi5gzRx
         5tAgFI+g3lbECCLyoeBSQu/pDMF+TL6I5OyerkkRCkKeIcjoSPjMxvafSeocoWhZC3Jm
         4Fgh+dM2UIPpxvLfloSyD/ndGhz1Bv0oKoR5Z2RFj9P2mKjK01BD0SiFeXxrD+nwEnMu
         Xy41MXlbkoQv0ZPfdu2GG61r+5ctlKdWevhtY5sQZU22EFLzrofhdntpg2R/43ESc4FU
         TLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700687250; x=1701292050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S9L3RVtYohgGGbQz/96kvey3bQHCTTJXpo42ThDVUdw=;
        b=ryVGfZc5yNrc4leqOS8RsX2yEUMfXu+e2Ccui+fURERywDMDDCwiG7RZZrLtpfXGGJ
         G1IR7Cxn/CzCL0Wk3/weFDABZDsmN0Ilh5U2BI0PMYGNE+Hvb4axDk7e3nHZDrQfYchf
         IcuNIIN/fdl5iNTmwIN7xeAHo/Fh4z5k0jRpePTRWaaaJmf7HUzr3FT0LgdVHOdny1Lf
         qLg+qCnScBllyUCclrtSatG2/ep2PJHcO4UzQumHEEoHkT0ovmGA+CojnN2PgcYJW1eq
         8a4BHkezA4knOMdnq8ah/gBRfiHWEmK4eA0GMQZJ2RDTCkFZxRYlC94RYi6v/RuoLrWq
         vzlQ==
X-Gm-Message-State: AOJu0YxXpqwx0/ZlWQu0o4/AImS5xWwuI8niUv/RJzBTB7OC8vhjNJEk
	1F4ZCwtWfzQLVEnSni/S0pgca8UyP94487IM
X-Google-Smtp-Source: AGHT+IF/3pCNTuaqh5gWtza5ciCvev2e1XTtz9HtEVsRp2drFx1hsYy1SFSCOV9fL/8wEDUv0Nu7JA==
X-Received: by 2002:a9d:7855:0:b0:6d6:567a:c83d with SMTP id c21-20020a9d7855000000b006d6567ac83dmr4001922otm.9.1700687249923;
        Wed, 22 Nov 2023 13:07:29 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id w2-20020a0ca802000000b006781b67abaasm94384qva.109.2023.11.22.13.07.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 13:07:29 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/5] shared/util: Add GMAP related UUIDs
Date: Wed, 22 Nov 2023 16:07:23 -0500
Message-ID: <20231122210727.893872-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds GMAP 1.0[1] UUIDs following the assigned numbers[2].

[1] https://www.bluetooth.org/DocMan/handlers/DownloadDoc.ashx?doc_id=576496
[2] https://www.bluetooth.com/wp-content/uploads/Files/Specification/Assigned_Numbers.pdf?id=3
---
 src/shared/util.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index bf37fce364ed..47efff750e30 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -773,6 +773,7 @@ static const struct {
 	{ 0x1854, "Hearing Aid"					},
 	{ 0x1855, "Telephony and Media Audio"			},
 	{ 0x1856, "Public Broadcast Announcement"		},
+	{ 0x1858, "Gaming Audio"				},
 	/* 0x1857 to 0x27ff undefined */
 	{ 0x2800, "Primary Service"				},
 	{ 0x2801, "Secondary Service"				},
@@ -1081,6 +1082,11 @@ static const struct {
 	{ 0x2bda, "Hearing Aid Features"			},
 	{ 0x2bdb, "Hearing Aid Preset Control Point"		},
 	{ 0x2bdc, "Active Preset Index"				},
+	{ 0x2c00, "GMAP Role"					},
+	{ 0x2c01, "UGG Features"				},
+	{ 0x2c02, "UGT Features"				},
+	{ 0x2c03, "BGS Features"				},
+	{ 0x2c03, "BGR Features"				},
 	/* vendor defined */
 	{ 0xfeff, "GN Netcom"					},
 	{ 0xfefe, "GN ReSound A/S"				},
-- 
2.42.0

