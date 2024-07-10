Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749AC19046D;
	Wed, 10 Jul 2024 12:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720613886; cv=none; b=SoeQvah4krY1B6FZbcIPpuHnmAxQp7KlfxL4n/75BHKM+nU9MdDZjHNo1kHXtE3iwnpmh0uZIjncWGqkbW0QndgWThQSUXRIVjN2yqbe5828Fi7mKEAtWPrAH2FdxtRE+uPgnWVVRuRayTFY6fwZyI3EsueOKvNqgPhmGXDQR+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720613886; c=relaxed/simple;
	bh=Mc4FARdR6+L13bQllZJqIjgHsR+un/Qjk1ZSnQGsfk4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SjFR6SMNGO7S/nqXWN+Ns59B2Wjh0womqDCH4MXwrBFVGy8r8zMfvpUzw2kEV6faE7M7HU0PSH1l/KrvzrGCtIL4BhX6aNK8XIXVm1XjmvfInIhv+MEhe7JERnPrgWF1M0r+xjIApE8MuNKijLRcjjUL69ZJA9XDtXD9RJwpOS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BFEF01A066F;
	Wed, 10 Jul 2024 14:18:02 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 92A961A14B5;
	Wed, 10 Jul 2024 14:18:02 +0200 (CEST)
Received: from pe-lt8779.in-pnq01.nxp.com (pe-lt8779.in-pnq01.nxp.com [10.17.104.141])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 1B3821820F77;
	Wed, 10 Jul 2024 20:18:01 +0800 (+08)
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	rohit.fule@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com,
	haibo.chen@nxp.com,
	LnxRevLi@nxp.com
Subject: [PATCH v1] Bluetooth: btnxpuart: Fix warnings for suspend and resume functions
Date: Wed, 10 Jul 2024 17:45:58 +0530
Message-Id: <20240710121558.934069-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

This fixes the warnings 'nxp_serdev_resume' and 'nxp_serdev_suspend'
defined but not used.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407100518.06Xxq5PK-lkp@intel.com/
---
 drivers/bluetooth/btnxpuart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index c5b40bba6bfa..b9b5032480b1 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1498,6 +1498,7 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
 	hci_free_dev(hdev);
 }
 
+#ifdef CONFIG_PM_SLEEP
 static int nxp_serdev_suspend(struct device *dev)
 {
 	struct btnxpuart_dev *nxpdev = dev_get_drvdata(dev);
@@ -1515,6 +1516,7 @@ static int nxp_serdev_resume(struct device *dev)
 	ps_control(data->hdev, PS_STATE_AWAKE);
 	return 0;
 }
+#endif
 
 static struct btnxpuart_data w8987_data __maybe_unused = {
 	.helper_fw_name = NULL,
-- 
2.34.1

