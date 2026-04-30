Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78B43090C2
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 19:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777578687; cv=none; b=JSAnR9nmFz3K1NLQymwpyt4JAiFm/ee1BSGaYScFHYq5hahgWLSQKD131w3Rlj8H6gVp1sUNk4f+znaf8jM6QDLjeqDGM1JTyRW5QvvEpkZMxM0i6SBRbEvaoycIUP59ATj6HvXLve29A+8kP5yGkrbRHeldn7bIWIxcr8lcMOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777578687; c=relaxed/simple;
	bh=8cNOssElKOHalAA0MWzx6zL2C+ZK/0LnvI3bXjY0BlA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dFitnu64q1GBIJZEZFRTrZyh6FkuG8VycMSIQl5ymP45RkFSu6bRAEH6M+bcw2SBK5M54YAfNjLM1BFX6aplbvbbkH51IxddE2nQsiEClaFydW1BWXEPWAw+vrvKLOBAP0cEbcXA6u/+lwy/eUh0JHnptouVqJMIiloMEaI30q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLB4IyXl; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLB4IyXl"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-60fa13bde2dso828437137.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 12:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777578684; x=1778183484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rL9sxAE8MJAgIWPk/+zT5pRrq10hKhMB4QqEq14zmP0=;
        b=aLB4IyXlXbfpszxjG6PBSKMsU5zn2c5WwNgpQNcfokIeso7DjrqqN84ZSNonICSipm
         0u4O2Ri6EdxZcu2kYsqvk5340HMWpIjFPkaMqO5Z/HriWhNATvdey9bG2yeBBlj7Ox0h
         TvPzEHg5lcC8KEUxUZ1TrB7exxS9Y28d18kgIfAlW8ckGUwE6jGUIpzWthwGXabTz8GL
         P1kbih8yXo+ibYeW8k2O5d8+xrau221C6ooDFjmproBzmAnuilfP7SU+71HVBAedxaVF
         6RYNpnSCaiXrqahXKxkxO1nzc0szUPzJgxm/Wi+MrJZ+wprlO3Q/H+Sl0D1ytfW/KrpM
         h5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777578684; x=1778183484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rL9sxAE8MJAgIWPk/+zT5pRrq10hKhMB4QqEq14zmP0=;
        b=iYL8+/j0uyZmH/YgDjwZnw+sv5ot28XaWkh+GgdkyzE3X8Z4FrfrTnhbYnwCG/eW65
         lJdz4xs7DSVFTJ2dgAN9z149fdq3q4yPB7mfBcukVgdrSYG3/IABowAunva2rrGO6dqd
         VI8Ivm0eFFMyQhjNi8RaxiN5oNVXVjo9OiSYt0PB93XpZgD5URQ1nzJ/c2C0MCOH2nsc
         gXEGIYmzG1UbbNXFhAK3mS4jwh8c1eHHwfxjobsnV/LMm85kAwDL/z+uKSzItYSHP3QA
         iXtF+DubZY6ODabOdJn5WbJ849UZO2kdEF38a3p30J9jen6sD0Nz0H+ThiVJCaY+kMr2
         VZsw==
X-Gm-Message-State: AOJu0YyqP7IU3k5ZkEa4qeC5EBjn8QfXav2Gdsz3jrw9B13/vCxKU590
	Gf16vRe0CY9T11T1J8kQOGXuGbcdBgHJfmIF+F1qxZI+rpLIOn1fYYGK1RuxXkGE
X-Gm-Gg: AeBDiesAg5/rFIg14wZ3eU/vZX+RMuavmd26eSuWHa0TuiJM1ZaI5FvLLzE8GZQuBfC
	hBtjrA9HIHbj19AFNTdjtQLtHKLH2rgvPplXhAGJ1LBe8ExWDMPu2wDiQ3gjaUI2SB/zKYijNqt
	UtGtL6wiwg/SiG8KzQvR6JY78nOkBlGLY7oz0ZEUCoQOJ7wewSYpDxEHIOa8+uhkff5yH0GkLoj
	ujGDfeHxB2ZzvxkK5v2kMhEJAxngj7GhXqEfHmgTyXehOFdyQ/R+B0hORG/s8dJ+dMCpzScSEq8
	eN0ruMNf9tMMuzUK3MWVupmZE5ZE/6l7kiOPfiEeWUIP59dqY1dwA6oyhOgoLlWjqe6cudRVLlO
	Ju+leJlPsFSeT9FqhC9rHAhTOqKZCFMFWj1cH4XqlQOlvIDG5kV6a8V+5KzP4pO6iumxoTO40cR
	LADo9Hcdv6eGr2puhC+1elbjhHu1bfHFhswV2gMYv7ZKxT6sNku32nlog/eGaFi494zNpsos49/
	EJ+j2WRUaqFnFYeXvbILbh/WKMp8UU1ADHpUxc=
X-Received: by 2002:a05:6102:6c2:b0:60c:bca6:8198 with SMTP id ada2fe7eead31-62ad2936309mr3127638137.10.1777578684437;
        Thu, 30 Apr 2026 12:51:24 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95ce0902d6dsm406045241.6.2026.04.30.12.51.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 12:51:24 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] shared/util: Add decoding support for HIDS 1.1 UUIDs
Date: Thu, 30 Apr 2026 15:51:13 -0400
Message-ID: <20260430195114.608794-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for HIDS 1.1 SCI UUIDs:

HID SCI Mode(0x2c39)
HID SCI Information(0x2c3a)
---
 src/shared/util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index 07e718bca0a8..62dd1369b70d 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -1164,6 +1164,8 @@ static const struct {
 	{ 0x2c17, "RAS Control Point"				},
 	{ 0x2c18, "RAS Ranging Data Ready"			},
 	{ 0x2c19, "RAS Ranging Data Overwritten"		},
+	{ 0x2c39, "HID SCI Mode"				},
+	{ 0x2c3a, "HID SCI Information"				},
 	/* vendor defined */
 	{ 0xfeff, "GN Netcom"					},
 	{ 0xfefe, "GN ReSound A/S"				},
-- 
2.53.0

