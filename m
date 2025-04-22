Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E142701CE
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Apr 2025 21:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745358581; cv=none; b=OrC+YNrSpw8zCGTYJF/k2hEXuM9yYHZVm8S2qFwRgQ5rw7l/RCuRvhlPgqoBph4MkFVKr99EBI9cOU9CIiMPmcTsTRAnCplSsgl33ytvanQaI6mJyNwimGaplrZMjGH95EY4BsQYLQpUcacNZJZlgC8f4TyfiIr6ASpeyeeDCd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745358581; c=relaxed/simple;
	bh=TvZjBIaz4uelar/xVn2bol6G3rXPbXUMwlYkoAUA1JA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Cb2PLJv58oBZZOfY57WppaCdD6JHmIVqm5i+sOEiNMK38lTUx0OT3W0OU6nvUKV8XhE/I+kuziOc4vu1qvqTT28N2mtCkXRCC9clCDjPGuEBPq688PsSTzf1ZSsVfymDO5gSx2Q/aYr5GxMOYTMIeV+aryoXyEFIiJQ4G7Stmjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSFQZOUP; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSFQZOUP"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-528ce9731dbso1618844e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Apr 2025 14:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745358578; x=1745963378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vSOCGxtIG/u/KBm/Rn9S7GObnbkw+yuzfmL2XWaCw4c=;
        b=lSFQZOUPnfGJBaFD2boH5HX4ODbAsVviade6fmcMiEL2sGJFoYguGRGkvMA2pcJLyQ
         zG1PHL22AkxbcW0Nq/au+8HRg5X6Fuo+kKpoRz3EPh9sCIrKOpFM4iInZrRUSF2RKaqd
         5y1glB9e8vNjOg3UICbmr193o3P++abL4hxnjjw7A9rT6D7nrMBYNjDVk4OkmbuU/IRa
         MGdViqCUgKukiTWbO5PbkTmsBumnlSux+c6+WzPoaReyyIUlW8lojkyA8C68YFPln27S
         ctqth1HAFTMjhoUC6ZbYT6hy3HDGp02oh+vXkPMiZ0I5Wcrg5jf6M2189DNFlhggzflc
         1gtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745358578; x=1745963378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vSOCGxtIG/u/KBm/Rn9S7GObnbkw+yuzfmL2XWaCw4c=;
        b=Zgwyw2lGXMftILXWCUBoHOA5bX9S7UO3O1DOrkSf+P3Y+U8Rfu7Mk5uEo1O0uMMXMd
         EBh/YOsE1Mhzpsi1c4RXOtE/BUHiWnwqLtH+rXzn7i4omgPF0+1kCUWK0DvvxzCJt/gU
         2GuBGSPDPQ5xBWfXsEFWTtS18QexrADPsxCO6zWMfPG2yzN68SVW+/uwU752/2TKm5ev
         rBhVnaBJBiH56zNhO+6O2qAKf2VDSGyxZueWuZUqWLPPVEA8T3WJYdZ9WtCAVRE894jj
         HCraOwAuWvcn7Hyp1Rj9URMiOVLWCjf4iXRhva4POnHsL0um2UPEdJrkjZR9Tm4dOuqc
         I8HA==
X-Gm-Message-State: AOJu0YxpLz3k/1xRNxD4pepnGYE24QTaZW4ceyfjg/4UYr2JTT/fPmF2
	nAhvbyTDTY63ZUT1hn2ul7Oofw4lL387dOx+YlCX6id1tEV08xC7J8YaNWBPStQ=
X-Gm-Gg: ASbGncunbsDb8Le9+9tQzPlzBXaVQTyzpHghEOk4OJumus1EjNlc0syZb9CCajrB/na
	zMHVeJ2KQur/26OcgzrcRxhjYRIFgJi8AJRu4tLBjW3vrb9/5ymbYfzS3HTUQqttQgzCkD6/xBo
	eLh2VWdFlsBqfTl3N2BJDsOKERc7ioVM2rGtyxDI+EZHqgE8yNpaiZvVVAXhNCcwJLFyBS0e1o8
	pzFEiV7r6F3Od/iSQfQkCbr4AYDDKoTUc+5p7hDvQu+N6BeTN+wmR5WK5dD2jupIvTwvwx7YMus
	MfXcTK+9r6XxM5LG5aNP8uccFaQl0UPtFplD+muPm7ZIdZT3byl59V7m2c4loGKGoNRtyjXSHqs
	jQ0F6jM7jVw==
X-Google-Smtp-Source: AGHT+IEdEEfVC/jajTXNrMu1RUHffsSskgpNBycmjghSxEKThiZ6zuHrRlKCkAhM5MTvNp3S05MjUQ==
X-Received: by 2002:a05:6122:793:b0:520:6773:e5bf with SMTP id 71dfb90a1353d-529253bd450mr12376611e0c.1.1745358577723;
        Tue, 22 Apr 2025 14:49:37 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52922c141a8sm2112155e0c.19.2025.04.22.14.49.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 14:49:37 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] workflows: Add sync action
Date: Tue, 22 Apr 2025 17:49:35 -0400
Message-ID: <20250422214935.993192-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds sync action which was part of https://github.com/bluez/actions/
but it gets disabled every 60 days due to inactivity, in addition to
syncing with upstream repositories it also syncs with patchwork which
created the PR and then triggers ci action to do the testing.
---
 .github/workflows/sync.yml | 45 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 .github/workflows/sync.yml

diff --git a/.github/workflows/sync.yml b/.github/workflows/sync.yml
new file mode 100644
index 000000000000..cd85bdd478c3
--- /dev/null
+++ b/.github/workflows/sync.yml
@@ -0,0 +1,45 @@
+name: Sync Repositories and Patchwork
+on:
+  schedule:
+    - cron: "*/5 * * * *"
+
+jobs:
+  bluez:
+    runs-on: ubuntu-latest
+    steps:
+    - uses: actions/checkout@v2
+    - uses: bluez/action-sync-repo@master
+      with:
+        src_repo: 'https://git.kernel.org/pub/scm/bluetooth/bluez.git'
+        src_branch: 'master'
+        dest_repo: 'bluez/bluez'
+        dest_branch: 'master'
+        secret_token: ${{ secrets.ACTION_TOKEN }}
+
+  bluetooth-next:
+    needs: bluez
+    runs-on: ubuntu-latest
+    steps:
+    - uses: actions/checkout@v2
+    - uses: bluez/action-sync-repo@master
+      with:
+        src_repo: 'https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git'
+        dest_repo: 'bluez/bluetooth-next'
+        for_upstream_branch: 'for-upstream'
+        secret_token: ${{ secrets.ACTION_TOKEN }}
+
+  patchwork:
+    needs: bluez
+    runs-on: ubuntu-latest
+    steps:
+    - uses: actions/checkout@v3
+
+    - name: Sync Patchwork
+      uses: tedd-an/bzcafe@main
+      with:
+        task: patchwork
+        space: user
+        github_token: ${{ secrets.ACTION_TOKEN }}
+        email_token: ${{ secrets.EMAIL_TOKEN }}
+        patchwork_token: ${{ secrets.PATCHWORK_TOKEN }}
+        patchwork_user: ${{ secrets.PATCHWORK_USER }}
-- 
2.49.0

