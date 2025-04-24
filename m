Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10874292911
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 19:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745524609; cv=none; b=O4/606GR94bVWHR58oT4hO9fkno12XN7dpc+N0XkuW5b8G4oWQldCjQ83cbaFMs3367YE1hdcHS/iXK74Wy7M9udf813I1uZbqLZmNg2WB5R2WVn2/vOpoK4pvCGLPbaZmcpM/yUeDCA5m7TpeP8SWogcP2IAI0TQRfy5VZG4SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745524609; c=relaxed/simple;
	bh=nrdqykpbBeh8ZTnJH/QaO682xvhQyktiTq8ZrElZjbg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=AjrPJxtziFoQajpBrMCuBl7Vkr/BNiRiBrxMODSjhhXK+yx0Zvve90F3GwdFHq6M9xb7/E0mKarFKYJYedlc8eRt/oiAOO7EH38XOHESBTd7/gqhqDV9n+F+gjzJcrhTprMpH1Ml3r6a1/cBUedHcnAa9eU4eJR7Nu58QLuZaUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EfVGUyUx; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfVGUyUx"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-525b44ec88aso684772e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 12:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745524606; x=1746129406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hWcUC95b7VNHsS4QYSms4r2gSRyPSA87tyFWHfvt5Jk=;
        b=EfVGUyUx7QCm59lJ54+JGU5t9AeTApF5TT1BtlPwmrzTdb71FoZmXvGpc/JfpGK65z
         IQlYGeJWV23GWHPEZXPV4fbWHqQtnLg8ewnjVENPQ59n3QFo8RRARlZ5Cs1rM8XCIpt4
         qSscHTyYMm4+c6syifKPnEjOa+Xx2MIr9norG4AJF9eAhfs7nniOWlIPMqfo8JQeJRY5
         eytRrLArcMpHNf/Dw1HVhPeKOmuIyL8jxFUiOfvGcA66iLmUU+D/rK4GTh+xcw7TUHCo
         IG9MTmLkKWZ+bk5Wic95/6jeNdVZQiAFEBHFERtLQM/TcwZYjVqbVGiL6IBZPeLajs9k
         ZgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745524606; x=1746129406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hWcUC95b7VNHsS4QYSms4r2gSRyPSA87tyFWHfvt5Jk=;
        b=pSQPXd7YCZDIPS57M80JYZy/rFmxzt10AafZdMDE/1KG1PvaIYS0xng7E1IVXQDL1e
         U5J3m77fH7EEr0S8my/dQGRR1DANaYNEUVHmyaVySdZJ0w8N8GeSSQFQvXCYuPSMMVLF
         T6j6tWrSJDOsJ7lj22sGio+77mvrKxQBYdVjcR28XKRKLIECn9fNutp9efELQki1CFFt
         8NKbzJiwx2xYPIPjOG0A42NUsRVvLhlOqmau4YC5xbwoyirJal///k9MYQ9YuvNQfk3E
         ohsfcv757tX5G/6K5MCiLiMVbDIm2SMgBlWmEuGtgbEq0CWovhcDBIKpzlZ7cqyCfuX2
         AmZA==
X-Gm-Message-State: AOJu0YwXwI8kzlLLdYUee2YU54EHrO+DhZ8/W8BV3b4SDiNgAkMTOxiB
	SRno3ejyqXlYV9ykMzp2Fb1DtFy/GvX3wnWgYkaNZB1v87Ev/qGnk0//nw==
X-Gm-Gg: ASbGnctpt6m0z9nQLqVQKwfBxCLBAigbgOUngtNSXxGZ0urY1QwYX8HRnyd2bWIwras
	qSrpFwaFegevOw0486KnEZcn3FiBBhod50hTFdcZzcYOf0Ekh5V+clbbO2raibJ3vKGET9vdDlG
	DOWgsmWJjUGMgdhmg0++n8/hesfMcrEIh2EO+xGYyzdjx/eyonCUGSY6LtkmyfnJqMUB/iIHZ0g
	AnDPCIY6pe95E2t1B19AcW3KMCmc2ax9HsWW4tDiHstJR85a8uNCZqU7vYo8RPVRv8TFTJXWmle
	oYdDNg04h+Ar/pr6EeSjJxD5Yp7cVLo7FopPiV7KrH3gHY+9nYqei4Vl6B5X4Yc/2p28Xz7vY26
	hV7whvd4B87WaearxWZO7
X-Google-Smtp-Source: AGHT+IFWx+8Bn9I13J/l+6n+NekSzdQSZvwl+dXdufX9p3/IkgYkwVceRQpU362c1htS2bHr+lVOTQ==
X-Received: by 2002:a05:6102:36d3:b0:4c3:9b0:9e6b with SMTP id ada2fe7eead31-4d4cdfbc9a2mr958893137.10.1745524606145;
        Thu, 24 Apr 2025 12:56:46 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4d3d49a9108sm379884137.5.2025.04.24.12.56.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 12:56:44 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] workflows: Add checkpatch action
Date: Thu, 24 Apr 2025 15:56:41 -0400
Message-ID: <20250424195643.1375697-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds checkpatch action rather replacing the custom CI one which
will be going to be disabled.
---
 .github/workflows/checkpatch.yml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 .github/workflows/checkpatch.yml

diff --git a/.github/workflows/checkpatch.yml b/.github/workflows/checkpatch.yml
new file mode 100644
index 000000000000..42ef7d03e157
--- /dev/null
+++ b/.github/workflows/checkpatch.yml
@@ -0,0 +1,14 @@
+name: Checkpatch on PR
+
+on: [pull_request]
+
+jobs:
+  my_review:
+    name: checkpatch
+    runs-on: ubuntu-latest
+    steps:
+    - uses: actions/checkout@v1
+    - name: Run checkpatch review
+      uses: webispy/checkpatch-action@master
+      env:
+        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
-- 
2.49.0

