Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CDD23536B
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Oct 2025 01:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760666298; cv=none; b=ssozAJn6B98uu1Rnu8LDe4ScOKC3EgAKyrPFQXZ4R3WP1E9S1ynXGgO/EfLN3LBp5fUBUHUC6h9S4T2rLgPNnQoBTky4CEcZQKUMuJ/auw4ywFib6Ym/at2zbq+Dd1Dnkn/DgVxapvcpIcb2HmTSMKTiDT3kIYrDoMDHdUvIAVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760666298; c=relaxed/simple;
	bh=3r/pmZKRhF53e1Gm023W1vLTkP/Pg7hut3IOgwSTCOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aX9drjiOCT6LYhLwHE8OycsVdaXhj8lhoG0iXipbROpaSHvSp9sqJskDt9MEBHBCvnI5vulC47ViJEwjUzg7mCkuCjsEI3kgKhFzTvKdP9JFCJUmVQlWXyjbt2yGMSk1+UrYp9Q+X1yAK3x+EQIL72gy4iHEtxBU6MJehjmKjz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSR2t7+/; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSR2t7+/"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3307de086d8so1235336a91.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 18:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760666296; x=1761271096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOZ4uz8Nh3B9V1m68QZ3s2UdWr7aoJBE0q+xVnSOGgU=;
        b=dSR2t7+/EjST9wI2TiF0vhTwfUs6vTuCsp+zOPWOCfln2hXQoRAJp3RXvlTK1E1BcS
         xqSM/9ViTbRLN5rtwpG6V9kBuqa12xFCj7OuOohw26i0yMtGwxlCrwsuxExd0+1KjMjz
         IhVIFaxej0nYCbVvblIiZxMsvoXu2LJHzweIAvZ+MENwrFO+wbmsQ7yjf4t2GAaS8Azh
         sRsg12tMZqW+gDQEGNrWWbzwBHUfFQY2E6dMFisMVVsooDe9K9AmvGOmvXpUA2nR6ga6
         Bmg3Ol5Wd1R2wef5/PahtMJoO1oEUicJyL9qmbbbq3Gg7u37xe7D2r7WbJk7mNt/fBad
         oCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760666296; x=1761271096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOZ4uz8Nh3B9V1m68QZ3s2UdWr7aoJBE0q+xVnSOGgU=;
        b=fA/bbB6se9gNlTXFONSujVZxyIbzGELkTI2rNc7dZcrBLuW0WSM4Ajj3/nvSWuFXgP
         Viq/TJm00O0iq1VlNGpokWy3F51VgBcJhbfTvZwor6R43YlNIvWGzVPrPOF0SCF7uVwX
         SEDqiI6lXL+l7q9YjlPQMXaQa+1f2YU2UYFjdLtkjwAsJT+19hKS2bc4CcrclinOWA6F
         W1LJAAR3v4wA01YCtfJQPA5FXobt5m9DQLDIBip5VG/ODpEFtu3TSNpNlWX0J1M5HkGV
         xBCqsLUZdeQlHXG9DUywmAZSXlx61ehX6bSsCMKBN3eUTgRq1eOlTJrni8Nn7Z3tcDx8
         OE/w==
X-Gm-Message-State: AOJu0YweGwoP+2XOthb0r+ejwoyEVJZzunCicrvMYSgvNy78YI9k2J60
	Qvm45zXrVqDZBYo962UsvIEF3E8Pgcds0BiqGFWNPPEM3a82q22HT47QJ3oUBA==
X-Gm-Gg: ASbGncspMTmCgnv4fdTwWW9ryhPiNtp2SgaN6ZNGILfnGOsb191ZnKXLMLuo7oN6da+
	5e83o+LwEEUqif4dbWwcgVWn9swxw02OfInXNHh4J08iAQWMVkakN98a7mDvul6pzU5/echVuQb
	3YPzt/uFaJsOgUK+65RAiuBnGWnaIUablR0IxKM0wvpD0zgLI9dMCEsF3bCGubWUonB9gLpNMaC
	uiu69rMoBx7tcY6jatV5+YeFNo89MNH8j07rhMHi6zLmnpD+sog/AvNj4M6odpz+bJEI/aQ1GxR
	PRvac1L2aS0MHjH+gu5jpr3j5roV8MeM1CGgoudmOwHX9cEfP+jwgQv/+dgHQjSlx5EnD2Hm0A9
	X449WnjrrYKFubjoOUZj7GFUKBd0YBylgXLo5UydmtFS+PWq52sW0wUW6hmnpIHqQw5uDrSTnkS
	mWPMsEe0CuRH/HhayDVYRhrAoH7As5qOwCUK+KOVnUuWkJ715R8m1v18WcvEWYywgej/FFKCA3k
	WtsvwCC8XjD1g==
X-Google-Smtp-Source: AGHT+IFB1IPIr57NneCZH+fKgz2HNDjqM7MsJzVAmgYAdKYFBVl5RLgeq/3jwGOFMArMswRUpcoDTw==
X-Received: by 2002:a17:90b:2b4b:b0:33b:c20a:35e0 with SMTP id 98e67ed59e1d1-33bcf90c1d3mr1958517a91.30.1760666295616;
        Thu, 16 Oct 2025 18:58:15 -0700 (PDT)
Received: from pidgey.. ([2607:fb90:8be2:8e43:bc7:e05d:ff48:a60d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33ba96ca5d9sm1701979a91.2.2025.10.16.18.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 18:58:15 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH BlueZ 2/2] hog-lib: Fix 32-bit integer truncation
Date: Thu, 16 Oct 2025 18:57:59 -0700
Message-ID: <20251017015759.46326-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017015759.46326-1-andrew.smirnov@gmail.com>
References: <20251017015759.46326-1-andrew.smirnov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Id paramter stored in getrep_id and setrep_id corresponds to a 32-bit
tag value passed to us from the kernel side of UHID. Specifying this
parameter as uint16_t breaks the synchronization after 65536 request
and renders the attached BLE device inoperable.

Fixes: cdddd7e69e06 ("android/hog: implement get_report functionality")
Fixes: 83ed02d06fca ("android/hog: Implement set_report functionality")
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 profiles/input/hog-lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 860c6e32d..70a1bdcbf 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -87,9 +87,9 @@ struct bt_hog {
 	uint16_t		ctrlpt_handle;
 	uint8_t			flags;
 	unsigned int		getrep_att;
-	uint16_t		getrep_id;
+	uint32_t		getrep_id;
 	unsigned int		setrep_att;
-	uint16_t		setrep_id;
+	uint32_t		setrep_id;
 	unsigned int		report_map_id;
 	struct bt_scpp		*scpp;
 	struct bt_dis		*dis;
-- 
2.43.0

