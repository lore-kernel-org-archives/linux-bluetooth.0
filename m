Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBA9385D96
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 04:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787201012; cv=none; b=TzzI2Ww7yFtv3ODJl7/pqCEzTvYc2YLklwNQWB0U0ZtP+8uNO01+Ezix5DNqitVkBYHXVfiNN+BDq9cBGNvzLejyt6KdK53kN+vd7R+vkb3Se3fdPy9cPPkLf4nsq2SokS8I021G3smMt3XV4VZxva8cya4uS3vCe2vtdkV/1P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787201012; c=relaxed/simple;
	bh=cE2a0cbgd7+VMFti3/savNuy67+eIuh70YqOs8zEpYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GSxiiCqXL4llOjCr9Iy9BP0UzkBXbpVO0L1d2XOT52ZWm1D1sLVJEcaPZMvRxcnINZEINF2+yFv6TXqLdo7x5PwoD+4SVsDby6JkccU9X6BccUyk94NF4XagsjMvQHzmuT+F7UdQnf63CJszoF6vVqlK/FM0m2LI9FQ2PgaFhvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O969NHn7; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O969NHn7"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e88b60121so1448352a91.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 21:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787201011; x=1787805811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p9WH5AflqflAU1ce36po3RrVqECtdovfGcL/7R52yiA=;
        b=O969NHn7qFNXnQrsDmQ9ZyyRPOyTjV8WqpdxGxbslFwXlld/rM9Q1wy8fmOfAeh5eY
         HJFIPJgQZCRP5hFnUQX9S/aV44u5BPJ/vlp/PY3UkuNbHJ1DvhnF/BaPKs8L9dn4FxY0
         7lTKoeMMg8s2433Ecjyu3I7tFjKnpTntqZyQmjuKGa4SyG6VqRdA7P9Sz/PAkedKhVE/
         u3Midr51jF+GGFUn9PRjmCP5z4Uv8lY2favAYbvDa+QwOmMYoyHDvh1QLiP1QSgeGMyT
         +bolJP+WA9WLHvu6IJO9bfY2f3lAlQF5kZTPNMDZD8f1VMqlLCvj7sUaU23ut2WMVNrp
         f74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787201011; x=1787805811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p9WH5AflqflAU1ce36po3RrVqECtdovfGcL/7R52yiA=;
        b=W6uSXPlwuQrP4tPOsmgKy8s4xLKA32uIEFSVRHNlqXzo8sOh3az81sfGOGmBnykp5A
         hpMdBDpXHrJsfPzVzGOvt6o4T/xJQ0pFz8Qlab/ci+9uoQXx0nwuv6qbEjMJay0hpqv7
         mvEJRMK4762osLRCjykthAc12qolHGayNq19+eqBGK9IU5LNmtBpNcm40zcK5UbBK3MD
         fn86gLeYMV4Tdld7bImsdy+jNsrwfQEgyxfigj9KsbywyOXdqOIvgoSE6obraIxe5ken
         dnbxt2CFzypigtaec35B8eF64X7VYrztGc+VDguyWG0aicez0dQPdZyZdrmhW3y/Cjni
         9kVQ==
X-Forwarded-Encrypted: i=1; AHgh+Roe6sTYf0wkudOZaMlONQw4FiqE/nndsZBGOU5GhC2GTIOxEZoTlwrPA0Q4eLzW0SEHCU4Rhidi0M4EzG1Cxj0=@vger.kernel.org
X-Gm-Message-State: AFuF++lYwNNhdsWqCq0LToDXqQs6RPSJFdjr1vxpu9AzT7m2Xf04OBRM
	h/yXWqYNkLXfDFcMcmmWQb9Ty6W7S3cXSQ8jJPN7m+Z0qcS+zD/JXkIqWXmXlfo=
X-Gm-Gg: AR+sD10tP9XUwFJsDpuwnc7Lzus0CzfcQudgNcMXlw4ZZncHBF4x657NN0/AkRGDMbR
	cpGi0Xq7catscMAa9r9JD7O2hLfCF+6lyLFj31o8nHepy2ODvgVoCrblzvvqDU0252oZ4grJR8d
	kAKTlAHDyfdsb1hrIytTr9XAga4pn8fI0BwOHaTyQx58Hv6sy1LFbMROX5DlcQCPYg/bodhuGqF
	3Ln/Nuwj3hnOo9GZk473wk6iF85b1USMgbvl3u4mRzcmdjpfm9N2WoScW5w5KowvQe2lVK/Rw/U
	oBlOOY9D/gkBf7Vml5mDid9Vikk+A8KtAzdEXzh2ao8F+8k1f8iedzNglex64yQlOIo1qfmaLZH
	8vGM+MA7WZI7kQXv4cNgpuosTTJLZDXDAFQ43+IdwQWcGlsLgIjX+CgL4PRbh08vDY2M/CSAkMz
	zDKNzHD30xTMNntbHeAxLeWso9R0vperp10JQ2ucD04QWW+ugEBE6GRrGnkvMj8659NgZwRb7ls
	g==
X-Received: by 2002:a17:90b:4a05:b0:37f:c22a:c188 with SMTP id 98e67ed59e1d1-39580a80a65mr18398300a91.4.1787201010537;
        Wed, 19 Aug 2026 21:43:30 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fb321dfsm5373705a91.16.2026.08.19.21.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 21:43:30 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: brgl@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH] Bluetooth: hci_qca: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Thu, 20 Aug 2026 11:42:58 +0700
Message-ID: <20260820044258.1954272-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the deprecated SIMPLE_DEV_PM_OPS
to DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr().

This lets us drop the __maybe_unused annotations from its suspend and
resume callbacks, and reduces kernel size in case CONFIG_PM or
CONFIG_PM_SLEEP is disabled.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/bluetooth/hci_qca.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 1222f97800f4..859b13814ff6 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2643,7 +2643,7 @@ static void qca_serdev_shutdown(struct serdev_device *serdev)
 	}
 }
 
-static int __maybe_unused qca_suspend(struct device *dev)
+static int qca_suspend(struct device *dev)
 {
 	struct serdev_device *serdev = to_serdev_device(dev);
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
@@ -2757,7 +2757,7 @@ static int __maybe_unused qca_suspend(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused qca_resume(struct device *dev)
+static int qca_resume(struct device *dev)
 {
 	struct serdev_device *serdev = to_serdev_device(dev);
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
@@ -2769,7 +2769,7 @@ static int __maybe_unused qca_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(qca_pm_ops, qca_suspend, qca_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(qca_pm_ops, qca_suspend, qca_resume);
 
 #ifdef CONFIG_OF
 static const struct of_device_id qca_bluetooth_of_match[] = {
@@ -2823,7 +2823,7 @@ static struct serdev_device_driver qca_serdev_driver = {
 		.name = "hci_uart_qca",
 		.of_match_table = of_match_ptr(qca_bluetooth_of_match),
 		.acpi_match_table = ACPI_PTR(qca_bluetooth_acpi_match),
-		.pm = &qca_pm_ops,
+		.pm = pm_sleep_ptr(&qca_pm_ops),
 #ifdef CONFIG_DEV_COREDUMP
 		.coredump = hciqca_coredump,
 #endif
-- 
2.53.0

