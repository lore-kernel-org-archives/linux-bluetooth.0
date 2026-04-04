Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3667E30BF66
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Apr 2026 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775305852; cv=none; b=m7eupxKUjbBSwfI2fm7Z44/1jdpwUsqZsyzUarrsj6rD5kYAU4Q+lPxx+CA9DbEE0aWBeULhrA0duLHuTRNPGKWGFsFHMdw6/GqYB936pcaAg/J8QIJOZ+ufVhwLJ7gPtLj31W/R6VK+EwEwLwWZha7aildQArSEKZPkDBbdDNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775305852; c=relaxed/simple;
	bh=yBYqG8f/BNhSoefQs4Dp++NLQbYC5JQ8dk7Ttks9e5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q+lqgXbnKKlBL4mNThnC0c5aQ9bFq55vW6Yn3RzqCZUpMDdZfHYExZkdD/TvSiFXoTmPMibrwT2czRxCtRtnpMNwPGSYyoGZ9e4t4TeJOlUxUHyoST7FgaYiMRlYCippvBCbiTtRqPqZpFHUBICV3DbsKlwjf4FkMwW1nA55PaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vgj66MTy; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vgj66MTy"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b9b1df1a6b3so325639566b.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 04 Apr 2026 05:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775305848; x=1775910648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lQJwHs7LLfBmb1/jGCD5Yd30WkGkaC/E9C+9sb1VIRE=;
        b=Vgj66MTyEIDPCC0y7DGE+EiNoaSz5V9NkCuUmt230xfJAbFbRFp4ZM5vi/lpIbUQNr
         /u1xJqNQEMXDzC46+M/vKwQH4NSFYwWzAZQetRxjyo2lkQHTWw9YV+8AqDPJIwy0n++F
         +4T2R9bKblExYMDEqX+k9lmurs6M5fu7pEululG2gdkmf5+3yOmjQiYMYQqOs5EDUmK3
         9SantYtRwbb5DkXqCdWjZol5bA0DyRaRzQ8OdVWWStofkIFeziyzvxoFvHLIgoPlkj0o
         rtcLlJBmx2V/llCaNlsfb+oDWGR8oG83XK34NhT5/H0dbBcqziYjronia07CJL8ccH+O
         4QUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775305848; x=1775910648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQJwHs7LLfBmb1/jGCD5Yd30WkGkaC/E9C+9sb1VIRE=;
        b=gl9/VuBrcj2UrxCzRCHx6nbTMu6p0JnFQFcd40Cd9/sknzIPQIYXxqabCn/3ZPNvWd
         X1GpfHzhdZ8B72yC9iYZcgAZb2v02XdwJScTdz7lW1W7eW7dheWI9Jx41qkzvE3rBkXa
         kIwcYsvT6mHRFsZQLdwOo451b26SRiHbytAzj8h8/Mrw3iIQNOufQEfZgCxaIFq/wkiX
         r67nK+lDGnzEvMzYKfUnb5tW2TM1KDG8BHsxLvIboqBjMo9B6O8pOxzoLwYixV30xDH+
         4m6DPPbx+5IPjZDOBRpz48wS79ByymrTB8bMKxc4yVtGySNFA7sYDtGB8btpqdXUQzGq
         apuw==
X-Gm-Message-State: AOJu0YzsHfOnuHR/ofVeBn31eSeB3G0EwS82VXTY3UZp4HhbQdHwxUxo
	0KRepfsa/OnkEvkpiXLnx6GULMZ8xoaksaXm/gACRyxLXyZsYajyyNBxJWFl
X-Gm-Gg: AeBDievUBUDAkZuMtOxrCMdHP3FphmeyqMxsK1puVlsXohhYJv9rndhi2oYCuTv0pE7
	8qgiD+i//8oK21Qh36XMMz/orkZeiSu7QulWdpqzu8MVUydAoycI5bpkWeVHY/xTYinjaXy1prG
	FkoC0C3Gq5lTaxuG7BBwdIh2d2u9TH1whivU/CODb5AXORhSQ2zQwwJns4FFha501Hf0lfZ3/He
	vUpjiwX+rHnlgFbnfsvivM0r1e0C7WmykNodTBrHsZYKts/iCAd0FH+sM6LfZj3yKPUwLeRwr2G
	pFW3Pajkg4AEqBMkbgL7ktA/5GZ7lKCDeHNa9Hug8r9HT/FfagWwffWM+T2BPizrn5+EX2Zn9ml
	Fp1Phjh9S0u5EomGsnqi/701ZYPX2oePKBtSKh8i4gtM0udPVBuIUimgNZSROeBmGJv9d6BTXJL
	/+6QTcIvtk3wPtSuvy0VMITH0xo4I=
X-Received: by 2002:a17:906:6a1e:b0:b97:feec:5e82 with SMTP id a640c23a62f3a-b9c67b83920mr340531266b.43.1775305847511;
        Sat, 04 Apr 2026 05:30:47 -0700 (PDT)
Received: from mczerski.lan ([2a02:a311:43ab:e720:8870:5268:2b23:e74b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3d026466sm285940566b.55.2026.04.04.05.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 05:30:47 -0700 (PDT)
From: Marek Czerski <ma.czerski@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marek Czerski <ma.czerski@gmail.com>
Subject: [PATCH BlueZ] sixaxis: DS4: use 0x12 cmd to get device bdaddr
Date: Sat,  4 Apr 2026 14:30:42 +0200
Message-ID: <20260404123042.3049158-1-ma.czerski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change is required for Esperanza EGG109k ps controller clone.
EGG109k looks like PS3 controller but presents itself to the system
as PS4 controller. It does not respond to 0x81 command.
Command 0x12 contains both the device mac address as well as
configured host mac address, so it can be used to query
both. Kernel driver also uses 0x12 command for that.
---
 plugins/sixaxis.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 27bc09815..8e212ee71 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -111,12 +111,12 @@ static int sixaxis_get_device_bdaddr(int fd, bdaddr_t *bdaddr)
 
 static int ds4_get_device_bdaddr(int fd, bdaddr_t *bdaddr)
 {
-	uint8_t buf[7];
+	uint8_t buf[16];
 	int ret;
 
 	memset(buf, 0, sizeof(buf));
 
-	buf[0] = 0x81;
+	buf[0] = 0x12;
 
 	ret = ioctl(fd, HIDIOCGFEATURE(sizeof(buf)), buf);
 	if (ret < 0) {
-- 
2.43.0

