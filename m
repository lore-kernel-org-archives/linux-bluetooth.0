Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C210347BD1
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140308; cv=none; b=D1RBu+q/djs/sbv13/aM3sjqYp3951OPT9NKgwi7sq6DkAtQUiouoM2FfdfXBbF08QJ6ZvFGa1zxQvm7CAakTFKtbUlKmq1jiPWUH1stWmAtt9VYhDtkVnR/YZEBssXh+NQ1Vf7AEo/9Hjx1iNQvUXUlcVM6JI/RvfAGmqMEIfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140308; c=relaxed/simple;
	bh=fgd/CdpdjngZwUppg3a36JJWZ3EOyZ/6o6kjoXjg8hk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BFqB+lY5wdYEt+X+lgytwsLJNCRABrqzqnFceagY4hJNYJlM87WyCZlC5kDV3XCfSBi5zuIjdaYYkK42/GP88k76YTZa3qaEkIwuLenW3RhLpXpuEUeEX8jPG9G86kS9JmrLjHTu912rQZZMHbGpFrH6sapdL63jmk1bV/9AYq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2QIp6vb; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2QIp6vb"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-932c3aa32f3so1495547241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 06:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761140305; x=1761745105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ci1m8j+EQUgcN9JtwHea50SO0/9QQgg7X3Q9V5MHZOY=;
        b=m2QIp6vbnZv5xh5FRymhlHi8reOOQVoF7SZV5377YRFeRU5DuJVJj/xzPpEgfp5Pb3
         /AskTu0q4dJM3r7ln9vzE3lm1n6fVh69/ZsuIxU3BQX843RFB1ZM4aSMjPItjJ+kn7Ra
         w4tgvvXGuUiEhG7oVuosYrasZp0F2g78ZuiBUMKtL5X0N7ND0KMAbN5V+FJKpmrbG3kx
         7N0T9IAQxQRdkycZRvjwzLGTF+xVbwCDVTggIFBhlRkkH+nwoaauf2ZbLskKkJ0Fi1jF
         st3oV5vwPffhZtXG1PfmprrmYiwy01VhC7e2wkRDOSb5i1W6vdaGX14uZGQG03nSMtGG
         3Veg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761140305; x=1761745105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ci1m8j+EQUgcN9JtwHea50SO0/9QQgg7X3Q9V5MHZOY=;
        b=anGkD/xZzi7u4dCaIyPlE3jrx74wPejCM1lAAG3mq92SS5js4e3Uihs1yE4ch5xsAT
         sWP0lLv0gU3L6KmEkXDnxJqDg95FlXg0nTml9QCZ575BghotjIvlmvdc+lb3CNq0ojv2
         D6mSTp1c2B569SyQOovmyxnwtnhuBXGhw3v2LSp41dKXND5Y8yc6NXnhnOgDNiaoG22z
         +mSjEWQv+Z0rfL3MGV+OoC4nB3I0Rjj2uiiDzRVoSJ/ZzJYzkfA6Ibr7mer6KoW428f/
         zu44KbgsvkDU7vKNHNV7t575nOjIRurHl8XWODjXqI3Y4Hk+jlgcMSBRA9A7Bkbuk4xI
         SE9Q==
X-Gm-Message-State: AOJu0Yy52LOr8iiM1/ZdqdOVjroNg1M5IGWXj3yyZ0Zo8gglXP2UNPZi
	oaWvjUFc4Kejb5BNXsGv2zEhK+pjyX0++SuzWvGAr03p76E5D4fKO+GZgSXiTDfO
X-Gm-Gg: ASbGnctYu7TbJaVQnHJ0EVJYPkJ6jTbR87hi8NpwB5wfj83qLxA40ArczKoAUwDMAiy
	fjhS20zkn9x1sfztt97fYuekkJIQECZcBeXFp6iYzNbWKOPzOu2aTfhBRiNTIg9psqvNKIHShK3
	4+ieQvWRjccM+RJ6HZ8wM/dBd962ZOk25r31qt9iR3WqZHPLmWiGtVN6VCerpp6l5enOq145f4B
	pv7ApclB/GOI6aXmiDiSLUqF+kSzsBq+wBWrQJaJt+cBV2zns7L29K1sZ8Evfbm1ealNmnqMiDW
	JeydpQ0r8CoP2xQFH/Z6LxlWLHPrb97CEyQkQ1kw0Pay/FdVwOx/tUbA/UEtCzrFqOEgmoyJw+Q
	bvl29GQLYS4mWIT2q95B4vZi8zR6dnG3BhgIUgSs7O4npJ+hSJsL667pVl2nA4oi7Lhfkun9f35
	Eb7UGdwAInu4SCFQ==
X-Google-Smtp-Source: AGHT+IFr8C8bFxgBg52Nu5lHJuOPv6stFfFJGCIsR7WTnym0S8go+Gt2a09SJePiCzAbDzUoihpraA==
X-Received: by 2002:a05:6102:3a12:b0:522:194f:fcd7 with SMTP id ada2fe7eead31-5d7dd473519mr5657896137.15.1761140305208;
        Wed, 22 Oct 2025 06:38:25 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5db23d61d56sm320766137.8.2025.10.22.06.38.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 06:38:23 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] ioctl-tester: Fix handle value
Date: Wed, 22 Oct 2025 09:38:14 -0400
Message-ID: <20251022133814.1404453-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Recent changes to emulator has changed the ACL handles to start at
handle 0x0001 in order to use dedicated ranges for different link
types.
---
 tools/ioctl-tester.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/ioctl-tester.c b/tools/ioctl-tester.c
index cb283e1ec68b..c29b30268d89 100644
--- a/tools/ioctl-tester.c
+++ b/tools/ioctl-tester.c
@@ -550,7 +550,7 @@ static const struct hci_conn_list_req conn_list_req_1 = {
 	.dev_id = 0x00,
 	.conn_num = 0x01,
 	.conn_info = {{
-		.handle = 0x002a,
+		.handle = 0x0001,
 		.bdaddr = {{ 0x00, 0x00, 0x01, 0x01, 0xaa, 0x00 }},
 		.type = 0x01,
 		.out = 0x00,
@@ -568,7 +568,7 @@ static const struct hci_conn_info_req conn_info_req = {
 	.bdaddr = {{ 0x00, 0x00, 0x01, 0x01, 0xaa, 0x00 }},
 	.type = ACL_LINK,
 	.conn_info = {{
-		.handle = 0x002a,
+		.handle = 0x0001,
 		.bdaddr = {{ 0x00, 0x00, 0x01, 0x01, 0xaa, 0x00 }},
 		.type = 0x01,
 		.out = 0x00,
-- 
2.51.0

