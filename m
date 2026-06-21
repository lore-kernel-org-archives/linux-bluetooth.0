Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1C31A0712
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jun 2026 18:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782066434; cv=none; b=rSmKZIjVvwduvlSDH3s8XZZIavX1eJ+NPrGTX1mqJ+Kdpf53fvZSpLmQVJNfABPHXJsketsvAqxze4nMwoSxi1LmEtVHHBiIJyF/oFZAuxLToJlmWwddlvl2RiNO3p+ycLLR+qCFeHhMC9F2BG7LwvVApDvxtNjdZf+mGR/V+wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782066434; c=relaxed/simple;
	bh=k0qQcX4P0JiFu8fWSPGmpKBZjGHP8yL9WwrqkaHsZ1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=crtFY9DoWJba6nL0+0p+YJ/LdYbu7tilioyyN94bu1IEl1tXJAqhBIE4Aj/nFYFMUvdURLpaoHwI5yyFuSj8p7A9dXnS/6WvjAGaltsiKYYz9Ild0ol+N9B4397SaneqdehPBB9UmBKXyD/B6GVdNMy2MnucIRZh91+WAbh44pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0qZhgOY; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0qZhgOY"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c77d52bec4so2179875ad.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jun 2026 11:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782066432; x=1782671232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HA4VXtjm+GeKmvAD2XV2LMq0z7lMqG+qKMME+pWEgPI=;
        b=R0qZhgOYVN1ixZDQuT9S6KTkJeD2BqcUgtnOQa6RGVPo6tNl/oD8ujNfZd38HqFa11
         JyAxJhToTv7ws4Y5eza2ScUEDOKMo6jEtJz1Nhz0VfNgW1GYVOBGiWQVAIskHtkKcw9h
         SBaPfuqg4PaTEBA3/5jbuX+SzQ3Xd96fJ7/y9q6zsgUcloAkMOHNFy5nbAAIVo1tMWGm
         iffl8f5zjRwiTMYmEUYUvPJIZrBGf/EYhH4L4v4VtCKDGMYMBtRfRdQEUInwQTqCmDWE
         xe3zUnomjO2tjjd6tZL3vWXMLmKWXx8wAa4IR2VG9tC4OUnkmoRuqNpCGdKDqXGI4+WZ
         rx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782066432; x=1782671232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HA4VXtjm+GeKmvAD2XV2LMq0z7lMqG+qKMME+pWEgPI=;
        b=GZ6Jbk2rGLPxKtGBofbmi+5GNCn57aJBS3+ErokNnI4jhs1eqZ+bAN5EatDOXQ7NEl
         0FQQglh44TAy+CNLf9JgIRC8Au3gjrgg9PkeBN9QGRbZI1PSIJYPv0KItpguKIQgV/E6
         DmCxkVgAvuB0j7YReRfoZxyj20qJcgxzin517ix5BhnGBHjusFCPtzZedIvs9pjcuD19
         ZGYAxw3MIJkxCUW1C/Wb6EUHG6pNVjRvKWPeY7+AMEsnEPAEX6Xj1XdctYYo/+bB6640
         cGh4cLTklAtnhkasTvnjk3vBN+MOxhQ2NQlihb1ST0sscSnat15iE0eV1bk9fKAkC8Qc
         eGqA==
X-Gm-Message-State: AOJu0YyYYo98S7/AC548HlsA+en3+K38lg7ua6d1GyPtOIDJL0t8ohAU
	k6ObQ9C7kxqdnMyo5IRf8o8PydawLlls2hLzQh3BdVK7HF8yj1tVffd5qUNvBA==
X-Gm-Gg: AfdE7ckGWDw8EjK35dfGJwgb4yiXHcX3T3i0YisAaZf+1O71nWPM2QzWbH2nm91mBTK
	VdN/pWZ160wVRHryA0JC/kKjS586DLcboWYttrFBmc0FGNq6FLMK/G0wkjkrq3R6xDyjyetsuZ5
	wQltb6LdWC9KOr6aCXVx+app6VjVSTGcnai9qoRvQtq7bqBSnuMaRb1iuviGOXddj54BG6GqSnt
	atuWAhwTioip+Uc2iuMkvsGsynxyk/dLadmxsC5vUiNK0DC9U3i5Xs0mDXx/K7hhMo9xO5NA66e
	K+m8+H6bcqK/0+bPQ0Tdijc5SLUB6KTfLtDDNw3Y/zbslp+bldkfJ01hp+txcuYN4a/Ik4OQFHz
	VPrRMfmGbBkytC9mIu1Kvp4VHCkstgcyfEeD7KTOCTkqELGxUDHnU3hoKIOx7mwwkpad8g1VMKs
	5HUQnv4N62j/mqPPjHLYArn+8nXuXYmF1EWZEztjNfrUrFz53ErbiXZbzUrp6M6a6nljG8bMxJe
	EGhCH0Jc2ZL2+f1QwDheMOjbHoHuI3B7ke67uhKguKeNF60RHTqPqfd3w==
X-Received: by 2002:a17:902:ce02:b0:2c6:d06c:a3e6 with SMTP id d9443c01a7336-2c7195f6381mr94981515ad.23.1782066432460;
        Sun, 21 Jun 2026 11:27:12 -0700 (PDT)
Received: from kapoor.mahindrauniversity.edu.in ([122.184.65.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c743bfea46sm51972655ad.69.2026.06.21.11.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 11:27:12 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH 2/2] monitor: Remove dead assignments in hwdb helpers
Date: Sun, 21 Jun 2026 23:57:05 +0530
Message-ID: <20260621182705.118840-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return values of udev_hwdb_unref() and udev_unref()
are assigned to local variables that are never read again.

Remove the unnecessary assignments.

Found by scan-build.
Signed-by : Arnav Kapoor <kapoorarnav43@gmail.com>
---
 monitor/hwdb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/monitor/hwdb.c b/monitor/hwdb.c
index 6c0d052bb..245b32b0e 100644
--- a/monitor/hwdb.c
+++ b/monitor/hwdb.c
@@ -56,12 +56,12 @@ bool hwdb_get_vendor_model(const char *modalias, char **vendor, char **model)
 			*model = strdup(udev_list_entry_get_value(entry));
 	}
 
-	hwdb = udev_hwdb_unref(hwdb);
+	udev_hwdb_unref(hwdb);
 
 	result = true;
 
 done:
-	udev = udev_unref(udev);
+	udev_unref(udev);
 
 	return result;
 }
@@ -103,12 +103,12 @@ bool hwdb_get_company(const uint8_t *bdaddr, char **company)
 		}
 	}
 
-	hwdb = udev_hwdb_unref(hwdb);
+	udev_hwdb_unref(hwdb);
 
 	result = true;
 
 done:
-	udev = udev_unref(udev);
+	udev_unref(udev);
 
 	return result;
 }
-- 
2.53.0

