Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7197F2D1914
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072459; cv=none; b=GgwApPsvKsixfWM9urGmO8PouZZc4QumSEzfh0D6lEs+Zgqa5Fp6RAYF9yt43NpFJ7gzHZI4gsqOxvBRyVwEeoohAgZ3RAYYbPhn9q7mfxWUeDvO1GttO8w3US0pCWaOSYqI4WYdNzoWOFQ3s1EwlY2seU6Q/7/DKzpr01J49VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072459; c=relaxed/simple;
	bh=q33ce8+frqKgGaRpVRO1z08J/7tP+j9aTiTDexbSRLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MH7BAu0a6ivbhn+b3JK5o82AphO19/wO6u9GBDeOy6GHx8t12TFUFmD4LvuNjbTXrl70hOm9N8R+2PkYmJBmxENDY6SFNrzRrr/5HejkutSP/kDpX5CV1qRz3MNpZJA9xjsPO+0oJXNqXMC/A0O2NmclmZBUw9Ju/kv7r0H3Dn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=edPuFj6j; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="edPuFj6j"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a54690d369so11523f8f.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Jul 2025 07:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752072456; x=1752677256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4NtH0feHwwUczaaFj41kCVHxJaG2GKZc+XLPiyiigkw=;
        b=edPuFj6jJg/2IGwu8uMXKqZtKJbnOxl+5C7jzkYK8z8FN/NboDPBDjDf+7OiR2qEZF
         O37UcZesOkkJpKoZy+6+Ipan7jYIFmMMAae5HUoMtbZbZIw5aNSY0u+7mCDxY0gFjNM7
         5zHcbcZqr+J4yX+GGZFVA9hc0UIj6dCDAc3xN7G9sWvwyySv6hspk614jisM9ceh1cGL
         ThiKc3OiT4wcF2dLDj6JMDvlQKs12/NRRPO5On2U4IvA9wvhvhRyKT+NQJUe6B/svSp0
         1GgtJwT3feFH4MoJAfDoxi2Ed/7H20WeSAjHEBqUC5jI8aoTW2l59JwaxwR/Er2neUiE
         oLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752072456; x=1752677256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4NtH0feHwwUczaaFj41kCVHxJaG2GKZc+XLPiyiigkw=;
        b=fwRQOW4jUNRhRaAOkJHNR6AmX63W4OD7a+rty0iVrvWOBeG2NbaEHBI3VRPVnGf/do
         c1oe7g1eU0TzRcbxw9OFsdq0OxHUv+SeDpcXm6AXbIWay4iLrXaS58EK2X6jCILj/xP4
         0EUD6BmFR24j2Nx3mSsMqytZE/zAwV9kQ7LCV7Qss6T6zSZa6byuBkOGfsCkU/bUt21t
         YeOWXuddfJX5AGRnr+xkFoFVSBYcEBzv+2xwcuY4avi6KglYC286kjeJNl1uRR8dP+OR
         Hg2BlUX0r9jUO+BlotaS/ToSIF9XN8qLSRbq0EKETUO44EROl431QkbDfiHIoAJvT6LT
         H8iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSorOcv2VFS2ojqhaoeY9l+K27LBPOQILdOh619+FEtCcAo6r561J0OTVS+ErUfZxnycs8cnMzbvd5PzPChiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT4UtFwf0IJnrWQOoxhw3rgPQIqSnr73mNRKfZL4FKswnJTkle
	aY3VFFP48I/+DGprL0ooNe0UUltYCKV99gLZHp45iV0Kvi9bk0hfhfFCJ/NUo7SLc3E=
X-Gm-Gg: ASbGncvZl6mvHD/0ZYTlX7oTu7sDZUZJ4trXL3vwUSmK2yZAX0vaGtZjR9MONLd5SEP
	e33x6NQtVQprVKLx0bBIqPAyiq+B/3nCqJOzfowY3rsuykjuRRSIPAr7bo6ZgsZzV0FuVOb0aH+
	s7wIA50aFXv1rG+UFNA8jvKk6/+qTJbEsxQ0BwdghPsrisa0jLGQHWeSJ8Y/uj0q1W+o9D3AG4J
	IbCK3X6ZO+NjOJTI81djYAxCqJ6cwDBF/4IaTd/fUbp/NXzcqzBN2SbbVH1shLwATMsTOqoipdg
	YvKZwuToYW+22zRVtNRvI98kqzJ2/NsPQal+Z+0pIQ+Ph9DquW//CplISa9rvms=
X-Google-Smtp-Source: AGHT+IEUE8tMaPDZZaKY17LAPbD4MKLwoSLGBEVWhrKQhzPLWiq+YuKvyeMKc71elZ017y0Pb2Lzbg==
X-Received: by 2002:a05:6000:705:b0:3b3:9c75:a4fb with SMTP id ffacd0b85a97d-3b5e4522093mr2562948f8f.33.1752072455658;
        Wed, 09 Jul 2025 07:47:35 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b04e:cfc4:3bd9:6180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47285c90esm16243899f8f.91.2025.07.09.07.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:47:35 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: Shuai Zhang <quic_shuaz@quicinc.com>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2] MAINTAINERS: add a sub-entry for the Qualcomm bluetooth driver
Date: Wed,  9 Jul 2025 16:47:28 +0200
Message-ID: <20250709144728.43313-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Patches modifying drivers/bluetooth/hci_qca.c should be Cc'ed to the
linux-arm-msm mailing list so that Qualcomm maintainers and reviewers
can get notified about proposed changes to it. Add a sub-entry that adds
the mailing list to the list of addresses returned by get_maintainer.pl.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Changes in v2:
- add remaining QCA files (Dmitry)

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index efba8922744a3..d018923ddd3eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20464,6 +20464,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
 F:	drivers/net/wwan/qcom_bam_dmux.c
 
+QUALCOMM BLUETOOTH DRIVER
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	drivers/bluetooth/btqca.[ch]
+F:	drivers/bluetooth/btqcomsmd.c
+F:	drivers/bluetooth/hci_qca.c
+
 QUALCOMM CAMERA SUBSYSTEM DRIVER
 M:	Robert Foss <rfoss@kernel.org>
 M:	Todor Tomov <todor.too@gmail.com>
-- 
2.48.1

