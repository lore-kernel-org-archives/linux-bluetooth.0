Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BD4FC0E
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Mar 2025 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740906226; cv=none; b=VhAhSXuGxaJA1oKbsKmaNszVoKNeDP3NKzAz+aBUHzCNlE58mSg2a560ubFxD8tAfbMJOHk49Vf7buKTpJqa716lqoqYNVPz9SG4Ee/xQWCQ/ssNK3QGBX57Qv/ih8BXbRjS2e+1ixlhp2B1xxkRLkzAzel35WiFnlH5/SL0pyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740906226; c=relaxed/simple;
	bh=Y41k8sRn69p+2KUJb1JYWyaTEOZohyg10P3/a38GIWc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CyP3RDeun1TbtIOceAtuuw1yZcFuoMpEYaU0+XOB2C6Zr1hwldS3RHQg6ycylh9GwdjAoMLo9HQ9awY9mZVkoblX+MyYcXodcNtpxNnoC6BIGPTopeWR9goJ3GZNnWYpyHcF5BsGg3JcpmDwyxjg+anGnmdq1fI0kx2KmJMMyAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arIdoA7h; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arIdoA7h"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e52c1c3599so1126884a12.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Mar 2025 01:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740906223; x=1741511023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0vgta6DvD1GHffF71Y91zbrcWNYSXRrDw9kwTQnQcQA=;
        b=arIdoA7hNl0Is621iQJhFO/V5qmspjf2eW4243d+KQZvAypoTPYPRmBtWv3xrdrkEj
         dxWeb8fyRqswqEB3SF4oocoH071tf/O+uUWifFxChXrc9n8XBI3jOSK4Ix7/XiIUhjEL
         XoumYcUpW91sKgPwSXcRL8Pjo5ojLoqgX5g6H/ZmyDxP33Dfyvkqy3tuYfbKBuIIn2Tu
         7TlbW1syq4cXsPC1DsimQ0VNVvJKjcCMVxknfHSYcdzvPXw5n4yis8K8ZopA0foKsJG5
         Vy5/J2sdQYL2t3pNde08eoAL0nlUHUORpXjQxxPv3a633diFBWcWCWNdQX1cbe6mJVG2
         iwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740906223; x=1741511023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0vgta6DvD1GHffF71Y91zbrcWNYSXRrDw9kwTQnQcQA=;
        b=CKNA0knJmXsGY1/Dr/jvMzfmmzI07fm1DRSrznaFZ1c7QVo8jRSU1pZH5OaS+1Ndh8
         B5YfWwVjT4yEQI64usMr4DKb/7imfHcz23X4EOVDWj4L9D84CT/yowYFL9pz7oqpXbHL
         PlMq+yaB6ktZnV2LtkVpOPwEof55RIyQGVDIA2QeL2vfcnzlFBeV3FpO3pprQqMCky0W
         aEY4eHzVCZYFAI9hG0kVSokdaknfIypj4IkS8o/IgUnBzcS//emKrraMoqQoor4PPnd2
         AYc1LYkeeYciGz0tgMnAMhIQNgV8ikF5RC30Oq6IwlkcJsOwpwH90640WMrjHg0j4Kat
         8/vQ==
X-Gm-Message-State: AOJu0YwDAJf8gpRkfqREl9kNGY0ZgzkLSSOjHGnOCEwEVmGzdkMSGc5+
	wT8LuaoaQZVFMblrPefWf9vyKLVraC+upTnB+zWhyVL/SQMkwocE/0DoMKaq
X-Gm-Gg: ASbGncv9bTxfFdzfHc9L13lbBQ0i+4Gy+zyMOos8rYtcSUeUEcGna0T1EEZIky/u2yd
	FI8Ghr28hppz+6Mhftz59u5Bggf8PWGTJ4dWxQQpShWhjkPKzQ0cfvTyVkwGpyrAI8kmecFAzEu
	x8AFDGMihl6bOwKBuV+9zddI7LO2gmeT0hdlRzlx4xjZrmiwcVxVbhp8E6Lfdyux7tYmOkxYRSR
	QcRk8V2crYc1jPKNMF3t1JH7kqe1sFTMdJJzh9GhXi1HL6lcsHh+TZRJBm3xQ7zT9wxnMbRtaBZ
	j4M2lB7viXgfAujClmM1O4VaQjyzvIXg1vQCmzGN8BQnQGQu1uuQFpdUO+cBqcSi7e0O7ZWwz97
	OdDMx0t7xF4U1oVxaD3n+D3iJ/0u6vHrXrPn/FQ==
X-Google-Smtp-Source: AGHT+IFmen+HOEZnzvuROHTKsht37hFfPptN+qXmX3bnZpkUssg55i697F7MUItBWqW0tj68PsB2gg==
X-Received: by 2002:a17:907:3e9f:b0:abe:ef8b:6fb3 with SMTP id a640c23a62f3a-abf2687d927mr1242296666b.43.1740906222302;
        Sun, 02 Mar 2025 01:03:42 -0800 (PST)
Received: from localhost.localdomain (46.205.201.86.nat.ftth.dynamic.t-mobile.pl. [46.205.201.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c6ed7ccsm624452166b.96.2025.03.02.01.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 01:03:41 -0800 (PST)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ 1/2] uuid-helper: Accept any 16-bit HEX value as a valid UUID
Date: Sun,  2 Mar 2025 10:03:30 +0100
Message-Id: <20250302090331.17756-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bt_name2string() function restricts HEX values to the list of
predefined service names. This list is very limited, so loosing that
restriction will allow to pass any 16-bit HEX value as a profile to
D-Bus API calls like ConnectProfile or RegisterProfile.
---
 src/uuid-helper.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/src/uuid-helper.c b/src/uuid-helper.c
index b62b1af82..9d19c5a29 100644
--- a/src/uuid-helper.c
+++ b/src/uuid-helper.c
@@ -169,7 +169,8 @@ static int string2uuid16(uuid_t *uuid, const char *string)
 char *bt_name2string(const char *pattern)
 {
 	uuid_t uuid;
-	uint16_t uuid16;
+	unsigned int uuid16;
+	char *endptr = NULL;
 	int i;
 
 	/* UUID 128 string format */
@@ -182,11 +183,9 @@ char *bt_name2string(const char *pattern)
 		goto proceed;
 
 	/* HEX format */
-	uuid16 = strtol(pattern, NULL, 16);
-	for (i = 0; bt_services[i].class; i++) {
-		if (bt_services[i].class == uuid16)
-			goto proceed;
-	}
+	uuid16 = strtoul(pattern, &endptr, 16);
+	if (uuid16 <= 0xffff && *endptr == '\0')
+		goto proceed;
 
 	return NULL;
 
-- 
2.39.5

