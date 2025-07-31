Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD94A5383
	for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jul 2025 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959646; cv=none; b=tEvQRYtkgz8eCxnNfBPlMjD8yemYhWV3RQBZ3MlomgPbV/dESFd57eA70lZzlWWoldEnaroViPoTE2UV7df3D7II3Soqq/Vo3g3OAA1xAwUJAjN/yd0o6RFPoefByuRrZVJkRoruDgGiigeUtEdgYXh36osiN/dD8qxpYEHOITE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959646; c=relaxed/simple;
	bh=S0NxfBLQ9XzDmryCwzo6WBtV7kz5jXCITr0RoELmPtM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hHewROgRFSXq14wBE+37zViAkjjITgxvgkXx5n2kEYYG850tPmwAsg5ykxeZeTDsqFDrcQs7P+d49TilwYqpqYpH2zp4zBpxsJ2tS7Tm8wAbnTBsWq416IpTBhWKvTIgpH9iy/b+Gws33cFsw+4A4sCEXz4WrPMNUlLHzFBFXc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZdJ+zDwQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZdJ+zDwQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753959645; x=1785495645;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S0NxfBLQ9XzDmryCwzo6WBtV7kz5jXCITr0RoELmPtM=;
  b=ZdJ+zDwQ8jFMDosPWQv+DfsnBdFLE377WqtcRpZKlY8bzdXfeP2p/yUD
   lRvsveeklY3o57szvF97ZdacRRq9jeRFirs5wqqEjtBQA943YyDX0P5pA
   Gsvm+ssru2x21/rigzlhLH8ZNBbUaPhCBM/mvQPd4FZVNDD1UUI4nj7ur
   Vy/NDDyG598HQYeu8PfGSM9en9tH43VVcnPXPlqKoeuB6Vt1M8HvP8JgI
   /se2+yGy5ayIL00mw710fG5m/T6dfE0xgTbGe+x1SxiVEY7tnNHSjmLHD
   wZCM+Sn7HGj0UcMNp3KXrF+bT44dFp8s/HVh5QGYdWMQh1c/x3NovD4SQ
   w==;
X-CSE-ConnectionGUID: 09LMAYPqRti1p1BflQ8fkg==
X-CSE-MsgGUID: Pi+kZDhxR6Wtij3dCr1nQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56356943"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="56356943"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 04:00:44 -0700
X-CSE-ConnectionGUID: 4MgIYEK5QWa8ePoUYV6I/Q==
X-CSE-MsgGUID: kAlqLneoS6mU/hxFjQ3kGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="167721644"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by orviesa004.jf.intel.com with ESMTP; 31 Jul 2025 04:00:43 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: Define hdev->wakeup() callback
Date: Thu, 31 Jul 2025 16:47:11 +0530
Message-ID: <20250731111711.1456427-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>

Implement hdev->wakeup() callback to support Wake On BT feature.

Test steps:
1. echo enabled > /sys/bus/pci/devices/0000:00:14.7/power/wakeup
2. connect bluetooth hid device
3. put the system to suspend - rtcwake -m mem -s 300
4. press any key on hid to wake up the system

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index ce17c5ea67e8..22a2953adbd6 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2416,6 +2416,13 @@ static void btintel_pcie_hw_error(struct hci_dev *hdev, u8 code)
 	btintel_pcie_reset(hdev);
 }
 
+static bool btintel_pcie_wakeup(struct hci_dev *hdev)
+{
+	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
+
+	return device_may_wakeup(&data->pdev->dev);
+}
+
 static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
 {
 	int err;
@@ -2441,6 +2448,7 @@ static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
 	hdev->set_diag = btintel_set_diag;
 	hdev->set_bdaddr = btintel_set_bdaddr;
 	hdev->reset = btintel_pcie_reset;
+	hdev->wakeup = btintel_pcie_wakeup;
 
 	err = hci_register_dev(hdev);
 	if (err < 0) {
-- 
2.43.0

