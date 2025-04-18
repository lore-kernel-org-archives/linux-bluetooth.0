Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0212868B
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Apr 2025 21:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745010621; cv=none; b=cBFbDaja8oRb282/dstchMOG5gDjZtW3wRn3GXFEKKxhxHET0rFzUlCQoIokIlRsJzDI+xfuMjr90dbaFiVwfx4HWT3XLP17ftXJkzVoj4lPsUYCsmX68084HbIBekdz2ISSs7lN9lGibcEDsml3SKg2VxETzp9eFN5DFR60lkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745010621; c=relaxed/simple;
	bh=207amQEoabngfSRxBlxgRwnh57fcKBRcJO/EipxXDZ0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jiXZ28FnG4mErGTg6fd7EffXxC6F3Bf7gfz9KLzbBMfzuSYK1jdngnwbQjbmH5HRCR2F9o/bVeqXc2wPw+PqOyxi1WFkLcB4R/escTYYiM8o+hPRPIJO2OAWI5EDUbd8p8JaJoSzsoQRzmbYDbvHth8zNBduI9YL76E1oood0UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fx2Sgclu; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fx2Sgclu"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-51eb18130f9so993886e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Apr 2025 14:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745010617; x=1745615417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=e2WKQyvt1FpuWtr2FS4XAZSIkBKks0mvpixIdUlo5T8=;
        b=Fx2SgclunwGDq2DBB4nq7HzmA9qkxZj15FF5D0BSL1JbOGuPnyWPrypH03rim17gzA
         MqKalpmKXUowYJu6bdK39btFjIkLcImB2tsVB48Yr4WN11pqhlk8hKMiqsbniCAkWELz
         Bbn/uI17E2VhO4EQVKUjNFl+CGQCnVftWrJzt8hH0zyh1eQeBFwjUl043LBi6BbR1f6e
         Ro34TkWilC7fvPJlaMJRawSq4GSzJAqmbCQizuLsoH/6ij4A5P8DaxZ8MZiUmCZyN1yx
         ucWAFTRuFmJUlTBVD8v6Na7Uu/pUQ/p0prOccLohkoC9HLJuURzyYxVDBbv23jIhcM4t
         ELUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745010617; x=1745615417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e2WKQyvt1FpuWtr2FS4XAZSIkBKks0mvpixIdUlo5T8=;
        b=cFOCFPA8ch7O4XJoPpetDzbITCibOn3aYbwjczltoAgoJ/0JzmEWZVoAU2uSiNhhsc
         GOZLktjv7rWNiE+CBh4LO/UDt6CW3vtkr9lZvDhBUEnAl+yStHS+ZNGEE1A+nsz/lR9N
         UuuASapN+Lje1Lv+4CJNs+TDP70lo4ANfQO2snFs0LRGWd0hgon7AHC7uIbPsZIjMtDP
         YF16BrT7iyl34GJ5IFB/oDpSLPU+UbaIYZSfCxAbGVcoIF7kWGpCz984yiyB9I8dpcOW
         vwFVOXGsP8CjtqBdmFQUOfddnkMWtJDK0e8MpQ1BzRj9qlxqYbra5OfP0/UKo9ZC0wtG
         qu2w==
X-Gm-Message-State: AOJu0YwaKAqTPuh2uryjmBFZwZcRra7W3BJFvbUFSaiuYhaZB6Oto58x
	2Ss9u8Y4nIIxnv2LNtitDUIakPepaV6jyUfvVcEdvJsZcIZ6qwNQhN0I9Dot
X-Gm-Gg: ASbGncvSiSfpvm79zkclkbiaXAITmrCUcXwrIN8W72YvgBvDRrqE04DjRWAtfSjA/rC
	jeEqTX+K7W3VJjIxcJ6WeWhpCQX4PKYanIs3Zmc2sGNpWL6PsIkVDM26lf8YytjZRnFcBhnrnGb
	T0RgEVzXZNwUwU6w8S9qDRN2lRKzq5yNpfU/N/l06xjK0bJRjhClgsKFXjhr+Ce5SqpTUdhRdRw
	MazrkNZ0jB5XypPjlIDKIaNzv6jIk1IJXGBiQaSctDBMCBKpa3pMA5rmNejRXqe7jGES8M/1OCE
	w2ypLs18ghTqgjlT4zbO7xSQNbAagnxJxRkk7Jz+GmOdrV5QR7mu7cJTgHtv8JfBcMNfZE+4dzm
	3kw+8V2ghTQ==
X-Google-Smtp-Source: AGHT+IHIF+R/GpGw6+S/UGH0CGlK4ghMjfVp1x854LPb+LGAUjzDDBeu4py770CiDj0le6atC/vS4A==
X-Received: by 2002:a05:6122:1d8f:b0:529:2481:848e with SMTP id 71dfb90a1353d-5292521e562mr3633229e0c.0.1745010616889;
        Fri, 18 Apr 2025 14:10:16 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8776466c8b4sm593078241.11.2025.04.18.14.10.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 14:10:16 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] workflows: Add stale action
Date: Fri, 18 Apr 2025 17:10:13 -0400
Message-ID: <20250418211013.304822-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds stale action to which marks github issues as stale after 30
days of inactivity, after an issue is marked as stale if it remais
stale for another 5 days then it is marked as closed.
---
 .github/workflows/stale.yml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 .github/workflows/stale.yml

diff --git a/.github/workflows/stale.yml b/.github/workflows/stale.yml
new file mode 100644
index 000000000000..c6d6134d9d00
--- /dev/null
+++ b/.github/workflows/stale.yml
@@ -0,0 +1,14 @@
+name: 'Close stale issues and PRs'
+on:
+  schedule:
+    - cron: '30 1 * * *'
+
+jobs:
+  stale:
+    runs-on: ubuntu-latest
+    steps:
+      - uses: actions/stale@v9
+        with:
+          stale-issue-message: 'This issue is stale because it has been open 30 days with no activity. Remove stale label or comment or this will be closed in 5 days.'
+          days-before-stale: 30
+          days-before-close: 5
-- 
2.49.0

