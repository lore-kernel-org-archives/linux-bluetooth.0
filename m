Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A47B44E67F
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 19:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920365; cv=none; b=GAOW0oCcjL3RhmYsDYhVDIxx9pmvIZNzmkWPriP7A/LUpF0GpLpwmbzLn+MFLbA+HzkDCVn8T25Q9a4Tbx8lbDFC/9OJe7WgQZBCQKHy47vEmaeErf8+oTGGhr1OI7AWLbo5f0/OW0Q1KI6HMzL5Gv7RV/VvpYT0M53n5cIUZS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920365; c=relaxed/simple;
	bh=8JNB+35w9Lano8J8NIMUc0MAg2cQjB6ysCX7Ivd6S+w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULmltq+axFZhQfVgq+sGrSpYPUbZwe7pacOgSTT6Nal5RnWOOZf3y2dj6USkmoiGAUQDBB/gVyJEdbgqmCz1vI8qyfEfjZqcuBoUi3JIp7jnY3TeGOcETq7t05jLQWpyYy5Ag45iXMbiUOELkWkXdlPlmoI6+05QzK3OG7TiNss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZlnYJbK; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZlnYJbK"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5bf9506704fso248141e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 12:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920363; x=1785525163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KpdN95T/FiKDdstHIc/UTa2FGWkVuFdAXDTdpTJ0Lzg=;
        b=ZZlnYJbKl5Uv7mg0rV/RRm3p1qlo349IrBiqtv2if5ulvD7TZhFkbSJNlg4Ja3qRRX
         lZpQBfanvXnEeE4Lu7U2ty+lvNMEPEWEcDyan05uI4vrXZmNacGN0zLLKo2PZJHZWRy8
         selibMYCaNd+xKRXxOUJD6Jr/BvNz/p/ACVSLdSpq87bOTAJN8bmgpyJ0OCf7yqWeXmY
         wZBvd5beKrNjrlm2lqMZcGFF41TwQjMkWk40LfX656UaqQcWKmfnj51lZWoLwpM0pvyq
         mwIQXzK/W4RtYezjKCaClh7/ucrh2TjFSvDJ4dGIuqYL5AhB7MeODrNcE4VntetAStXy
         HiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920363; x=1785525163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KpdN95T/FiKDdstHIc/UTa2FGWkVuFdAXDTdpTJ0Lzg=;
        b=ancNYB+nrYgmg+TXQt6Feu9Snvub0aELHG0cI09k8zJHS1H/aTXrXltgOyj4/13LJF
         bIwgP7br4TppwkVX/viDyh9uB8nxe+xlxanxzg8qRb0VtVt7cLMCKvu5mDOmAFOlWcAM
         rHL+NFT5vzB2nBT8fu0NXVuQBKqPGrK78SGXf8mo/hqf+1bSV9WQl1gUSmrRabp3qjH+
         5cL9mGKLqM3CCZZ4cdGzz3/CzuzE5e2YrHjHKxl94U41YKLjCmzZL2zA8aX5xkhuG/K9
         kVPQQakmvBq6Ubm2ZQPp2Gt1um6DOXZy3RzaOBy726BUJbm9M4u5MueAxxKGNl8b91ie
         tIRw==
X-Gm-Message-State: AOJu0YwSD2MPwj5K2lQgAcqzgy3Uu2SRenJzIjAjGk2z+U/T+OSWOHbi
	hlktavH2lVBN3nwwXyGiVwdUiXAd8R6rfjZ7WcDvRuszUcwUyY/+LWcFVbzjM50/
X-Gm-Gg: AR+sD104Hfsxy7SyQHCvoJqVoo8GdPCeNbOBv+OoahORUDSXimlvX5tbO7PMT3MyHQy
	ZEksAhvX9uHA/m+WMjmLq3uKMpBd20aFu0Jms/02u0G2eoMZK+W1x5U6lVj3HulkOQRKKpMHf6d
	/03akVRsXAQHYD2gsBYDqnAlLfCVkgDCmNbXnMS/6ekvpUohSPxdEQnjz+htcvwjubLeS16rsvq
	VEXNpiGEnpeO2n9XlTguYV5Tpibko6JGUGDVbDl3srbjgyNVWLY5I9A5PxvJulP04ybqUiURn81
	tHKsPeCdy+4yTotcgld1sP/5cg2mAatUS/4UIp4ImkcLkkZVrYJMKAPUzbDSY92aGs/Uxm+4nwV
	hqIjgHP+6PYWNi0JGxaFVT0dnyNO5P9auxkFg/A6Q7c1pgEW9+dOp2socOfKh0etmyrBwkfCSNy
	szxpz7XdiAiCoOhJ9z+/PWp6s1Lea+nfs/BDMOSusA9tF5j1z4gb9ANCO7JQzEvDu61MvDTdUf
X-Received: by 2002:a05:6122:3a12:b0:5bd:9dbd:60bb with SMTP id 71dfb90a1353d-5c2da17126amr4164637e0c.9.1784920363107;
        Fri, 24 Jul 2026 12:12:43 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97774c8b921sm488554241.4.2026.07.24.12.12.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:12:42 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 07/12] doc: Document ConnectionSubrate storage format
Date: Fri, 24 Jul 2026 15:12:20 -0400
Message-ID: <20260724191225.1815634-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724191225.1815634-1-luiz.dentz@gmail.com>
References: <20260724191225.1815634-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Document the [ConnectionSubrate] group in the device info file which
stores per-device connection subrate parameters for the SCI feature.
---
 doc/settings-storage.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
index 15f55f9ed908..8bd677e24548 100644
--- a/doc/settings-storage.txt
+++ b/doc/settings-storage.txt
@@ -361,3 +361,25 @@ Long term key) related to a remote device.
 
   CCC_LE		Integer		CCC value for LE transport
   CCC_BR/EDR		Integer		CCC value for BR/EDR transport
+
+
+[ConnectionSubrate] group contains:
+
+  MinInterval		Integer		Minimum Connection Interval
+					(in units of 0.125 ms)
+
+  MaxInterval		Integer		Maximum Connection Interval
+					(in units of 0.125 ms)
+
+  SubrateMin		Integer		Minimum Subrate Factor
+
+  SubrateMax		Integer		Maximum Subrate Factor
+
+  MaxLatency		Integer		Maximum Peripheral Latency
+					(in units of subrated connection
+					events)
+
+  ContinuationNumber	Integer		Number of continuation events
+
+  SupervisionTimeout	Integer		Link Supervision Timeout
+					(in units of 10 ms)
-- 
2.54.0

