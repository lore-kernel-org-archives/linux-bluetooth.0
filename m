Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035F9163
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jun 2024 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718371861; cv=none; b=CIIq7edtxEqW9b1qDkDIA5H8yJq3yfZlUvBcneBMAqAn1RjNPgZGMvp0slzy8iUfGuAunQ6NRjBZ6js/+CSR0s0bhomIusFf6aImeEQ1titBNC+3OfA4hWMBQOUOGpKyKx7IhZPc/irZIo57RL6807YqVbSTWTnq5uST5kIAvo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718371861; c=relaxed/simple;
	bh=QoB2/bsQhRCClsU7H2QS2vx/BMM46hY3blbo/OSYFd4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qokOHkPlSlVlO7WEwdkagfY4gg6xQTNcXZR0nS8VXLP+0bEYPUO0+ExSfJb4ubhmHhde5PlizyLvSt3OYit7z9KQeA3HzHSY0ER9Y6R44RtZX84KcKZ8MTQ27EUpCXgRllriVuX3Zd2B89UtQk/tgnQxqGixmhCdT72rjAqa/94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhdAQErJ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhdAQErJ"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6ef8e62935so291052166b.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jun 2024 06:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718371858; x=1718976658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IfDZGZUVHFHEc+IMJqQNH7KrutsOoxg205ylIXXBc/Y=;
        b=HhdAQErJ8er3yjCYbGTbc6SVYFIMWpDd1MYEBHmYHs9EFxtZle612s7bZOtXeKi6Z8
         Sh8Z/1TKzE3p4PkZUdted8vNUmEyfo9gMOXKpU6PufWIqENBlUsSypqk2zJcOqb0EA4E
         1GHLRYxPgzSUslBkrBEUYAxCSlV58WpVIENdfDEmVlGHUYL+v2dR1Ff3bQ54dHx4i2nt
         mwdOJ2jdFQYiTvZ+Sxj7WzfDzz4S72X/iPyRRnUHqFwENOnTJxrBvh1fWkd7Wj4L873A
         PHoB32nQVaTx7XKWTi6sWRorXumit3cNe96u71keJiszRFDJ3KRC58fFB6PQsPUERUzU
         qCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718371858; x=1718976658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IfDZGZUVHFHEc+IMJqQNH7KrutsOoxg205ylIXXBc/Y=;
        b=sKTEGtp16Y4iCpEiX84c/0phPCfuEED0L2ODjNND6Sp/xEyZ8RFeLllcUtF3+A1GGI
         8S4Zbu7fEIC2MVaBbqv7TZuHZwx/2QP08sbqUPdlfiIPYfwLTJUMkzKx1tpetFt4/Hq5
         vKddP3hBMUm31MlLmn0AsRQVF6Bs9Lk98a7JRflwET3BK5WgNaBvErT/6gHdWvlkAG2M
         6fT9nXki4/Xe0iN7P4/eCciYM4r28k+jRJxu9ovvB+rdlgL/q8QV6AoZlk7qJctEx5kS
         w60c9OLC8aspyhDfISwBjdSW2C4NmLFQJRA2qPZYkB7upCEQ+XX9Ts17NihMOmHZVrwg
         38WA==
X-Gm-Message-State: AOJu0YxJzQUVyfhV1muuou9Lw9f7HDt8cShCD+FRHL2eT3y2znq0kq50
	aFljvZPPE/DE6caLRf3xy2eagTxpDW8AP7xxMXK/eb48t/JQdTUyEk38hQ==
X-Google-Smtp-Source: AGHT+IHG8YJGhsZ6xQbP0z6JGJucEQMEgFs1bX3Spjapz1SLMD+ZOkoc9s1wqEyNwbc7PFL9rqf0NQ==
X-Received: by 2002:a50:871a:0:b0:57c:68fd:2bca with SMTP id 4fb4d7f45d1cf-57cbd67fc68mr2356030a12.24.1718371833969;
        Fri, 14 Jun 2024 06:30:33 -0700 (PDT)
Received: from raspberrypi.home (46.205.193.11.nat.ftth.dynamic.t-mobile.pl. [46.205.193.11])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb7439646sm2280810a12.88.2024.06.14.06.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 06:30:33 -0700 (PDT)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ] shared/util: Update SDO defined UUIDs
Date: Fri, 14 Jun 2024 15:30:24 +0200
Message-Id: <20240614133024.1299311-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The list of SDO defined UUIDs taken from section 3.10 of:
https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Assigned_Numbers/out/en/Assigned_Numbers.pdf
---
 src/shared/util.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/src/shared/util.c b/src/shared/util.c
index ee59b94a0..98bf1a178 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -1566,9 +1566,23 @@ static const struct {
 	{ 0xfd60, "Sercomm Corporation"				},
 	{ 0xfd5f, "Oculus VR, LLC"				},
 	/* SDO defined */
-	{ 0xfffc, "AirFuel Alliance"				},
-	{ 0xfffe, "Alliance for Wireless Power (A4WP)"		},
-	{ 0xfffd, "Fast IDentity Online Alliance (FIDO)"	},
+	{ 0xfccc, "Wi-Fi Easy Connect Specification Service"	},
+	{ 0xffef, "Wi-Fi Direct Specification Service"		},
+	{ 0xfff0, "Public Key Open Credential (PKOC) Service"	},
+	{ 0xfff1, "ICCE Digital Key Service"			},
+	{ 0xfff2, "Aliro Service"				},
+	{ 0xfff3, "FiRa Consortium Service"			},
+	{ 0xfff4, "FiRa Consortium Service"			},
+	{ 0xfff5, "Car Connectivity Consortium, LLC Service"	},
+	{ 0xfff6, "Matter Profile ID Service"			},
+	{ 0xfff7, "Zigbee Direct Service"			},
+	{ 0xfff8, "Mopria Alliance BLE Service"			},
+	{ 0xfff9, "FIDO2 Secure Client-To-Authenticator Transport Service" },
+	{ 0xfffa, "ASTM Remote ID Service"			},
+	{ 0xfffb, "Direct Thread Commissioning Service"		},
+	{ 0xfffc, "Wireless Power Transfer (WPT) Service"	},
+	{ 0xfffd, "Universal Second Factor Authenticator Service" },
+	{ 0xfffe, "Wireless Power Transfer Service"		},
 	{ }
 };
 
-- 
2.39.2

