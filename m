Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BFF2BEC3C
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Apr 2025 21:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745358226; cv=none; b=KcgY0+gF7lQd7VFt7la9EYooQb4/irfdlg+SZuwMLOjB41/WDNIgBEaul66uvwFdD2QjzJ2U/CPjIRlivemXlLD9CNv5gBEbITOo/pKh1VIBPTYwhY7VytozB6wAKX0Nbc1BBMx1l9bBGPOm66iCFhZVCGNYNRod6SJ/y/JI4tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745358226; c=relaxed/simple;
	bh=eJhdMAbsXeU8zsSeN92v6AMmWvAgGLbdSDpjRTMsA+k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ttGfrHLp6De1PiI9CtsiIWNRRoGoW8+te3fJ7hkaNfoZoZgaKOn6+FOI0vh/1k9eU7A61WLQRg3mQ8KcRBampZU0GK2EeK21Y+Wg5DdiuLK8z2zMMoHBJefGd2f4vCr5ln/M65wU7O1rkVW40kMVRuRFjZaZ+dTsH1xTmPkFD/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDMy0l9n; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDMy0l9n"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-527b70bd90dso2231819e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Apr 2025 14:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745358222; x=1745963022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YWiDdDDv3fK3+B7pt/iQEwv4r84tJfm03AwnLmEIzVc=;
        b=DDMy0l9nNjbl8/FLAOXYedVVuJ+8sbcgEfUArY1EEJJYAHBa9DWGVHuyDEXe9aoS9N
         GyMhX4lEhb+zfNPfiUjaQxH+AOsa0QmOeqPSEBu4FuJfOJlb/0Z4f3Wx3TTP/iezdVtV
         lDv6aouuOLSZdToHP1J1an/IKvGQF45bd2voEJenwISJ3ICqs1aKjkVPFAFLn7Szu8Um
         rQPspIKxtW15jSfOI+EoifXE82vut/ApqVU+6p/SDYPa09fVCj4JVkd76dwWLOEkrM9n
         GaoWwICgn5Kznd6IlWBg5qT2WLC3G0JLiD2lNBCgckjOXsmRCCuAmBaz8MCPM/nYmdkh
         dAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745358222; x=1745963022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YWiDdDDv3fK3+B7pt/iQEwv4r84tJfm03AwnLmEIzVc=;
        b=LvRLLy+6WjByw05zSLXDy5E57Um51lXJoXKNTiBeCVyCjMjPDzlDZ5pf750cCGoa8c
         /TiQN2hoKwxlGqN21OghkAkwk7mMFP8/DuTZ4CG8/t0QfGZVMFxa106UxnjKxrJUFe2U
         LQ0ymAJRceAmZMKmX/C5jL1mLzSrVDYt9fICvY/rGIjnQ9PevU0MIAG24MZ3MCqHP7Kn
         rUzadbeIHYY/QOYjFVAiTy2EQwh3xR/qka/U3V5FfjUVT738PqSsbQZ7RDZawTo5hFXo
         GFmoZdN1LQCmuz34+OkHlm9D4ZFDRpmS8jMLHWEHQZEsbGkownujoDLReSo9WyFE1Yey
         EVFg==
X-Gm-Message-State: AOJu0Yw6Pv422J9NijtkYk3lRlKHswTUopMCggTGxAnrEckB8+NIDbXP
	iCQ4MX3Wxy4vjLz7990Vmrg69zPnqBtQN6PDphLIYfKY+UYAp70/0SFQdEzzCto=
X-Gm-Gg: ASbGncs1fWRLcBZPXOQTXoVSth1XV3DlAyYrFDOQe7A3FCc/xm75aEZLFMlpmt9RGah
	3Cx2hAwMfSeIOlAEG23dzuGHkIAuMRUNDEXQtXmP8f6bmL8flxD7H/pjDlPGkdx3H+E3AX87sv2
	z0L713ZBmXgIeRK289vn+vYBK2wSSbOyKZM+V0jFV2HQcuNExF+g2z4PM4tXv9eFnVVp8z7cjSq
	Yjrr/7f2IR2miuyEncXSqR3V7puwRdF7Nrtc45dgbVB+vpd38EbSORF0m6EKTGLuCJsbngNHZhN
	fnaZyhcelPjrJE1nxIMjXquSOKmI7EcCK4q4O2KjYAcPeLKSYlzReS/0pS6vCWoiAe3pTFmXZGz
	CoifuIC2NmA==
X-Google-Smtp-Source: AGHT+IGCge1V9ha/2qU9dspOzIxfDUEdXU6qwn3FST8UdT2+Pk3dnkHKW9IH5JieRtg6X/Lif9Simg==
X-Received: by 2002:a05:6122:1781:b0:529:b2:ea5e with SMTP id 71dfb90a1353d-529253bdce8mr15294258e0c.2.1745358222009;
        Tue, 22 Apr 2025 14:43:42 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52922beb8casm2161019e0c.1.2025.04.22.14.43.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 14:43:41 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] sync-repo: Add patchwork job to synchronize with patchwork
Date: Tue, 22 Apr 2025 17:43:40 -0400
Message-ID: <20250422214340.991450-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is required in order to pickup the pending patches and create PR
which then triggers ci action to run.
---
 .github/workflows/sync-repo.yml | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/.github/workflows/sync-repo.yml b/.github/workflows/sync-repo.yml
index 4b106ee4f68a..cd85bdd478c3 100644
--- a/.github/workflows/sync-repo.yml
+++ b/.github/workflows/sync-repo.yml
@@ -1,4 +1,4 @@
-name: Sync Repo
+name: Sync Repositories and Patchwork
 on:
   schedule:
     - cron: "*/5 * * * *"
@@ -27,3 +27,19 @@ jobs:
         dest_repo: 'bluez/bluetooth-next'
         for_upstream_branch: 'for-upstream'
         secret_token: ${{ secrets.ACTION_TOKEN }}
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

