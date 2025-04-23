Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CED63CF
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745434797; cv=none; b=hg1QRSropgWtKthJFjpRiXO5MWd2x1E4Si2ZZVvxRDH/Zm9jXEop51Rx8l+5a2sipk9HQke5L0CuQt50OUaCul4+JvViM/sS64KW3eh6IBinSrloDfnJf0Kn1zmjysI2QrlInMNGDuBzOr6oM0PavIeMgEGGsaRSoWkxGmfIwdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745434797; c=relaxed/simple;
	bh=8AnlQHf29eF4RG/KEBMsqjq4tWQXRqS7AWdgwzneXY8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=J9U1G0hxmHolUheumuS4jUcEZSN8jtMQt2ClXaYY0Txif7Wy8d/VYaLOJZ4+XXwiIr8B2TO6JJgKyKi5YmPbPbO+68/m5+Gll6YoT6zlEINSxGduOlQ5dED4RK4I+jrj0XXzqB9HFz9NBjsGd9IhyK9jP7i+2yk+85VOz/Z2RMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPB553aV; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPB553aV"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5240b014f47so92775e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 11:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745434794; x=1746039594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kuOBG4C96kc7AfYad8YiFQQfhLE7y/MEQERh7KPRhKc=;
        b=bPB553aV/mpPh0vAaR1qO9Vf72od7tNaEPrLsFA/EWIlvOv4BQvaYupD7+ThMry6R/
         47Mc6eZ7hCUjBZaFGQctZOmKmAIdmDY8CodTRYUQMznyNjFifcum2i8G7bj9auoStvS9
         uIeshm+IA7u6r2Tb2Rqa/Op8FyxbpskH8kdX8C/n49oPcGwtucc3L2cZuWxB1UXbfhO6
         JNsM4b386fU1Xg7PdxyPQOTDz9en06EYSMO5ccLBur5h2u5plwlGkzUCYEgPQu8TM8Kj
         tASOIFUFhk/NDTYpiHvAZSANribCRO7xAKG0Fdgh706lJRezSzr9zaUtr9/4v/AhbREc
         JW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745434794; x=1746039594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kuOBG4C96kc7AfYad8YiFQQfhLE7y/MEQERh7KPRhKc=;
        b=UUyjYw8UsmD9HfXn0fxqI26BHZ2nYWqMWaFCGOFtHLkKz42hs+dI7y+DOA2j2XRXQE
         7TD1OU+uyWjGEihOIWPmmFHjBNC7VR+gLbS/hu5ZR8rV95mRXADALn2Iiohi72PnHFyg
         2nWhO2HvtyADFMYVXwaUlZZ8cQZI2flVqwAyWAsKOdqaRcM0OJBdlCfL9sICxBZp6dcb
         q53gZGXAztRFh9eZNmbNORkuCuPgARy1mEiPHrNqJ6G+mr6SThyI8RpfMyuyEgM0Z+Cw
         ME/lhSErfFPKkP7fJSq30TJW1PXz78feCwVyB1DN0TNdujFYmN2qtbSAvTibgC7Tx8hW
         vVzQ==
X-Gm-Message-State: AOJu0Yy/gmL9yw93/TDkLvZCgJ48E7B2w4BRO2ZitM9S0/C7RlnHDlOw
	tvaLhMW09+FaNRShaP/o5MxRY0cTBsfWrwO7m0MFj3vMzD05TD+oDI0J/D+Z3fc=
X-Gm-Gg: ASbGncsdmHvyO8BSLWZnZzCVVPIJ/jw0o07J/S+4kyf6C/Z9NBcNkINKQ9E2NIfyhOQ
	pK4TuGGtlc/DctNTw+8Xnb1p6UJ0Yz6D6xr/I7vQ8ENbdovhjGaUqtAu/lBk8X4opH+EWDprBhX
	jRS+NXzruRh/MyVjwrrPSGNm4Qa8Ks3HGQ/LzDgIHsaCk6btCoEfq7/3mArrNbDX6276JiurbjL
	SMWU/UUT1s0UJ3TERxdb3Q0P7U1lHuMkxUchan9cJV6isWG7ia+sThcEfwJ+DMxFfsk17q6E3fR
	B6fej6zUfF/4HyX2fyi9Afg5DUJQ4tlfSnvjFT9luwGc9OE50k1f7qskfdHWpPgD00Z+pxY9fMG
	vznBzvKa2Pg==
X-Google-Smtp-Source: AGHT+IHIgluCaEUcsKG9ONhnmmhKe/l4aYQU4dpFldfJmncdecKzF7j5Uz7YtzkKTRe4WQ5OOLwBRg==
X-Received: by 2002:a05:6102:4b03:b0:4c4:e36b:e8bf with SMTP id ada2fe7eead31-4d38cf2516emr164763137.3.1745434793822;
        Wed, 23 Apr 2025 11:59:53 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4cb7e00090esm2639200137.20.2025.04.23.11.59.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 11:59:53 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] workflows/sync: Add Cleanup PR and Sync Workflow
Date: Wed, 23 Apr 2025 14:59:51 -0400
Message-ID: <20250423185951.1171350-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the missing tasks of Cleanup PR and Sync Workflow which are
required in order to properly handle the PRs.
---
 .github/workflows/sync.yml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/.github/workflows/sync.yml b/.github/workflows/sync.yml
index cd85bdd478c3..48def96b8aac 100644
--- a/.github/workflows/sync.yml
+++ b/.github/workflows/sync.yml
@@ -34,6 +34,19 @@ jobs:
     steps:
     - uses: actions/checkout@v3
 
+    - name: Cleanup PR
+      uses: tedd-an/bzcafe@main
+      with:
+        task: cleanup
+        github_token: ${{ secrets.ACTION_TOKEN }}
+
+    - name: Sync Workflow
+      uses: tedd-an/bzcafe@main
+      with:
+        task: sync
+        upstream_repo: 'https://git.kernel.org/pub/scm/bluetooth/bluez.git'
+        github_token: ${{ secrets.GITHUB_TOKEN }}
+
     - name: Sync Patchwork
       uses: tedd-an/bzcafe@main
       with:
-- 
2.49.0

