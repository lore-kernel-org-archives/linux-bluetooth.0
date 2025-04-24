Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F77292926
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 19:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745524613; cv=none; b=UpGL0tOuyv3DqFiJAEDRtY4hNH70NwaN7h5vn1esBk22YPhLtN8grS2uTAWWGCy25DzLw6Sfh92N4jzKVtxRPrD+DtSuNUKxk3e7VjpmWRwtqESwG55HAxU1+V+EsGwV3Cxy1LDhDPnD6zuYM8FreIQqeGuyT5pTvm3TBmF5fSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745524613; c=relaxed/simple;
	bh=cDvDLDekrJzxFm7cD6fZJ4cCUZ2Noz/cwMLJ42QCY8k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VfB8elB9iCGppi2B537wP4wrFgz/seoLy+es5r5fO2erS/XkM/505XxDqZ8fYTURw2n7t+CNW+KKfVVsfbVBXdctdzSIdcOfD1GCE59iYEzcEdLlKaWByTKm6cpkyLuE9wdTkaLM5NZxHvjby6qUqBpznMGuuNtXyke2aDdufag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPiXpeMw; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPiXpeMw"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-86d69774081so663141241.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 12:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745524610; x=1746129410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sS4RL0z+Ob82qobo4tVa5DU3OE1E+MnCL7mnK/Gkylo=;
        b=QPiXpeMwHkRZ85u49J33eCE3UT4H+WJ8/uIZrSt6mx6DBwXKt2cSfk49g0mfK7TIaH
         88SuhSB+ok2qdTiskUOpY7d2tUXIfBYEZonMWeTnAVT2fZNj+kF2ow5BXQrxQCqz8xaz
         mrklWCIuzG+p5Q1CPosceGpCZL36L/Gt8FkvtBAQ+1GBkR6O8XoF8K+VaROi5E8smSFB
         IwCvCj2Ouge/nc9SRU9IlYdTlNjmoSBHnnCnCZy+HoLA3KeJ1iMCyt0LdvKbraAn8MRK
         cQfeX8SF8eo5u7cVZwDnYAgCUg0qX63D+l/reXxbKUZGfPt1zFlohfOlxug0dsKuOej6
         nKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745524610; x=1746129410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sS4RL0z+Ob82qobo4tVa5DU3OE1E+MnCL7mnK/Gkylo=;
        b=jm597cXoXlUZeLjOwylNhfVEJfiE9fQH3DZ4R1Vks3QWjAD6fZnSfzR/zZB/kO6H2E
         s3nSs757k/5iaMP5vVe03w/ofbzWo2v8LYG8XZp01oMy9Enqh55fdA6ylk5o74lpYcFY
         yX112kevi1q9jFK6STHmjkWfTIKg/tkKucOf7QOatLtwA9nWEXRQUckWcp4tgf1lcSao
         Fu9renVWN58ESGTgtU7YjhjOMlzft7WPe3+IwD6qoN1YDDaJdEHpCIrUpr+3gXEDIpt6
         SpRE/tNIIJFv1hciQ/5FaKrRicR9neCiEpO0aQRIhxDKI+FabArQUYIA7hQYzpENabNF
         cHQA==
X-Gm-Message-State: AOJu0YyU9UPvw1vLwP9JguniWFZuVqFsQyOZpC3eT2u2FJTR8Mummu05
	oeQ6TyEXGVpuzGjjHLzt2h4jsts359iKvyCY/JIHZDJTANlHfVkBbUo1Jg==
X-Gm-Gg: ASbGncuuYN+3zvo37sY3pROco9idGElTn3lPEvgNvx2tJn4PwRs2so9xOHGLyj8xR6G
	ppYCLndUEIAAVg1Fvqqa+MiVM3WP9H5wpqKAh2P4SfxitW8J9fPpwFJRdkjAfDp8Q6LxMpPw4Oq
	q+EscfGL5QHuG7P5cOpRekuTKQqpc6xZXHiWwv04/fNT/CG6cJLMhWYZ6jxC2dwzsHWvwFXAWUk
	cb+zVjQ/8kIWqSjUlK/N2U4DWLcgp/L/UnaXT0tCLCzIqC8BwpDeT1Y61Kmin++TNxPkheQnZZL
	3veZunnHyhN867s8uXzzcPycvmfM4qfQ8bbOGTQE555Rk3aJcSLKFCCE4wy/dUOzP/+VbODQQQE
	KmPY0mtvENw==
X-Google-Smtp-Source: AGHT+IFn2m0eH5Da2wjgZ+pUSbLYhIGWLW8qP+hXpRB7mv5P1CRgiiFJGwXHLT+OZ/eH7Jm3rkcj6w==
X-Received: by 2002:a05:6102:5793:b0:4c3:b0:46fd with SMTP id ada2fe7eead31-4d4d007eda6mr1375610137.24.1745524610008;
        Thu, 24 Apr 2025 12:56:50 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4d3d49a9108sm379884137.5.2025.04.24.12.56.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 12:56:48 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] workflows: Add lint action
Date: Thu, 24 Apr 2025 15:56:42 -0400
Message-ID: <20250424195643.1375697-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424195643.1375697-1-luiz.dentz@gmail.com>
References: <20250424195643.1375697-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds lint action replacing the custom CI one which will be going
to be disabled.
---
 .github/workflows/lint.yml | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 .github/workflows/lint.yml

diff --git a/.github/workflows/lint.yml b/.github/workflows/lint.yml
new file mode 100644
index 000000000000..9f775cf638f6
--- /dev/null
+++ b/.github/workflows/lint.yml
@@ -0,0 +1,32 @@
+---
+name: Lint
+
+on: # yamllint disable-line rule:truthy
+  push: null
+
+permissions: {}
+
+jobs:
+  build:
+    name: Lint
+    runs-on: ubuntu-latest
+
+    permissions:
+      contents: read
+      packages: read
+      # To report GitHub Actions status checks
+      statuses: write
+
+    steps:
+      - name: Checkout code
+        uses: actions/checkout@v4
+        with:
+          # super-linter needs the full git history to get the
+          # list of files that changed across commits
+          fetch-depth: 0
+
+      - name: Super-linter
+        uses: super-linter/super-linter@v7.3.0 # x-release-please-version
+        env:
+          # To report GitHub Actions status checks
+          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
-- 
2.49.0

