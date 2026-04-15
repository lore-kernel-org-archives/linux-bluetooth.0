Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564E334C81E
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776277345; cv=none; b=nHXyRIVSkuw/Zv5QUKIo63Uj5VrZcj3xr4HrCl1yD4UEQLfZBiIc8F3Mj6FrVb2YVIr3N4CTgIoVDiR8cpE9aOwQidRin0mi63ScbGOahIGulhbYLrQDZ4JQy207DrfvBgJjXSfRWG13vAUftFuZfuZR9wQZ/n7/9F9ZC+sYD94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776277345; c=relaxed/simple;
	bh=XbEAWuHs3c8UIilRdmPJMHyOqCFzAqoop15XbwC0Nm8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8+EIxlMFN3fUz5pM+bYCS8AKTyqJ5gk7hcMLulYdafDo8Z8HbR3h+XJ5cqz6ijigPkB31XpkgUNa5Dm62230OsnhtBd929+QeCfKm+3cwlkhZM57p1qt2eJj/RPRrJclG1SH9Y0mAxBO/h+68+ePj1bck2Ls/wb9QpSz6y5QWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llOJPcts; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llOJPcts"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-94e2ad66abcso1928538241.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 11:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776277342; x=1776882142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nBN2HIdLFk+wEmHsm7xNPU61wSYItdcuea9X1Zxo/2Q=;
        b=llOJPctszQ1Hxx5bXdh2Zkh6pCUkUJavcgwwpjwYGIWayEAozDUDWkEpK8tc7XUtip
         a41rg9AGAmc2KHJFXaOJE49v0l1fIS9jVeOJhwxnIRlUPVjNZZIw85aj+IfNMmcRtcBe
         5lj+EKL6tUJhyQSImWxqli3Re+3zzXfAqN1FxiHrM2n9XZOfl2Nz53EHZgUVdMHI5Md5
         jsHuYvDvZMebKISTn6d6iFPlepp5ASqGmD7Pz8HY0Js4X875i0QBLohEySjYNLN9Bs54
         gogHgCiyQHJ5W1aOZ6cAcxGnZziwFlRuFB7I55JjCAX/XmdTqTmTRAXyzS0uHVkoPWrs
         ysnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776277342; x=1776882142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nBN2HIdLFk+wEmHsm7xNPU61wSYItdcuea9X1Zxo/2Q=;
        b=RIK2hGmt+xUsywQ6QJCszB9pzQaBjvaG7Evh247fw7sRHELhS5+Vf2LeY8yylVP1Pz
         yvASe7dCa8cLlwildyZjVKKpHxhJJ3ywoYIwZdoAz+/Ig/P4peGLAhOfi0l8CrQuBQJp
         JxMTa6itbC0CCdBMYq4/f/HTnF9lM/FevBD98Btwk2/2hW8FE+XfD/6IkRIkf8LV14qa
         IOIeEdVPK0OJeeteHFq+9qfqUQk44BhnchHHg+0gQAbBRaJ/vHSjkrO+Asnm2xu4S/29
         Nkp0MzY6DSTXfgLFdu6vI7wsTUTEQ/uHDQj8Zl+iwLKM78LGwugJJShKaqfdWnyk1G8/
         3lgg==
X-Gm-Message-State: AOJu0Yx7DkKbx8qWXEFNBWUs5WiJvhL1VC82bCle7zcu/gMvqnBdV+7P
	Wcdpo8VlXe+LzBCvKbOsF4gx4M68thePypJnY2/VmGpu2b3UOI0/DkGCKIJ2HNS7Mo8=
X-Gm-Gg: AeBDieuMNtqyjsqfrnMaojsYjCVHJ9zg2YGCJU+meOfEHyRVP4/6IoBKLhd0cbTtjYm
	OX5ErLfe9sQJb9hjW75zvjDbA2w6ZFfrTk0PlC41XhLcWbCOLJL1+migisgT5SnTnsJhwQg0jfI
	4Sbh5oW1jRa+PztCri4dsAmsQpK3e/xWIeOJVLawYCB3k848TXZ7Oj7HmcVk9NjYa/yoQy93tSX
	bm823SdIpCjIaPyXaTRgPNLw1jxBf/FCOTkyB81dRCDsx7iTtRu5urifZwDZRZAP0uNDViPsKuU
	tE3CT8kOf65q94ZtH1xwaN6hj3nZLB7XPJOglQfkGUtCaS9jbNL26keQXTyORLZ/Ol16rUqztUS
	HTm3chAApJ6PRl3h0xBjTJU+iXpIHMcgVqIvbOZUJgdzgkkiHWlqIHA3SqdkGyg28JgFU7StbKM
	AnhfE8s+ExQPg0cYq+p0q1S6jmpsfTHtE8HflEIBlfdM1vEvxb09/LYC5WXUncmE8Y8FbFJ7I1R
	mqlutW8wgNlR6Y64hpUEYgdTNW8hH4Am5HZJMM=
X-Received: by 2002:a05:6102:161f:b0:5ff:cb2c:a04d with SMTP id ada2fe7eead31-60a00629d70mr9686792137.17.1776277341910;
        Wed, 15 Apr 2026 11:22:21 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-612cf10e76csm1219063137.8.2026.04.15.11.22.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:22:21 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/3] github: Make result posting robust against action failures
