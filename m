Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4002C15AF6
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745507745; cv=none; b=ueOyEgWHxKoNu4KanjOdoVFT9lgDWUdoTGSY18sRTsZdVEf5/OeM8gGw99s2O4UhvU20NZe5+CgQnruu0y9fVvPxGUWA80VQfIODd6T5Skw0fnr3Ftn6kB8sNiSZUxsRzWIBhEdRkOn4F4JKWZc8d4yXMrwPBaCWFOXBtwXiIEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745507745; c=relaxed/simple;
	bh=ZoPVAOJDQzhfg9OPMMVhujqJnQeym53xxN8RwyB+anY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CJDUy8bIkoSRxkXiVzYvToF2q1XqoGW/NybXg8Y4u3xdZeFKXZbHUWYvU0d2pbf1nJMQ4EBDaKTaXCOZsXuQZ9XX23oa4fuu7nm2PF2wyySvwKHFIdVudLrg0o7KzsxL/s4S3JRsAj9skvQjm0RTDT9sjQpQdkW1dE+voUPoLgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHdGTQ42; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHdGTQ42"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7304efb4b3bso492391a34.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 08:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745507742; x=1746112542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pkcss/TM2MHloD6MI4Ns+2DzAlXVCK2wvPNu4g9L6WY=;
        b=KHdGTQ42ZKRseCYg4odKddR6m8qaz2k61yilQMvSqgdn4zm/8/O35D9h80jHElWUTZ
         VzHqAuoLx2ICqs19RklZhn26drOEeeEk6FNxq8K0m0iPSVMDNV3O+TwMTQMMiQw2DLai
         i6Y285pNlul6eETOff8dAqoBzoA4NUn5G1WwTOIQz+m+H/doF5Dmu4ZWUB0mWmx0c8+5
         eBl5GBHXRF0KOpXdL+2lR+LiZ0BFIcFCkDTUdAu5GJGu+r8QPfBOkZM3hd8hcUaFFZYJ
         fcrSCObGXsaFUkbFMdlX0rXtLFZO/yrnU01sUHTj3Sk3fBYfAH8nH49Urb2mP2Mf376V
         yB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745507742; x=1746112542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pkcss/TM2MHloD6MI4Ns+2DzAlXVCK2wvPNu4g9L6WY=;
        b=QqEGFfWxH5P2pRuWQBgTaKXdYZ20qbpS5ifubZXGzww9OW9OfNTNtDD0CRMTez+HR2
         idjldxKS5I80/ph4dY0xGIFjcTFLYmDc5L3pdofJKFedHyk7IiXZMx3xT2+NFYUh4kQw
         CimsXcV6+0Ifvv6IvR9gEfwE8m2libMK8wofGtI3pvex3uWgUaaZ8EWKxq+PA45PG7yG
         YEbTGJyuoKgPD7wkdAEAHIq19dfuL8r05KCkuBrwj5adTZqfnQ+3HoOzdeF9lFkyo+Ae
         hrZEfDz9MHH/JHRQwC73UVJ3FnV5tntTCqUgyZdzp9VSPMv3csLQI45KDZ8vbG2B3H9K
         hizQ==
X-Gm-Message-State: AOJu0Yy5HP3C6KLGwXpPefE3oDlK4mTMgfrbrWpXgWvq4jtq6pP7aoEG
	/L+//r7GWdihNrZRDgp76XbflXYYPWNqwOsGoSrUd644jII44L/v1m5VCg==
X-Gm-Gg: ASbGncunXRrIsv9prBNLZaCfG8l63CKEUMUMhhRIPVA6ZdL40KjzP6RP4U76oTyhkqt
	DgExidWfY+D240nHJuQU/YS4faDwOPWfB6CWWzkZhmOHIO325+xJ/ZT7J6akcczey+60qDoJHX9
	h3i6y4vf1ro/hvwFT2ZGDAVK1V3TmMQ3227XKcWX8g+ZMFEdd8dbs9ftG0Hsg3n0ohJEK/eAn58
	E5ohPfvtmrR6RT4a+lJbuJHYNtUqGoFmvW21khZ/trjtjh3l2+iGrh0qGYjPd8itAZ4tBf4ZwPG
	u29Wrca7crMLPkwiqFDEH4MUQIP8iH98tP39eLsrRQs1Z5Ba9BQ9HQFTdsw1guinckWeqFc3BuD
	EAx/W095vrPgvsd1og0ux
X-Google-Smtp-Source: AGHT+IGqlw4i9Kdd5NsxYEu37+6ha1ewxAy1MgzEnfwMs02OkvU44fguwWdkqY+005IZHkaPfsaC4Q==
X-Received: by 2002:a05:6830:6382:b0:72b:94d8:9466 with SMTP id 46e09a7af769-7304dbd87c9mr2162499a34.28.1745507742448;
        Thu, 24 Apr 2025 08:15:42 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-877aef6bc07sm324349241.34.2025.04.24.08.15.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 08:15:41 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] workflows: Make use bluez/action-ci action
Date: Thu, 24 Apr 2025 11:15:39 -0400
Message-ID: <20250424151540.1322778-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This replaces the bzcafe action with bluez/action-ci so we can maintain
everything in the github bluez organization.
---
 .github/workflows/ci.yml   | 2 +-
 .github/workflows/sync.yml | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index 9d267e1ccc95..a47492740569 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -13,7 +13,7 @@ jobs:
         path: src/src
 
     - name: CI
-      uses: tedd-an/bzcafe@main
+      uses: bluez/action-ci@main
       with:
         task: ci
         base_folder: src
diff --git a/.github/workflows/sync.yml b/.github/workflows/sync.yml
index cfc58530c32b..5b3d7d6355a0 100644
--- a/.github/workflows/sync.yml
+++ b/.github/workflows/sync.yml
@@ -48,13 +48,13 @@ jobs:
     - uses: actions/checkout@v3
 
     - name: Cleanup PR
-      uses: tedd-an/bzcafe@main
+      uses: bluez/action-ci@main
       with:
         task: cleanup
         github_token: ${{ secrets.ACTION_TOKEN }}
 
     - name: Sync Patchwork
-      uses: tedd-an/bzcafe@main
+      uses: bluez/action-ci@main
       with:
         task: patchwork
         space: user
-- 
2.49.0