Date: Wed, 15 Apr 2026 14:22:08 -0400
Message-ID: <20260415182210.514686-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415182210.514686-1-luiz.dentz@gmail.com>
References: <20260415182210.514686-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Use always() conditions with file-existence checks so steps 1-4
results are posted even if the btsnoop-analyzer action fails
partway through. The error comment now only fires on actual action
failure (e.g. btmon build error), not LLM errors which are handled
gracefully by the analyzer.
---
 .github/workflows/btsnoop-analyzer.yml | 34 +++++++++++++++++---------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/.github/workflows/btsnoop-analyzer.yml b/.github/workflows/btsnoop-analyzer.yml
index 3bbd963004cb..9ecda193ceff 100644
--- a/.github/workflows/btsnoop-analyzer.yml
+++ b/.github/workflows/btsnoop-analyzer.yml
@@ -100,12 +100,14 @@ jobs:
           GH_MODELS_TOKEN: ${{ secrets.GH_MODELS_TOKEN }}
 
       - name: Post detection comment
-        if: steps.parse.outputs.found == 'true' && success()
+        if: always() && steps.parse.outputs.found == 'true' && steps.analysis.outcome != 'skipped'
         uses: actions/github-script@v7
         with:
           script: |
             const fs = require('fs');
-            const detect = fs.readFileSync('${{ steps.analysis.outputs.detect }}', 'utf8');
+            const path = '${{ steps.analysis.outputs.detect }}';
+            if (!fs.existsSync(path)) return;
+            const detect = fs.readFileSync(path, 'utf8');
             await github.rest.issues.createComment({
               owner: context.repo.owner,
               repo: context.repo.repo,
@@ -114,12 +116,14 @@ jobs:
             });
 
       - name: Post filter comment
-        if: steps.parse.outputs.found == 'true' && success()
+        if: always() && steps.parse.outputs.found == 'true' && steps.analysis.outcome != 'skipped'
         uses: actions/github-script@v7
         with:
           script: |
             const fs = require('fs');
-            const filter = fs.readFileSync('${{ steps.analysis.outputs.filter }}', 'utf8');
+            const path = '${{ steps.analysis.outputs.filter }}';
+            if (!fs.existsSync(path)) return;
+            const filter = fs.readFileSync(path, 'utf8');
             await github.rest.issues.createComment({
               owner: context.repo.owner,
               repo: context.repo.repo,
@@ -128,12 +132,14 @@ jobs:
             });
 
       - name: Post annotation comment
-        if: steps.parse.outputs.found == 'true' && success()
+        if: always() && steps.parse.outputs.found == 'true' && steps.analysis.outcome != 'skipped'
         uses: actions/github-script@v7
         with:
           script: |
             const fs = require('fs');
-            const annotate = fs.readFileSync('${{ steps.analysis.outputs.annotate }}', 'utf8');
+            const path = '${{ steps.analysis.outputs.annotate }}';
+            if (!fs.existsSync(path)) return;
+            const annotate = fs.readFileSync(path, 'utf8');
             await github.rest.issues.createComment({
               owner: context.repo.owner,
               repo: context.repo.repo,
@@ -142,12 +148,14 @@ jobs:
             });
 
       - name: Post diagnostics comment
-        if: steps.parse.outputs.found == 'true' && success()
+        if: always() && steps.parse.outputs.found == 'true' && steps.analysis.outcome != 'skipped'
         uses: actions/github-script@v7
         with:
           script: |
             const fs = require('fs');
-            const diagnose = fs.readFileSync('${{ steps.analysis.outputs.diagnose }}', 'utf8');
+            const path = '${{ steps.analysis.outputs.diagnose }}';
+            if (!fs.existsSync(path)) return;
+            const diagnose = fs.readFileSync(path, 'utf8');
             await github.rest.issues.createComment({
               owner: context.repo.owner,
               repo: context.repo.repo,
@@ -156,12 +164,14 @@ jobs:
             });
 
       - name: Post analysis comment
-        if: steps.parse.outputs.found == 'true' && success()
+        if: always() && steps.parse.outputs.found == 'true' && steps.analysis.outcome != 'skipped'
         uses: actions/github-script@v7
         with:
           script: |
             const fs = require('fs');
-            const analysis = fs.readFileSync('${{ steps.analysis.outputs.analyze }}', 'utf8');
+            const path = '${{ steps.analysis.outputs.analyze }}';
+            if (!fs.existsSync(path)) return;
+            const analysis = fs.readFileSync(path, 'utf8');
 
             const footer = `\n\n---\n<sub>Analyzed by [btsnoop-analyzer](https://github.com/Vudentz/btsnoop-analyzer) using btmon from [BlueZ](https://github.com/bluez/bluez). MAC addresses ${
               '${{ steps.parse.outputs.anonymize }}' === 'true'
@@ -177,7 +187,7 @@ jobs:
             });
 
       - name: Post error comment
-        if: steps.parse.outputs.found == 'true' && failure()
+        if: always() && steps.parse.outputs.found == 'true' && steps.analysis.outcome == 'failure'
         uses: actions/github-script@v7
         with:
           script: |
@@ -190,7 +200,7 @@ jobs:
             The automated analysis encountered an error. This could be due to:
             - Unsupported trace file format
             - Trace file too large to process
-            - LLM API rate limiting or downtime
+            - btmon build failure
 
             A maintainer will review your trace manually.
 
-- 
2.53.0

